<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 19.03.2005
 *
*/
require_once("lisattava.php");
require_once("lisattavaview.php");

/**
 * class KaudenjoukkueenLisays
 *
 */
class KaudenjoukkueenLisays extends Lisattava
{
   
    var $muokkaus;
    
    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function KaudenjoukkueenLisays($arg = 'kaudenjoukkueenlisays'){        
        $this->Lisattava($arg);        
        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);

        $this->tiedot=array(            
            'kausi' => array(NULL,TRUE,'SELECTLISAA'),
            'kotipaikka' => array('',TRUE,'TEXT',40),
            'kuva' => array('',FALSE,'FILEUPLOAD',50),
            'logo' => array('',FALSE,'FILEUPLOAD',50),
            'kotihalli' => array(NULL,FALSE,'SELECT'),
            'kuvaus' => array('',FALSE,'TEXTAREA'),
            'joukkueid' => array(NULL,FALSE,'HIDDEN'),
            
        );

        $this->viewName = "LisattavaView";
        $this->taulunNimi = "kaudenjoukkue";

        $result = array();
        if( isset($_REQUEST['kausi']) ) {
            $_REQUEST['kausi'] = intval($_REQUEST['kausi']);
            
            $this->openConnection();
            $result = &$this->db->doQuery("SELECT kausi FROM Kaudenjoukkue WHERE kausi = $_REQUEST[kausi] " .
                " and joukkueid = $_SESSION[joukkue]");
            $this->db->close();
            
            D($result);
        }
        else {
            $_REQUEST['kausi'] = 0;
        }
        
        $_SESSION['muokkaus'] = false;
        
