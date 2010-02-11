<?php


/**
 * kaudenjoukkue.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 20.03.2005
 *
*/

require_once "multilista.php";
require_once "joukkuekorttiview.php";
require_once "errorview.php";

class JoukkueKortti extends MultiLista {

    var $dataJoukkue;

    function JoukkueKortti() {
        $this->MultiLista('joukkuekortti');

        $this->columns = array(
            'pelaajat' => array('pelinumero','etunimi', 'sukunimi', 'pelipaikka', 'kapteeni'),
            'toimihenkilot' => array('tehtava','etunimi', 'sukunimi'));

        $this->links = array(
            'pelaajat' => array(
                'pelinumero'=>array(array('pelaaja','joukkueid'),'pelaajakortti'),
                'etunimi'=>array(array('pelaaja','joukkueid'),'pelaajakortti'),
                'sukunimi'=>array(array('pelaaja','joukkueid'),'pelaajakortti')),
            'toimihenkilot' => array(
                'tehtava'=>array(array('pelaaja','joukkueid'),'pelaajakortti'),
                'etunimi'=>array(array('pelaaja','joukkueid'),'pelaajakortti'),
                'sukunimi'=>array(array('pelaaja','joukkueid'),'pelaajakortti'))
        );

        $this->defaultorder = array(
            'pelaajat' => 'pelinumero',
            'toimihenkilot' => 'tehtava'
        );

        $this->order = array(
            'pelaajat' => NULL,
            'toimihenkilot' => NULL
        );

        $this->nextdirection = $this->order;

        $this->direction = $this->order;

        $this->viewname = "JoukkueKorttiView";

        unset($this->dataJoukkue);
        if ( isset($_REQUEST['kausi']) and isset($_REQUEST['joukkueid']) ) {
            $_SESSION['joukkuekortti'] = array('kausi' => $_REQUEST['kausi'],
                'joukkueid' => $_REQUEST['joukkueid']);
        } else {
            if ( isset($_SESSION['joukkuekortti']['kausi']) and isset($_SESSION['joukkuekortti']['joukkueid']) ) {
                $_REQUEST['kausi'] = $_SESSION['joukkuekortti']['kausi'];
                $_REQUEST['joukkueid'] = $_SESSION['joukkuekortti']['joukkueid'];
            } else {
                $_REQUEST['kausi'] = '';
                $_REQUEST['joukkueid'] = '';
            }
        }

        if ( empty($_REQUEST['kausi']) or empty($_REQUEST['joukkueid']) ) {
            $this->viewname = 'ErrorView';
            $this->addError($this->tm->getText('Virheelliset hakutiedot!'));
        }

    }

    function suorita( )
    {
        if ( $this->viewname == "ErrorView" ) {
            $this->createView($this->viewname);
            return;
        }

        $query = "SELECT pitkanimi, lyhytnimi, email, maskotti, k.kuvaus, kuva, j.logo as defaultlogo, k.logo, kotipaikka," .
                "(SELECT nimi FROM Halli WHERE halliid = k.kotihalli) as kotihalli " .
                "FROM Joukkue j, Kaudenjoukkue k WHERE j.joukkueid = k.joukkueid and " .
                "k.kausi = $_REQUEST[kausi] and k.joukkueid = $_REQUEST[joukkueid]";
        $this->dataJoukkue = $this->commitSingleSQLQuery($query);

        // L&ouml;ytyik&ouml; joukkuetietoja
        if( count($this->dataJoukkue) > 0) {
            $this->dataJoukkue = $this->dataJoukkue[0];
            if ( empty($this->dataJoukkue['logo']) ) {
                $this->dataJoukkue['logo'] = $this->dataJoukkue['defaultlogo'];
            }
            parent::suorita();
        }
        else {
            $this->addError($this->tm->getText('eikaudenjoukkueesta'));
            $this->createView('ErrorView');
            return;
        }
    }

    function &getQuery($key) {
	$tmp = "";
        if($key == 'pelaajat') {
            $tmp = "SELECT joukkueid, pelaaja, pelinumero, pelipaikka, CASE kapteeni WHEN 't' THEN 'C' ELSE ' ' END as kapteeni,
                (SELECT trim(etunimi) FROM henkilo WHERE hloid = p.pelaaja) as etunimi,
                (SELECT trim(sukunimi) FROM henkilo WHERE hloid = p.pelaaja) as sukunimi
                FROM pelaajat as p, kaudenjoukkue as j WHERE p.joukkue = j.joukkueid and j.joukkueid = $_REQUEST[joukkueid]
            and j.kausi = $_REQUEST[kausi] and p.kausi = j.kausi";
        }
        else if($key == 'toimihenkilot') {
            $tmp = "SELECT kaudenjoukkue as joukkueid, henkilo as pelaaja, henkilo, tehtava, kaudenjoukkue, kausi,
                (SELECT trim(etunimi) FROM henkilo WHERE hloid = p.henkilo) as etunimi,
                (SELECT trim(sukunimi) FROM henkilo WHERE hloid = p.henkilo) as sukunimi
                FROM toimi as p WHERE p.kaudenjoukkue = $_REQUEST[joukkueid]
            and p.kausi = $_REQUEST[kausi]";
        }
	return $tmp;
    }
}


?>
