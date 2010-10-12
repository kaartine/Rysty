<?php
/**
  * henkiloview.php
  * Copyright Rysty 2004:
  *   Teemu Lahtela
  *   Jukka Kaartinen
  *   Teemu Siitarinen
  *
  * author: tepe
  * created: 09.03.2005
  *
  */

require_once("listaview.php");


/**
 *  * class HenkiloView
 *  *
 *  */
class HallitView extends ListaView
{
        function HallitView(&$arg) {
	    
        $this->ListaView($arg);
        
        $this->headers = array(
            'nimi'=>$this->tm->getText('Nimi'),            
            'kenttienlkm'=>$this->tm->getText('Kenttien lkm'),            
            'alusta'=>$this->tm->getText('Alusta'),
            'lisatieto'=>$this->tm->getText('Lis&auml;tieto')
        );
        
        $this->toiminnonNimi = "hallit";
    }
    
} // end of HenkiloView
?>
	
