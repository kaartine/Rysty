 
<?php
/*
 * Created on Apr 7, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
 
  require_once("view.php");

 class TuloksenLisays5View extends View
{
        /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function TuloksenLisays5View (&$arg) {
        $this->View($arg);
        $kuvaus='';
    }
    function drawMiddle () {
        print "MOI";
    }
}
?>
