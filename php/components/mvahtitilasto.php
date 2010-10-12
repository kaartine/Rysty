<?php

/** 
 * mvahtitilasto.php
 * Copyright Rysty 2006:
 *   Jukka Kaartinen
 * 
 * Created on 19.4.2006
 */
 
require_once('tablecomponent.php');

class GoalieStats extends TableComponent {

	var $outfit = array('tableclass' => '', 'trclass' => '', 'thclass' => '');

	function GoalieStats($toiminto) {
		$this->TableComponent($toiminto);
		
		$this->set('dorder', array( 'mpero', 'maalivahti') );	// Oletus järjestys
 		
 /*		
 		print '<pre>';
 		print_r($_SESSION);
 		print '</pre>';
*/ 		
 		$this->headers = array(
 			'maalivahti' => array('maalivahti','','asc'), 
 			'ottelut' => array('ottelut','tilastot','desc'),
 			'voitot' => array('voitot','tilastot','desc'),
 			'peliaika' => array('peliaika','tilastot','desc'), 
			'maalit' => array('maalit','tilastot','desc'), 
			'mpero' => array('mpero','tilastotc','asc')
		);
		
 		$this->links = array(
			'maalivahti' => array('SL', 'pelaajakortti', array('pelaaja','joukkueid')));
	}

	/**
	 * 
	 * Set query.
	 */
	function getQuery() {
		return 
		"SELECT DISTINCT p.pelaajaid as pelaaja, $_SESSION[defaultjoukkue] as joukkueid, h.hloid as hloid, trim(sukunimi||' '||etunimi) as maalivahti, " .
        "    (SELECT count(p.peliID) FROM Peli p, Sarja s, Pelaajatilasto pt WHERE (kotijoukkue = $_SESSION[defaultjoukkue] or vierasjoukkue = $_SESSION[defaultjoukkue]) and s.kausi IN (".$this->outparams['kausi'].") ".$this->outparams['sarja']." and p.peliid = pt.peliid and pt.peliid IN (SELECT a.peliid FROM Peli a WHERE (a.kotijoukkue = $_SESSION[defaultjoukkue] or a.vierasjoukkue = $_SESSION[defaultjoukkue]) ".$this->outparams['sarja']." and a.sarja = p.sarja ) and pt.pelaaja = h.hloid and pt.maalivahti = true) as ottelut, " .
        "    (SELECT count(p.peliID) FROM Peli p, Sarja s, Pelaajatilasto pt WHERE ( (kotijoukkue = $_SESSION[defaultjoukkue] and kotimaalit > vierasmaalit) or (vierasjoukkue = $_SESSION[defaultjoukkue] and vierasmaalit > kotimaalit)) and s.kausi IN (".$this->outparams['kausi'].") ".$this->outparams['sarja']." and p.peliid = pt.peliid and pt.peliid IN (SELECT a.peliid FROM Peli a WHERE (a.kotijoukkue = $_SESSION[defaultjoukkue] or a.vierasjoukkue = $_SESSION[defaultjoukkue]) ".$this->outparams['sarja']." and a.sarja = p.sarja ) and pt.pelaaja = h.hloid and pt.maalivahti = true) as voitot, " .
        "    (SELECT to_char(sum(pt.mvtuloaika),'DD:HH24:MI') FROM Peli p, Sarja s, Pelaajatilasto pt WHERE (kotijoukkue = $_SESSION[defaultjoukkue] or vierasjoukkue = $_SESSION[defaultjoukkue]) and s.kausi IN (".$this->outparams['kausi'].") ".$this->outparams['sarja']." and p.peliid = pt.peliid and pt.peliid IN (SELECT a.peliid FROM Peli a WHERE (a.kotijoukkue = $_SESSION[defaultjoukkue] or a.vierasjoukkue = $_SESSION[defaultjoukkue]) ".$this->outparams['sarja']." and a.sarja = p.sarja ) and pt.pelaaja = h.hloid and pt.maalivahti = true) as minuutit, " .
 		"    (SELECT sum(pt.paastetytmaalit) FROM Peli p, Sarja s, Pelaajatilasto pt WHERE (kotijoukkue = $_SESSION[defaultjoukkue] or vierasjoukkue = $_SESSION[defaultjoukkue]) and s.kausi IN (".$this->outparams['kausi'].") ".$this->outparams['sarja']." and p.peliid = pt.peliid and pt.peliid IN (SELECT a.peliid FROM Peli a WHERE (a.kotijoukkue = $_SESSION[defaultjoukkue] or a.vierasjoukkue = $_SESSION[defaultjoukkue]) ".$this->outparams['sarja']." and a.sarja = p.sarja ) and pt.pelaaja = h.hloid and pt.maalivahti = true) as maalit " .
 		" FROM Pelaajatilasto pe, Pelaaja as p, Henkilo as h WHERE pe.peliid IN ( (Select p.peliid FROM peli p, sarja s where (p.kotijoukkue=$_SESSION[defaultjoukkue] or p.vierasjoukkue=$_SESSION[defaultjoukkue]) and p.sarja=s.sarjaid and s.kausi IN (".$this->outparams['kausi']."))) and pe.maalivahti = true and h.hloid = p.pelaajaid and pe.pelaaja = h.hloid and pe.joukkue=$_SESSION[defaultjoukkue]";		
	}
	
	function column($row, $column ) {
		$ret = 0;
//		print $row;		
//		print '<pre>';
//		print_r($this->data);
//		print '</pre>';
		
		if ($column === 'mpero') {
			if( $this->data[$row]['ottelut'] > 0 ) {
				$ret = round($this->data[$row]['maalit'] / $this->data[$row]['ottelut'],2);
			}
		}	
		else if($column === 'peliaika')	{
			$tmp = explode(':', $this->data[$row]['minuutit']);
			if ( count($tmp) == 3 ) {
				// muutetaan päivä ja tunnit minuuteiksi ja lasketaan yhteen			 
	            $ret = (($this->data[$row]['ottelut']*$_SESSION['peliaika']) - (intval($tmp[0])*1440)+(intval($tmp[1])*60)+(intval($tmp[2])));
	        }
		}
		
		return $ret;
 	}
}
?>

