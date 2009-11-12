<?php
/**
 * sarjatilastot.php  
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * author: tepe
 * created: %date%
 * 
*/

require_once("lomakeelementit.php");
require_once("sarjatilastotview.php");
require_once("sarjatilastotcomp.php");
require_once("sarjanpelitcomp.php");
require_once("toiminto.php");

/**
 * class SarjaTilastot
 * 
 */
class SarjaTilastot extends Toiminto
{
    var $data;
    var $sarjatilastot;
    var $sarjanpelit;

    function SarjaTilastot() {
        $this->Toiminto( 'sarjatilastot' );
        
        $this->viewname = "SarjaTilastotView";        

        if( isset($_REQUEST['sarja']) and is_numeric($_REQUEST['sarja']) ) {
            $_SESSION['sarja'] = $_REQUEST['sarja'];
        }
        else if( !isset($_SESSION['sarja']) ) {
            $_SESSION['sarja'] = $_SESSION['defaultsarja'];
        }
    }

    function suorita() {
        $this->createView($this->viewname);

        // open connection to db
        $this->openConnection();
        
        $sarja = "sarja";
        $result = &$this->db->doQuery("SELECT sarjaid, (kausi||', '||tyyppi||', '||nimi) as value FROM Sarja ORDER BY kausi DESC");
        $this->sarjat = new Select( $result, $sarja, $_SESSION['sarja'], true );
        
        $this->db->close();
        
        $this->sarjatilastot = new SeriesStats('sarjatilastot');
        $this->sarjatilastot->addParameters(array('sarjaid' => $_SESSION['sarja'] ));
        $this->sarjatilastot->suorita();

        $this->sarjanpelit = new SeriesPlayedGames('sarjatilastot', TRUE);
        $this->sarjanpelit->addParameters(array('sarjaid' => $_SESSION['sarja'] ));
        $this->sarjanpelit->suorita();        
    }

} // end of SarjaTilastot
?>
