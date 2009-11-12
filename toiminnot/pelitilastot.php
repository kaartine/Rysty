<?php
/**
 * pelitilastot.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: %date%
 *
*/
require_once('toiminto.php');
require_once('tuloslisays1.php');
require_once('peliview.php');
require_once("tuloksenlisaysotsikko.php");

/**
 * class PeliTilastot
 *
 */
class PeliTilastot extends Toiminto
{
    var $koti;
    var $vieras;
    var $tiedot;



    function PeliTilastot () {

        $this->Toiminto('pelitilastot'); // call super
        $this->viewName = 'PeliView';
      $this->tiedot=array(

            'kotimaalit'=>array('',TRUE,'NUMBER',5),
            'vierasmaalit'=>array('',TRUE,'NUMBER',5),

            'kotiepaonnstuneetrankut'=>array('',FALSE,'NUMBER',5),
            'vierasepaonnstuneetrankut'=>array('',FALSE,'NUMBER',5),

            'kotirangaistukset'=>array('',FALSE,'NUMBER',5),
            'vierasrangaistukset'=>array('',FALSE,'NUMBER',5),
            'aikalisaa'=>array('',FALSE,'TIME_MM_SS',5),
            'aikalisab'=>array('',FALSE,'TIME_MM_SS',5),
            'tuomari1'=>array('',FALSE,'TEXT'),
            'tuomari2'=>array('',FALSE,'TEXT'),
            'yleisomaara'=>array('',FALSE,'TEXT'),
            'toimitsija1'=>array('',FALSE,'TEXT'),
            'toimitsija2'=>array('',FALSE,'TEXT'),
            'toimitsija3'=>array('',FALSE,'TEXT'),
            'sarja'=>array('',FALSE,'HIDDEN'),
            'kausi'=>array('',FALSE,'HIDDEN'),
            'pelipaikka'=>array('',FALSE,'TEXT'),
            'huomio'=>array('',FALSE,'TEXT'),
            'kuvaus' =>array('',FALSE,'TEXT'),
            'toiminto'=>array('tuloksenlisays',FALSE,'HIDDEN'),
            'seuraavatila'=>array(NULL,FALSE,'HIDDEN'),
            'pvm'=>array('',FALSE,'LABEL'),// -> 'LABEL'
            'sarjanimi'=>array('',FALSE,'LABEL'), //-> 'LABEL'
            'atoimihenkilo1'=>array('',FALSE,'HIDDEN'),
            'atoimihenkilo2'=>array('',FALSE,'HIDDEN'),
            'atoimihenkilo3'=>array('',FALSE,'HIDDEN'),
            'atoimihenkilo4'=>array('',FALSE,'HIDDEN'),
            'atoimihenkilo5'=>array('',FALSE,'HIDDEN'),
            'btoimihenkilo1'=>array('',FALSE,'HIDDEN'),
            'btoimihenkilo2'=>array('',FALSE,'HIDDEN'),
            'btoimihenkilo3'=>array('',FALSE,'HIDDEN'),
            'btoimihenkilo4'=>array('',FALSE,'HIDDEN'),
            'btoimihenkilo5'=>array('',FALSE,'HIDDEN'),

            'kotijoukkuenimi'=>array('',FALSE,'HIDDEN'),
            'vierasjoukkuenimi'=>array('',FALSE,'HIDDEN'),
            'kotijoukkuepitkanimi'=>array('',FALSE,'HIDDEN'),
            'vierasjoukkuepitkanimi'=>array('',FALSE,'HIDDEN')

         );

    }
    function suorita(){
        $this->haeTiedot();
        $this->otsikkoView = new TuloksenOtsikko($this->tiedot);
        $this->createView($this->viewName);

    }

