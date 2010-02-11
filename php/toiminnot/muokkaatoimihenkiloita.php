<?php


/**
 * kaudenjoukkue.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 22.03.2005
 *
*/

require_once "lista.php";
require_once "lomakeelementit.php";
require_once "muokkaatoimihenkiloitaview.php";

class MuokkaaToimihenkiloita extends Lista {

    var $toimenkuva;
    
    function MuokkaaToimihenkiloita() {
        $this->Lista('muokkaatoimihenkiloita');

        unset($this->katisyys);
        unset($this->pelipaikka);

        $this->columns = array(
            'etunimi',
            'sukunimi',
            'toimi'
        );

        $this->links = array('sukunimi'=>array('hloid','henkilonlisays'),'etunimi'=>array('hloid','henkilonlisays'));

        $this->defaultorder = 'toimi';
        $this->viewname = "MuokkaaToimihenkiloitaView";   
    }

    function suorita() {

        D("<pre>");       
        D( $_REQUEST);
        D("</pre>");

        if( isset($_REQUEST['paivita']) ) {
            $this->openConnection();

            foreach($_REQUEST['toimihenkilo'] as $key => $henkilo)
            {
                $query = "UPDATE Toimi SET tehtava = '$henkilo[toimi]' ".                        
                        " WHERE henkilo = $key and kaudenjoukkue = $_SESSION[kaudenjoukkueid] and kausi = $_SESSION[kausi]";
                $this->db->doQuery($query);
            }
            $this->db->close();

            if ( !$this->db->error ) {
            //tästa alkaa takaisinkytkennän toimintasarja
                $this->drawForm = false;
                $this->suoritaAutoRefresh();
                return;
            }
        }
        else {
            parent::suorita();    
            
            // open connection to db
            $this->openConnection();
           
            $toimi = "toimenkuva";
            $result = &$this->db->doQuery("(SELECT ' ' as value, 'Ei tiedossa' as name) UNION (SELECT toimenkuva, toimenkuva as value FROM Toimenkuva)");
            
            $i = 0;
            foreach( $this->data as $henkilo )
            {     
                D("<pre>");       
                D( $henkilo);
                D("</pre>");           
                
                //$this->toimenkuva[$i] = new Select($result,"toimihenkilo[$henkilo[hloid]][toimi]",$henkilo['toimi']);
                $button = new Button('toimenlisays', 'toimenlisays', 'toimenlisays', false);
                $this->toimenkuva[$i] = new SelectLisaa("toimihenkilo[$henkilo[hloid]][toimi]", $result, $button, $henkilo['toimi'] );
                //SelectLisaa( $toimi, $result, "toimihenkilo[$henkilo[hloid]][toimi]", 'toimenlisays');
                
                $i++;
            } 
            $this->db->close();      
        }
    }


    function getQuery() {
        return
          " SELECT henkilo as hloid, tehtava as toimi," .
          "  (SELECT trim(etunimi) FROM henkilo WHERE hloid = t.henkilo) as etunimi, " .
          "  (SELECT trim(sukunimi) FROM henkilo WHERE hloid = t.henkilo) as sukunimi " .
          " FROM Toimi t WHERE kaudenjoukkue = $_SESSION[kaudenjoukkueid] and kausi = $_SESSION[kausi]";
    }

/*    function suorita() {

    }
  */
}


?>
