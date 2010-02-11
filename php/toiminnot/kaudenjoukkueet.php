<?php
/**
 * pelaajatilastot.php
 * Copyright Lämmi/Rysty 2005:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 26.03.2005
 *
*/
require_once("lista.php");
require_once("kaudenjoukkueetview.php");
require_once("joukkueentiedot.php");


class KaudenJoukkueet extends Lista
{
    var $joukkueid;
    function KaudenJoukkueet(){
        $this->Lista('kaudenjoukkueet');

        $this->columns = array('kausi', 'kotipaikka','kotihalli','kuvaus','kortti');
        $this->defaultorder = 'kausi';
        $this->viewname = "KaudenJoukkueetView";

        $this->links = array(
            'kausi'=>array(array('joukkueid','kausi'),'kaudenjoukkue'),
            'kotipaikka'=>array(array('joukkueid','kausi'),'kaudenjoukkue'),
            'kotihalli'=>array(array('joukkueid','kausi'),'kaudenjoukkue'),
            'kortti'=>array(array('joukkueid','kausi'),'joukkuekortti','LINK')
        );

        if ( isset($_REQUEST['joukkueid']) ) {
            $this->joukkueid = $_REQUEST['joukkueid'];
            $_SESSION['joukkue'] = $_REQUEST['joukkueid'];
        }
        else {
            $this->joukkueid = $_SESSION['joukkue'];
        }

        $this->joukkuetiedot = new JoukkueTiedot();
        $this->joukkuetiedot->haeTiedot($this->joukkueid);
    }

    function getQuery(){
        return
            "SELECT joukkueid, kausi, kotipaikka, kuvaus,
             (SELECT nimi FROM halli WHERE halliid = kotihalli ) as kotihalli
             FROM kaudenjoukkue WHERE joukkueid = $this->joukkueid";
    }

}
?>
