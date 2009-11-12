<?php
/*
 * Created on Mar 11, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */

require_once("lisattava.php");
require_once("lisattavaview.php");
require_once("lomakeelementit.php");
require_once("tuloslisays1.php");
require_once("tuloksenlisaysotsikko.php");

class TuloksenLisays extends Lisattava
{
    var $koti;
    var $vieras;
    var $tilahistoria=array(-9,1);
    var $useOldTiedot;
    var $otsikkoView;
    /* sivut
    1. maalimäärät ja jäähymäärät
    2. kokoonpano
    3. maalintekijät
    4. varmista
    */


    function TuloksenLisays () {
        $this->Lisattava('tuloksenlisays'); // call super
        $this->useOldTiedot = FALSE;
        $this->tiedot=array(
            'peliid'=>array(NULL,TRUE,'HIDDEN'),

            'kotimaalit'=>array('',TRUE,'NUMBER',5),
            'vierasmaalit'=>array('',TRUE,'NUMBER',5),

            'kotiepaonnstuneetrankut'=>array('',FALSE,'NUMBER',5),
            'vierasepaonnstuneetrankut'=>array('',FALSE,'NUMBER',5),

            'eipoytakirjaa'=>array('ei poyt&auml;kirjaa',FALSE,'CHECKBOX',40,false),
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
            'vierasjoukkue'=>array('',FALSE,'HIDDEN'),
            'kotijoukkue'=>array('',FALSE,'HIDDEN'),
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
        if  ( !isset($_SESSION['nykyTila'] ) ) {
            $_SESSION['nykyTila'] = 1;
        }
        unset($this->koti);
        unset($this->vieras);
        unset($this->otsikkoView);


        $this->asetaSeuraavaTila();
        //$this->toiminnonNimi = 'tuloksenlisays'.$_SESSION['nykyTila'];

    }
    function asetaSeuraavaTila () {
        $tila = 0;
        $v = 1;


/*        print "<pre>";
        print $_SESSION['nykyTila']. ' ';
        print $_REQUEST['seuraavatila'];
        print "</pre>";
        */
        if ( isset( $_SESSION['nykyTila'] )  and (isset($_REQUEST['seuraava']) or isset($_REQUEST['edellinen'])) and
                        ($_SESSION['nykyTila']+1) == ($_REQUEST['seuraavatila']) )
         {
            $this->useOldTiedot = TRUE;

            $this->koti = unserialize($_SESSION['tuloslisays']['koti'] );
            $this->vieras = unserialize( $_SESSION['tuloslisays']['vieras']);
            if ( isset($_SESSION['tiedot'])) {

                $this->tiedot = unserialize($_SESSION['tiedot']);

            }

            $tila = $_SESSION['nykyTila'];
            if ( isset($_REQUEST['seuraava']) ) {
                $v = ($tila+1);
                if ( $tila == 1){
                    if ( isset($_REQUEST['eipoytakirjaa'])) {
                        $v = 4;
                        $this->tiedot['eipoytakirjaa'][4] = true;
                    } else {
                        $this->tiedot['eipoytakirjaa'][4] = false;
                    }
                }

            }
            else if ( isset($_REQUEST['edellinen']) ) {
                if ( $this->tiedot['eipoytakirjaa'][4] === true){
                    $v = 1;
                }
                else {
                    $v = ($tila-1);
                }
            }
        } else {
            unset($_SESSION['tiedot']);
            $_SESSION['tuloslisays'] = array();
            $this->useOldTiedot = FALSE;
            $_SESSION['nykyTila'] = 1;
         }

        if ( $v > 1 ) {
            $_SESSION['vanhaTila'] = $tila;
        }
        else {
            $_SESSION['vanhaTila'] = -9;
            $v = 1;
        }

        $_SESSION['seuraavatila'] = $v;


    }
    function lataaView($v) {
        D('<br>lataaview: '.$v);
        $this->otsikkoView = new TuloksenOtsikko($this->tiedot);

        if ( $v == 2 )
        {
            require_once("tuloksenlisays2.php");
            $this->viewName = "TuloksenLisays2View";
        }
        else if ( $v == 3 )
        {
            require_once("tuloksenlisays3.php");
            $this->viewName = "TuloksenLisays3View";
        }
        else if ( $v == 4 )
        {
            require_once("tuloksenlisays4.php");
            $this->viewName = "TuloksenLisays4View";
        }
        else if ( $v == 5 )
        {
            require_once("tuloksenlisays5.php");
            $this->viewName = "TuloksenLisays5View";
        }

        else {

            require_once("tuloksenlisays1.php");
            $this->viewName = "TuloksenLisaysView";
        }


    }

    function suorita( )
    {
        $seuraava = $_SESSION['seuraavatila'];
        //$_SESSION['nykyTila'];
        $this->checkContent($_REQUEST);
        D( "<br>seuraava1: $seuraava <br>");

        if ( !$this->lueJaTarkistaRequest() ) {
            if ( $this->useOldTiedot ) {
                $seuraava = 1;
            } else {
                $this->errors = array();
            }
        }


        if ( !$this->taytaErikoisKentat()){
            if ( $this->koti == NULL or $this->vieras == NULL ) {

                require_once('errorview.php');
               $this->createView('ErrorView');
               unset($_SESSION['nykyTila']);
                return;
            }
            $seuraava = $_SESSION['nykyTila'];
            D( "<br>seuraava1: $seuraava <br>" . $_SESSION['vanhaTila']);
        }

        $_SESSION['nykyTila'] = $seuraava;

        $this->tiedot['seuraavatila'][0] = $_SESSION['nykyTila']+1;
        $_SESSION['tiedot'] = serialize($this->tiedot);

        $_SESSION['tuloslisays']['koti'] = serialize($this->koti);
        $_SESSION['tuloslisays']['vieras'] = serialize($this->vieras);

        $this->lataaView($seuraava);
        $this->createView($this->viewName);
        // tämän pitäisi olla viewin puolella mutta jätetään se tähän viimeiseksi
        $this->luoLomakeElementit();
        if ( $seuraava == 5 ) {
            unset($_SESSION['nykyTila']);
        }

    }

    function taytaErikoisKentat () {

        $success = TRUE;
        $next = NULL;
        if ( $this->useOldTiedot ) {
            $next = $_REQUEST['seuraavatila'];
        }
        if ( $next == NULL ) {
            $success = $this->tila1();
        }
        else {

            if (  $next == 2 ) {
                $success = $this->tila2();
            }
            else if (  $next == 3 ) {
                $success = $this->tila3();
            }
            else if (  $next == 4 ) {
                $success = $this->tila4();
            }
            else if (  $next == 5 ) {
                if ( $_SESSION['nykyTila'] == 4 and isset($_REQUEST['seuraava']) and $_REQUEST['finish'] === 'now') {
                    $this->laitakantaan();
                    unset($_SESSION['tiedot']);
                    unset($_SESSION['tuloslisays']);
                    unset($_SESSION['nykyTila']);
                }
            }
            else {
                $this->addError('Tuntematon virhe tuloksenlis&auml;yksess&auml;! Tilaa ei tunneta: '.$next);
                // on virheen paikka
                $success =FALSE;
                 unset($_SESSION['tiedot']);
                 unset($_SESSION['tuloslisays']);

                $this->koti = NULL;
                $this->vierasi = NULL;
            }
        }
        if ( isset($_REQUEST['edellinen']) and !$success ){
         $success = TRUE;
         $this->errors = array();
        }
        return $success;

    }

    function tila1() {
        $_SESSION['tiedot'] = NULL;
        unset($_SESSION['tiedot']);


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

        if ( count($result1[0]) == 0) {
            $this->db->close();
            $this->addError($this->tm->getText('Virheellinen peli'));
            $this->kantaanLaitettu =NULL;
             unset($_SESSION['tiedot']);
             unset($_SESSION['tuloslisays']);
            $this->koti = NULL;
            $this->vierasi = NULL;
            unset($_SESSION['nykyTila']);
            return FALSE;
        }
        $this->koti = new JoukkueTieto($result1[0]['kotijoukkue'], 'koti');
        $this->vieras = new JoukkueTieto($result1[0]['vierasjoukkue'], 'vieras');
/*
print '<hr><pre>';
print_r($result1);
print '<pre><hr>';
*/
        $this->koti->maalienlkm = $result1[0]['kotimaalit'];
        $this->vieras->maalienlkm = $result1[0]['vierasmaalit'];
        $this->koti->nimi = $result1[0]['kotijoukkuenimi'];
        $this->vieras->nimi = $result1[0]['vierasjoukkuenimi'];

        $tapahtuma = &$this->db->doQuery("SELECT tyyppi, (paiva||', '||to_char(aika,'HH24:MI')) as pvm, kuvaus FROM tapahtuma WHERE tapahtumaid = $_REQUEST[peliid]");
        // nämä käyttää tietokantaa
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

       if ( $this->tiedot['kotimaalit'][0]  === NULL and $this->tiedot['vierasmaalit'][0] === NULL  ) {
            $_SESSION['tuloslisays']['uusipeli'] = TRUE;
       } else {
            $_SESSION['tuloslisays']['uusipeli'] = FALSE;
       }


        $this->tiedot['kotirangaistukset'][0] = count( $this->koti->jaahyt);
        $this->tiedot['vierasrangaistukset'][0] = count($this->vieras->jaahyt);
        $this->tiedot['kotiepaonnstuneetrankut'][0] = count($this->koti->epaonnisrankut);
        $this->tiedot['vierasepaonnstuneetrankut'][0] = count($this->vieras->epaonnisrankut);
    }





    function tila2() {


            $this->koti->maalienlkm = $this->tiedot['kotimaalit'][0];
            $this->vieras->maalienlkm = $this->tiedot['vierasmaalit'][0];
            $this->koti->rangaistustenlkm = $this->tiedot['kotirangaistukset'][0];
            $this->vieras->rangaistustenlkm = $this->tiedot['vierasrangaistukset'][0];
            $this->koti->epaonnistuneidenlkm = $this->tiedot['kotiepaonnstuneetrankut'][0];
            $this->vieras->epaonnistuneidenlkm = $this->tiedot['vierasepaonnstuneetrankut'][0];

            $this->koti->luoMaalit();
            $this->vieras->luoMaalit();

        return true;

    }

    function tila3() {

            $success = $this->koti->taytaMaalivathditjaKokoonpano($this);


            if ( !$this->vieras->taytaMaalivathditjaKokoonpano($this) ) {
                $success = FALSE;
            }
            return $success;

    }
    function tila4() {
        $success = TRUE;
            if ( !$this->koti->lueRequestMaalit() ) {
                $success = FALSE;
                $e = &$this->koti->errors;
                for ($index = 0; $index < sizeof($e); $index++) {

                    $this->addError($e[$index]);
                    $this->addError($e[++$index]);
                }
            }
            if ( !$this->vieras->lueRequestMaalit() ) {
                $success = FALSE;
                $e = &$this->vieras->errors;
                for ($index = 0; $index < sizeof($e); $index++) {
                    $this->addError($e[$index]);
                    $this->addError($e[++$index]);
                }
            }
        if ( !$success ){

        }
        // reset error messages
         $this->koti->errors = array();
        $this->vieras->errors = array();
        return $success;
    }
    function laitaKantaan(){
        $peliid = $this->tiedot['peliid'][0];
        $this->openConnection();
        // ensin tuhotaan vanhat
        $this->db->doQuery($this->delete('maali', 'maaliid'));
        $this->db->doQuery($this->delete('rangaistus', 'rangaistusid'));
        $this->db->doQuery($this->delete('epaonnisrankku', 'epaonnisrankkuid'));
        $this->db->doQuery(
                    "DELETE FROM pelaajatilasto WHERE peliid = $peliid");
        $this->db->doQuery(
                    "DELETE FROM tilastomerkinta WHERE peliid = $peliid");
        $tiedot = array(
 'vierasjoukkue','kotijoukkue','sarja',
'atoimihenkilo1', 'atoimihenkilo2',  'atoimihenkilo3',  'atoimihenkilo4', 'atoimihenkilo5', 'btoimihenkilo1', 'btoimihenkilo2',
'btoimihenkilo3', 'btoimihenkilo4', 'btoimihenkilo5',
//'pelipaikka',
'kotimaalit', 'vierasmaalit', 'tuomari1',
 'tuomari2', 'toimitsija1', 'toimitsija2', 'toimitsija3',  'huomio', 'aikalisaa', 'aikalisab',  'yleisomaara'
        );
//        $this->tiedot['aikalisaa'][0] = tarkistaAika($this->tiedot['aikalisaa'][0]);
//        $this->tiedot['aikalisab'][0] = tarkistaAika($this->tiedot['aikalisab'][0]);
        $this->db->doQuery(
            $this->paivittavaSQLLauseke($tiedot,'peli',"peliid = $peliid")   );
        // sitten luodaan uudet, jos pöytäkirja asetettu
        if ( $this->tiedot['eipoytakirjaa'][4] === false){
             $this->laitaJoukkueKantaan($this->koti);
             $this->laitaJoukkueKantaan($this->vieras);
         }

        $this->db->close();
        $this->suoritaAutoRefresh();
    }


    function laitaJoukkueKantaan(&$j) {
        $j->pelaajatilastot($this->db);
        $j->maalitKantaan($this->db);
        $j->jaahytKantaan($this->db);
        $j->epaonnistuneetKantaan($this->db);
    }
    function delete ($taulu, $idnimi) {
                $peliid = $this->tiedot['peliid'][0];
                return "delete FROM $taulu WHERE $idnimi = " .
                "(select timerkintaid from tilastomerkinta where peliid = $peliid and timerkintaid = $idnimi)";
    }
}
function tarkistaAika($aika){
    if ( !empty($aika) ) {
            $aika = str_replace(',',':',$aika);
            $aika = '00:'.str_replace('.',':',$aika);
    } else {
        return 'NULL';
    }
    return "'$aika'";
}
?>
