<?php

/** 
 * mvahtitilasto.php
 * Copyright Rysty 2006:
 *   Jukka Kaartinen
 * 
 * Created on 30.9.2006
 */
 
require_once('tablecomponent.php');

class SeriesStats extends TableComponent {

	var $outfit = array('tableclass' => '', 'trclass' => '', 'thclass' => '');

	function SeriesStats($toiminto) {
		$this->TableComponent($toiminto);
		
		$this->set('dorder', array( 'p', 'v', 'me') );	// Oletus järjestys
 			
 		$this->headers = array(
 			'joukkue' => array('joukkue','','asc'),
 			'pelit' => array('pelit','tilastot','desc'),
 			'v' => array('v','tilastot','desc'),
 			'tp' => array('tp','tilastot','desc'), 
			'h' => array('h','tilastot','desc'), 
			'tm' => array('tm','tilastot','desc'), 
			'pm' => array('pm','tilastot','desc'),
            'me' => array('me','tilastot','desc'),
			'p' => array('p','tilastot','desc')
		);
		
 		$this->links = array(
			'joukkue' => array('SL', 'joukkuekortti', array('joukkueid')));
			
        $this->allowUserSort = false;			
	}
	
	function drawTableRows() {
		// taulukon arvot		
		$i=1;
		foreach( $this->data as $row ) {
			print '<tr class="'.$this->outfit['trclass'].'">';
			foreach( $this->headers as $header ) {
			    // Piirtää viivan toisena ja kolmantena olevien joukkueiden väliin.
			    if( $i == 2 || $i == 7 ) {
			        print '<td class="'.$header[1].' alaviiva">';
			    }
			    else {
					print '<td class="'.$header[1].'">';
			    }
		    	print $this->createLink($header[0], $row);
				print '</td>';
			}
            $i++;			
			print '</tr>';			
		}
	}

	/**
	 * 
	 * Set query.
	 */
	function getQuery() {
	    return
	        "SELECT joukkueid, lyhytnimi as joukkue, " .
   	        "	(SELECT sum(kotimaalit) FROM Peli WHERE ( (kotijoukkue = j.joukkueid) ) AND kotimaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid'].") as kotimaalit, " .
   	        "	(SELECT sum(vierasmaalit) FROM Peli WHERE ( (vierasjoukkue = j.joukkueid) ) AND kotimaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid'].") as vierasmaalit, " .
       	        
   	        "	(SELECT sum(vierasmaalit) FROM Peli WHERE ( (kotijoukkue = j.joukkueid) ) AND kotimaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid'].") as kpaastetyt,  " .
   	        "	(SELECT sum(kotimaalit) FROM Peli WHERE ( (vierasjoukkue = j.joukkueid) ) AND vierasmaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid'].") as vpaastetyt, " .
   	        
   	        "	(SELECT count(peliid) FROM Peli WHERE ( (kotijoukkue = j.joukkueid) OR (vierasjoukkue = j.joukkueid) ) AND kotimaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid']." ) as pelit, " .   	        
	        "	(SELECT count(peliid) FROM Peli WHERE ( (kotijoukkue = j.joukkueid AND kotimaalit > vierasmaalit) OR (vierasjoukkue = j.joukkueid AND vierasmaalit > kotimaalit) ) AND kotimaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid']." ) as v, " .
	        "	(SELECT count(peliid) FROM Peli WHERE ( (kotijoukkue = j.joukkueid AND kotimaalit = vierasmaalit) OR (vierasjoukkue = j.joukkueid AND vierasmaalit = kotimaalit) ) AND kotimaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid']." ) as tp, ".
  	        "	(SELECT count(peliid) FROM Peli WHERE ( (kotijoukkue = j.joukkueid AND kotimaalit < vierasmaalit) OR (vierasjoukkue = j.joukkueid AND vierasmaalit < kotimaalit) ) AND kotimaalit IS NOT NULL AND sarja = ".$this->outparams['sarjaid']." ) as h " .
	    	"FROM Joukkue j, Sarjanjoukkueet s, Peli p WHERE p.sarja = sarjaid AND s.joukkue = j.joukkueid AND sarjaid = ".$this->outparams['sarjaid']. " GROUP BY j.joukkueid, lyhytnimi, s.joukkue";
	}
	
	function column($row, $column ) {
//		$ret = 0;
//		print $row;		
//		print '<pre>';
//		print_r($this->data);
//		print '</pre>';
		
	    if( $column === 'me') {
		    $ret = ($this->data[$row]['kotimaalit'] + $this->data[$row]['vierasmaalit']) - ($this->data[$row]['kpaastetyt'] + $this->data[$row]['vpaastetyt']);
		}
		else if( $column === 'tm' ) {
		    $ret = $this->data[$row]['kotimaalit'] + $this->data[$row]['vierasmaalit'];
		}
		else if( $column === 'pm' ) {
		    $ret = $this->data[$row]['kpaastetyt'] + $this->data[$row]['vpaastetyt'];
		}
		else if( $column === 'p') {
		    $ret = $this->data[$row]['v'] * 2 + $this->data[$row]['tp'];
		}
		else {
		    $ret = 'sa';
		}
		return $ret;
 	}

}
?>

