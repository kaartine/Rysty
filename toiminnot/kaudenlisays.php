<?php
/*
 * Created on Jan 22, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */

 require_once("lisattava.php");
 require_once("lisattavaview.php");
 require_once("lomakeelementit.php");

/**
 * class Login
 *
 */
class KaudenLisays extends Lisattava
{


    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function KaudenLisays(){        
        $this->Lisattava('kaudenlisays');
                
        $this->drawForm = true;
        $this->tiedot=array(
            'vuosi' => array('',TRUE,'NUMBER',4)
        );

        $this->viewName = 'LisattavaView';
        $this->taulunNimi = 'kausi';
    }
}
?>
