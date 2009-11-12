<?php

/** 
 * sarjanpelitcomp.php
 * Copyright Rysty 2006:
 *   Jukka Kaartinen
 * 
 * Created on 30.9.2006
 */
 
require_once('tablecomponent.php');

class SeriesPlayedGames extends TableComponent {

	var $outfit = array('tableclass' => '', 'trclass' => '', 'thclass' => '');
	var $eitulosta = '';

	function SeriesPlayedGames($toiminto, $pEitulosta) {
		$this->TableComponent($toiminto);
		
		$this->set('dorder', array() );	// Oletus järjestys
 			
 		$this->headers = array(
 			'pvm' => array('pvm','','desc'),     
 			'kotijoukkue' => array('kotijoukkue','tilastot','asc'),
 			'kotimaalit' => array('kotimaalit','tilastot','desc'),
 			'vierasmaalit' => array('vierasmaalit','tilastot','desc'), 
			'vierasjoukkue' => array('vierasjoukkue','tilastot','asc')
		);
		
		if( !$pEitulosta ) {
		    $this->eitulosta = 'AND kotimaalit IS NOT NULL';
		}
		
 //		$this->links = array(
//			'joukkue' => array('SL', 'joukkuekortti', array('joukkueid')));
	}
	
	function drawTableHeaders() {}
	
	function drawTableRows() {
		// taulukon arvot		
		$i=1;
		foreach( $this->data as $row ) {
			print '<tr class="'.$this->outfit['trclass'].'">';
			$voittaja = 0; // 0 = tasapeli, -1 koti voitti ja 1 vieras voitti
			if( $row['kotimaalit'] > $row['vierasmaalit'] ) {
			    $voittaja = -1;
			}
			else if( $row['kotimaalit'] < $row['vierasmaalit'] ) {
			    $voittaja = 1;
			}
						
			foreach( $this->headers as $header ) {
		        print '<td class="'.$header[1].'">';
			    if( $voittaja == -1 and ($header[0] === 'kotijoukkue' or $header[0] === 'kotimaalit' ) ) {
                    print '<b>'.$this->createLink($header[0], $row).'</b>';
			    }
			    else if( $voittaja == 1 and ($header[0] === 'vierasjoukkue' or $header[0] === 'vierasmaalit' ) ) {
                    print '<b>'.$this->createLink($header[0], $row).'</b>';
			    }
			    else {
			        print $this->createLink($header[0], $row);
			    }
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
	        "SELECT to_char(paiva,'YYYY-MM-DD') as oikeaaika, paiva as pvm, kotimaalit, vierasmaalit, " .
	        "	(SELECT lyhytnimi FROM joukkue WHERE joukkueid = p.kotijoukkue) as kotijoukkue, ".
	        "	(SELECT lyhytnimi FROM joukkue WHERE joukkueid = p.vierasjoukkue) as vierasjoukkue ".
	    	"FROM Peli p, Tapahtuma t WHERE tapahtumaid = peliid ".$this->eitulosta." AND sarja = ".$this->outparams['sarjaid']. "ORDER BY oikeaaika DESC, kotijoukkue ASC";
	}
}
?>
