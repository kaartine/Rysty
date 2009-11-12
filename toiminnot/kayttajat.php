<?php
/**
 * kayttajat.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 01.02.2005
 *
 */

require_once("lista.php");
require_once("kayttajatview.php");
//require_once("listaview.php");

class Kayttajat extends Lista {
    
    function Kayttajat(){
	$this->Lista('kayttajat');
	$this->columns = array('tunnus','etunimi', 'sukunimi');
	$this->defaultorder = 'tunnus';
	$this->viewname = "KayttajatView";
	$this->links = array('tunnus'=>array('henkilo','kayttajanlisays'),
       'etunimi'=>array('henkilo','kayttajanlisays'),
       'sukunimi'=>array('henkilo','kayttajanlisays'),
     );
    }
    
    function suorita() {
        if( isset($_REQUEST['poista']) and isset($_REQUEST['tunnus']) ) {
            
            $query = "DELETE FROM Kayttajat WHERE tunnus = '$_REQUEST[tunnus]'";
            
            $this->openConnection();
            
            $result = $this->db->doQuery($query);
          /*  if( count($result) > 0 ) {
                $this->poistaOikeus('omattiedotoikeudet',$_REQUEST[tunnus]);
                $this->poistaOikeus('joukkueenalueoikeudet',$_REQUEST[tunnus]);
                $this->poistaOikeus('lisaamuokkaaoikeudet',$_REQUEST[tunnus]);
                $this->poistaOikeus('yllapitooikeudet',$_REQUEST[tunnus]);
            }
            */
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
        }
        
    }
    
    function poistaOikeus ($taulu, $tunnus) {
        $query = "DELETE from $taulu where tunnus = '$tunnus'";
        $this->db->doQuery($query); 
    }
    
    function getQuery(){
	return
	  "SELECT k.tunnus, h.hloid as henkilo, h.etunimi, h.sukunimi ".
//	  "(SELECT etunimi FROM henkilo WHERE hloid = henkilo) as etunimi, ".
//	  "(SELECT sukunimi FROM henkilo WHERE hloid = henkilo) as sukunimi " .
	  "FROM kayttajat k, henkilo h where k.henkilo = h.hloid" ;
    }
    
    
} // end of Joukkueet
?>

