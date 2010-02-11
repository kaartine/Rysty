<?php
/**
 * sarjatyypinlisays.php 
 * 
 * Copyright Rysty 2004:   
 * 
 * Teemu Lahtela   
 * Jukka Kaartinen
 * Teemu Siitarinen
 *
 * author: Jukka
 * created: 25.03.2005
 *
*/

 require_once("lisattava.php");
 require_once("lisattavaview.php");
 require_once("lomakeelementit.php");

/**
 * class Login
 *
 */
class SarjaTyypinLisays extends Lisattava
{


    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function SarjaTyypinLisays() {        
        $this->Lisattava('sarjatyypinlisays');
                
        $this->drawForm = true;
        $this->tiedot=array(
            'tyyppi' => array('',TRUE,'TEXT',25)
        );

        $this->viewName = 'LisattavaView';
        $this->taulunNimi = 'sarjatyyppi';
    }
}
?>
