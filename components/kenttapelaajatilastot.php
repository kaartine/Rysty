<?php

/** 
 * mvahtitilasto.php
 * Copyright Rysty 2006:
 *   Jukka Kaartinen
 * 
 * Created on 30.9.2006
 */
 
require_once('tablecomponent.php');

class FieldPlayerStats extends TableComponent {

	var $outfit = array('tableclass' => '', 'trclass' => '', 'thclass' => '');

	function FieldPlayerStats($toiminto) {
		$this->TableComponent($toiminto);
		
		$this->set('dorder', array( 'pist', 'maalit') );	// Oletus järjestys
 		
 /*		
 		print '<pre>';
 		print_r($_SESSION);
 		print '</pre>';
*/ 		
		
 		$this->headers = array(
 			'nimi' => array('nimi','','asc'),     
 			'pelit' => array('pelit','tilastot','desc'),
 			'maalit' => array('maalit','tilastot','desc'),
 			'syotot' => array('syotot','tilastot','desc'), 
			'pist' => array('pist','tilastot','desc'), 
			'jaahyt' => array('jaahyt','tilastot','desc'),
            'plusmiinus' => array('plusmiinus','tilastot','desc'),
 			'pp' => array('pp','tilastotc','desc')
		);
		
 		$this->links = array(
			'nimi' => array('SL', 'pelaajakortti', array('pelaaja','joukkueid')));
	}

	/**
	 * 
	 * Set query.
	 */
	function getQuery() {
	    return
	    "SELECT DISTINCT hloid as pelaaja, pe.joukkue as joukkueid, hloid, trim(sukunimi||' '||etunimi) as nimi, " .
        "   (SELECT count(p.peliID) FROM Peli p, Sarja s, Pelaajatilasto pt WHERE (kotijoukkue = $_SESSION[defaultjoukkue] or vierasjoukkue = $_SESSION[defaultjoukkue]) and s.kausi IN (".$this->outparams['kausi'].") ".$this->outparams['sarja']." and p.peliid = pt.peliid and pt.peliid IN (SELECT a.peliid FROM Peli a WHERE (a.kotijoukkue = $_SESSION[defaultjoukkue] or a.vierasjoukkue = $_SESSION[defaultjoukkue]) ".$this->outparams['sarja']." and a.sarja = p.sarja ) and pt.pelaaja = h.hloid ) as pelit, " .
        "   (SELECT count(maaliID) FROM Maali m, Tilastomerkinta t, Sarja s, Peli p WHERE m.maaliid = t.timerkintaID and t.joukkueid = $_SESSION[defaultjoukkue] and s.kausi IN (".$this->outparams['kausi'].")  and p.peliid = t.peliID ".$this->outparams['sarja']." and m.tekija = h.hloid) as maalit," .
        "   (SELECT count(syottaja) FROM Maali m, Tilastomerkinta t, Sarja s, Peli p WHERE m.maaliid = t.timerkintaID and t.joukkueid = $_SESSION[defaultjoukkue] and s.kausi IN (".$this->outparams['kausi'].") and p.peliid = t.peliID and m.syottaja IN (SELECT hloid FROM henkilo) ".$this->outparams['sarja']." and m.syottaja = h.hloid) as syotot," .
        "   (SELECT sum(minuutit) FROM Rangaistus r, Tilastomerkinta t, Sarja s, Peli p WHERE r.rangaistusid = t.timerkintaID and t.joukkueid = $_SESSION[defaultjoukkue] and s.kausi IN (".$this->outparams['kausi'].") and p.peliid = t.peliID ".$this->outparams['sarja']." and r.saaja = h.hloid) as jaahyt, " .
        "   (SELECT sum(plusmiinus) FROM Pelaajatilasto pt WHERE pt.peliid IN (SELECT peliid FROM Peli p WHERE (p.kotijoukkue = $_SESSION[defaultjoukkue] or p.vierasjoukkue = $_SESSION[defaultjoukkue]) and p.sarja IN (".$this->outparams['plusmiinussarja']." ) and pt.pelaaja = h.hloid )) as plusmiinus " .
        " FROM Pelaajat pe, Henkilo h WHERE pe.joukkue = $_SESSION[defaultjoukkue] and pe.pelaaja = h.hloid and pe.kausi IN (".$this->outparams['kausi'].") ";
	}
	
	function column($row, $column ) {
		$ret = 0;
//		print $row;		
//		print '<pre>';
//		print_r($this->data);
//		print '</pre>';
		
		if ($column === 'pp') {
			if( $this->data[$row]['pelit'] > 0 ) {
				$ret = round( ($this->data[$row]['maalit'] + $this->data[$row]['syotot']) / $this->data[$row]['pelit'],2);
			}
		}
		else if( $column === 'pist') {
		    $ret = $this->data[$row]['maalit'] + $this->data[$row]['syotot'];
		}
		return $ret;
 	}
}
?>

