<?php
/**
 * henkilot.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 19.03.2005
 *
*/
require_once("lista.php");
require_once("pelaajanlisaysview.php");

class LisaaPelaajia extends Lista
{
    function LisaaPelaajia(){
        $this->Lista('lisaapelaajia');
        $this->columns = array('etunimi', 'sukunimi', 'joukkue', 'hloid');
        $this->defaultorder = 'joukkue';
        $this->viewname = "PelaajanLisaysView";

        //$this->links = array('etunimi'=>array('hloid','henkilonmuokkaus'), 'sukunimi'=>array('hloid','henkilonmuokkaus'));
        
        $this->redirectSuoritaTo('kaudenjoukkue');
    }

    function getQuery() {
        $query =
            "SELECT b.etunimi, b.sukunimi, b.hloid,
                (SELECT lyhytnimi FROM Joukkue WHERE joukkueID = (SELECT max(p.joukkue) FROM Pelaajat p WHERE p.pelaaja = b.hloid)) as joukkue FROM henkilo b";

        if( isset($_SESSION['suodatin']) and $_SESSION['suodatin'] !== "" )
        {
            $query .= " WHERE b.hloid NOT IN ($_SESSION[suodatin])";
        }

        return $query;
    }
}
?>