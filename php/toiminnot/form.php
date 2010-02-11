<?php
/*
 * Created on Jan 30, 2005
 *
 * Created by Jukka Kaartinen
 *  (c) Lämmi
 */
 
 
 
 /*class Form {
 	
 	var $characters = array();
 	
 	function Form($characters = NULL) {
 		if( !is_null($characters) ) {
 			$this->characters = $characters;
 		}
 		else {
 		//	$this->characters = array(array(197,196,214,229,228,246,";"),array("&Aring;","&Auml;","&Ouml;","&aring;","&auml;","&ouml;","ERROR"));
 			//$this->characters = array(array(197,196,214,229,228,246,";"),array("&Aring;","&Auml;","&Ouml;","&aring;","&auml;","&ouml;","ERROR"));
 		}
 	}
 	*/
 
 	/**
 	 * Check content of the form by replaysing characters  
 	 */
 	function &checkContent(&$form, $quote_style = ENT_QUOTES ) {
 		foreach($form as $key => $value)
 		{
 			// rekursiivinen osaisi tarkistaa myös mahdolliset taulukot mutta tällä hetkellä ei tarvetta.
 			/*if( is_array($value) ) {
 				$form[$key] = &checkContent($value);
 				continue;
 			}*/
 			//$given = &$value;
 			
 			//$form[$key] = str_replace($this->characters[0], $this->characters[1],$value);
 			//$form[$key] = &html_entity_decode( $value, $quote_style );
   			$form[$key] = &htmlspecialchars( html_entity_decode( $value, $quote_style ), $quote_style );
   			
   			
 		}
 		return $form;
	}
//}
 
?>
