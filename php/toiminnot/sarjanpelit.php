<?php
/**
 * sarjanpelit.php  
 * Copyright Rysty 2006:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * author: tepe
 * created: %date%
 * 
*/

require_once("lomakeelementit.php");
require_once("sarjanpelitview.php");
require_once("sarjanpeliteditcomp.php");
require_once("lisattava.php");

/**
 * class SarjaTilastot
 * 
 */
class SarjanPelit extends Lisattava
{
    var $data;
    var $sarjanpelit;
    var $sarjat;

    function SarjanPelit() {
        $this->Lisattava( 'sarjanpelit' );
        
        $this->viewName = "SarjanPelitView";

        if( isset($_REQUEST['sarja']) and is_numeric($_REQUEST['sarja']) ) {
            $_SESSION['sarja'] = $_REQUEST['sarja'];
        }
        else if( !isset($_SESSION['sarja']) ) {
            $_SESSION['sarja'] = $_SESSION['defaultsarja'];
        }
        
        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);
        $this->tiedot=array(
            'paiva'=>array('',TRUE,'PVM',10),
            'aika'=>array('',TRUE,'TIME_HH_MM',5),
            'tyyppi'=>array(NULL,TRUE,'SELECT'),
            'kotijoukkue'=>array(NULL,TRUE,'SELECT'),
            'kotimaalit'=>array(NULL,FALSE,'TEXT','2'),
            'vierasjoukkue'=>array('',TRUE,'SELECT'),
            'vierasmaalit'=>array(NULL,FALSE,'TEXT','2'),
            'pelipaikka'=>array(NULL,FALSE,'SELECTLISAA'),
            'paikka'=>array(NULL,FALSE,'TEXT',100),
            'sarja'=>array('',TRUE,'HIDDEN'),
            'kuvaus'=>array('',FALSE,'TEXTAREA'),
            'peliid'=>array(NULL,FALSE,'HIDDEN')
           );


