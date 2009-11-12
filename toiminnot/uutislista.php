<?php
/*
 * Created on Feb 10, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
 require_once("lista.php");
require_once("uutislistaview.php");

 class UutisLista extends Lista {
    
    function UutisLista(){
        $this->Lista('uutislista');
        $this->columns = array('otsikko', 'uutinen','pvm','ilmoittaja');
        $this->defaultorder = 'pvm';
        $this->viewname = "UutisListaView";
        
        $this->links = array('otsikko'=>array('uutinenid','uutiset'), 'uutinen'=>array('uutinenid','uutiset'));
        
    }    
        function getQuery(){
        return
            "SELECT * FROM uutinen";
    }
 } 
?>
