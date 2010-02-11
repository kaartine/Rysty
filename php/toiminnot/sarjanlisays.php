<?php
/*
 * Created on Jan 22, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
require_once("lisattava.php");
require_once("lisattavaview.php");
require_once("lomakeelementit.php");

/**
 * class Login
 *
 */
class SarjanLisays extends Lisattava
{
    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function SarjanLisays() {
        $this->Lisattava('sarjanlisays');

        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);

        $this->tiedot=array(
            'sarjannimi' => array('',TRUE,'TEXT',40),
            'kausi' => array(NULL,TRUE,'SELECTLISAA'),
            'tyyppi' => array(NULL,TRUE,'SELECTLISAA'),
            'kuvaus' => array('',FALSE,'TEXT',40),
            'jarjestaja' => array('',FALSE,'TEXT',80),
            'sarjaid' => array(NULL,FALSE,'HIDDEN')
            );

        //$this->asetaTiedot($this->tiedot);

        $this->viewName = "LisattavaView";
        $this->taulunNimi = "sarja";
    }

    /**
     *
     */
    function taytaErikoisKentat() {
        $this->openConnection();

        // muokataan vanhaa
        if( isset($_REQUEST['sarjaid']) and $_REQUEST['sarjaid'] > 0)
        {
            $this->haeTiedotKannasta();
            $this->tiedot['sarjaid'][0] = new Input('sarjaid', $_REQUEST['sarjaid'], 'hidden');
        }

        $kausi = "kausi";
        $result = &$this->db->doQuery("SELECT vuosi, vuosi as value FROM Kausi ORDER BY vuosi desc");
        $tmp = $this->tiedot[$kausi][0];
        $this->tiedot[$kausi][0] = &$result;
        $this->tiedot[$kausi][0] = $this->luoLomakeElementti($kausi, $this->tiedot[$kausi], $tmp, 'kaudenlisays','lisaakausi');

        /*
        $tyyppi = "tyyppi";
        $result = &$this->db->doQuery("SELECT tyyppi, tyyppi as value FROM SarjaTyyppi ORDER BY tyyppi desc");
        $this->tiedot[$tyyppi][0] = new Select( $result, $tyyppi, $this->tiedot[$tyyppi][0] );
        */

        $tyyppi = "tyyppi";
        $result = &$this->db->doQuery("SELECT tyyppi, tyyppi as value FROM SarjaTyyppi ORDER BY tyyppi desc");
        $tmp = $this->tiedot[$tyyppi][0];
        $this->tiedot[$tyyppi][0] = &$result;
        $this->tiedot[$tyyppi][0] = $this->luoLomakeElementti($tyyppi, $this->tiedot[$tyyppi], $tmp, 'sarjatyypinlisays','lisaasarjatyyppi');

        $this->db->close();

        D( "<pre>");
        //D($this->tiedot);
        D("</pre>");
    }

    function haeTiedotKannasta () {
        $_REQUEST['sarjaid']=intval($_REQUEST['sarjaid']);

        if ( is_int($_REQUEST['sarjaid']) ) {


            // haetaan seurat
            $result = &$this->db->doQuery("SELECT sarjaid, nimi as sarjannimi, kausi, tyyppi, kuvaus, jarjestaja" .
                    " FROM Sarja WHERE sarjaid = '".$_REQUEST['sarjaid']."'");


            if ( count( $result ) == 1 ) {
                $result = $result[0];

                // täytetään kannan taulukon tulokset luokan tiedoiksi
                foreach ( $this->tiedot as $k => $v ) {
                    if ( array_key_exists($k, $result) ) {
                        $this->tiedot[$k][0] = $result[$k];
                    }
                }
                /*
                D( "<pre>");
                D($this->tiedot);
                D("</pre>");
                */
           }
        }
    }

    function annaSQLLauseke () {
        // verrataan että onko null, koska jos käytettäis empty funktiota niin id = 0 menisi metsään
        $sarjanArvot = array( "nimi", "kausi", "tyyppi", "kuvaus", "jarjestaja");
        $_REQUEST['nimi'] = $_REQUEST['sarjannimi'];
        $this->tiedot['nimi'] = $this->tiedot['sarjannimi'];             

        $query = NULL;
        if ( empty($_REQUEST['sarjaid'] ) ) {
            // insert, uusi seura
            $query = $this->rakennaSQLLauseke($sarjanArvot, $this->taulunNimi);
        }
        else {

            $ehdot = "sarjaid = ".$_REQUEST['sarjaid'];
            $query = $this->paivittavaSQLLauseke($sarjanArvot, $this->taulunNimi, $ehdot);
        }
        return $query;
    }
}
?>
