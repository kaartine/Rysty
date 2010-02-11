<?php
/*
 * Created on Jan 19, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */


//require_once("joukkueenlisaysview.php");
require_once("lisattava.php");
require_once("lisattavaview.php");
require_once("lomakeelementit.php");

/**
 * class Login
 *
 */
class JoukkueenLisays extends Lisattava
{


    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function JoukkueenLisays(){        
        $this->Lisattava('joukkueenlisays');
        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);
        $this->tiedot=array(
            'seuraid'=>array(NULL,TRUE,'SELECTLISAA'),
            'lyhytnimi'=>array('',TRUE,'TEXT',10),
            'pitkanimi'=>array('',TRUE,'TEXT',40),
            'logo' => array('',FALSE,'FILEUPLOAD'),
            'maskotti'=>array('',FALSE,'TEXT',40),
            'email'=>array('',FALSE,'TEXT',260),
            'kuvaus'=>array('',FALSE,'TEXTAREA'),
            'joukkueid' => array('',FALSE,'HIDDEN')
        );

        $this->viewName = 'LisattavaView';
        $this->taulunNimi = 'joukkue';

    }

    /**
     *
     */
    function taytaErikoisKentat() {
    
        $this->view->formStart = '<form enctype="multipart/form-data" action="index.php" method="POST">' .
                '<input type="hidden" name="MAX_FILE_SIZE" value="900000" />';  
                        
        // muokataan vanhaa
        if( isset($_REQUEST['joukkueid']) and $_REQUEST['joukkueid'] > 0)
        {
            $this->haeTiedotKannasta();         
            $this->tiedot['joukkueid'][0] = new Input('joukkueid', $_REQUEST['joukkueid'], 'hidden');
        }

        // avataan yhteys tietokantaan
        $this->openConnection();
        
	/*
	// haetaan seurat
        $this->result = &$this->db->doQuery("SELECT seuraid, nimi FROM seura ORDER BY nimi asc");
        // luodaan seuralle select olio
        $id = 'seuraid';
        $this->tiedot[$id][0] = new Select( $this->result, $id, $this->tiedot[$id][0] );
	*/
	
	// haetaan seurat
        $result = &$this->db->doQuery("SELECT seuraid, nimi FROM seura ORDER BY nimi asc");
        // luodaan seuralle select olio
        $id = 'seuraid';
//        $this->tiedot[$id][0] = new Select( $this->result, $id, $this->tiedot[$id][0] );
        $tmp = $this->tiedot[$id][0];
	$this->tiedot[$id][0] = &$result;
	$this->tiedot[$id][0] = $this->luoLomakeElementti($id, $this->tiedot[$id], $tmp, 'seuranlisays','uusiseura');
	
	
	
        // suljetaan yhteys        
        $this->db->close();
    }

     function haeTiedotKannasta () {
        $this->openConnection();
        // haetaan seurat
        $result = &$this->db->doQuery("SELECT joukkueid, seuraid, lyhytnimi, pitkanimi, maskotti, kuvaus, email" .
                " FROM Joukkue WHERE joukkueid = $_REQUEST[joukkueid]");

        // suljetaan yhteys       
        $this->db->close();

        $result = $result[0];

        // täytetään kannan taulukon tulokset luokan tiedoiksi
        foreach ( $this->tiedot as $k => $v ) {
            if ( array_key_exists($k, $result) ) {
                $this->tiedot[$k][0] = $result[$k];
            }
        }        
    }

    function annaSQLLauseke() {
        D("<pre>");
        D($_REQUEST);
        D("</pre>");
        
        $joukkueArvot = array( 'seuraid', 'lyhytnimi', 'pitkanimi', 'maskotti', 'kuvaus', 'email');

        $query = NULL;
        // verrataan että onko null, koska jos käytettäis
        // empty funktiota niin id = 0 menisi metsään
        if ( empty($_REQUEST['joukkueid']) ) {
            $this->openConnection();
            $this->luoID('joukkueid', 'joukkue_joukkueid_seq');
            $this->db->close();
             array_push($joukkueArvot, 'joukkueid');
            if ( $this->lataaKuvat() ) {
                 array_push($joukkueArvot, 'logo');
            }
            // insert, uusi joukkue
            $query = $this->rakennaSQLLauseke($joukkueArvot, "joukkue");
        }
        else {
            if ( $this->lataaKuvat() ) {
                 array_push($joukkueArvot, 'logo');
            }
            // update, päivittää vanhaa taulua
            $ehdot = "joukkueid = ".$_REQUEST['joukkueid'];
            $query = $this->paivittavaSQLLauseke($joukkueArvot, "joukkue", $ehdot);
        }
        return $query;
    }
    function lataaKuvat () {
            $dir = 'joukkue/' . muunnaNimi($this->tiedot['lyhytnimi'][0]); 
            $this->tiedot['logo'][0] = 
                $this->uploadImage('logo',$dir, 'defaultlogo' );
            if ( $this->tiedot['logo'][0] != NULL ) {
                return TRUE;
            }
            return FALSE;
        }
    //function getData() {
    //}
}
?>
