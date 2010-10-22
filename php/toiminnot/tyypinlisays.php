<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 14.04.2005
 *
*/

 require_once("lisattava.php");
 require_once("lisattavaview.php");
 require_once("lomakeelementit.php");

/**
 * class Login
 *
 */
class TyypinLisays extends Lisattava
{
    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function TyypinLisays(){        
        $this->Lisattava('tyypinlisays');
                
        $this->drawForm = true;
        $this->tiedot=array(
            'tyyppi' => array('',TRUE,'TEXT',20)
        );

        $this->viewName = 'LisattavaView';
        $this->taulunNimi = 'tyyppi';
    }
}
?>