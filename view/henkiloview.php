<?php
/**
 * henkiloview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: %date%
 *
*/

require_once("listaview.php");


/**
 * class HenkiloView
 *
 */
class HenkiloView extends ListaView
{
    function HenkiloView(&$arg) {

        $this->ListaView($arg);

        $this->headers = array(
            'etunimi'=>$this->tm->getText('Etunimi'),
            'sukunimi'=>$this->tm->getText('Sukunimi'),
            'joukkue'=>$this->tm->getText('Viimeisin joukkue'),
            'kayttaja'=>'&nbsp;'
        );
        $this->toiminnonNimi = "henkilot";
    }

} // end of HenkiloView
?>
