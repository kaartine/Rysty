<?php

/**
 * lis‰tt‰v‰.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 20.01.2005
 *
*/



/**
 * class Lis‰tt‰v‰
 *
 */
/******************************* Abstract Class ****************************
  Lis‰tt‰v‰ does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/

require_once("toiminto.php");
require_once("form.php");
require_once("lomakeelementit.php");

class Lisattava extends Toiminto
{
    var $taulunNimi;
    var $drawForm;
    var $notset;
    var $result;

    /**
     Moniuloitteinen taulukko
     taulukon alkioina taulukoita, joissa:
     tietokannan sarakkeen nimi
        0. arvo
        1. onko pakollinen
        2. tyyppi: 'TEXT', 'SELECT', 'TEXTAREA', 'RADIO', 'CHECKBOX',
                    'NOEDIT' (pelkk‰ teksti jota ei voi muokata), 'PICTURE'
        3. valinnainen tekstikenttien pituus
     esim:

    $tiedot = array('vuosi' => array('vuosi'=>array('',TRUE,'TEXT',4)) ;
    */
    var $tiedot;
    var $viewName;

   function Lisattava($toinnonNimi){

        $this->Toiminto($toinnonNimi);
        unset( $this->taulunNimi);
        unset( $this->drawForm);
        unset( $this->notset);
        unset( $this->result);
        unset( $this->tiedot);

        unset( $this->viewName);
        $this->drawForm = TRUE;
    }

    function checkContent(&$req){
        checkContent($_REQUEST);
    }

    function suorita( )
    {
        $this->createView($this->viewName);

        $this->checkContent($_REQUEST);
/*
    D( "<pre>");
    D( $this->tiedot);
    D( $_REQUEST);
    D("</pre>");
*/
        // jos ei lˆydy t‰ytt‰m‰ttˆmi‰ kohtia niin kantaan vaan
        if ( isset($_REQUEST['send']) and $this->lueJaTarkistaRequest() )    {
            D("<br>tarkastetaan sy&ouml;tt&ouml;<br>");
            $this->drawForm = false;
            $this->laitaKantaan();
            
	    //t‰sta alkaa takaisinkytkenn‰n toimintasarja
            $this->suoritaAutoRefresh();
        }
        else if( isset($_REQUEST['poista']) && $_REQUEST['poista'] == true ) {
            $this->drawForm = false;
            
            $this->poistaRivi();
            
            //t‰sta alkaa takaisinkytkenn‰n toimintasarja
            $this->suoritaAutoRefresh();
        }
        else {
            // draw data fields in
            $this->taytaErikoisKentat();
        }
    }

    /*
    function nykyinenTila() {
        // halutaan palata takaisin edelliseen toimintoon
        if( count($this->tilat) > 1 ) {
            D( "<br>lis&auml;tt&auml;v&auml; t&auml;nne: ".$this->tilat[count($this->tilat)-1]."<br>");
            return array_pop($this->tilat);
        }

        return $this->tilat[count($this->tilat)-1];
    }*/

    function &annaSQLLauseke() {
    	print_r($this->tiedot);
    	print_r($this->taulunNimi);
    	$tmpArray = array_keys($this->tiedot);
        return $this->rakennaSQLLauseke($tmpArray,$this->taulunNimi);
    }

    function laitaKantaan () {

        // INSERT INTO taulu (nimet,toinen) values (arvo,toka)
        $query = $this->annaSQLLauseke();

        if( $query != '') {
            $result = $this->commitSingleSQLQuery( $query );
        }
        else {
            $this->addError('tyhj&auml; kysely');
            $this->db->error = true;
        }
    }
    /**
     * Luokkakohtaiset erikoiskent‰t t‰ytet‰‰n t‰m‰ ylim‰‰rittelem‰ll‰.
     */
    function taytaErikoisKentat(){
    }
    // Useful functions for all
    /**
     * Checks that all fields in tiedot are set in _REQUEST
     * Fills tiedot arrays value
     * @return true if no unset fields found
     */
    function lueJaTarkistaRequest(){

        $this->notset = array(array(), array(),array());
        $allOK = TRUE;
        foreach ($this->tiedot as $key => $value) {
            if ( !array_key_exists($key, $_REQUEST) )
            {
                //$allOK = FALSE; // jos tietoa ei lˆydy niin se ei ole virhe
                if ( is_a($value[0],'LomakeElementti')) {
                    continue;
                }
                $_REQUEST[$key] = $value[0];

                //array_push($this->notset[2], $key);
            }
            $arvo = trim($_REQUEST[$key]);
            if ( $value[1] ) { // onko pakollinen
                if ( $arvo === NULL or $arvo === '' ) {
                     if (count($this->notset[0]) == 0) {
                        $this->addError('Arvoa ei asetettu:');
                     }
                    array_push($this->notset[0], $key);
                    $allOK = FALSE;
                    $this->addError($this->tm->getText($key));

                }
            }
            if ( !empty($arvo) and !$this->tarkistaTyyppi($arvo, $value[2]) ){
                    if (count($this->notset[2]) == 0) {
                        $this->addError('Laiton arvo kentˆss&auml;:');
                    }
                array_push($this->notset[2], $key);
                $allOK = FALSE;
                    $this->addError($this->tm->getText($key)." = $arvo");
            }

            if ( isset($value[3]) )  { // pituus
                if ( $value[2] != 'TIME_HH_MM' and $value[2] != 'TIME_MM_SS' and $value[2] == 'PVM' and
                 strlen($arvo) > $value[3] ) {
                    // lˆytyi laiton pituus!!!
                    // TODO:
                    if (count($this->notset[1]) == 0) {
                        $this->addError('kent&auml;ss&auml; liian paljon teksti&auml;:');
                    }
                    array_push($this->notset[1], $key);
                    $allOK = FALSE;
                    $_REQUEST[$key] = substr($_REQUEST[$key],0,$value[3]);
                    $this->addError($key." = $arvo");
                }
            }
            $this->tiedot[$key][0] = $arvo;
        }
/*
        if ( isset($this->notset ) ) {
            if ( count($this->notset[0]) > 0) {
                $this->addError("T&auml;yt&auml; ainakin t&auml;hdell&auml; (*) merkityt kent&auml;t!");
                array_merge($this->errors, $this->notset[0]);
            }
            if (count($this->notset[1]) > 0) {
                $this->addError("Laiton pituus jossain: KORJAAAAAAA");
                array_merge($this->errors, $this->notset[1]);
            }
            if (count($this->notset[2]) > 0) {
                $this->addError( "Laiton arvo kent&auml;ss&auml;: <br>");
                array_merge($this->errors, $this->notset[2]);
            }
        }*/

        return $allOK;
    }
    /**
     * palauttaa false jos tyyppi on virheellinen
     */
    function tarkistaTyyppi(&$arvo, $tyyppi) {
        switch ($tyyppi) {
            case 'NUMBER':
                return is_numeric($arvo);
            case 'PVM':
                return isLegalDate($arvo);
            case 'TIME_HH_MM':
                return isLegalTimeHHMM($arvo);
            case 'TIME_MM_SS':
                return isLegalTimeMMSS($arvo);
                /* $format = '%H:%M';

                if (strptime($arvo, $format) == FALSE) {
                    $format = '%H.%M';
                    return (strptime($arvo, $format) != FALSE); // jos on array niin OK
                }*/

            case 'PICTURE':
                return TRUE;
            case 'TEXT':
            case 'HIDDEN':
            case 'PASSWORD':
            case 'EMAIL':
            case 'CHECKBOX':
            case 'RADIO':
            case 'TEXTAREA':
            case 'SELECT':
            case 'SELECTLISAA':
            case 'LABEL':
            case 'FILEUPLOAD':
                return TRUE;
                break;
            default:
                D("<br>ERROR in lis&auml;tt&auml;v&auml; tyypi tarkistus<br>");
                D($tyyppi);
                break;
        }
        return FALSE;
    }
    /**
     * Rakentaa annetun taulukon( muotoa array('key 1', 'key 2') mukaisten
     * avainten perusteella sql queryn.
     * @return string example: INSERT INTO taulu (pitkanimi, maskotti) values
     * ('Mun nimi', ' Gorilla maskotti')
     */
    function &rakennaSQLLauseke(&$tiedot,$tauluNimi){
            $rows='';
            $values='';
            $arvojaON = FALSE;
            foreach ($tiedot as $k) {
                //$val = $_REQUEST[$k];
                if ( array_key_exists($k,$this->tiedot) )
                {
                    $val = $this->tiedot[$k][0];
                    if ( $val != NULL ) {
                        $this->lisattyKantaan[$k] = $val;

                        if ( isset($_REQUEST[$k]) and $_REQUEST[$k] == -1) {
                            $rows = $rows.$k.',';
                            $values = $values." NULL,";
                            $arvojaON = TRUE;
                        }
                        else {
                            $rows = $rows.$k.',';
                            $values = $values."'".trim($val)."',";
                            $arvojaON = TRUE;
                        }
                    }
                }
            }
            $query = '';
            if ( $arvojaON ) {
                $query = "INSERT INTO $tauluNimi (".substr($rows, 0, -1).') VALUES ('.substr($values, 0, -1).')' ;
            }
            return $query;
    }

    /**
     * P‰ivitt‰‰ annetun taulukon( muotoa array('key 1', 'key 2') mukaisten
     * avainten perusteella sql queryn.
     * @return string example: UPDATE taulu SET (pitkanimi, maskotti) values
     * ('Mun nimi', ' Gorilla maskotti') WHERE ehdot
    */
    function &paivittavaSQLLauseke(&$tiedot, $tauluNimi, $ehdot) {
        $rows='';
        $values='';
        foreach ($tiedot as $k) {
            $val = $this->tiedot[$k][0];
            if ( $val != NULL or $val == '') {
                $this->lisattyKantaan[$k] = $val;

                if ( $val == -1 or trim($val) == '') {
                    $values = $values.' '.$k." = NULL,";
                }
                else {
                    $values = $values.' '.$k." = '".trim($val)."',";
                }
            }
        }
       $query = "UPDATE $tauluNimi SET ".substr($values, 0, -1) ." WHERE $ehdot";


        // update, yhteystieto on jo olemassa
        return $query;
    }

    /**
        Tarkastaa onko edesyksi talukonarvo asetettu
        @param arvot Viitaus talukkoon jossa on aivaimet joiden pit‰isi olla asetettuna $_REQUESTiss‰
        @return true jos jonkin arvo asetettu muuten false
    */
    function arvotAsetettu(&$arvot) {
        foreach ($arvot as $k) {
            if ( array_key_exists($k, $_REQUEST ) and $_REQUEST[$k] != NULL and $_REQUEST[$k] !== "")
            {
                return true;
            }
        }
        return false;
    }

    /**
     *      *  kutsuu annetulle sequensille nextvalia ja laittaa saadun arvon
     *      * $this->tiedot[$taulunnimi] taulukon ensimm‰iseen alkioon(luo taulukon myˆs)
     *      */

    function luoID($taulunidNimi, $sequenceNimi)
    {
        $query = "SELECT nextval('$sequenceNimi')";//yhteystieto_yhtietoid_seq
        $result = $this->db->doQuery($query);
        // ent‰ jos query ei onnistunutkaan?
        $this->tiedot[$taulunidNimi] = array(NULL,FALSE,'HIDDEN'); // yhtietoid
        $this->tiedot[$taulunidNimi][0] = $result[0]['nextval'];
    }

    function luoLomakeElementti($name,$tiedot, $selected = NULL, $action = NULL,$buttonLabel = NULL) {



        $maxlength = isset($tiedot[3])?$tiedot[3]:40;
        $koko = $maxlength > 40?40:$maxlength;

        $input = NULL;
        switch ($tiedot[2]) {
            case 'TEXT':
            case 'PICTURE':
            case 'EMAIL':
                $input = new Input($name, $tiedot[0], 'text', $koko);
                break;
            case 'LABEL':
                $input = new Label($tiedot[0]);
                break;
            case 'NUMBER':
            case 'PVM':
            //case 'TIME':
            case 'TIME_HH_MM': // poistetaan nollat lopusta
                $p = explode(':', $tiedot[0]);
                if ( count($p) == 3 ) {
                    $tiedot[0] = "$p[0]:$p[1]";
                }
                $input = new Input($name, $tiedot[0], 'text', $koko);
                break;
            case 'TIME_MM_SS': // poistetaan nollat alusta
                $p = explode(":", $tiedot[0]);
                if ( count($p) == 3 ) {
                    $tiedot[0] = "$p[1]:$p[2]";
                }
                $input = new Input($name, $tiedot[0], 'text', $koko);
                break;
            case 'HIDDEN':
                $input = new Input($name, $tiedot[0], $tiedot[2], $koko);
                break;
            case 'PASSWORD':
                $input = new Input($name, $tiedot[0], $tiedot[2], $koko);
                break;
            case 'CHECKBOX':
                $input = new Checkbox($name, $tiedot[0],$tiedot[0],(isset($tiedot[4]) and $tiedot[4]));
                break;
            case 'RADIO':
                $input = new Radiobutton($name, $tiedot[0],$tiedot[0]);
                break;
            case 'TEXTAREA':
                if($koko == 40)
                    $koko = 5;
                $input = new TextArea($name, $tiedot[0],'60', $koko);
                break;
            case 'SELECTLISAA':
                //$button = new Link($this->toiminnonNimi, $action, $action, true);
                $label = $action;
                if ( $buttonLabel != NULL ) $label = $buttonLabel;
                $button = new Button($this->toiminnonNimi, $label, $action);
                $input = new SelectLisaa($name, $tiedot[0], $button, $selected);
                break;
             case 'FILEUPLOAD':
                $input = new FileInput($name, $tiedot[0], 'file');
                 break;
            default:
                D("<br>ERROR in lis&auml;tt&auml;v&auml;<br>");
                D('<pre>');
                D($tiedot);
                D('</pre>');
                break;
        }
        if ( isset($v[3]) ) {
            $input->LENGTH = $tiedot[3];
        }
        return $input;
    }


    function luoLomakeElementit () {
        foreach ( $this->tiedot as $name => $tiedot ) {
            // jos on jo valmiiksi lomake-elementti niin annetaan olla
            if ( is_a( $tiedot[0], 'LomakeElementti' ) ) {
                continue;
            }
            $selected = NULL;
            if( $tiedot[2] == 'SELECTLISAA' ) {
               $selected = $tiedot[0];
            }

            $input = $this->luoLomakeElementti($name,$tiedot, $selected);
            $this->tiedot[$name][0] =  $input;

        /*    switch ($v[2]) {
                case 'NUMBER':
                case 'TIME':
                case 'PVM':
                    $input = new Input($key, $v[0], 'text');
                    break;
                case 'TEXT':
                case 'HIDDEN':
                case 'PASSWORD':
                    $input = new Input($key, $v[0], $v[2]);
                    break;
                case 'CHECKBOX':
                    $input = new Checkbox($key, $key,$v[0]);
                    break;
                case 'RADIO':
                    $input = new Radiobutton($key, $key,$v[0]);
                    break;
                case 'TEXTAREA':
                    $input = new TextArea($key, $v[0]);
                    break;
                default:
                    break;
            }
            if ( isset($v[3]) ) {
                $input->LENGTH = $v[3];
            }
            $this->tiedot[$key][0] =  $input;
            */
        }
    }

    /**
     * @param lomakekent‰n nimi
     * @param kansio minne kuva siirret‰‰n
     * @param kuvan uusi nimi
     */
    function uploadImage($kuva, $kansio, $uusnimi) {

        D ('<pre>');
        D($_FILES);
        D ('</pre>');
        if ( $_FILES[$kuva]['error'] == UPLOAD_ERR_NO_FILE ) {
            D('Ei kuvaa'); // ei virhe, lomake oli vaan tyhj‰
            return NULL;
        }
        else if ( $_FILES[$kuva]['error'] == UPLOAD_ERR_OK ) {
            $tmp_name = $_FILES[$kuva]['tmp_name'];
            $result_array = getimagesize($tmp_name);
            $ending = '';
            if ($result_array !== false) {
               $mime_type = $result_array['mime'];
               switch($mime_type) {
                   case 'image/jpeg':
                       D( 'file is jpeg type');
                       $ending = 'jpg';
                       break;
                   case 'image/gif':
                       D( 'file is gif type');
                       $ending = 'gif';
                       break;
                   case 'image/png':
                       D( 'file is png type');
                       $ending = 'png';
                       break;                       
                   default:
                       D( 'file is an image, but not of png, gif or jpeg type');
                       $this->addError($this->tm->getText('Virheellinen kuvatiedosto'));
                       return '';
               }
            } else {
               D( 'file is not a valid image file');
               $this->addError($this->tm->getText('Virheellinen tiedosto'));
            }

            $dir =  kuvaKansio($kansio);
            if ( !$dir ) {
               D( 'VIRHE kansion luomisessa');
               $this->addError($this->tm->getText('Virhe kuvan tallennuksessa!'));
               return '';
            }
            $uus_nimi = $dir.preg_replace('/[^a-z0-9_\-\.]/i', '_',$uusnimi).".$ending";
            if ( move_uploaded_file($tmp_name, $uus_nimi) ) {
                chmod($uus_nimi, 0777 ); // TODO: korjaa oikeudet  0755 olis parempi
                D( 'FILE MOVED OK new name:');
                D($uus_nimi);
                return $uus_nimi;
            }
        } else {
               $this->addError($this->tm->getText('Virhe tiedoston latauksessa'));
            print 'ERROR UPLOADING FILE';
        }
        return '';

    }
    
    /**
     * T‰ll‰ voidaan poistaa rivej‰ tietokannasta. Kutsutaan kun requestiss‰ on poista=true 
     */
    function poistaRivi() {
        
    }
    
    /**
     * P‰ivitt‰‰ Rss- feed tiedoston uutisille.
     */
    function updateNewsRssFeed()
    {
	GLOBAL $JOUKKUEENNIMI;
	GLOBAL $WEBADDRESS;
	GLOBAL $EMAIL;
	GLOBAL $HOMEDIR;
	$query = "SELECT pvm, uutinenid, uutinen, ilmoittaja, otsikko FROM uutinen ORDER BY pvm DESC LIMIT 15";
	$result = $this->commitSingleSQLQuery($query);
	  
	$updateDate = date("r");
	
	$rss = "<?xml version=\"1.0\"?> 
<rss version=\"2.0\">
<channel>
<title>$JOUKKUEENNIMI - kotisivut</title>
<link>http://".$WEBADDRESS."</link>
<description>$JOUKKUEENNIMI - kotisivut</description>
<pubDate>Tue, 17 Apr 2007 18:00:00 GMT</pubDate>
<lastBuildDate>". $updateDate ."</lastBuildDate>
<docs>http://$WEBADDRESS</docs>
<generator>Rysty</generator>
<managingEditor>$EMAIL</managingEditor>
<webMaster>$EMAIL</webMaster>";

	foreach( $result as $item ) {
	    list($day, $month, $year) = explode('.', $item['pvm']);
	    
	    $rss .= "\n<item>
<title>". htmlentities($item['otsikko'], ENT_QUOTES) ."</title>
<link>http://".$WEBADDRESS."/index.php?alitoiminto=uutislista&amp;all=1&amp;uutinenID=".$item['uutinenid']."#ID".$item['uutinenid']."</link>
<description>". htmlentities($item['uutinen'] ." <br /><br />". $item['ilmoittaja'], ENT_QUOTES) ."</description>
<pubDate>". date("r", mktime(0,0,0, $month , $day, $year) ) ."</pubDate>
<guid>http://".$WEBADDRESS."/index.php?alitoiminto=uutislista&amp;all=1&amp;uutinenID=".$item['uutinenid']."#ID".$item['uutinenid']."</guid>
</item>";
	
	}
	
	$rss .= "\n</channel>\n</rss>\n";
	$rss = str_replace("&Auml;", "&#196;", $rss);
	$rss = str_replace("&auml;", "&#228;", $rss);
	$rss = str_replace("&ouml;", "&#246;", $rss);
	$rss = str_replace("&Ouml;", "&#214;", $rss);
	
	$filename = $HOMEDIR.'/public_html/rss.xml';
	
	// Let's make sure the file exists and is writable first.
	if (is_writable($filename)) {
	    
	    // In our example we're opening $filename in append mode.
	    // The file pointer is at the bottom of the file hence
	    // that's where $somecontent will go when we fwrite() it.
	    if (!$handle = fopen($filename, 'w')) {
		D("Cannot open file ($filename)");
	    }
	    
	    // Write $somecontent to our opened file.
	    if (fwrite($handle, $rss) === FALSE) {
		D("Cannot update rss file. Write to file ($filename) failed.");
	    }	  
	    
	    fclose($handle);
	    
	} else {
	    D("The file $filename is not writable");
	}
    }
    
} // end of Lis‰tt‰v‰
?>

