<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 11.04.2005
 *
*/

require_once("lisattava.php");
require_once("tapahtumanlisaysview.php");

class TapahtumanLisays extends Lisattava
{
    var $osallistujat;
    var $tyyppi;

    /*
     function delete ($taulu, $idnimi) {
	 return "delete FROM $taulu WHERE $idnimi = " .
	   "(select timerkintaid from tilastomerkinta where peliid = '$_REQUEST[tapahtumaid]' and timerkintaid = $idnimi)";
     }
     */
    
    function TapahtumanLisays() {
        $this->Lisattava('tapahtumanlisays');

        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);
        $this->tiedot=array(
            'paikka'=>array('',FALSE,'TEXT',100),
            'aika'=>array('',TRUE,'TIME_HH_MM',5),
            'paiva'=>array('',TRUE,'PVM',10),
            'tyyppi'=>array('',TRUE,'SELECTLISAA'),
            'kuvaus'=>array('',FALSE,'TEXTAREA'),
            'vastuuhlo'=>array('',FALSE,'SELECT'),
            'tapahtumaid'=>array('',FALSE,'HIDDEN')
        );

        $this->viewName = "TapahtumanlisaysView";
        $this->taulunNimi = "tapahtuma";
        $this->toiminnonNimi = 'tapahtumanlisays';

