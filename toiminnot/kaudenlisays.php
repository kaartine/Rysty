<?php
/*
 * Created on Jan 22, 2005
 *
 * Created by Teemu Lahtela
 * (c) L�mmi
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
     * M��ritell��n rakentajassa lis�tt�v�t tiedot
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
