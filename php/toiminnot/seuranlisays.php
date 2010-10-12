<?php
/*
 * Created on Jan 19, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */

 require_once("lisattava.php");
 require_once("lisattavaview.php");
 require_once("lomakeelementit.php");

 class SeuranLisays extends Lisattava
{


    var $drawForm;
    var $notset;
    var $result;

    function SeuranLisays(){
        $this->Lisattava('seuranlisays');
        
        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);
        $this->tiedot=array(
            'nimi'=>array('',TRUE,'TEXT',40),
            'perustamispvm'=>array('',TRUE,'PVM',10),
            'lisatieto'=>array('',FALSE,'TEXTAREA'),
            'seuraid'=>array(NULL,FALSE,'HIDDEN'),

            );

        $this->viewName = "LisattavaView";
        $this->taulunNimi = "seura";
        $this->toiminnonNimi = 'seuranlisays';
    }


    function taytaErikoisKentat() {
        $this->openConnection();

        // muokataan vanhaa
        if( isset($_REQUEST['seuraid']) and $_REQUEST['seuraid'] > 0)
        {
            $this->haeTiedotKannasta();
            $this->tiedot['seuraid'][0] = new Input('seuraid', $_REQUEST['seuraid'], 'hidden');
        }
    }

    function haeTiedotKannasta () {

        // haetaan seurat
        $result = &$this->db->doQuery("SELECT seuraid, nimi, perustamispvm, lisatieto" .
                " FROM Seura WHERE seuraID = $_REQUEST[seuraid]");

        $result = $result[0];

        // täytetään kannan taulukon tulokset luokan tiedoiksi
        foreach ( $this->tiedot as $k => $v ) {
            if ( array_key_exists($k, $result) ) {
                $this->tiedot[$k][0] = $result[$k];
            }
        }

        D( "<pre>");
        D($this->tiedot);
        D("</pre>");
    }

    function annaSQLLauseke () {
        // verrataan että onko null, koska jos käytettäis empty funktiota niin id = 0 menisi metsään
        $seuranArvot = array( "nimi", "perustamispvm", "lisatieto");

        $query = NULL;
        if ( empty($_REQUEST['seuraid']) ) {
            // insert, uusi seura
            $query = $this->rakennaSQLLauseke($seuranArvot, "seura");
            print $query;
        }
        else {

            $ehdot = " seuraid = ".$_REQUEST['seuraid'];
            $query = $this->paivittavaSQLLauseke($seuranArvot, $this->taulunNimi, $ehdot);
        }
        return $query;
    }
}
?>
