<?php
/**
 * sarjat.php  
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * author: tepe
 * created: %date%
 * 
*/


require_once("lista.php");
require_once("sarjaview.php");


/**
 * class Sarjat
 * 
 */
class Sarjat extends Lista
{		
	function Sarjat()
    {	        
		$this->Lista('sarjat');
        $this->columns = array('nimi', 'kausi', 'tyyppi', 'kuvaus', 'jarjestaja');
        $this->defaultorder = 'kausi';
        $this->viewname = "SarjaView";
        
        $this->links = array('nimi'=>array('sarjaid','sarjanmuokkaus'));
    }

    function getQuery(){
        return
            "SELECT sarjaID, kausi, tyyppi, nimi, kuvaus, jarjestaja FROM Sarja ";
    }
   	
	//var $data = array("types"=>array(), "series"=>array(), "season"=>array());
	
  /*  function Sarjat()
    {
		// call super
		$this->Lisattava();
		unset($this->types);
    }
    
    function suorita( )
    {
       $this-   >createView("SarjaView");
	
		if( !isset($_REQUEST[action]) or $_REQUEST[action] == "listaa") {
			$this->openConnection();
		    $query = "SELECT sarjaID, kausi, tyyppi, nimi, kuvaus, jarjestaja FROM Sarja";
		    $this->db->open();
		    $this->data[series] = $this->db->doQuery(&$query);				
		    
		    $this->db->commit();
			    
			$this->db->close();
			    
		    D( "<pre>");
		    D ($this->data[series]);
		    D("</pre>");	
		}
		else {
			// Does received form has valid data             
	        if ( isset($_REQUEST[nimi]) and isset($_REQUEST[kuvaus]) and
		     isset($_REQUEST[jarjestaja]) and isset($_REQUEST[tyyppi]) and 
		     isset($_REQUEST[kausi]) and isset($_REQUEST[sarjaID]) )
	        {
		    	D( "lis&auml;ttiin uusi tietokantaan tai p&auml;ivitettiin vanhaa!");
	        }
	        else if( $_REQUEST[action] == "muokkaa" ) {
	        	$this->openConnection();
	        	$this->db->open();
			    $query = "SELECT sarjaID, kausi, tyyppi, nimi, kuvaus, jarjestaja FROM Sarja".
			    		" WHERE sarjaID=$_REQUEST[sarjaID]";
			    D( $query);		
			    $this->data[series] = $this->db->doQuery($query);
			    
			    $query = "SELECT tyyppi FROM SarjaTyyppi ORDER BY tyyppi ASC";			    
			    $this->data[types] = $this->db->doQuery($query);
			    
			    $query = "SELECT vuosi FROM Kausi";
			    $this->data[season] = $this->db->doQuery($query);
			    
			    $this->db->commit();			    
			    $this->db->close();
	        }        
	        else
	        {
			    $this->openConnection();			    
			    $this->db->open();
			    
			    $query = "SELECT tyyppi FROM SarjaTyyppi ORDER BY tyyppi ASC";
			    $this->data[types] = $this->db->doQuery($query);
			    
			    $query = "SELECT vuosi FROM Kausi";
			    $this->data[season] = $this->db->doQuery($query);
			    $this->db->commit();
			    
			    $this->db->close();
	        }
		}
    
    } // end of member function suorita

	/**
     * Toiminnon tietokannasta hakema tieto
     *
     * @return void
     * @abstract
     * @access public
     */
/*    function &getData( $type )
    {
    	$values = &$this->data[$type];
    	   	
		if($values != NULL) {
			return $values; }
		else {
			return null; }
	
    } // end of member function getData
    */
} // end of Sarjat
?>
