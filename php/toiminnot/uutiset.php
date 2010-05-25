<?php
/**
 * uutiset.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: %date%
 *
*/

require_once("lisattava.php");
require_once("uutisetview.php");
require_once("lomakeelementit.php");
/**
 * class Uutiset
 *
 */
class Uutiset extends Lisattava
{
    function Uutiset(){
        $this->Lisattava('uutiset');

        $this->tiedot=array(
            'uutinenid'=>array(NULL,FALSE,'HIDDEN'),
            'pvm'=>array('',FALSE,'HIDDEN'),
            'ilmoittaja'=>array('',FALSE,'HIDDEN',80),
            'otsikko'=>array('',TRUE,'TEXT',100),
            'uutinen'=>array('',TRUE,'TEXTAREA')
        );

        $this->viewName = "UutisetView";
        $this->taulunNimi = "uutinen";	
    }

    function checkContent(&$req){
    }


    /**
     * Luokkakohtaiset erikoiskentät täytetään tämä ylimäärittelemällä.
     */
    function taytaErikoisKentat(){
        if ( isset($_REQUEST['uutinenid']) and is_numeric($_REQUEST['uutinenid']) ){
          $this->haeTiedotKannasta();
        }
        /*$this->tiedot['uutinen'][0] = new TextArea('uutinen', $this->tiedot['uutinen'][0] );
        $this->tiedot['uutinenid'][0] = new Input('uutinenid', $this->tiedot['uutinenid'][0],'hidden' );
        $this->tiedot['pvm'][0] = new Input('pvm', $this->tiedot['pvm'][0] ,'hidden');
        $this->tiedot['ilmoittaja'][0] = new Input('ilmoittaja', $this->tiedot['ilmoittaja'][0] ,'hidden');*/
    }
    
    function haeTiedotKannasta() {
        $query = 'SELECT * from uutinen where uutinenid = ' . $_REQUEST['uutinenid'];
        $result = $this->commitSingleSQLQuery($query);
        if ( count($result) == 1) {
            foreach ( $this->tiedot as $k => $v ) {
                if ( array_key_exists($k, $result[0]) ) {
                    $this->tiedot[$k][0] = $result[0][$k];
                }
            }
        }
    }

    function laitaKantaan () {

        // INSERT INTO taulu (nimet,toinen) values (arvo,toka)
        $_REQUEST['pvm'] = date("d.m.Y");
        $this->tiedot['pvm'][0] = $_REQUEST['pvm'];

        $_REQUEST['ilmoittaja'] = $_SESSION['kokonimi'];
        $this->tiedot['ilmoittaja'][0] = $_REQUEST['ilmoittaja'];

        if ( isset($_REQUEST['uutinenid']) and is_numeric($_REQUEST['uutinenid']) ){
            $ehdot = 'uutinenid = '.$_REQUEST['uutinenid'];
            $tmptiedot = array_keys($this->tiedot);
            $query = $this->paivittavaSQLLauseke($tmptiedot, $this->taulunNimi, $ehdot);
        }
        else {
            $query = $this->annaSQLLauseke();
        }
        $result = $this->commitSingleSQLQuery( $query );
	
	$this->updateNewsRssFeed();
    }

} // end of Uutiset
?>
