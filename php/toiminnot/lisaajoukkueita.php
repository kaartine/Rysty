<?php
/**
 * lisaajoukkueita.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 30.03.2005
 *
*/
require_once("lista.php");
require_once("lisaajoukkueitaview.php");

class LisaaJoukkueita extends Lista
{
    function LisaaJoukkueita(){
        $this->Lista('lisaajoukkueita');
        
        $this->columns = array('lyhytnimi', 'pitkanimi');
        $this->defaultorder = 'lyhytnimi';
        $this->viewname = "LisaaJoukkueitaView";
        
        $this->redirectSuoritaTo('sarjanjoukkueet');
    }

    function getQuery() {
/*        $query =
            "SELECT j.lyhytnimi, j.pitkanimi, k.joukkueid as joukkue " .
          " FROM Kaudenjoukkue as k, Joukkue as j " .
          " WHERE k.kausi = $_SESSION[kausi] and k.joukkueid = j.joukkueid";*/
        $query =
            "SELECT j.lyhytnimi, j.pitkanimi, j.joukkueid as joukkue " .
          " FROM Joukkue as j ";
          //" WHERE k.kausi = $_SESSION[kausi] and k.joukkueid = j.joukkueid";

        if( isset($_SESSION['joukkuesuodatin']) and $_SESSION['joukkuesuodatin'] !== "" and
            isset($_SESSION['kausisuodatin']) and $_SESSION['kausisuodatin'] !== "" )
        {
            $query .= " WHERE j.joukkueid NOT IN ($_SESSION[joukkuesuodatin])";
        }

        return $query;
    }
}
?>
