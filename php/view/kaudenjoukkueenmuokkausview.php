<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 22.04.2005
 *
*/

require_once "lisattavaview.php";

/**
 * class KaudenjoukkueView
 *
 */
class KaudenjoukkueenMuokkausView extends LisattavaView
{

    function KaudenjoukkueenMuokkausView (&$arg) {
        $this->LisattavaView($arg);
    }

    function drawMiddle() {
        $this->toiminto->joukkuetiedot->draw();
        parent::drawMiddle();
    }
}

?>