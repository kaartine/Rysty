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
require_once("joukkueview.php");

/**
 * class Joukkueet
 *
 */
class Joukkueet extends Lista
{
    function Joukkueet(){
        $this->Lista('joukkueet');
        $this->columns = array('lyhytnimi', 'pitkanimi', 'email', 'kuvaus', 'seura', 'maskotti');
        $this->defaultorder = 'lyhytnimi';
        $this->viewname = "JoukkueView";
        $this->links = array(
        'lyhytnimi'=>array('joukkueid','kaudenjoukkueet'),
        'pitkanimi'=>array('joukkueid','kaudenjoukkueet'),
         'seura'=>array('seuraid','seuranlisays'));
    }

    function getQuery(){
        return
            "SELECT b.joukkueid, b.seuraid, b.lyhytnimi, b.pitkanimi, b.email, b.kuvaus, b.maskotti, " .
            "(SELECT nimi FROM seura WHERE seuraid = b.seuraid) as seura " .
            "FROM joukkue b" ;
    }


} // end of Joukkueet
?>