        /*
        if ( is_int($_REQUEST['kausi']) and  $_REQUEST['kausi'] > 0 and count($result) > 0) {
            $_SESSION['muokkaus'] = true;
            //$this->muokkaus = true;
        } 
        else {
            //$this->muokkaus = false;
            $_SESSION['muokkaus'] = false;
        }*/
    }

    /**
     *
     */
    function taytaErikoisKentat() {
        // asetataan lomake tukemaan tiedoston latausta
        $this->view->formStart = '<form enctype="multipart/form-data" action="index.php" method="POST">' .
                '<input type="hidden" name="MAX_FILE_SIZE" value="900000" />';  
        $this->openConnection();
        
        // muokataan vanhaa
        if( $_SESSION['muokkaus']/*$this->muokkaus*/ == true )
        {   
            /*
            $kausi = "kausi";
            $result = &$this->db->doQuery("SELECT vuosi, vuosi as value FROM Kausi");
            $this->tiedot[$kausi][0] = new Select( $result, $kausi, $_REQUEST['kausi'] );
            */
            /*
            $kausi = "kausi";
            $result = &$this->db->doQuery("SELECT vuosi, vuosi as value FROM Kausi ORDER BY value desc");
            //$tmp = $this->tiedot[$kausi][0];
            $this->tiedot[$kausi][0] = &$result;
            $this->tiedot[$kausi][0] = $this->luoLomakeElementti($kausi, $this->tiedot[$kausi], $_REQUEST['kausi'], 'kaudenlisays');*/
        }
        else {
            /*
            $kausi = "kausi";
            $result = &$this->db->doQuery("SELECT vuosi, vuosi as value FROM Kausi");
            $this->tiedot[$kausi][0] = new Select( $result, $kausi );
            */
            
            $kausi = "kausi";
            $result = &$this->db->doQuery("SELECT vuosi, vuosi as value FROM Kausi ORDER BY value desc");
            $tmp = $this->tiedot[$kausi][0];
            $this->tiedot[$kausi][0] = &$result;
            $this->tiedot[$kausi][0] = $this->luoLomakeElementti($kausi, $this->tiedot[$kausi], $tmp, 'kaudenlisays');
        }
        
        $this->haeTiedotKannasta();
        $this->tiedot['joukkueid'][0] = new Input('joukkueid', $_SESSION['joukkue'], 'hidden');

        /*$tyyppi = "kotihalli";
        $result = &$this->db->doQuery("(SELECT -1 as value, ('Ei tiedossa') as nimi) UNION (SELECT halliid as value, nimi FROM Halli ORDER BY nimi asc)");
        $this->tiedot[$tyyppi][0] = new Select( $result, $tyyppi, $this->tiedot[$tyyppi][0] );
        */
        
        $tyyppi = "kotihalli";
        $eitiedossa = $this->tm->getText('Ei tiedossa');
        $result = &$this->db->doQuery("(SELECT -1 as value, ('$eitiedossa') as nimi) UNION (SELECT halliid as value, nimi FROM Halli ORDER BY nimi asc)");
        $this->tiedot[$tyyppi][0] = new Select( $result, $tyyppi, $this->tiedot[$tyyppi][0] );

        $this->db->close();

        /*
        D( "<pre>");
        D($this->tiedot);
        D("</pre>");
        */
    }

    function haeTiedotKannasta () {

        // haetaan joukkueen tiedot
        $result = &$this->db->doQuery("SELECT kotipaikka, kotihalli, kuvaus, kuva, logo" .
                " FROM Kaudenjoukkue WHERE joukkueid = $_SESSION[joukkue] and kausi = $_REQUEST[kausi]");


        if ( count( $result ) == 1 ) {
            $result = $result[0];

            // täytetään kannan taulukon tulokset luokan tiedoiksi
            foreach ( $this->tiedot as $k => $v ) {
                if ( array_key_exists($k, $result) ) {
                    $this->tiedot[$k][0] = $result[$k];
                }
            }
       }
    }

    function annaSQLLauseke () {
        // verrataan että onko null, koska jos käytettäis empty funktiota niin id = 0 menisi metsään
        $kaudenJoukkueenArvot = array( 'joukkueid', 'kotipaikka', 'kausi', 'kotihalli', 'kuvaus');
                
        if ( !$_SESSION['muokkaus']/*!$this->muokkaus*/ ) {
            
//            D($this->tiedot);
            
            // tarkastetaan että kautta ei ole jo luotu
            $this->openConnection();
            $kausi = $this->tiedot['kausi'][0];
            $joukkue = $this->tiedot['joukkueid'][0];
            $result = &$this->db->doQuery("SELECT kausi FROM Kaudenjoukkue WHERE kausi = $kausi " .
                " and joukkueid = $joukkue");
            $this->db->close();
            
//            D($result);
            
            if( isset($result[0]) and count($result) > 0 ) { // kaudenjoukkue on jo olemassa
                $this->addError('kausi on jo olemassa!');
                D('l&ouml;ytyi vanha');
                return '';
            }            
            $this->lataaKuvat($kaudenJoukkueenArvot);
                       
            // insert, uusi seura
            $query = $this->rakennaSQLLauseke($kaudenJoukkueenArvot, $this->taulunNimi);
                
        }
        else {
            $this->lataaKuvat($kaudenJoukkueenArvot);
            $ehdot = "joukkueid = $_SESSION[joukkue] and kausi = $_REQUEST[kausi]";
            $query = $this->paivittavaSQLLauseke($kaudenJoukkueenArvot, $this->taulunNimi, $ehdot);
        }

        
        return $query;
    }
    
    function lataaKuvat (&$kaudenJoukkueenArvot) {
            $this->openConnection();
            $result = &$this->db->doQuery("SELECT lyhytnimi FROM joukkue WHERE joukkueid = $_SESSION[joukkue]");
            $this->db->close();        
            if( count($result) > 0 ) { // joukkue on  olemassa
                $dir = 'joukkue/' . muunnaNimi($result[0]['lyhytnimi']);
                $this->tiedot['kuva'][0] = 
                    $this->uploadImage('kuva', $dir, 'ryhmakuva_'.$_REQUEST['kausi'] );
                $this->tiedot['logo'][0] = 
                    $this->uploadImage('logo',$dir, 'logo_'.$_REQUEST['kausi'] );
                    
	            if ( $this->tiedot['kuva'][0] != NULL ) {
	                array_push($kaudenJoukkueenArvot,'kuva');
	                D('Joukkue kuva löyty');
	            }
	            if ( $this->tiedot['logo'][0] != NULL ) {
	                array_push($kaudenJoukkueenArvot,'logo');
	                D('Logo löyty');
	            }                     
            }              	
    }
}
?>


