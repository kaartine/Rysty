<?php
/**
 * toiminto.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 13.01.2005
 *
*/

/**
 * class Toiminto
 *
 */
/******************************* Abstract Class ****************************
  Toiminto does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/
require_once("tietokanta.php");

class Toiminto
{

    var $view;                // Viewin nimi
    var $errors = array();
    var $tilat;// = array();
    var $toiminnonNimi;

    /** kahva tietokantaan */
    var $db;
    var $LOGGED_IN;
    var $toiminnot;
    var $suoritetaankoAutoRefresh;
	var $refreshlink;

    var $lisattyKantaan = array();

    var $tm;

    function Toiminto($toiminnonNimi){
        $this->toiminnonNimi = $toiminnonNimi;
        unset($this->view);
        unset($this->db);
        unset($this->toiminnot);
        // ladataan vanhat tilatiedot sessiosta
        if ( array_key_exists('tilat', $_SESSION) ) {
            $this->tilat = &$_SESSION['tilat'];
        }
        else {
            $this->tilat = array();
            $_SESSION['tilat'] = &$this->tilat;
        }
        // check if user is in session
        if ( isset($_SESSION['nimi']) and isset($_SESSION['salasana']) ) {
            $this->LOGGED_IN = TRUE;
        } else {
            $this->LOGGED_IN = $this->readCookie();
        }
        
        $this->refreshlink = '';

        $this->insertedInDB = false;

        $this->asetaTila();

        $this->tm = &TranslationManager::instance();
    }
    /**
     * @return string nykyinen tila
     */
    function nykyinenTila(){
        $size = count($_SESSION['palaa']);
        if( $size > 0 and $_SESSION['palaa'][$size-1] != $this->toiminnonNimi) {
            if( isset($_REQUEST['samarefresh']) and $_REQUEST['samarefresh'] == true ) {
                $pois = $this->toiminnonNimi;
                D( "<br>SAMA<br>");
            }
            else {
                $pois = array_pop( $_SESSION['palaa'] );
                D("<br>poistettu: $pois <br>");
            }
        }
        else {
            $pois = $this->toiminnonNimi;
        }

        return $pois;
    }
    /**
     * @param string tila
     */
    function asetaNykyinenTila($tila){
        $size = count($this->tilat);
        // != ja !== kanssa saa olla tarkkana mitä milloinkin tarvitsee
        if ( $size == 0 or $this->tilat[ $size - 1 ] != $tila ) {
            array_push($this->tilat, $tila);
        }
    }

    /**
     * Ohjaa autoRefreshin takasin jos tätä on kutsuttu rakentajassa.
    */
    function asetaTila() {
        $size = count($_SESSION['palaa']);
        if( $size == 0 or $_SESSION['palaa'][$size-1] != $this->toiminnonNimi ){
            array_push( $_SESSION['palaa'], $this->toiminnonNimi);
            D( "<br>lis&auml;tty<br>");
        }
    }

    function openConnection(){
        $this->db = new Tietokanta();
        $this->db->open();
    }

    /**
     * Lisää errorin joka tulostetaan käyttäjälle.
     * view hoitaa tekstin kääntämisen.
     */
    function addError($error){
        array_push($this->errors, $error);
    }

    /**
     * Returns the view for this action.
     */
    function &getView () {
        return $this->view;
    }
    /**
     * Creates a view for this action.
     * @param string className
     */
    function createView ($class) {
        $registry = &Registry::instance();
        if (!$registry->isEntry('view')) {
            $registry->setEntry(
                    'view', new $class($this));
        }
        $this->view =  &$registry->getEntry('view');
        //$this->view->setToiminto($this);

        if ( array_key_exists('autorefresh', $_REQUEST) and
              array_key_exists('kantaanlaitettu', $_SESSION)) {

            if ( $_REQUEST['autorefresh'] == 1 ){
              $this->view->naytaKantaanLisatyt($_SESSION['kantaanlaitettu']);
              unset($_SESSION['kantaanlaitettu']);
            }
        }
    }


    /**
     * Processes the action.
     *
     * @return void
     * @abstract
     * @access public
     */
    function suorita( )
    {
        //echo "Suorittaa: ". get_class( $this ) ."\n";

    } // end of member function suorita

    function getCurrentHierarchyPosition( )
    {
    } // end of member function getCurrentHierarchyPosition

    /**
     * Toiminnon tietokannasta hakema tieto
     *
     * @return void
     * @abstract
     * @access public
     */
    function &getData( )
    {
        //print "GetData\n";
    } // end of member function getData

    /**
     * @return errors that happened during execution
     */
    function &getErrors()
    {
        return $this->errors;
    }

    /**
     * Kaikille toiminnoille yhteistä dataa
     *
     * @return void
     * @abstract
     * @access public
     */
    function getPublicData( )
    {
    } // end of member function getPublicData

    /**
     * useless???
     * Palauttaa sql kyselylauseen kyseiselle toiminolle
     * @return string query
     * @abstract
     */
    function createSQLquery( )
    {
    } // end of member function createSQLquery

    /**
     * Palauttaa sql kyselylauseen kyseiselle toiminolle
     * @return string query
     * @abstract
     */
    function executeSQLquery( )
    {
    } // end of member function executeSQLquery
    //----------
   /**
    * Avaa yhteyden kantaan ja suorittaa kyselyn, sulkee yhteyden ja palauttaa
    * tuloksen.
    */
   function &commitSingleSQLQuery (&$query) {
        $this->openConnection();
        $result = $this->db->doQuery($query);
        //$this->db->commit();
        $this->db->close();
       return $result;
    }

    function autoRefresh () {
        // Refreshin jälkeen palataan toiseen tilaan.
        //$size = count($_SESSION['palaa']);

        if( isset($_SESSION['buttonIndex']) ) {
            for( $i = 1; $i <= $_SESSION['buttonIndex']; $i++ ) {

                if( isset($_REQUEST['palaa'.$i]) ) {
                    $_REQUEST['palaa'] = $_REQUEST['palaa'.$i];

                    if( isset($_REQUEST['seuraava'.$i]) and isset($_REQUEST['alitoiminto'.$i]) ) {
                        $_REQUEST['seuraava'] = $_REQUEST['seuraava'.$i];
                        $_REQUEST['alitoiminto'] = $_REQUEST['alitoiminto'.$i];
                    }
                    else {
                        D("<br />SEURAAVA TAI ALITOIMINTO KENTTÄÄ EI OLE ASETTTU! VIRHE VIEWIN puolella!<br />");
                    }
                }
            }
            $_SESSION['buttonIndex'] = 0;
        }

        if( isset( $_REQUEST['palaa'] ) /*and $_REQUEST['palaa'] == true*/ and isset($_REQUEST['seuraava']) ) {
            $this->tallennaTila();
            array_push($_SESSION['palaa'], $_REQUEST['seuraava'] );
            return true;
        }
        /*
        if( $_SESSION['palaa'][$size-1] == $this->toiminnonNimi ) {
            //array_pop( $_SESSION['palaa'] );
            return true;
        }*/

        return $this->suoritetaankoAutoRefresh;
    }

    function tallennaTila() {
        if( isset($this->tiedot) ) {

            foreach( $_REQUEST as $key => $value ) {
                if( array_key_exists( $key, $this->tiedot ) ) {
                    $_SESSION['tallennus'][$this->toiminnonNimi][$key] = $value;
                }
            }
        }
    }

    function lataaTiedot() {
        //D("lataaTiedot()" );
        //D($_REQUEST);
        if( isset($_SESSION['tallennus'][$this->toiminnonNimi]) ) {
            //D("function lataaTiedot() {");
            foreach( $_SESSION['tallennus'][$this->toiminnonNimi] as $key => $value) {
                       
                $_REQUEST[$key] = $value;
                //D($key);
                //D($_REQUEST[$key]);
            }
        }
        // tyhjennetään kun ollaan luettu
        unset($_SESSION['tallennus'][$this->toiminnonNimi]);
        //D("lataaTiedot() loppu" );
        //D($_REQUEST);
        
    }

    /*function lataaTiedot($tiedot) {
        if( isset($_SESSION['tallennus'][$this->toiminnonNimi]) ) {
            foreach( $_SESSION['tallennus'][$this->toiminnonNimi] as $key => $value) {
                if( $this->tiedot[$key][0] == '' ) {
                    $this->tiedot[$key][0] = $value;
                    print "ladattu: $key $value <br>";
                }
            }
        }
        else {
            $this->tiedot = &$tiedot;
        }
    }*/

    function suoritaAutoRefresh () {
        $this->suoritetaankoAutoRefresh = true;
        $_SESSION['kantaanlaitettu'] = $this->lisattyKantaan;
    }

    function succeeded() {
        if( isset($this->db) ) {
            return $this->db->succeeded();
        }
        else {
            return true;
        }
    }

    function redirectSuoritaTo($toiminto) {
        D($_SESSION['palaa']);
        $size = count($_SESSION['palaa']);

        array_pop($_SESSION['palaa']);
        $size = count($_SESSION['palaa']);
        if( $size > 1 and $_SESSION['palaa'][$size-2] != $toiminto) {
            array_push($_SESSION['palaa'], $toiminto);
        }
    }


    function  readCookie() {
        if ( isset($_COOKIE['kvpelaaja1']) and isset($_COOKIE['kvpelaaja2'])) {
            D( '<pre>Cookie');
            D($_COOKIE);
            D( '</pre>');

            $nimi = $_COOKIE['kvpelaaja1'];
            $pw = $_COOKIE['kvpelaaja2'];
            return $this->doLogin($nimi, $pw);
        }
        return FALSE;
    }

    function doLogin($nimi, $md5salasana, $usecookie = FALSE) {

                global $COOKIEHOURSTOLIVE;
                $success = FALSE;

                $this->openConnection();

                $query = "SELECT henkilo from kayttajat where tunnus = '$nimi'".
                        " and salasana = '$md5salasana'";
                $result = $this->db->doQuery($query);

                if ( count($result) == 1) {
                    D(  '<br>');
                    $query = "SELECT etunimi, sukunimi,hloid from henkilo where hloid = '".$result[0]['henkilo']."'";
                    $result = $this->db->doQuery($query);

                    D($result);
                    $_SESSION['nimi'] = $nimi;
                    $_SESSION['salasana'] = $md5salasana;
                    $_SESSION['kokonimi'] = $result[0]['etunimi']." ".$result[0]['sukunimi'];
                    $_SESSION['hloid'] = $result[0]['hloid'];
                    $data = array($nimi, $md5salasana);
                    if ( $usecookie ) {
                        if ( setcookie('kvpelaaja1',$nimi, time()+60*60*$COOKIEHOURSTOLIVE, '/' ) ) { // time = 90 päivää
                            D( "COOKIE 1 SET OK");
                        }
                        if ( setcookie('kvpelaaja2',$md5salasana, time()+60*60*$COOKIEHOURSTOLIVE, '/' ) ) { // time = 90 päivää
                            D( "COOKIE 2 SET OK");
                        }
                    }
                    $success = TRUE;
                    $_SESSION['oikeudet'] = '';
                }
                $this->db->close();
            return $success;
    }
    
    function getOmaRefreshLink() {    	
    	return $this->refreshlink;	
    }
    
    function setOmaRefreshLink($link) {    	
    	$this->refreshlink = $link;	
    }
    
    function asetaSalaus( $bool ) {
    	$metodi = $bool==true ? 'https' : 'http';
    	
		if ( $bool == false or !array_key_exists('HTTPS', $_SERVER) or $_SERVER['HTTPS'] !== 'on' ) {
//	    	print 'ei oo ssl k&auml;yt&ouml;ss&auml;<br />';
	    	$this->setOmaRefreshLink($metodi.'://'.$_SERVER['SERVER_NAME'].$_SERVER['PHP_SELF'].'?toiminto='.$this->toiminnonNimi);
	    	$this->drawForm = false;
	        $this->suoritaAutoRefresh();
		}
	}
    
    
} // end of Toiminto

