<?php
/**
 * component.php
 * Copyright Rysty 2006:
 *   Jukka Kaartinen
 * 
 * Created on 19.4.2006
 * 
 * Component on abstracktiluokka kaikille componenteille. Siitä ei voi tehdä instansseja.
 */
 
 require_once("config.php"); // getID;
 
 class Component {
 
 	var $ID;
 	var $TM; // Kääntäjä
 	var $outparams = array();
 	var $toiminto;

 	/**
 	 * @param toiminto Toiminnon nimi jossa kyseinen komponentti sijaitsee.
 	 */
 	function Component($toiminto) {
 		$this->ID = getID( get_class($this) );
 		$this->TM = TranslationManager::instance();
 		$this->toiminto = $toiminto;
 		$_SESSION['IDS'][$this->ID] = 1;
    }
 	
 	
 	/**
 	 * Piirtää komponentin. 
 	 */
 	function draw() {
 		D('Implement drawPageSelector()- function!');
 	}
 	 
 	function addParameters($params) {
 		$keys = array_keys( $params );
 		foreach( $keys as $name ) {
 			$this->outparams[$name] = $params[$name];
 		} 
 	}
 	 
	/**
	 * Sets variable to session
	 */
	function set($name, $value) {
		if( !isset($this->ID) ) {
			D('IDt&auml; ei ole asetettu');
			return;
		}
		
//		if( !isset($_SESSION['ID'.$this->ID][$name]) ) {
			$_SESSION['ID'.$this->ID][$name] = $value;
//		}
	}
	
	/**
	 * Gets variable to session.
	 */
	function get($name) {
		if( !isset($this->ID) ) {
			D('IDt&auml; ei ole asetettu');
			return;
		}
//		print_r($_SESSION);
		if( isset($_SESSION['ID'.$this->ID][$name]) ) {
			return $_SESSION['ID'.$this->ID][$name];
		}
		
		return NULL;
	}
 }
 
?>
