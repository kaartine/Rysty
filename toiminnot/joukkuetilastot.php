
<?php
/**
 * joukkuetilastot.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 28.01.2005
 *
*/
require_once("lista.php");
require_once("joukkuetilastotview.php");
require_once("joukkueentiedot.php");

/**
 * class JoukkueTilastot
 *
 */
class JoukkueTilastot extends Lista
{
    function JoukkueTilastot(){
        $this->Lista('joukkuetilastot');

        $this->joukkuetiedot = new JoukkueTiedot();

        $this->columns = array('sarjannimi', 'pelit', 'voitot', 'tasapelit', 'tappiot', 'kotivoitot', 'kotitasapelit','kotitappiot');
        $this->defaultorder = '';
        $this->viewname = "JoukkueTilastotView";
        $this->links = array('sarjannimi' => array(array('kausi','joukkueid'),'joukkuekortti')
        );
    }

    function suorita() {
        $this->setOrder('desc');

        if( isset($_REQUEST['sort']) and $_REQUEST['sort'] == 'pisteet' ) {
            unset($_REQUEST['sort']);
            $_REQUEST['omasort'] = 'pisteet';
        }

        if( isset($_REQUEST['sort']) and $_REQUEST['sort'] == 'ppp' ) {
            unset($_REQUEST['sort']);
            $_REQUEST['omasort'] = 'ppp';
        }

        parent::suorita();

        if( isset($_REQUEST['omasort']) ) {
            usort($this->data, array("JoukkueTilastot", "cmp") );
        }

        $this->joukkuetiedot->haeTiedot($_SESSION['defaultjoukkue']);
    }

    function getQuery(){

        $sarja = "(kotijoukkue = $_SESSION[defaultjoukkue] and p.sarja = s.sarjaid and kotimaalit IS NOT NULL and vierasmaalit IS NOT NULL) or (vierasjoukkue = $_SESSION[defaultjoukkue] and s.sarjaid = p.sarja and kotimaalit IS NOT NULL and vierasmaalit IS NOT NULL) ";
        
        return
        "SELECT s.sarjaid, (s.kuvaus||', '||s.kausi) as sarjannimi, s.kausi, $_SESSION[defaultjoukkue] as joukkueid, " .
        "   (SELECT count(peliID) FROM Peli p WHERE $sarja) as pelit,
         (SELECT count(peliID) FROM Peli p WHERE (kotijoukkue = $_SESSION[defaultjoukkue] and kotimaalit > vierasmaalit and p.sarja = s.sarjaid) or
            (vierasjoukkue = $_SESSION[defaultjoukkue] and vierasmaalit > kotimaalit and p.sarja = s.sarjaid) ) as voitot,
         (SELECT count(peliID) FROM Peli p WHERE (kotijoukkue = $_SESSION[defaultjoukkue] and kotimaalit = vierasmaalit and p.sarja = s.sarjaid) or
            (vierasjoukkue = $_SESSION[defaultjoukkue] and vierasmaalit = kotimaalit and p.sarja = s.sarjaid) ) as tasapelit,
         (SELECT count(peliID) FROM Peli p WHERE (kotijoukkue = $_SESSION[defaultjoukkue] and kotimaalit < vierasmaalit and p.sarja = s.sarjaid) or
            (vierasjoukkue = $_SESSION[defaultjoukkue] and vierasmaalit < kotimaalit and p.sarja = s.sarjaid) ) as tappiot,
         (SELECT count(peliID) FROM Peli p WHERE kotijoukkue = $_SESSION[defaultjoukkue] and kotimaalit > vierasmaalit and p.sarja = s.sarjaid) as kotivoitot,
         (SELECT count(peliID) FROM Peli p WHERE kotijoukkue = $_SESSION[defaultjoukkue] and kotimaalit = vierasmaalit and p.sarja = s.sarjaid) as kotitasapelit,
         (SELECT count(peliID) FROM Peli p WHERE kotijoukkue = $_SESSION[defaultjoukkue] and kotimaalit < vierasmaalit and p.sarja = s.sarjaid) as kotitappiot, " .
         "(SELECT count(peliID) FROM Peli p WHERE vierasjoukkue = $_SESSION[defaultjoukkue] and kotimaalit < vierasmaalit and p.sarja = s.sarjaid) as vierasvoitot,
         (SELECT count(peliID) FROM Peli p WHERE vierasjoukkue = $_SESSION[defaultjoukkue] and kotimaalit = vierasmaalit and p.sarja = s.sarjaid) as vierastasapelit,
         (SELECT count(peliID) FROM Peli p WHERE vierasjoukkue = $_SESSION[defaultjoukkue] and kotimaalit > vierasmaalit and p.sarja = s.sarjaid) as vierastappiot" .
        " FROM Sarja s ORDER BY kausi asc, sarjannimi asc";

    }

} // end of JoukkueTilastot
?>
