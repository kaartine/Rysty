<?php
/**
 * joukkueview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 14.04.2005
 *
*/


require_once("listaview.php");
/**
 * class SeuratView
 *
 */
class SeuratView extends ListaView
{
    function SeuratView(&$arg){

        $this->ListaView($arg);

        $this->headers = array(
            'nimi'=>$this->tm->getText('Nimi'),
            'perustamispvm'=>$this->tm->getText('Perustamis Pvm'),
            'lisatieto'=>$this->tm->getText('Lisätiedot')
        );
        $this->toiminnonNimi = "seurat";
    }


} // end of SeuratView
?>