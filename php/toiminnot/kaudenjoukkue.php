<?php


/**
 * kaudenjoukkue.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 16.02.2005
 *
*/

require_once "multilista.php";
require_once "kaudenjoukkueview.php";

class Kaudenjoukkue extends MultiLista {
    
    var $kjoukkue;
    function Kaudenjoukkue() {
        
        $this->MultiLista('kaudenjoukkue');

        $this->columns = array(
            'pelaajat'=>array('pelinumero','etunimi', 'sukunimi', 'katisyys',
                       'maila', 'pelipaikka', 'syntymaaika', 'poista', 'kapteeni', 'aloituspvm', 'lopetuspvm'),
            'toimihenkilot'=>array('etunimi', 'sukunimi', 'toimi')
        );
        
        $this->viewname = "KaudenjoukkueView";
        
        $this->defaultorder = array(
            'pelaajat' => 'pelinumero',
            'toimihenkilot' => 'toimi'
        );
        
        $this->order = array(
            'pelaajat' => NULL,
            'toimihenkilot' => NULL
        );
        
        $this->nextdirection = $this->order;
        
        $this->direction = $this->order;
        
        if( isset($_REQUEST['joukkueid']) ) {
            $_SESSION['kaudenjoukkueid'] = $_REQUEST['joukkueid'];
            $_SESSION['joukkue'] = $_SESSION['kaudenjoukkueid'];
        }
        
        if( isset($_REQUEST['kausi']) ) {
            $_SESSION['kausi'] = $_REQUEST['kausi'];
        }
        
        if( isset( $_REQUEST['suodatin']) )
        {
            $_SESSION['suodatin'] = $_REQUEST['suodatin'];
        }
        
        $this->kjoukkue = array(); 
    }

    function suorita() {

        D("<pre>");
        //D( $this->tiedot);
        D( $_REQUEST);
        D("</pre>");

        if( isset($_REQUEST['poista']) and $_REQUEST['poista'] == 1 and isset($_SESSION['kaudenjoukkueid']) and isset($_REQUEST['pelaaja']) ) {

            $query = "DELETE FROM Pelaajat WHERE joukkue = $_SESSION[kaudenjoukkueid] AND ".
                    "pelaaja = $_REQUEST[pelaaja] and kausi = $_SESSION[kausi]";

            $this->openConnection();
            $this->db->doQuery($query);
            $this->db->close();

            if ( !$this->db->error ) {
            //tïästa alkaa takaisinkytkennän toimintasarja
                $this->drawForm = false;
                $this->suoritaAutoRefresh();
                return;
            }
        }
        else if( isset($_REQUEST['send']) and isset($_REQUEST['lisaa']) and count($_REQUEST['lisaa']) > 0 )
        {
            // Saatiin lista lisättävistä pelaajista

            // open connection to db
            $this->openConnection();

            foreach($_REQUEST['lisaa'] as $lisattava)
            {
                $query = "INSERT INTO Pelaajat(pelaaja, joukkue, kausi) values ($lisattava, $_SESSION[kaudenjoukkueid], $_SESSION[kausi])";
                $this->db->doQuery($query);
            }

            $this->db->close();

            $this->suoritaAutoRefresh();
        }
        else if( isset($_REQUEST['poista']) and $_REQUEST['poista'] == 1 and isset($_SESSION['kaudenjoukkueid']) and isset($_REQUEST['henkilo']) ) {

            $query = "DELETE FROM Toimi WHERE kaudenjoukkue = $_SESSION[kaudenjoukkueid] AND ".
                    "henkilo = $_REQUEST[henkilo] and kausi = $_SESSION[kausi]";

            $this->openConnection();
            $this->db->doQuery($query);
            $this->db->close();

            if ( !$this->db->error ) {
            //tästa alkaa takaisinkytkennän toimintasarja
                $this->drawForm = false;
                $this->suoritaAutoRefresh();
                return;
            }
        }
        else if( isset($_REQUEST['toimi']) and isset($_REQUEST['lisaa']) and count($_REQUEST['lisaa']) > 0 )
        {
            // Saatiin lista lisättävistä toimihenkilöistä

            // open connection to db
            $this->openConnection();

            foreach($_REQUEST['lisaa'] as $lisattava)
            {
                $query = "INSERT INTO Toimi(kaudenjoukkue, kausi, henkilo) values ($_SESSION[kaudenjoukkueid], $_SESSION[kausi], $lisattava)";
                $this->db->doQuery($query);
            }

            $this->db->close();

            $this->suoritaAutoRefresh();
        }
        else {
            parent::suorita();
            
             // open connection to db
            $this->openConnection();
            
            $this->kjoukkue = $this->db->doQuery("SELECT kotipaikka, pitkanimi, lyhytnimi, " .
                    " (SELECT nimi FROM Halli WHERE halliid = kotihalli) as kotihalli, k.kuvaus, kuva, k.logo, kausi" .
                    " FROM Kaudenjoukkue k, Joukkue as j WHERE k.joukkueid = $_SESSION[joukkue] and kausi = $_SESSION[kausi] and j.joukkueid = k.joukkueid");
                    
            $this->kjoukkue = $this->kjoukkue[0];
            $this->db->close();
        }
    }



    function getQuery($key) {
        if($key === 'pelaajat') {
            return
              "SELECT pelaaja, joukkue, pelinumero, pelipaikka, CASE kapteeni WHEN 't' THEN 'Kapteeni' ELSE ' ' END as kapteeni, aloituspvm, lopetuspvm, 
                (SELECT katisyys FROM pelaaja c WHERE pelaajaid = p.pelaaja) as katisyys,
                (SELECT maila FROM pelaaja WHERE pelaajaid = p.pelaaja) as maila,
                (SELECT trim(etunimi) FROM henkilo WHERE hloid = p.pelaaja) as etunimi,
                (SELECT trim(sukunimi) FROM henkilo WHERE hloid = p.pelaaja) as sukunimi,
                (SELECT syntymaaika FROM henkilo WHERE hloid = p.pelaaja) as syntymaaika
                FROM pelaajat as p WHERE joukkue = $_SESSION[kaudenjoukkueid] and kausi = $_SESSION[kausi]";
        }
        else if($key === 'toimihenkilot') {
            return
              "SELECT henkilo as pelaaja, henkilo, kaudenjoukkue as joukkue, tehtava as toimi,
                (SELECT trim(etunimi) FROM henkilo WHERE hloid = t.henkilo) as etunimi,
                (SELECT trim(sukunimi) FROM henkilo WHERE hloid = t.henkilo) as sukunimi                
                FROM Toimi as t WHERE kaudenjoukkue = $_SESSION[kaudenjoukkueid] and kausi = $_SESSION[kausi]";               
        }
    }

/*    function suorita() {

    }
  */
}


?>