        $this->osallistujat=array('paasee'=>array(), 'eipaase'=>array());
        $this->tyyppi = '';
    }

    function suorita() {
	if( isset($_SESSION['onkooikeuksia']) and isset($_REQUEST['remove']) and isset($_REQUEST['tapahtumaid']) ) {
	    
	    $this->openConnection();
	    $query = "SELECT tyyppi FROM tapahtuma WHERE tapahtumaid = '$_REQUEST[tapahtumaid]'";
	    $result = $this->db->doQuery($query);

	    if( count($result) > 0 and $result[0]['tyyppi'] === 'peli') {
	        $this->addError("On liian vaarallista päästä tuhoamaan peli täältä. Joten sitä ei sallita.");
		/*
		$this->db->doQuery($this->delete('maali', 'maaliid'));		
		$this->db->doQuery($this->delete('rangaistus', 'rangaistusid'));
		$this->db->doQuery($this->delete('epaonnisrankku', 'epaonnisrankkuid'));
		$this->db->doQuery("DELETE FROM pelaajatilasto WHERE peliid = '$_REQUEST[tapahtumaid]'");
		$this->db->doQuery("DELETE FROM tilastomerkinta WHERE peliid = '$_REQUEST[tapahtumaid]'");
		$this->db->doQuery("DELETE FROM peli WHERE peliid = '$_REQUEST[tapahtumaid]'");
		 */
		parent::suorita();
	    }
	    else {    
		$query = "DELETE FROM osallistuja WHERE tapahtumaid = '$_REQUEST[tapahtumaid]'";
		$query2 = "DELETE FROM tapahtuma WHERE tapahtumaid = '$_REQUEST[tapahtumaid]'";
		$result = $this->db->doQuery($query);
		$result = $this->db->doQuery($query2);
		
		if ( !$this->db->error ) {
		    //tästa alkaa takaisinkytkennän toimintasarja
		    $this->drawForm = false;
		    $this->suoritaAutoRefresh();
		    return;
		}	    
		$this->db->close();	    
	    }
	}
	else {
	    parent::suorita();
	}
    }
    
    function taytaErikoisKentat() {
        $this->openConnection();

        // muokataan vanhaa
        if( isset($_REQUEST['tapahtumaid']) and $_REQUEST['tapahtumaid'] > 0)
        {
            D("haetaaaan<br>");
            $this->haeTiedotKannasta();
            $this->tiedot['tapahtumaid'][0] = new Input('tapahtumaid', $_REQUEST['tapahtumaid'], 'hidden');
        }

        $vastuuhlo = "vastuuhlo";
        $result = &$this->db->doQuery("(SELECT -1 as value, 'Ei tiedossa' as nimi) UNION (SELECT hloid as value, trim(etunimi||' '||sukunimi) as nimi FROM henkilo ORDER BY nimi)");
        $this->tiedot[$vastuuhlo][0] = new Select( $result, $vastuuhlo, $this->tiedot[$vastuuhlo][0] );

        /*
        $tyyppi = "tyyppi";
        $result = &$this->db->doQuery("SELECT tyyppi as value, tyyppi as nimi FROM Tyyppi");
        $this->tiedot[$tyyppi][0] = new Select( $result, $tyyppi, $this->tiedot[$tyyppi][0] );
        */

        $tyyppi = 'tyyppi';
        $result = &$this->db->doQuery("SELECT tyyppi as value, tyyppi as nimi FROM Tyyppi");
        $this->tiedot[$tyyppi][0] = &$result;
        $this->tiedot[$tyyppi][0] = $this->luoLomakeElementti($tyyppi, $this->tiedot[$tyyppi], $this->tyyppi, 'tyypinlisays','uusityyppi');

        $this->db->close();
    }

    function lueJaTarkistaRequest(){
	    
	$result = parent::lueJaTarkistaRequest();
	if ( $this->tiedot['tyyppi'][0] === 'peli' ) {
	    $this->addError($this->tm->getText('Lisää peli "Pelin lis&auml;ys" -linkin kautta!'));
	    $result = FALSE;
	}
	return $result;
    }
    
    function haeTiedotKannasta () {

        // haetaan pelin tiedot
        $result = &$this->db->doQuery("SELECT tapahtumaid, " .
            "   vastuuhlo, tyyppi, " .
            "   paikka, paiva, aika, kuvaus " .
            " FROM tapahtuma WHERE tapahtumaid = $_REQUEST[tapahtumaid]");


        // täytetään kannan taulukon tulokset luokan tiedoiksi
        foreach ( $this->tiedot as $k => $v ) {
            if ( array_key_exists($k, $result[0]) ) {
                $this->tiedot[$k][0] = $result[0][$k];
            }
        }

        $this->osallistujat['paasee'] = $this->db->doQuery(
            "SELECT (sukunimi||' '||etunimi) as nimi FROM Henkilo WHERE hloid IN (SELECT osallistuja FROM osallistuja WHERE tapahtumaid = $_REQUEST[tapahtumaid] and paasee = 't') ORDER BY nimi");

        $this->osallistujat['eipaase'] = $this->db->doQuery(
            "SELECT (sukunimi||' '||etunimi) as nimi, " .
            " (SELECT selite FROM osallistuja WHERE tapahtumaid = $_REQUEST[tapahtumaid] and osallistuja = hloid) as selite" .
            " FROM Henkilo WHERE hloid IN (SELECT osallistuja FROM osallistuja WHERE tapahtumaid = $_REQUEST[tapahtumaid] and paasee = 'f') ORDER BY nimi");
        $this->tyyppi = $this->tiedot['tyyppi'][0];     
        
        $this->view->otsikko = $this->tm->getText($this->tyyppi) . ' (' . $this->tiedot['paiva'][0]. ', '. substr($this->tiedot['aika'][0],0,5).')';    
            
    }

    function laitaKantaan () {

        $tapahtumaArvot = array('paikka', 'vastuuhlo', 'tyyppi', 'paiva', 'aika', 'kuvaus');

        // open connection to db
        $this->openConnection();

        if ( $this->arvotAsetettu($tapahtumaArvot) ) {

            if ( empty($_REQUEST['tapahtumaid']) ) {
                // insert, uusi tapahtuma
                $query = $this->rakennaSQLLauseke($tapahtumaArvot, "tapahtuma");
                $this->db->doQuery($query);
            }
            else {
                // update, yhteystieto on jo olemassa
                $ehdot = "tapahtumaid = ".$_REQUEST['tapahtumaid'];
                $query = $this->paivittavaSQLLauseke($tapahtumaArvot, 'tapahtuma', $ehdot);
                $this->db->doQuery($query);
            }
        }

        $this->db->close();
    }
}
?>
