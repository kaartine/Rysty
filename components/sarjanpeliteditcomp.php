<?php

/** 
 * sarjanpeliteditcomp.php
 * Copyright Rysty 2006:
 *   Jukka Kaartinen
 * 
 * Created on 30.9.2006
 */
 
require_once('sarjanpelitcomp.php');

class SeriesPlayedGamesEdit extends SeriesPlayedGames {


	function SeriesPlayedGamesEdit($toiminto, $pEitulosta) {
		$this->SeriesPlayedGames($toiminto, $pEitulosta);
		
		$this->set('dorder', array() );	// Oletus järjestys
 			
 		$this->headers = array(
 			'pvm' => array('pvm','','desc'),     
 			'kotijoukkue' => array('kotijoukkue','tilastot','asc'),
 			'kotimaalit' => array('kotimaalit','tilastot','desc'),
 			'vierasmaalit' => array('vierasmaalit','tilastot','desc'), 
			'vierasjoukkue' => array('vierasjoukkue','tilastot','asc'),
			'muuta' => array('muokkaa','',''),
			'poista' => array('poista','','')
		);
		
		if( !$pEitulosta ) {
		    $this->eitulosta = 'AND kotimaalit IS NOT NULL';
		}
		
 		$this->links = array(
			'muokkaa' => array('SL', 'sarjanpelit', array('peliid')),
			'poista' => array('SL', 'sarjanpelit', array('peliid'), array('poista'=> 'true') ));
	}
	
	/**
	 * 
	 * Set query.
	 */
	function getQuery() {
	    return
	        "SELECT tapahtumaid as peliid, to_char(paiva,'YYYY-MM-DD') as oikeaaika, paiva as pvm, kotimaalit, vierasmaalit, " .
	        "	(SELECT lyhytnimi FROM joukkue WHERE joukkueid = p.kotijoukkue) as kotijoukkue, ".
	        "	(SELECT lyhytnimi FROM joukkue WHERE joukkueid = p.vierasjoukkue) as vierasjoukkue ".
	    	"FROM Peli p, Tapahtuma t WHERE tapahtumaid = peliid ".$this->eitulosta." AND sarja = ".$this->outparams['sarjaid']. " ORDER BY oikeaaika DESC, kotijoukkue ASC";
	}
	
    function column( $row, $column ) {
		$ret = '';

		if( $column === 'muokkaa') {
    	    $ret = $this->TM->getText('muokkaa');
		}
		else if($column === 'poista') {
		    $ret = $this->TM->getText('poista');
		}
        else {
			D('SARAKETTA ei l&ouml;ytynyt.');
		}
		
		return $ret;
	}
	
//	function drawTableHeaders() {}
//	
//	function drawTableRows() {
//		// taulukon arvot		
//		$i=1;
//		foreach( $this->data as $row ) {
//			print '<tr class="'.$this->outfit['trclass'].'">';
//			$voittaja = 0; // 0 = tasapeli, -1 koti voitti ja 1 vieras voitti
//			if( $row['kotimaalit'] > $row['vierasmaalit'] ) {
//			    $voittaja = -1;
//			}
//			else if( $row['kotimaalit'] < $row['vierasmaalit'] ) {
//			    $voittaja = 1;
//			}
//						
//			foreach( $this->headers as $header ) {
//		        print '<td class="'.$header[1].'">';
//			    if( $voittaja == -1 and ($header[0] === 'kotijoukkue' or $header[0] === 'kotimaalit' ) ) {
//                    print '<b>'.$this->createLink($header[0], $row).'</b>';
//			    }
//			    else if( $voittaja == 1 and ($header[0] === 'vierasjoukkue' or $header[0] === 'vierasmaalit' ) ) {
//                    print '<b>'.$this->createLink($header[0], $row).'</b>';
//			    }
//			    else {
//			        print $this->createLink($header[0], $row);
//			    }
//				print '</td>';
//			}
//            $i++;			
//			print '</tr>';			
//		}
//	}
}
?>


