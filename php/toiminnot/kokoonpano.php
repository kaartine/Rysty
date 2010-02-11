<?php


/**
 * kaudenjoukkue.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 18.03.2005
 *
*/

require_once "lista.php";
require_once "kokoonpanoview.php";

class Kokoonpano extends Lista {

    function Kokoonpano() {
        $this->Lista('kokoonpano');

        $this->columns = array('pelinumero','etunimi', 'sukunimi', 'pelipaikka', 'kapteeni');

        $this->defaultorder = 'pelinumero';
        $this->viewname = "KokoonpanoView";
    }

    function getQuery() {
        return
          "SELECT pelaaja, pelinumero, pelipaikka, CASE kapteeni WHEN 't' THEN 'C' ELSE ' ' END as kapteeni, 
            (SELECT trim(etunimi) FROM henkilo WHERE hloid = p.pelaaja) as etunimi,
            (SELECT trim(sukunimi) FROM henkilo WHERE hloid = p.pelaaja) as sukunimi
            FROM pelaajat as p, kaudenjoukkue as j WHERE p.joukkue = j.joukkueid and j.joukkueid = $_SESSION[defaultjoukkue] and p.lopetuspvm IS NULL 
	    and j.kausi = $_SESSION[defaultkausi] and p.kausi = j.kausi and p.kausi = j.kausi";
    }

/*    function suorita() {

    }
  */
}


?>
