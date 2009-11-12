<?php


/**
 * pelaajakortti.php
 * Copyright Rysty 2004:   Teemu Lahtela   Jukka Kaartinen
 * Teemu Siitarinen
 *
 * author: Jukka
 * created: 20.03.2005
 *
*/

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// HUOM. jos ei näy jotain sarjaa niin katso että joukkue on lisätty sarjanjoukkueisiin!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

require_once "multilista.php";
require_once "pelaajakorttiview.php";

class PelaajaKortti extends MultiLista {

    var $dataHenkilo;
    var $dataPelaaja;
    var $kausi;

    function PelaajaKortti() {
        $this->MultiLista('pelaajakortti');

        $this->columns = array(
            'tehot' => array('sarjannimi', 'joukkue', 'ottelut','maalit', 'syotot', 'pisteet', 'plusmiinus', 'aloituspvm', 'lopetuspvm'),
            'jaahyt' => array('sarjannimi', 'k','v', 'kym', 'kk', 'yht'));

/*
        $this->links = array(
            'pelaajat' => array(
                'pelinumero'=>array(array('pelaaja'),'pelaajakortti'),
                'etunimi'=>array(array('pelaaja'),'pelaajakortti'),
                'sukunimi'=>array(array('pelaaja'),'pelaajakortti')),
            'toimihenkilot' => array(
                'tehtava'=>array(array('henkilo'),'pelaajakortti'),
                'etunimi'=>array(array('henkilo'),'pelaajakortti'),
                'sukunimi'=>array(array('henkilo'),'pelaajakortti'))
        );
  */

        $this->defaultorder = array(
            'tehot' => 'sarjannimi',
            'jaahyt' => 'yht'
        );

        $this->order = array(
            'tehot' => NULL,
            'jaahyt' => NULL
        );

        $this->nextdirection = $this->order;

        $this->direction = $this->order;

        $this->viewname = "PelaajaKorttiView";

        if( !isset($_REQUEST['kausi']) ) {
            $this->kausi = "and k.kausi = $_SESSION[kausi]";
        }
        else {
            if( $_REQUEST['kausi'] === "kaikki" ) {
            $this->kausi = "";
            }
            else {
            $this->kausi = "and k.kausi = $_REQUEST[kausi]";
            }
        }
    }

    function suorita( )
    {
        parent::suorita();

        $query = "SELECT etunimi, sukunimi, syntymaaika, paino, pituus, kuva, kuvaus, lempinimi " .
                "FROM Henkilo WHERE hloid = $_REQUEST[pelaaja]";
        $this->dataHenkilo = $this->commitSingleSQLQuery($query);
        if( count($this->dataHenkilo) > 0) {
            $this->dataHenkilo = $this->dataHenkilo[0];
        }

        $query = "SELECT katisyys, maila " .
                "FROM Pelaaja WHERE pelaajaid = $_REQUEST[pelaaja]";
        $this->dataPelaaja = $this->commitSingleSQLQuery($query);
        if( count($this->dataPelaaja) > 0) {
            $this->dataPelaaja = $this->dataPelaaja[0];
        }
    }

    function &getQuery($key) {
        if($key == 'tehot') {
            return
              "SELECT s.sarjaid, (s.kausi||', '||s.tyyppi||', '||s.nimi) as sarjannimi, p.aloituspvm, p.lopetuspvm, " .
                "   (SELECT lyhytnimi FROM Joukkue WHERE joukkueid = p.joukkue) as joukkue, " .
                "   (SELECT count(tilastoID) FROM Pelaajatilasto pt, Peli pl " .
                "       WHERE pelaaja = h.hloid and joukkue = sj.joukkue and pl.sarja = s.sarjaid and pt.peliid = pl.peliid) as ottelut," .
                "   (SELECT count(maaliid) FROM Maali, Tilastomerkinta tm, Peli pl " .
                "       WHERE tekija = h.hloid and tm.joukkueid = sj.joukkue and tm.timerkintaid = maaliid and tm.peliid = pl.peliid and pl.sarja = s.sarjaid) as maalit," .
                "   (SELECT count(maaliid) FROM Maali, Tilastomerkinta tm, Peli pl " .
                "       WHERE syottaja = h.hloid and tm.joukkueid = sj.joukkue and tm.timerkintaid = maaliid and tm.peliid = pl.peliid and pl.sarja = s.sarjaid) as syotot," .
                "   (SELECT count(maaliid) FROM Maali, Tilastomerkinta tm, Peli pl " .
                "       WHERE (tekija = h.hloid or syottaja = h.hloid) and tm.joukkueid = sj.joukkue and tm.timerkintaid = maaliid and tm.peliid = pl.peliid and pl.sarja = s.sarjaid) as pisteet, " .
                "   (SELECT sum(plusmiinus) FROM Pelaajatilasto pt, Peli pl " .
                "       WHERE pelaaja = h.hloid and joukkue = sj.joukkue and pl.sarja = s.sarjaid and pt.peliid = pl.peliid) as plusmiinus" .
                "  FROM Henkilo h, Pelaajat p, Sarja s, Sarjanjoukkueet sj " .
                " WHERE h.hloid = p.pelaaja and h.hloid = $_REQUEST[pelaaja] and p.joukkue = sj.joukkue and p.kausi = s.kausi and sj.sarjaid = s.sarjaid ";
        }
        else if($key == 'jaahyt') {

             $saaja = "saaja = h.hloid and tm.joukkueid = sj.joukkue and tm.timerkintaid = rangaistusid and tm.peliid = pl.peliid and pl.sarja = s.sarjaid";

            return
              "SELECT s.sarjaid, (s.kausi||', '||s.tyyppi||', '||s.nimi) as sarjannimi, p.joukkue, " .
              "   (SELECT COALESCE(sum(minuutit),0) FROM Rangaistus, Tilastomerkinta tm, Peli pl " .
                "       WHERE $saaja and minuutit = 2) as k," .
              "   (SELECT COALESCE(sum(minuutit),0) FROM Rangaistus, Tilastomerkinta tm, Peli pl " .
                "       WHERE $saaja and minuutit = 5) as v," .
              "   (SELECT COALESCE(sum(minuutit),0) FROM Rangaistus, Tilastomerkinta tm, Peli pl " .
                "       WHERE $saaja and minuutit = 10) as kym," .
              "   (SELECT COALESCE(sum(minuutit),0) FROM Rangaistus, Tilastomerkinta tm, Peli pl WHERE $saaja and minuutit = 20) as kk," .
                "   (SELECT COALESCE(sum(minuutit),0) FROM Rangaistus, Tilastomerkinta tm, Peli pl WHERE $saaja) as yht" .
                " FROM Henkilo h, Pelaajat p, Sarja s, Sarjanjoukkueet sj " .
                " WHERE h.hloid = p.pelaaja and h.hloid = $_REQUEST[pelaaja] and p.joukkue = sj.joukkue and p.kausi = s.kausi and sj.sarjaid = s.sarjaid";
        }
    }
}


?>