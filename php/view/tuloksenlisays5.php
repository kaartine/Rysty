 
<?php
/*
 * Created on Apr 7, 2005
 *
 * Created by Teemu Lahtela
 * (c) L�mmi
 */
 
  require_once("view.php");

 class TuloksenLisays5View extends View
{
        /**
     * rakentajan viite (&) on t�rke� muistaa laittaa mukaan.
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
