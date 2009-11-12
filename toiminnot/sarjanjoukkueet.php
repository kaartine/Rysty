<?php


/**
 * sarjanjoukkueet.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 30.03.2005
 *
*/

require_once "lista.php";
require_once "sarjanjoukkueetview.php";

class SarjanJoukkueet extends Lista {
    
    var $kausi; 
    var $kaudet;
  //  var $kausiid;
    var $sarja;
    var $sarjat;
  //  var $sarjaid;
    
    function SarjanJoukkueet() {
        
        $this->Lista('sarjanjoukkueet');

        $this->columns = array('lyhytnimi', 'pitkanimi');
        
        $this->viewname = "SarjanJoukkueetView";
        
        $this->defaultorder = 'lyhytnimi';
         
/*        if( !isset($_REQUEST['kausi']) ) {
            if( !isset($_SESSION['kausi']) ) {
                $this->kausi = $_SESSION['defaultkausi'];
                $_SESSION['kausi'] = $_SESSION['defaultkausi'];
            }
            else {
                $this->kausi = $_SESSION['kausi'];                
            }            
        }
        else {            
            $this->kausi = "SELECT vuosi FROM Kausi WHERE vuosi = $_REQUEST[kausi]";
            $this->kausiid = $_REQUEST['kausi'];
            $_SESSION['kausi'] = $_REQUEST['kausi'];
        }
*/      
        if( !isset($_REQUEST['sarjaid']) ) {
            $this->sarja = "SELECT v.sarjaid FROM Sarja v WHERE v.sarjaid = $_SESSION[sarja]";
            $this->sarjaid = $_SESSION['sarja'];
            //$_SESSION['sarja'] = $_SESSION['sarja'];
        }
        else {
            $this->sarja = "SELECT v.sarjaid FROM Sarja v WHERE v.sarjaid = $_REQUEST[sarjaid]";            
            $this->sarjaid = $_REQUEST['sarjaid'];
            $_SESSION['sarja'] = $_REQUEST['sarjaid'];
        }
        
        if( isset( $_REQUEST['kausisuodatin']) )
        {
            $_SESSION['kausisuodatin'] = $_REQUEST['kausisuodatin'];
        }
        
        if( isset( $_REQUEST['joukkuesuodatin']) )
        {
            $_SESSION['joukkuesuodatin'] = $_REQUEST['joukkuesuodatin'];
        }

        unset($this->kaudet);
        unset($this->sarjat);
    }

    function suorita() {

        D("<pre>");
        //D( $this->tiedot);
        D( $_REQUEST);
        D("</pre>");

        if( isset($_REQUEST['poista']) and $_REQUEST['poista'] == 1 and isset($_REQUEST['joukkue']) and isset($_REQUEST['kausi']) and isset($_REQUEST['sarjaid']) ) {

            $query = "DELETE FROM Sarjanjoukkueet WHERE joukkue = $_REQUEST[joukkue] AND ".
                    " kausi = $_REQUEST[kausi] and sarjaid = $_REQUEST[sarjaid]";

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
        else if( isset($_REQUEST['send']) and isset($_REQUEST['lisaa']) and count($_REQUEST['lisaa']) > 0 )
        {
            // Saatiin lista lisättävistä joukkueista

            // open connection to db
            $this->openConnection();
            
            $query = "SELECT kausi FROM Sarja WHERE sarjaid = $_SESSION[sarja]";
            $tmp = $this->db->doQuery($query);
            $tmp = $tmp[0];
            D($tmp);

            foreach($_REQUEST['lisaa'] as $lisattava)
            {
                $query = "INSERT INTO Sarjanjoukkueet(sarjaid, joukkue, kausi) values ( $_SESSION[sarja], $lisattava, $tmp[kausi])";
                $this->db->doQuery($query);
            }

            $this->db->close();

            $this->suoritaAutoRefresh();
        }       
        else {
            parent::suorita();
            
            // open connection to db
            $this->openConnection();
/*        
            $kausi = "kausi";
            $result = &$this->db->doQuery("SELECT vuosi, vuosi as value FROM Kausi");            
            $this->kaudet = new Select( $result, $kausi, $this->kausi );//array('',FALSE,'SELECT'), 
*/            

            $sarja = "sarjaid";
            $result = &$this->db->doQuery("SELECT sarjaid, (tyyppi||', '||nimi||', '||kausi) FROM Sarja ORDER BY kausi desc, tyyppi asc");
            $this->sarjat = new Select( $result, $sarja, $this->sarjaid );
            
            $this->db->close(); 
        }
    }

    function getQuery() {
       return
          "SELECT j.lyhytnimi, j.pitkanimi, joukkue, sarjaid, s.kausi " .
          " FROM Sarjanjoukkueet as s, Joukkue as j WHERE s.sarjaid IN ($this->sarja) and s.joukkue = j.joukkueid ";

    }
}


?>
