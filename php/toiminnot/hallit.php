<?php
/**
 * joukkueet.php
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
require_once("hallitview.php");

/**
 * class Joukkueet
 *
 */
class Hallit extends Lista
{
    function Hallit(){
        $this->Lista('hallit');
        $this->columns = array('nimi','halliid','kenttienlkm','lisatieto','alusta');

        $this->defaultorder = 'nimi';
        $this->viewname = "HallitView";
        $this->links = array(
        'nimi'=>array('halliid','hallinlisays'));
        
    }

    function getQuery(){
        return
            "SELECT nimi, halliid, kenttienlkm, lisatieto, alusta FROM halli";
    }


} // end of Joukkueet
?>
