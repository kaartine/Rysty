<?php
/*
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * Created on Apr 20, 2005
 *
 * Created by Teemu Lahtela
 * (c) L&auml;mmi
 */
  require_once("view.php");

/**
 * class PeliView
 *
 */
class ErrorView extends View
{

     /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function ErrorView (&$arg) {
        $this->View($arg);
    }
    function drawMiddle () {
        //print $this->tm->getText('Laiton toiminto!');
    }
}
?>
