<?php
/*
 * Created on Jan 13, 2005
 *
 *
 */
 require_once("multilista.php");
 require_once("mainview.php");

 class Main extends MultiLista
{
    var $result;

    function Main() {
        $this->MultiLista('main');
        
        $this->setSortin(false);

        $this->columns = array(
            'seuraavat' => array('tyyppi', 'paikka', 'pvm'),
            'tulokset' => array('sarjannimi', 'kotijoukkue', 'vierasjoukkue', 'sarja', 'pvm'),
            'uutiset' => array('pvm', 'uutinenID', 'otsikko'));

        $this->links = array(
            'seuraavat'=>array(
                    'pvm'=>array(array('tapahtumaid'),'tapahtumanlisays')),
            'tulokset' =>array(
                    'sarjannimi'=>array(array('peliid'),'pelitilastot'),
                    'pvm'=>array(array('peliid'),'pelitilastot'),
                    'lopputulos'=>array(array('peliid'),'pelitilastot'),
                    'kotijoukkue'=>array(array('peliid'),'pelitilastot'),
                    'vierasjoukkue'=>array(array('peliid'),'pelitilastot')),
            'uutiset' => array(
            		'pvm' => array(array('uutinenID'),'uutislista'),
            		'otsikko'=> array(array('uutinenID'),'uutislista'))
                    
         );
         
        $this->defaultorder = array(
            'seuraavat' => 'paiva',
            'tulokset' => 'paiva',
            'uutiset' => 'pvm'
        );

        $this->order = array(
            'seuraavat' => 'asc',
            'tulokset' => 'desc',
            'uutiset' => 'desc'
        );

        $this->nextdirection = $this->order;

        $this->direction = $this->order;

        $this->viewname = "MainView";

        $this->setLimit(5);
    }

    function suorita() {
		
        // jos ei löydy täyttämättömiä kohtia niin kantaan vaan
        if ( (isset($_REQUEST['tulossa']) or isset($_REQUEST['eitulossa'])) and isset($_REQUEST['tapahtumaid']) ) {

            $this->drawForm = false;
            $this->openConnection();            

            if( isset($_REQUEST['tulossa']) and $_REQUEST['ilmoittaudu'] == 0) {
                $this->db->doQuery( "INSERT INTO osallistuja values ($_REQUEST[tapahtumaid], $_SESSION[hloid], '1')" );
            }
            else if( isset($_REQUEST['tulossa']) and $_REQUEST['ilmoittaudu'] == 1 ) {
                $this->db->doQuery( "UPDATE osallistuja SET paasee = '1', selite = '' WHERE tapahtumaid = $_REQUEST[tapahtumaid] and osallistuja = $_SESSION[hloid]" );
            }
            else if( trim($_REQUEST['selite']) == '' ) {
                $this->addError("Jos et p&auml;&auml;se tulemaan niin anna syy!");
            }
            else {
                if( isset($_REQUEST['eitulossa']) and $_REQUEST['ilmoittaudu'] == 0) {
                    $this->db->doQuery( "INSERT INTO osallistuja values ($_REQUEST[tapahtumaid], $_SESSION[hloid], '0', '$_REQUEST[selite]')" );
                }
                else if( isset($_REQUEST['eitulossa']) and $_REQUEST['ilmoittaudu'] == 1) {
                    $this->db->doQuery( "UPDATE osallistuja SET paasee = '0', selite = '$_REQUEST[selite]' WHERE tapahtumaid = $_REQUEST[tapahtumaid] and osallistuja = $_SESSION[hloid]" );
                }
                else {
                    print "TÄNNE EI OLISAANUT TULLA BUGI!!!et viitsis ilmoittaa ylläpitoon.";
                }
            }

            //tästa alkaa takaisinkytkennän toimintasarja
            $this->suoritaAutoRefresh();
            $this->db->close();
            
            return;
        }

        parent::suorita();

        $i=0;
        foreach( $this->data['seuraavat'] as $rivi) {

            if( trim($rivi['paasee']) == '' ) {
                $this->data['seuraavat'][$i]['ilmoittaudu'] = 0;
            }
            else {
                $this->data['seuraavat'][$i]['ilmoittaudu'] = 1;
            }
            $i++;
        }      
        
    }
    
    function getQuery($key)
    {
        if($key == 'seuraavat' ) {
            $henkilo = 0;
            if( $this->LOGGED_IN == true ) {
                $henkilo = $_SESSION['hloid'];    
            }
            return "SELECT tapahtumaid, tyyppi, paikka, (paiva||' '||to_char(aika,'HH24:MI')) as pvm, kuvaus, " .
                "   (SELECT trim(etunimi||' '||sukunimi) FROM henkilo WHERE hloid = vastuuhlo) as vastuuhlo, " .
                "   (SELECT paasee FROM osallistuja as o  WHERE o.osallistuja = $henkilo and o.tapahtumaid = t.tapahtumaid ) as paasee, " .
                "   (SELECT selite FROM osallistuja as o  WHERE o.osallistuja = $henkilo and o.tapahtumaid = t.tapahtumaid ) as selite, " .
                "   (SELECT nimi FROM Halli, Peli p WHERE halliid = p.pelipaikka and p.peliid = t.tapahtumaid) as pelipaikka " .
                " FROM Tapahtuma t WHERE paiva >= CURRENT_DATE";
        }
        else if($key == 'tulokset') {
            return "SELECT (s.kausi||', '||s.tyyppi) as sarjannimi, (b.kotimaalit||' - '||b.vierasmaalit) as lopputulos,
                    (t.paiva||' '||to_char(t.aika,'HH24:MI')) as pvm, peliid,
                    (SELECT lyhytnimi FROM joukkue WHERE (joukkueid = b.kotijoukkue)) AS kotijoukkue,
                    (SELECT lyhytnimi FROM joukkue WHERE (joukkueid = b.vierasjoukkue)) AS vierasjoukkue
                FROM peli b, Sarja s, tapahtuma t 
                WHERE (t.tapahtumaid = b.peliid) and t.paiva >= (CURRENT_DATE - 90) and t.paiva <= CURRENT_DATE and s.sarjaid = b.sarja 
					 AND peliid = tapahtumaid AND (kotijoukkue = ".$_SESSION['defaultjoukkue']." OR vierasjoukkue = ".$_SESSION['defaultjoukkue'].")";
        }
        else if($key == 'uutiset') {
            return "SELECT pvm, otsikko, uutinenID FROM Uutinen WHERE pvm >= (CURRENT_DATE - 10)";
        }
    }

} // end of Main

?>