    function haeTiedot(){

        if ( !isset($_REQUEST['peliid']) or empty($_REQUEST['peliid']) ) {
            if ( isset($_SESSION['pelitilastot']['peliid']) )
            {
                $_REQUEST['peliid'] = $_SESSION['pelitilastot']['peliid'];
            }
        }
        else {
          $_SESSION['pelitilastot'] = array(
              'peliid'=>$_REQUEST['peliid']
              );
        }


        if ( empty($_REQUEST['peliid']) ) {
            D('VIRHE!!!');
            $this->addError($this->tm->getText('Virhellinen peli!'));
            return;
        }
        $this->openConnection();

        $result1 = &$this->db->doQuery('SELECT *, '.
                "to_char(aikalisaa,'MI:SS') as aikalisaa,  to_char(aikalisab,'MI:SS') as aikalisab, " .
                '(SELECT kausi from sarja where sarjaid = sarja ) as kausi, ' .
                '(SELECT lyhytnimi from joukkue ' .
                'where joukkueid = kotijoukkue) as kotijoukkuenimi , ' .
                '(SELECT lyhytnimi from joukkue  ' .
                'where joukkueid = vierasjoukkue ) as vierasjoukkuenimi, ' .
                '(SELECT pitkanimi from joukkue ' .
                'where joukkueid = kotijoukkue) as kotijoukkuepitkanimi , ' .
                '(SELECT pitkanimi from joukkue  ' .
                'where joukkueid = vierasjoukkue ) as vierasjoukkuepitkanimi, ' .
                '(SELECT nimi from sarja where sarjaid = sarja ) as sarjanimi, ' .
                '(SELECT nimi from halli where halliid = pelipaikka ) as pelipaikka ' .
                "FROM Peli WHERE peliid = $_REQUEST[peliid]");


        $this->koti = new JoukkueTieto($result1[0]['kotijoukkue'], 'koti');
        $this->vieras = new JoukkueTieto($result1[0]['vierasjoukkue'], 'vieras');


        $this->koti->viewOnly = TRUE;
        $this->vieras->viewOnly = TRUE;
/*
D('<hr><pre>');
D($result1);
D('<pre><hr>');
*/
        $this->koti->maalienlkm = $result1[0]['kotimaalit'];
        $this->vieras->maalienlkm = $result1[0]['vierasmaalit'];
        $this->koti->nimi = $result1[0]['kotijoukkuenimi'];
        $this->vieras->nimi = $result1[0]['vierasjoukkuenimi'];

        $tapahtuma = &$this->db->doQuery("SELECT tyyppi, (paiva||', '||to_char(aika,'HH24:MI')) as pvm, kuvaus FROM tapahtuma WHERE tapahtumaid = $_REQUEST[peliid]");
        // nämä käyttää tietokantaa
        //$this->koti->luoPelaajat($result1[0]['kausi'], $this->db);
        //$this->vieras->luoPelaajat($result1[0]['kausi'], $this->db);

        /*$this->koti->haePelaajamerkinnat( $this->db );
        $this->koti->haeMaalitJaJaahyt( $this->db );
        $this->vieras->haePelaajamerkinnat( $this->db );
        $this->vieras->haeMaalitJaJaahyt( $this->db );*/

        $this->koti->luoPelaajat($result1[0]['kausi'], $this->db);
        $this->vieras->luoPelaajat($result1[0]['kausi'], $this->db);

        $this->db->close();

         // summataan taulukot yhdeksi isoksi
        $result = &$result1[0];

        if ( count($tapahtuma) == 1) {
            $result = $result + $tapahtuma[0];
        }
        // täytetään kannan taulukon tulokset luokan tiedoiksi
        foreach ( $this->tiedot as $k => $v ) {
            if ( array_key_exists($k, $result) ) {
                $this->tiedot[$k][0] = $result[$k];
            }
        }

/*
        $this->tiedot['kotirangaistukset'][0] = count( $this->koti->jaahyt);
        $this->tiedot['vierasrangaistukset'][0] = count($this->vieras->jaahyt);
        $this->tiedot['kotiepaonnstuneetrankut'][0] = count($this->koti->epaonnisrankut);
        $this->tiedot['vierasepaonnstuneetrankut'][0] = count($this->vieras->epaonnisrankut);
*/
    }






} // end of PeliTilastot
?>
