<?php
/*
 * Created on Feb 10, 2005
 *
 * Created by Teemu Lahtela
 * (c) L�mmi
 */
 require_once("lisattavaview.php");
 
 class UutisetView extends LisattavaView
{
    /**
     * rakentajan viite (&) on t�rke� muistaa laittaa mukaan. 
     */
    function UutisetView (&$arg) {
        $this->LisattavaView($arg);
    }
    function laitaKantaan () {

        // INSERT INTO taulu (nimet,toinen) values (arvo,toka)
        $this->toiminto->tiedot['pvm'] = date("d.m.Y");
        $this->toiminto->tiedot['ilmoittaja'] = $_SESSION['kokonimi'];
        parent::laitaKantaan();
    }
}
?>
