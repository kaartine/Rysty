<?php
/*
 * Created on Jan 22, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */

 require_once("lisattava.php");
 require_once("lisattavaview.php");
require_once("errorview.php");
/**
 * class Login
 *
 */
class SalasananVaihto extends Lisattava
{


    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function SalasananVaihto(){
        $this->Lisattava('salasananvaihto');

        $this->drawForm = true;
        $this->tiedot=array(
            'vanhasalasana' => array('',TRUE,'PASSWORD',16),
            'salasana' => array('',TRUE,'PASSWORD',16),
            'salasana2' => array('',TRUE,'PASSWORD',16),
        );
        $this->viewName = 'LisattavaView';
        if ( !isset($_SESSION['nimi']) or !isset($_SESSION['hloid']) ) {
            $this->viewName = 'ErrorView';
        }
        $this->taulunNimi = 'kayttajat';
    }
    
    function laitaKantaan(){
        $kayttajaArvot = array('salasana');
        $ehdot = "tunnus = '$_SESSION[nimi]'";
        $this->tiedot['salasana'][0] = md5($_REQUEST['salasana']);

        $query = $this->paivittavaSQLLauseke($kayttajaArvot, "kayttajat", $ehdot);
        $result = $this->commitSingleSQLQuery( $query );
        $this->lisattyKantaan = array('Salasana'=>'Vaihdettu');

		//$this->asetaSalaus(false);
    }
    function lueJaTarkistaRequest() {
        $value = parent::lueJaTarkistaRequest();
        if(
            $_REQUEST['salasana'] !== $_REQUEST['salasana2'] ) {
                $value = FALSE;
                $this->addError("Uudet salasanat eiv&auml;t t&auml;sm&auml;&auml;!");
        } else {
            $md5salasana = md5($_REQUEST['vanhasalasana']);
            $nimi = $_SESSION['nimi'];
            $query = "SELECT henkilo from kayttajat where tunnus = '$nimi'".
                    " and salasana = '$md5salasana'";
            $result = $this->commitSingleSQLQuery( $query );

            if ( count($result) != 1) {
                $value = FALSE;
                $this->addError("Virheellinen vanha salasana!");
            }
        }
        $this->tiedot['vanhasalasana'][0] = '';
        $this->tiedot['salasana'][0] = '';
        $this->tiedot['salasana2'][0] = '';

        return $value;
    }
}
?>
