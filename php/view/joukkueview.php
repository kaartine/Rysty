<?php
/**
 * joukkueview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 26.01.2005
 *
*/


require_once("listaview.php");
/**
 * class JoukkueView
 *
 */
class JoukkueView extends ListaView
{
    function JoukkueView(&$arg){

        $this->ListaView($arg);

        $this->headers = array(
            'lyhytnimi'=>$this->tm->getText('Lyhytnimi'),
            'pitkanimi'=>$this->tm->getText('Pitk&auml;nimi'),
            'email'=>$this->tm->getText('Email'),
            'seura'=>$this->tm->getText('Seura'),
	    'maskotti'=>$this->tm->getText('Maskotti')
        );
        $this->toiminnonNimi = "joukkueet";
    }


} // end of JoukkueView
?>
