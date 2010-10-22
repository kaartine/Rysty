<?php
/**
 * joukkueet.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 14.4.2005
 *
*/


require_once("lista.php");
require_once("seuratview.php");

/**
 * class Seurat
 *
 */
class Seurat extends Lista
{
    function Seurat(){        
        $this->Lista('seurat');
        $this->columns = array('perustamispvm', 'nimi', 'lisatieto');
        $this->defaultorder = 'nimi';
        $this->viewname = "SeuratView";
        $this->links = array(
            'nimi'=>array('seuraid','seuranlisays'));
    }

    function getQuery(){
        return
            "SELECT seuraid, perustamispvm, nimi, lisatieto FROM Seura";
    }


} // end of Seurat
?>