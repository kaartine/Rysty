<?php
/**
 * poistettava.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Teemu Siitarinen
 * created: 07.02.2005
 *
*/



/**
 * class Poistettava
 *
 */
/******************************* Abstract Class ****************************
  Poistettava does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/

require_once("toiminto.php");
require_once("form.php");


class Poistettava extends Toiminto
{
    var $taulunNimi;
    var $drawForm;
    var $notset;
    var $result;
    var $tiedot;
    var $pakollisetTiedot;
    var $viewName;
    var $toiminnonNimi;
    var $avain;

    function Poistettava(){
        $this->Toiminto();
        unset( $taulunNimi);
        unset( $drawForm);
        unset( $notset);
        unset( $result);
        unset( $tiedot);
        unset( $pakollisetTiedot);
        unset( $viewName);
        unset( $toiminnonNimi);
    }
	
    /**
     * Checks that all fields in given array are set in _REQUEST
     */
    function &kentatTaytetty(&$kentat){
        $notset = array();
        foreach ($kentat as $value) {
            if ( !isset( $_REQUEST[$value] ) or $_REQUEST[$value] == NULL ) {
                array_push($notset,$value);
            }
        }
        return $notset;
    }
    /**
     * Poistaa annetun taulukon ( muotoa 'key') mukaisten
     * avainten perusteella sql queryn.
     * @return string example: DELETE FROM taulu WHERE pitkanimi = value
     */
    function &poistavaSQLLauseke(&$idtieto,$tauluNimi){
            $row=$idtieto;
			$val = $_REQUEST[$idtieto];
            $value="'".trim($val)."'";
            $query = "DELETE FROM ".$tauluNimi." WHERE ".substr($row, 0, -1)." = ".substr($value, 0, -1).")" ;
            return $query;
    }

    /**
     * Päivittää annetun taulukon( muotoa array('key 1', 'key 2') mukaisten
     * avainten perusteella sql queryn.
     * @return string example: UPDATE taulu SET (pitkanimi, maskotti) values WHERE ehdot
     * ('Mun nimi', ' Gorilla maskotti')
    */
    function &paivittavaSQLLauseke(&$tiedot, $tauluNimi, $ehdot) {
        $rows="";
        $values="";
        foreach ($tiedot as $k) {
            $val = $_REQUEST[$k];
            if ( $val != NULL ) {
                $values = $values." ".$k." = '".trim($val)."',";
            }
        }
    	$query = "UPDATE ".$tauluNimi." SET ".substr($values, 0, -1) ." WHERE ".$ehdot;

        // update, yhteystieto on jo olemassa
        return $query;
    }

    /**
        Tarkastaa onko edes yksi talukonarvo asetettu
        @param arvot Viitaus talukkoon jossa on aivaimet joiden pitäisi olla asetettuna $_REQUESTissä
        @return true jos jonkin arvo asetettu muuten false
    */
    function arvotAsetettu(&$arvot) {
        foreach ($tiedot as $k) {
            if ( array_key_exists($k, $_REQUEST ) and $_REQUEST[$k] != NULL and $_REQUEST[$k] !== "")
            {
                return true;
            }
        }
        return false;
    }

} // end of Poistettava
?>
