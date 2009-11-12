<?php
/**
 * pelaajatilastot.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 28.01.2005
 *
*/

require_once("lomakeelementit.php");
require_once("toiminto.php");
require_once("pelaajatilastotview.php");

require_once("mvahtitilasto.php");
require_once("kenttapelaajatilastot.php");

/**
 * class PelaajaTilastot
 *
 */
class PelaajaTilastot extends Toiminto
{
    var $kausi;
    var $kausiid;
    var $kaudet;
    var $sarjat;
    
    var $maalivahdit;
    var $kenttapelaajat;

    function PelaajaTilastot(){
        $this->Toiminto('pelaajatilastot');
        // pelinumero pitäisi hakea erikseen sillä muuten tulee tupla rivejä jos eri pelaaja on
        // pelannut eri numeroilla
//        $this->columns = array(/*'pelinumero',*/ 'nimi', 'pelit', 'maalit', 'syotot', 'pisteet',
  //          'jaahyt', 'plusmiinus', 'ppp');
  //      $this->defaultorder = 'maalit';        
            
        $this->viewname = "PelaajaTilastotView";
 //       $this->links = array(            
            /*'pelinumero'=>array(array('pelaaja','joukkueid'),'pelaajakortti','LINK'),*/        
   //         'nimi'=>array(array('pelaaja','joukkueid'),'pelaajakortti','LINK'),        

     //   );      

        if( !isset($_REQUEST['sarja']) ) {
        	if( $_SESSION['kaikkisarjat'] == true ) {
				$this->sarjaid = 'kaikki';
                $this->sarja = "and s.sarjaid = p.sarja";
                
                $this->kausi = "SELECT DISTINCT kausi FROM Sarja";
                $this->kausiid = 'kaikki';
                
                $this->plusmiinussarja = "SELECT sarja FROM Peli ph WHERE (ph.kotijoukkue = $_SESSION[defaultjoukkue] or ph.vierasjoukkue = $_SESSION[defaultjoukkue])";
                
                $_SESSION['kaikkisarjat'] = true;
        	}
        	else {
	            $this->sarja = "and s.sarjaid = $_SESSION[sarja] and p.sarja = s.sarjaid";
	            $this->sarjaid = $_SESSION['sarja'];
	
	            $this->kausi = "SELECT kausi FROM Sarja WHERE sarjaid = $this->sarjaid";
	            $this->kausiid = $this->sarjaid;
	            
	            $this->plusmiinussarja = "$this->sarjaid";
        	}
        }
        else {
            if( $_REQUEST['sarja'] === "kaikki" /*or $_SESSION['kaikkisarjat'] == true*/ ) {
                $this->sarjaid = 'kaikki';
                $this->sarja = "and s.sarjaid = p.sarja";
                
                $this->kausi = "SELECT DISTINCT kausi FROM Sarja";
                $this->kausiid = 'kaikki';
                
                $this->plusmiinussarja = "SELECT sarja FROM Peli ph WHERE (ph.kotijoukkue = $_SESSION[defaultjoukkue] or ph.vierasjoukkue = $_SESSION[defaultjoukkue])";
                
                $_SESSION['kaikkisarjat'] = true;
            }
            else {
                $this->sarja = "and s.sarjaid = $_REQUEST[sarja] and p.sarja = s.sarjaid";
                $this->sarjaid = $_REQUEST['sarja'];
                
                $this->kausi = "SELECT kausi FROM Sarja WHERE sarjaid = $this->sarjaid";
                $this->kausiid = $this->sarjaid;
                
                $this->plusmiinussarja = $this->sarjaid;
                
                $_SESSION['sarja'] = $_REQUEST['sarja'];
                $_SESSION['kaikkisarjat'] = false;
            }
        }

/*
        if( $_REQUEST['sarja'] === "kaikki" ) {
            //$this->kausi = "SELECT kausi FROM Sarjanjoukkueet WHERE joukkue = $_SESSION[defaultjoukkue]";
            $this->kausi = "SELECT DISTINCT kausi FROM Sarja";
            $this->kausiid = 'kaikki';
        }
        else {
            //$this->kausi = "SELECT kausi FROM Sarjanjoukkueet WHERE joukkue = $_SESSION[defaultjoukkue] and kausi = $_REQUEST[kausi]";
            $this->kausi = "SELECT kausi FROM Sarja WHERE sarjaid = $this->sarjaid";
            $this->kausiid = $this->sarjaid;
        }*/


//        unset($this->kaudet);
//        unset($this->sarjat);
    }

