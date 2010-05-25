<?php
/**
 * tapahtumat.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 11.05.2005
 *
*/

require_once("tapahtumatview.php");
require_once("lista.php");

/**
 * class Tapahtumat
 *
 */
class Tapahtumat extends Lista
{
    function Tapahtumat() {
        $this->Lista('tapahtumat');

        $this->columns = array( 'vastuuhlo', 'tyyppi', 'paikka', 'paiva', 'aika', 'kuvaus', 'selite');
        $this->defaultorder = 'paiva';
        $this->viewname = "TapahtumatView";
        $this->links = array('paiva'=>array('tapahtumaid','tapahtumanlisays'));
    }

    function getQuery() {
        return
            "SELECT t.tapahtumaid, " .
            "   (SELECT trim(etunimi||' '||sukunimi) FROM henkilo WHERE hloid = vastuuhlo) as vastuuhlo, tyyppi, " .
            "   paikka, paiva, to_char(aika,'HH24:MI') as aika, kuvaus," .
            "   (SELECT paasee FROM osallistuja as o  WHERE o.osallistuja = $_SESSION[hloid] and o.tapahtumaid = t.tapahtumaid ) as paasee, " .
            "   (SELECT selite FROM osallistuja as o  WHERE o.osallistuja = $_SESSION[hloid] and o.tapahtumaid = t.tapahtumaid ) as selite," .
            "   (SELECT nimi FROM Halli, Peli p WHERE halliid = p.pelipaikka and p.peliid = t.tapahtumaid) as pelipaikka " .
            " FROM tapahtuma as t";
    }


    /** Aggregations: */

    /** Compositions: */

     /*** Attributes: ***/






} // end of Tapahtumat
?>
