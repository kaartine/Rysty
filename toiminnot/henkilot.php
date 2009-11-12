<?php
/**
 * henkilot.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 27.01.2005s
 *
*/
require_once("lista.php");
require_once("henkiloview.php");

class Henkilot extends Lista
{
    function Henkilot(){
        $this->Lista('henkilot');
        $this->columns = array('etunimi', 'sukunimi', 'joukkue','kayttaja');
        $this->defaultorder = 'sukunimi';
        $this->viewname = "HenkiloView";

        $this->links = array('etunimi'=>array('hloid','henkilonmuokkaus'), 'sukunimi'=>array('hloid','henkilonmuokkaus'),
        'kayttaja'=>array('hloid','kayttajanlisays','LINK')
        );

    }

    function getQuery(){
        return
            "SELECT b.etunimi, b.sukunimi, b.hloID,
                (SELECT lyhytnimi FROM Joukkue WHERE joukkueID = (SELECT max(p.joukkue) FROM Pelaajat p WHERE p.pelaaja = b.hloid)) as joukkue FROM henkilo b";
    }
}
?>