  //      $this->taulunNimi = "tapahtuma";
//        $this->toiminnonNimi = 'sarjanpelit';
    }

    function suorita() {
        parent::suorita();
        
        // open connection to db
        $this->openConnection();
        
        $sarja = "sarja";
        $result = &$this->db->doQuery("SELECT sarjaid, (kausi||', '||tyyppi||', '||nimi) as value FROM Sarja ORDER BY kausi DESC");
        $this->sarjat = new Select( $result, $sarja, $_SESSION['sarja'], TRUE );
        
        $this->db->close();
        
        $this->sarjanpelit = new SeriesPlayedGamesEdit('sarjanpelit', TRUE);
        $this->sarjanpelit->addParameters(array('sarjaid' => $_SESSION['sarja'] ));
        $this->sarjanpelit->suorita();        
    }


    function taytaErikoisKentat() {
        $this->openConnection();

        // muokataan vanhaa
        if( isset($_REQUEST['peliid']) and $_REQUEST['peliid'] > 0) {
            if( $this->voiMuokata() ) {
	            $this->haeTiedotKannasta();
	            $this->tiedot['peliid'][0] = new Input('peliid', $_REQUEST['peliid'], 'hidden');
            }
			else {
			    unset($_REQUEST['peliid']);
			    $this->addError($this->tm->getText('eivoidamuokata'));
			}
        }
        else {
            $this->tiedot['aika'][0] = '12:00';//date('H:i');
            $this->tiedot['paiva'][0] = date('d.m.Y');
        }

        $joukkue = "kotijoukkue";
        $result = &$this->db->doQuery("SELECT joukkueid, lyhytnimi FROM Joukkue, Sarjanjoukkueet WHERE sarjaid = ".$_SESSION['sarja']." and joukkue = joukkueid ORDER BY lyhytnimi");

        $this->tiedot[$joukkue][0] = new Select( $result, $joukkue, $this->tiedot[$joukkue][0] );

        $joukkue = "vierasjoukkue";
        $this->tiedot[$joukkue][0] = new Select( $result, $joukkue, $this->tiedot[$joukkue][0] );

        $halli = "pelipaikka";
        $result = &$this->db->doQuery("SELECT halliid, nimi FROM Halli ORDER BY nimi");
        $tmp = $this->tiedot[$halli][0];
        $this->tiedot[$halli][0] = &$result;
        $this->tiedot[$halli][0] = $this->luoLomakeElementti($halli, $this->tiedot[$halli], $tmp, 'hallinlisays','uusihalli');

        $tyyppi = "tyyppi";
        $this->tiedot[$tyyppi][0] = new Input( $tyyppi, "peli", "hidden");

//        $sarja = "sarja";
//        $result = &$this->db->doQuery("SELECT sarjaid, (kausi||', '||tyyppi||', '||nimi) FROM Sarja ORDER BY kausi desc, tyyppi asc");
//        $this->tiedot[$sarja][0] = new Select( $result, $sarja, $this->tiedot[$sarja][0] );
        $this->tiedot['sarja'][0] = $_SESSION['sarja'];
        
        $this->db->close();
    }
    function lueJaTarkistaRequest(){

        $result = parent::lueJaTarkistaRequest();
         if ( $this->tiedot['kotijoukkue'][0] == $this->tiedot['vierasjoukkue'][0] ) {
            $this->addError($this->tm->getText('Joukke ei voi pelata kesken&auml;&auml;n!'));
            $result = FALSE;
         }
         return $result;
    }
    
    
    function haeTiedotKannasta () {
        
        
		// haetaan pelin tiedot
		$result1 = &$this->db->doQuery("SELECT peliid, kotijoukkue, vierasjoukkue, sarja, pelipaikka, kotimaalit, vierasmaalit" .
		        " FROM Peli WHERE peliid = $_REQUEST[peliid]");
		
		$result2 = &$this->db->doQuery("SELECT tyyppi, to_char(aika,'HH24:MI') as aika, paiva, kuvaus FROM Tapahtuma WHERE tapahtumaid = $_REQUEST[peliid]");
		
		 // summataan taulukot yhdeksi isoksi
		$result = &$result1[0];
		if ( count($result2) == 1) {
		    $result = $result + $result2[0];
		}
		
		// täytetään kannan taulukon tulokset luokan tiedoiksi
		foreach ( $this->tiedot as $k => $v ) {
		    if ( array_key_exists($k, $result) ) {
		        $this->tiedot[$k][0] = $result[$k];
		    }
		}
    }


    function laitaKantaan () {

        $tapahtumaArvot = array('paikka', 'tyyppi', 'paiva', 'aika', 'kuvaus');
        $peliArvot = array('kotijoukkue', 'kotimaalit', 'vierasmaalit', 'vierasjoukkue', 'sarja', 'pelipaikka');

        // open connection to db
        $this->openConnection();

        if ( $this->arvotAsetettu($tapahtumaArvot) ) {

            if ( empty($_REQUEST['peliid']) ) {
                // insert, uusi tapahtuma
                $this->luoID('tapahtumaid','tapahtuma_tapahtumaid_seq');
                array_push($tapahtumaArvot,'tapahtumaid');

                $query = $this->rakennaSQLLauseke($tapahtumaArvot, "tapahtuma");
                $this->db->doQuery($query);

                $this->tiedot['peliid'] = $this->tiedot['tapahtumaid'];
                $_REQUEST['peli'] = $this->tiedot['peliid'][0];

                array_push($peliArvot, 'peliid');
            }
            else {
	            // update, tapahtuma on jo olemassa
	            $ehdot = "tapahtumaid = ".$_REQUEST['peliid'];
	            $query = $this->paivittavaSQLLauseke($tapahtumaArvot, 'tapahtuma', $ehdot);
	            $this->db->doQuery($query);
            }
        }

        if ( !isset($_REQUEST['peliid']) ) {
            // insert, uusi peli
            $_REQUEST['peliid'] = $_REQUEST['peli'];
            $query = $this->rakennaSQLLauseke($peliArvot, "peli");
            $this->db->doQuery($query);
            D("uusi peli<br>");
        }
        else {
            // update, peli on jo olemassa
            $ehdot = "peliid = ".$_REQUEST['peliid'];
            $query = $this->paivittavaSQLLauseke($peliArvot, 'peli', $ehdot);
            $this->db->doQuery($query);
            D("vanha peli<br>");
        }

        // do final commit and close
        $this->db->close();
    }
    
    function poistaRivi() {
        if( isset($_REQUEST['peliid']) && is_numeric($_REQUEST['peliid']) ) {
            // open connection to db
            $this->openConnection();
            
            if( $this->voiMuokata() == false ) {
                $this->addError($this->tm->getText('eivoidapoistaa'));
                // do final commit and close
                $this->db->close();            
            }
            else {

	            $query = 'DELETE from Peli WHERE peliid = '. $_REQUEST['peliid'];
	            $this->db->doQuery($query);
	            
	            $query = 'DELETE from Tapahtuma WHERE tapahtumaid = '. $_REQUEST['peliid'];
	            $this->db->doQuery($query);
	                        
	            // do final commit and close
	            $this->db->close();
            }
        }
    }
    
    function voiMuokata() {
        $query = 'SELECT count(tm.peliid) FROM Pelaajatilasto as pt, Tilastomerkinta as tm WHERE tm.peliid = pt.peliid AND pt.peliid = '. $_REQUEST['peliid'];
		$ret = $this->db->doQuery($query);
		D($ret);
		if ($ret[0]['count'] > 0 ) {
		    return false;
		}
		return true;
    }

    

} // end of SarjaTilastot
?>
