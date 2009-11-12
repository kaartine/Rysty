<?php
/*
 * Created on Jan 19, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */

 require_once("lisattava.php");
 require_once("lisattavaview.php");
 require_once("lomakeelementit.php");

 class PelinLisays extends Lisattava
{


    var $drawForm;
    var $notset;
    var $result;

    function PelinLisays(){
        $this->Lisattava('pelinlisays');
        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);
        $this->tiedot=array(
            'pelipaikka'=>array(NULL,FALSE,'SELECTLISAA'),
            'paikka'=>array(NULL,FALSE,'TEXT',100),
            'aika'=>array('',TRUE,'TIME_HH_MM',5),
            'paiva'=>array('',TRUE,'PVM',10),
            'tyyppi'=>array(NULL,TRUE,'SELECT'),
            'kotijoukkue'=>array(NULL,TRUE,'SELECT'),
            'vierasjoukkue'=>array('',TRUE,'SELECT'),
            'sarja'=>array('',TRUE,'SELECT',10),
            'kuvaus'=>array('',FALSE,'TEXTAREA'),
            'peliid'=>array(NULL,FALSE,'HIDDEN')
           );

        //$this->pakollisetTiedot=array('pelipaikka', 'aika', 'paiva', 'tyyppi', 'kotijoukkue', 'vierasjoukkue', 'sarja');
        $this->viewName = "LisattavaView";
        $this->taulunNimi = "tapahtuma";
        $this->toiminnonNimi = 'pelinlisays';
    }


    function taytaErikoisKentat() {
        $this->openConnection();

        // muokataan vanhaa
        if( isset($_REQUEST['peliid']) and $_REQUEST['peliid'] > 0)
        {
            $this->haeTiedotKannasta();
            $this->tiedot['peliid'][0] = new Input('peliid', $_REQUEST['peliid'], 'hidden');
        }

        $joukkue = "kotijoukkue";
        $result = &$this->db->doQuery("SELECT joukkueid, lyhytnimi FROM Joukkue ORDER BY lyhytnimi");

        $this->tiedot[$joukkue][0] = new Select( $result, $joukkue, $this->tiedot[$joukkue][0] );

        $joukkue = "vierasjoukkue";
        $this->tiedot[$joukkue][0] = new Select( $result, $joukkue, $this->tiedot[$joukkue][0] );

        /*
        $halli = "pelipaikka";
        $result = &$this->db->doQuery("SELECT halliid, nimi FROM Halli ORDER BY nimi");
        $this->tiedot[$halli][0] = new Select( $result, $halli, $this->tiedot[$halli][0] );
        */

        $halli = "pelipaikka";
        $result = &$this->db->doQuery("SELECT halliid, nimi FROM Halli ORDER BY nimi");
        $tmp = $this->tiedot[$halli][0];
        $this->tiedot[$halli][0] = &$result;
        $this->tiedot[$halli][0] = $this->luoLomakeElementti($halli, $this->tiedot[$halli], $tmp, 'hallinlisays','uusihalli');

        $tyyppi = "tyyppi";
        $this->tiedot[$tyyppi][0] = new Input( $tyyppi, "peli", "hidden");

        $sarja = "sarja";
        $result = &$this->db->doQuery("SELECT sarjaid, (kausi||', '||tyyppi||', '||nimi) FROM Sarja ORDER BY kausi desc, tyyppi asc");
        $this->tiedot[$sarja][0] = new Select( $result, $sarja, $this->tiedot[$sarja][0] );

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
        $result1 = &$this->db->doQuery("SELECT peliid, kotijoukkue, vierasjoukkue, sarja, pelipaikka" .
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

//        D( "<pre>");
//        D($this->tiedot);
//        D("</pre>");

    }


    function laitaKantaan () {

        $tapahtumaArvot = array('paikka', 'tyyppi', 'paiva', 'aika', 'kuvaus');
        $peliArvot = array('kotijoukkue', 'vierasjoukkue', 'sarja', 'pelipaikka');

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
                // update, yhteystieto on jo olemassa
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
            // update, henkilö on jo olemassa
            $ehdot = "peliid = ".$_REQUEST['peliid'];
            $query = $this->paivittavaSQLLauseke($peliArvot, 'peli', $ehdot);
            $this->db->doQuery($query);
            D("vanha peli<br>");
        }

        // do final commit and close
        $this->db->close();
    }
}
?>
