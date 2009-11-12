<?php
/**
 * kaudenjoukkueenmuokkaus.php 
 * 
 * Copyright Rysty 2004:   
 * Teemu Lahtela   
 * Jukka Kaartinen   
 * Teemu Siitarinen
 *
 * author: Jukka
 * created: 20.04.2005
 *
*/
require_once("joukkueentiedot.php");
require_once("kaudenjoukkueenmuokkausview.php");
require_once("kaudenjoukkueenlisays.php");

/**
 * class KaudenjoukkueenMuokkaus
 *
 */
class KaudenjoukkueenMuokkaus extends KaudenjoukkueenLisays
{
    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function KaudenjoukkueenMuokkaus(){
        
        $this->KaudenjoukkueenLisays('kaudenjoukkueenmuokkaus');
        $this->tiedot['kausi'] = array($_REQUEST['kausi'],TRUE,'HIDDEN');
        
        D("kausi:");
        D($_REQUEST['kausi']."<br>");
        
        $_SESSION['muokkaus'] = true;
        
        $this->viewName = "KaudenjoukkueenMuokkausView";
        
        $this->joukkuetiedot = new Joukkuetiedot();
        $this->joukkuetiedot->haeTiedot($_SESSION['joukkue'],$_REQUEST['kausi']);
   }
}
 
?>
