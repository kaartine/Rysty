<?php
/**
 * omattiedot.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: %date%
 *
*/

require_once("henkilonlisays.php");

 require_once("omattiedotview.php");
/**
 * class OmatTiedot
 *
 */
class OmatTiedot extends HenkilonLisays
{
    function OmatTiedot () {

        $this->HenkilonLisays('omattiedot'); // first call father
        $this->viewName = "OmatTiedotView";
        $this->taulunNimi = "henkilo";
        $this->toiminnonNimi = 'omattiedot';
        $_REQUEST['hloid'] = $_SESSION['hloid'];
    }

    function taytaErikoisKentat(){
        parent::taytaErikoisKentat();

    }

} // end of OmatTiedot
?>