// help functions
/**
 * Tarkistaa onko annettu päivämäärä muotoa: d.m.y
 */
function isLegalDate (&$datestring) {
        $datestring = str_replace(',','.',$datestring);
        $p = explode('.', $datestring);
        if ( count($p) != 3 ) return FALSE;
        return (checkdate($p[1], $p[0], $p[2]));
}
/**
 * Tarkistaa onko annettu aika muotoa MM:SS, MM,SS tai MM.SS
 */
function  isLegalTimeMMSS(&$timestring) {

        $timestring= str_replace(',',':',$timestring);
        $timestring= str_replace('.',':',$timestring);
        $p = explode(':', $timestring);
        if ( count($p) == 3 ) {
            $p = array($p[1],$p[2]);

        }

        if ( count($p) != 2 ) return FALSE;
        if ( !is_numeric($p[0]) or !is_numeric($p[1] ) ) return FALSE;
        if ( $p[0] < 0 or $p[0] > 60 ) return FALSE;
        if ( $p[1] < 0 or $p[1] > 60 ) return FALSE;
        $timestring = '00:'.$p[0].':'.$p[1];
        return TRUE;
}
function  isLegalTimeMMSS2(&$timestring) {

        $timestring= str_replace(',',':',$timestring);
        $timestring= str_replace('.',':',$timestring);
        $p = explode(':', $timestring);

        if ( count($p) != 2 ) return FALSE;
        if ( !is_numeric($p[0]) or !is_numeric($p[1] ) ) return FALSE;

        if ( $p[0] < 0 or $p[0] > 60 ) return FALSE;
        if ( $p[1] < 0 or $p[1] > 60 ) return FALSE;
        return TRUE;
}
/**
 * Tarkistaa onko annettu aika muotoa HH:MM, HH,MM tai HH.MM
 */
function  isLegalTimeHHMM(&$timestring) {
        $timestring= str_replace(',',':',$timestring);
        $timestring= str_replace('.',':',$timestring);
        $p = explode(':', $timestring);
        if ( count($p) == 3 ) {
            $p = array($p[0],$p[1]);
        }
        if ( count($p) != 2 ) return FALSE;

        if ( $p[0] < 0 or $p[0] > 23 ) return FALSE;
        if ( $p[1] < 0 or $p[1] > 60 ) return FALSE;
        $timestring = $p[0].':'.$p[1].':00';
        return TRUE;

}

?>
