<?php
/**
 * pelit.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: %date%
 *
*/

require_once("lista.php");
require_once("pelitview.php");

/**
 * class Pelit
 *
 */
class Pelit extends Lista
{
    var $tila;

    function Pelit($name = 'pelit') {
        $this->Lista($name);

        $this->columns = array('tyyppi', 'sarja', 'pvm', 'halli', 'kotijoukkue', 'vierasjoukkue', 'kuvaus');

        $this->defaultorder = 'oikeaaika';
        $this->viewname = "PelitView";
        $this->links = array(
            'pvm'=>array('peliid','pelitilastot'),
            'lopputulos'=>array(array('peliid'),'pelitilastot'),
            'kotijoukkue'=>array(array('peliid'),'pelitilastot'),
             'vierasjoukkue'=>array(array('peliid'),'pelitilastot')
        );

        if( onkoOikeuksia('tuloksenlisays') ) {
            array_push($this->columns, 'lisaa');
            $this->links['lisaa'] = array('peliid','tuloksenlisays');
	    
            $this->links['sarja'] = array('peliid','pelinlisays');
        }

        if( isset($_REQUEST['alitila']) ) {
            if ( $_REQUEST['alitila'] == 'menneetpelit' ) {
                $this->tila = 'pelatut';
            }
            else if ( $_REQUEST['alitila'] == 'tulevatpelit' ) {
                $this->tila = 'tulevat';
            }
            else {
                $this->tila = 'kaikki';
            }
            $_SESSION['pelit'] = array('alitila'=>$this->tila);
        }
        else {
            if ( isset($_REQUEST['menu']) ) {
                $this->tila = 'tulevat';
            }
            else if ( isset($_SESSION['pelit']['alitila'] ) ) {
                $this->tila = $_SESSION['pelit']['alitila'];
            }
            else {
                $this->tila = 'tulevat';
            }

        }

    }

    function getQuery() {
        $q =
      "SELECT (to_char(paiva,'YYYY-MM-DD') || aika) as oikeaaika , (paiva||', ".

       "'||to_char(aika,'HH24:MI')) as pvm, y.peliid, (y.kotimaalit||' - '||y.vierasmaalit) as lopputulos,".
        "( SELECT lyhytnimi FROM joukkue where joukkueid = y.kotijoukkue) as kotijoukkue,".
        "( SELECT lyhytnimi FROM joukkue where joukkueid = y.vierasjoukkue) as vierasjoukkue,".
        "( SELECT (nimi||', '||kausi) FROM Sarja WHERE sarjaid=y.sarja) as sarja,".
        "( SELECT nimi FROM Halli WHERE halliid = y.pelipaikka) as halli,".
        "( SELECT kuvaus FROM Tapahtuma WHERE tapahtumaid=y.peliid) as kuvaus,".
        "( SELECT tyyppi FROM Tapahtuma WHERE tapahtumaid=y.peliid) as tyyppi ".
        " FROM Tapahtuma, Peli as y WHERE tapahtumaid=y.peliid";
        // ORDER BY paiva";
        if ( $this->tila == 'pelatut' ) {
            $q .= ' and paiva <= CURRENT_DATE ';

        }
        else if ( $this->tila == 'tulevat' ) {
            $q .= ' and paiva >= CURRENT_DATE';
        }
        return $q;
    }

    function getSort(){
        if ( $_REQUEST['sort'] === 'pvm') return 'oikeaaika';
        return $_REQUEST['sort'];
    }

    function suorita( ) {
        parent::suorita();
        if ( $this->order === 'oikeaaika') $this->order = 'pvm';
    }
/*
SELECT peliid, ".
        "( SELECT lyhytnimi FROM joukkue where joukkueid = y.kotijoukkue) as kotijoukkue,".
        "( SELECT lyhytnimi FROM joukkue where joukkueid = y.vierasjoukkue) as vierasjoukkue,".
        "( SELECT (nimi||', '||kausi) FROM Sarja WHERE sarjaid=y.sarja) as sarja,".
        "( SELECT nimi FROM Halli WHERE halliid = y.pelipaikka) as halli,".
        "(  ORDER BY paiva) as pvm,".
        "( SELECT kuvaus FROM Tapahtuma WHERE tapahtumaid=y.peliid) as kuvaus,".
        "( SELECT tyyppi FROM Tapahtuma WHERE tapahtumaid=y.peliid) as tyyppi".
       " FROM Peli as y";*/


} // end of Pelit
?>
