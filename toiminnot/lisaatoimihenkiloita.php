<?php
/**
 * henkilot.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 22.03.2005
 *
*/
require_once("lista.php");
require_once("lisaatoimihenkiloitaview.php");

class LisaaToimihenkiloita extends Lista
{
    var $toimet;
    
    function LisaaToimihenkiloita(){
        $this->Lista('lisaatoimihenkiloita');
        $this->columns = array('etunimi', 'sukunimi', 'joukkue', 'hloid');
        $this->defaultorder = 'joukkue';
        $this->viewname = "LisaaToimiHenkiloitaView";
        
        if( isset( $_REQUEST['suodatin']) )
        {
            $_SESSION['suodatin'] = $_REQUEST['suodatin'];
        }
        
        unset($this->toimet);
        $this->redirectSuoritaTo('kaudenjoukkue');
    }

    function getQuery() {
        $query =
            "SELECT b.etunimi, b.sukunimi, b.hloid,
                (SELECT lyhytnimi FROM Joukkue WHERE joukkueID = (SELECT max(p.joukkue) FROM Pelaajat p WHERE p.pelaaja = b.hloid)) as joukkue " .
            "FROM henkilo b";

        if( $_SESSION['suodatin'] !== "" )
        {
            $query .= " WHERE b.hloid NOT IN ($_SESSION[suodatin])";
        }

        return $query;
    }
}
?>