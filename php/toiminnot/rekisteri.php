<?php
/**
 * rekisteri.php  
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * author: tepe
 * created: 21.04.2005
 * 
*/


require_once("toiminto.php");
 require_once("rekisteriseloste.php");
/**
 * class Rekisteri
 * 
 */
class Rekisteri extends Toiminto
{
    function Rekisteri(){
        // call super
        $this->Toiminto('rekisteri');
	$this->createView("RekisteriView");
    }
    
} // end of Rekisteri
?>
