<?php
/**
 * toimenlisays.php
 * 
 * Copyright Rysty 2004:   
 * 
 * Teemu Lahtela   
 * Jukka Kaartinen 
 * Teemu Siitarinen
 *
 * author: Jukka
 * created: 22.03.2005
 *
*/

 require_once("lisattava.php");
 require_once("lisattavaview.php");
 //require_once("lomakeelementit.php");

/**
 * class Login
 *
 */
class ToimenLisays extends Lisattava
{
    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function ToimenLisays(){
        $this->Lisattava('toimenlisays');
                
        $this->drawForm = true;
        $this->tiedot=array(
            'toimenkuva' => array('',TRUE,'TEXT',20)
        );

        $this->viewName = 'LisattavaView';
        $this->taulunNimi = 'toimenkuva';
    }
}
?>