    function suorita() {
/*        
        $this->setOrder('desc');
        
        if(!isset($_REQUEST['sort'])) {
            $_REQUEST['sort'] = 'pisteet';
            $_REQUEST['dir'] = 'asc';
        }
        
        if( isset($_REQUEST['sort']) and $_REQUEST['sort'] == 'pisteet' ) {
            unset($_REQUEST['sort']);
            $_REQUEST['omasort'] = 'pisteet';
        }
        
        if( isset($_REQUEST['sort']) and $_REQUEST['sort'] == 'ppp' ) {
            unset($_REQUEST['sort']);
            $_REQUEST['omasort'] = 'ppp';
        }
*/
        $this->createView($this->viewname);


        // open connection to db
        $this->openConnection();

        
        $sarja = "sarja";
        $result = &$this->db->doQuery("SELECT sarjaid, (kausi||', '||tyyppi||', '||nimi) as value FROM Sarja ORDER BY kausi DESC");
        array_push($result, array('nimi'=>'kaikki','value'=>'kaikki'));
        $this->sarjat = new Select( $result, $sarja, $this->sarjaid, true );
        
        $this->db->close();
/*        
        $i = 0;
        foreach( $this->data as $rivi ) {
            if( $rivi['pelit'] > 0 )
                $this->data[$i]['ppp'] = round(($rivi['maalit']+$rivi['syotot'])/$rivi['pelit'],2);
            else
                 $this->data[$i]['ppp'] = 0;
                
            $this->data[$i]['pisteet'] = $rivi['maalit']+$rivi['syotot'];
            $i++;
        }       
        
        if( isset($_REQUEST['omasort']) ) {
            usort($this->data, array("PelaajaTilastot", "cmp") );
        }
*/        
        $this->maalivahdit = new GoalieStats('pelaajatilastot');
        $this->maalivahdit->addParameters(array('sarja' => $this->sarja, 'kausi' => $this->kausi));
        $this->maalivahdit->suorita();

        $this->kenttapelaajat = new FieldPlayerStats('pelaajatilastot');
        $this->kenttapelaajat->addParameters(array('sarja' => $this->sarja, 'kausi' => $this->kausi, 'plusmiinussarja' => $this->plusmiinussarja));
        $this->kenttapelaajat->suorita();
    }
/*    
    function getQuery() {
        return
        "SELECT DISTINCT hloid as pelaaja, pe.joukkue as joukkueid, hloid, trim(sukunimi||' '||etunimi) as nimi, " .
        "   (SELECT count(p.peliID) FROM Peli p, Sarja s, Pelaajatilasto pt WHERE (kotijoukkue = $_SESSION[defaultjoukkue] or vierasjoukkue = $_SESSION[defaultjoukkue]) and s.kausi IN ($this->kausi) $this->sarja and p.peliid = pt.peliid and pt.peliid IN (SELECT a.peliid FROM Peli a WHERE (a.kotijoukkue = $_SESSION[defaultjoukkue] or a.vierasjoukkue = $_SESSION[defaultjoukkue]) $this->sarja and a.sarja = p.sarja ) and pt.pelaaja = h.hloid ) as pelit, " .
        "   (SELECT count(maaliID) FROM Maali m, Tilastomerkinta t, Sarja s, Peli p WHERE m.maaliid = t.timerkintaID and t.joukkueid = $_SESSION[defaultjoukkue] and s.kausi IN ($this->kausi)  and p.peliid = t.peliID $this->sarja and m.tekija = h.hloid) as maalit," .
        "   (SELECT count(syottaja) FROM Maali m, Tilastomerkinta t, Sarja s, Peli p WHERE m.maaliid = t.timerkintaID and t.joukkueid = $_SESSION[defaultjoukkue] and s.kausi IN ($this->kausi) and p.peliid = t.peliID and m.syottaja IN (SELECT hloid FROM henkilo) $this->sarja and m.syottaja = h.hloid) as syotot," .
        "   (SELECT sum(minuutit) FROM Rangaistus r, Tilastomerkinta t, Sarja s, Peli p WHERE r.rangaistusid = t.timerkintaID and t.joukkueid = $_SESSION[defaultjoukkue] and s.kausi IN ($this->kausi) and p.peliid = t.peliID $this->sarja and r.saaja = h.hloid) as jaahyt, " .
        "   (SELECT sum(plusmiinus) FROM Pelaajatilasto pt WHERE pt.peliid IN (SELECT peliid FROM Peli p WHERE (p.kotijoukkue = $_SESSION[defaultjoukkue] or p.vierasjoukkue = $_SESSION[defaultjoukkue]) and p.sarja IN ($this->plusmiinussarja ) and pt.pelaaja = h.hloid )) as plusmiinus " .
        " FROM Pelaajat pe, Henkilo h WHERE pe.joukkue = $_SESSION[defaultjoukkue] and pe.pelaaja = h.hloid and pe.kausi IN ($this->kausi) ";
        

    }
*/
} // end of PelaajaTilastot
?>
