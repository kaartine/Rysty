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
class HallinLisays extends Lisattava
{


    /**
     * Määritellään rakentajassa lisättävät tiedot
     */
    function HallinLisays(){        
        $this->Lisattava('hallinlisays');

        $this->tiedot=array(
        
        'nimi' => array('',TRUE,'TEXT',40),
        'yhtietoid' => array('',FALSE,'HIDDEN'),
        'kenttienlkm' => array('',TRUE,'NUMBER',4),
        'lisatieto' => array('',FALSE,'TEXTAREA'),
        'alusta' => array('',FALSE,'TEXT',200),

          'puhelinnumero'=>array('',FALSE,'TEXT',30),
          'faxi'=>array('',FALSE,'TEXT',30),
          'email'=>array('',FALSE,'EMAIL',260),
          'katuosoite'=>array('',FALSE,'TEXT',100),
          'postinumero'=>array('',FALSE,'TEXT',8),
          'postitoimipaikka'=>array('',FALSE,'TEXT',50),
          'maa'=>array('',FALSE,'TEXT',50),
          'selite'=>array('',FALSE,'TEXT',200),
        
        'halliid' => array('',FALSE,'HIDDEN')
        );

        $this->viewName = 'LisattavaView';
        $this->taulunNimi = 'halli';
    }

    function laitaKantaan () {
        $halliArvot = array('nimi', 'kenttienlkm', 'alusta', 'lisatieto');
        
        $yhteystietoArvot = array('puhelinnumero', 'faxi',
             'email', 'katuosoite', 'postinumero', 'postitoimipaikka', 'maa', 'selite');
        // open connection to db
        $this->openConnection();

        if ( $this->arvotAsetettu($yhteystietoArvot) ) {
            if ( empty($_REQUEST['yhtietoid']) ) {
                // insert, uusi yhteystieto
                // ensin haetaan yhteystiedolle id
                $this->luoID('yhtietoid','yhteystieto_yhtietoid_seq');
                array_push($yhteystietoArvot,'yhtietoid');
                $query = $this->rakennaSQLLauseke($yhteystietoArvot, "yhteystieto");
                $this->db->doQuery($query);
                array_push($halliArvot,'yhtietoid');

            }
            else {
                // update, yhteystieto on jo olemassa
                $ehdot = "yhtietoid = ".$_REQUEST['yhtietoid'];
                $query = $this->paivittavaSQLLauseke($yhteystietoArvot, 'yhteystieto', $ehdot);
                $this->db->doQuery($query);

            }
        }

        if ( empty($_REQUEST['halliid']) ) {
            // insert, uusi henkilö
            $this->luoID('hloid', 'halli_halliid_seq');
            array_push($halliArvot, 'halliid');
            $query = $this->rakennaSQLLauseke($halliArvot, "halli");
            $this->db->doQuery($query);
           
        }
        else {
            // update, halli on jo olemassa
            $ehdot = 'halliid = '.$_REQUEST['halliid'];
            $query = $this->paivittavaSQLLauseke($halliArvot, 'halli', $ehdot);
            $this->db->doQuery($query);
            $this->tiedot['halliid'] = array($_REQUEST['halliid'],FALSE,'HIDDEN');
        }

        // do final commit and close
        $this->db->close();

    }    

    function taytaErikoisKentat(){
        if( isset($_REQUEST['halliid']) and is_numeric($_REQUEST['halliid']) ) {
            $this->haeTiedotKannasta();
        }
    }    

    function haeTiedotKannasta () {
        // ensin henkilon tiedot
        $query1 = " SELECT *  FROM halli WHERE halliid = ".$_REQUEST['halliid'];
        $this->openConnection();
        $result1 = $this->db->doQuery($query1);

        $yhttieto = $result1[0]['yhtietoid'];
        $result3 = NULL;
        // sitten yhteystiedot jos on merkitty
        if ( ! empty($yhttieto)) {
            $query3 = " SELECT * FROM yhteystieto WHERE  yhtietoid = $yhttieto";
            $result3 = $this->db->doQuery($query3);
        }

        $this->db->close();

         // summataan taulukot yhdeksi isoksi
        $result = &$result1[0];
        if ( count($result3) == 1) {
            $result = $result + $result3[0];
        }


        // täytetään kannan taulukon tulokset luokan tiedoiksi
        foreach ( $this->tiedot as $k => $v ) {
            if ( array_key_exists($k, $result) ) {
                $this->tiedot[$k][0] = $result[$k];
            }
        }

    }    
}
?>
