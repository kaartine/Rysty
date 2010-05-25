
<?php

/*
 * Created on Jan 30, 2005
 *
 * Created by Teemu Siitarinen
 * (c) Lämmi
 */

 require_once("lisattava.php");
 require_once("lisattavaview.php");
 require_once("lomakeelementit.php");

 class KayttajanLisays extends Lisattava
{

    function KayttajanLisays(){
        $this->Lisattava('kayttajanlisays'); // call super

        $this->tiedot=array(
          'etunimi'=>array('',TRUE,'TEXT'),
          'sukunimi'=>array('',TRUE,'TEXT'),
          'katuosoite'=>array('',FALSE,'TEXT',100),
          'postinumero'=>array('',FALSE,'TEXT',8),
          'postitoimipaikka'=>array('',FALSE,'TEXT',50),
          'puhelinnumero'=>array('',FALSE,'TEXT',30),
          'email'=>array('',FALSE,'EMAIL',260),
          'kayttajatunnus'=>array('',FALSE,'LABEL',16),
          'tunnus'=>array('',TRUE,'HIDDEN',16),
          'salasana'=>array('',TRUE,'PASSWORD',16),
          'salasana2'=>array('',TRUE,'PASSWORD',16),
          'yllapitooikeudet'=>array('',FALSE,'CHECKBOX'),
          'lisaamuokkaaoikeudet'=>array('',FALSE,'CHECKBOX'),
          'joukkueenalueoikeudet'=>array('',FALSE,'CHECKBOX'),
          'omattiedotoikeudet'=>array('',FALSE,'CHECKBOX'),
          'henkilo'=>array(NULL,FALSE,'HIDDEN'),
          'yhtieto'=>array(NULL,FALSE,'HIDDEN'),
          'hloid'=>array(NULL,FALSE,'HIDDEN')

         );
    // henkilö on jo olemassa niin salasanat eivät ole poakollisia
        if  (isset($_REQUEST['henkilo'] ) ) {
            $this->tiedot['salasana'][1] = FALSE;
            $this->tiedot['salasana2'][1] = FALSE;
        }
        $this->viewName = "LisattavaView";
        $this->taulunNimi = "kayttaja";

    }

    function laitaKantaan () {
        $commit = true;

        // verrataan että onko null, koska jos käytettäis empty funktiota niin id = 0 menisi metsään
        $yhteystietoArvot = array('email', 'katuosoite', 'postinumero', 'postitoimipaikka', 'puhelinnumero');

        $henkiloArvot = array('etunimi', 'sukunimi');
        $kayttajaArvot = array('tunnus', 'salasana', 'henkilo');
        $oikeusryhmaArvot = array('tunnus');

        $yhtietoid = NULL;

        // open connection to db
        $this->openConnection();


        if ( $this->arvotAsetettu($yhteystietoArvot) ) {
            if ( empty($this->tiedot['yhtieto'][0]) ) {
                // insert, uusi yhteystieto
                $this->luoID('yhtietoid','yhteystieto_yhtietoid_seq');
                array_push($yhteystietoArvot,'yhtietoid');
                $query = $this->rakennaSQLLauseke($yhteystietoArvot, "yhteystieto");
                $this->db->doQuery($query);
                $this->tiedot['yhtieto'] = $this->tiedot['yhtietoid'];
                array_push($henkiloArvot, 'yhtieto');
            }
            else {
                // update, yhteystieto on jo olemassa
                $ehdot = "yhtietoid = ".$_REQUEST['yhtieto'];
                $query = $this->paivittavaSQLLauseke($yhteystietoArvot, "yhteystieto", $ehdot);
                $this->db->doQuery($query);
            }
        }

        if ( empty($this->tiedot['hloid'][0]) ) {
            // insert, uusi henkilö
            $this->luoID('hloid', 'henkilo_hloid_seq');
            array_push($henkiloArvot, 'hloid');
            $query = $this->rakennaSQLLauseke($henkiloArvot, "henkilo");
            $this->db->doQuery($query);
            $this->tiedot['henkilo'] = $this->tiedot['hloid'];
            $this->tiedot['hloid'][0] = NULL;
        }
        else {
            // update, vanha henkilötieto
            $this->tiedot['henkilo'] = $this->tiedot['hloid'];
            $ehdot = "hloid = ".$_REQUEST['hloid'];
            $query = $this->paivittavaSQLLauseke($henkiloArvot, "henkilo", $ehdot);
            $this->db->doQuery($query);

            // update, henkilö on jo olemassa
        }

        if ( isset($this->tiedot['tunnus']) and !empty($this->tiedot['tunnus']) ) {
            $result = $this->db->doQuery("SELECT henkilo FROM Kayttajat WHERE tunnus = '$_REQUEST[tunnus]'");

            if ( count($result) == 0 ) {
                // insert, uusi käyttäjä

                // tarkistetaan oliko salasana syötetty ja että molemmat ovat samoja
                if(   !empty($_REQUEST['salasana']) && !empty($_REQUEST['salasana2']) and
                    $_REQUEST['salasana'] === $_REQUEST['salasana2'] )
                {
                    $this->tiedot['salasana'][0] = md5($_REQUEST['salasana']);
                    $query = $this->rakennaSQLLauseke($kayttajaArvot, "kayttajat");
                    $this->db->doQuery($query);
                }
                else {
                    $commit = false;
                }

            }
            else {

                // update, kayttäjä on jo olemassa
                // tarkistetaan oliko salasana syötetty ja että molemmat ovat samoja
                if( !empty($_REQUEST['salasana']) && !empty($_REQUEST['salasana2']) and
                    $_REQUEST['salasana'] === $_REQUEST['salasana2'] ) {
                    //$_REQUEST['salasana'] = md5($_REQUEST['salasana']);

                    $this->tiedot['salasana'][0] = md5($_REQUEST['salasana']);
                    // update, vanha henkilötieto
                    $ehdot = "henkilo = ".$_REQUEST['hloid'];
                    $query = $this->paivittavaSQLLauseke($kayttajaArvot, "kayttajat", $ehdot);

                    $this->db->doQuery($query);
                }
                // jos muokataan niin ei tarvitse laittaa salasanaa
                //else {
//                    $commit = false;
//                }
            }
        }
        else {
            $commit = false;
        }

        if ( $this->arvotAsetettu($oikeusryhmaArvot) ) {
          // Asetetaan tunnukselle kuuluvat oikeudet
          /* Oikeusryhmät:
            'yllapitooikeudet'
            'lisaamuokkaaoikeudet'
            'joukkueenalueoikeudet'
            'omattiedotoikeudet'
          */
          // ensin poistetaan oikeudet ja lisätään ne vain jos on rastit ruudussa
           $this->poistaOikeus('omattiedotoikeudet');
            if ($_REQUEST['omattiedotoikeudet'] === 'omattiedotoikeudet') {
                $query = $this->rakennaSQLLauseke($oikeusryhmaArvot, 'omattiedotoikeudet');
                $this->db->doQuery($query);
            }

            $this->poistaOikeus('joukkueenalueoikeudet');
            if ($_REQUEST['joukkueenalueoikeudet'] === 'joukkueenalueoikeudet') {
                $query = $this->rakennaSQLLauseke($oikeusryhmaArvot, 'joukkueenalueoikeudet');
                $this->db->doQuery($query);
            }

            $this->poistaOikeus('lisaamuokkaaoikeudet');
            if ($_REQUEST['lisaamuokkaaoikeudet'] === 'lisaamuokkaaoikeudet') {
                  $query = $this->rakennaSQLLauseke($oikeusryhmaArvot, 'lisaamuokkaaoikeudet');
                  $this->db->doQuery($query);
            }

            $this->poistaOikeus('yllapitooikeudet');
            if ($_REQUEST['yllapitooikeudet'] === 'yllapitooikeudet') {
                $query = $this->rakennaSQLLauseke($oikeusryhmaArvot, 'yllapitooikeudet');
                $this->db->doQuery($query);
            }

        }

        // do final commit and close
        if( $commit )
        {
            D('COMMIT');
            $this->db->commit();
        }
        else {
            D('ROLLBACK');
            $this->db->rollback();
        }

        $this->db->closeConnection();

    }

    function taytaErikoisKentat(){
        // jos tultiin luomaan uutta käyttäjää tai muokkaamaan vanhaa
        if( isset($_REQUEST['henkilo']) or isset($_REQUEST['hloid'])) {
            $this->haeTiedotKannasta();
        } 
        if ( empty($this->tiedot['tunnus'][0] ) ){
            $this->tiedot['tunnus'][2] = 'TEXT';
            $this->tiedot['kayttajatunnus'][2] = 'HIDDEN';
        }

        $oikeusryhmat = array('omattiedotoikeudet', 'joukkueenalueoikeudet',
                  'lisaamuokkaaoikeudet', 'yllapitooikeudet',);

        $this->tiedot['omattiedotoikeudet'][0] =
            new Checkbox($oikeusryhmat[0], $oikeusryhmat[0],'', !empty( $this->tiedot['omattiedotoikeudet'][0]));

        $this->tiedot['joukkueenalueoikeudet'][0] =
             new Checkbox($oikeusryhmat[1], $oikeusryhmat[1], '', !empty($this->tiedot['joukkueenalueoikeudet'][0]));

        $this->tiedot['lisaamuokkaaoikeudet'][0] =
            new Checkbox($oikeusryhmat[2], $oikeusryhmat[2],'' , !empty($this->tiedot['lisaamuokkaaoikeudet'][0]));

        $this->tiedot['yllapitooikeudet'][0] =
            new Checkbox($oikeusryhmat[3], $oikeusryhmat[3], '', !empty($this->tiedot['yllapitooikeudet'][0]));

        $this->tiedot['kayttajatunnus'][0]  = $this->tiedot['tunnus'][0];
    }


    function haeTiedotKannasta () {
        $hloid = '-1';
        if( isset($_REQUEST['henkilo']) )
        {
            $hloid = $_REQUEST['henkilo'];
        }
        else if( isset($_REQUEST['hloid'])) {
            $hloid = $_REQUEST['hloid'];
        }

        // ensin henkilon tiedot
        $query1 = " SELECT *, to_char(syntymaaika,'DD.MM.YYYY') as syntymaaika FROM henkilo WHERE hloid = $hloid";
        $this->openConnection();
        $result1 = $this->db->doQuery($query1);
        $yhttieto = $result1[0]['yhtieto'];

        // sitten käyttäjän tiedot

        $query2 = "SELECT * FROM kayttajat WHERE henkilo = $hloid";
        $result2 = $this->db->doQuery($query2);
        $ktunnus = NULL;
        if ( count($result2) > 0 ) {
            $ktunnus = $result2[0]['tunnus'];
        } 

        $result3=NULL;
        // sitten yhteystiedot jos on merkitty
        if ( ! empty($yhttieto)) {
            $query3 = " SELECT * FROM yhteystieto WHERE yhtietoid = $yhttieto";
            $result3 = $this->db->doQuery($query3);
        }

        $result4=NULL;
        $oikryhma="";

         // sitten haetaan kaikki oikeusryhmät, jotka ovat kayttajalle merkitty
        if ( ! empty($ktunnus)) {

            $query4 = " SELECT * FROM omattiedotoikeudet WHERE tunnus = '".$ktunnus."'";
            $result4 = $this->db->doQuery($query4);
            if (count($result4) == 1) {
                $this->tiedot['omattiedotoikeudet'][0] = 'omattiedotoikeudet';
            }

            $query4 = " SELECT * FROM joukkueenalueoikeudet WHERE tunnus = '".$ktunnus."'";
            $result4 = $this->db->doQuery($query4);
            if (count($result4) == 1) {
                $this->tiedot['joukkueenalueoikeudet'][0] = 'joukkueenalueoikeudet';
            }

            $query4 = " SELECT * FROM lisaamuokkaaoikeudet WHERE tunnus = '".$ktunnus."'";
            $result4 = $this->db->doQuery($query4);
            if (count($result4) == 1) {
                $this->tiedot['lisaamuokkaaoikeudet'][0] = 'lisaamuokkaaoikeudet';
            }

            $query4 = " SELECT * FROM yllapitooikeudet WHERE tunnus = '".$ktunnus."'";
            $result4 = $this->db->doQuery($query4);
            if (count($result4) == 1) {
                $this->tiedot['yllapitooikeudet'][0] = 'yllapitooikeudet';
            }
        }

        //$this->db->commit();
        $this->db->close();

         // summataan taulukot yhdeksi isoksi
        $result = &$result1[0];
        if ( count($result2) == 1) {
            $result = $result + $result2[0];
        }
        if ( count($result3) == 1) {
            $result = $result + $result3[0];
        }


        // täytetään kannan taulukon tulokset luokan tiedoiksi
        foreach ( $this->tiedot as $k => $v ) {
            if ( array_key_exists($k, $result) ) {
                $this->tiedot[$k][0] = $result[$k];
            }
        }
    // salasanat tyhjäksi
        $this->tiedot['salasana'][0] = '';
        $this->tiedot['salasana2'][0] = '';
    }


    function poistaOikeus ($taulu) {
        $query = "DELETE from $taulu where tunnus = '".$this->tiedot['tunnus'][0]."'";
        $this->db->doQuery($query);

    }
    function lueJaTarkistaRequest() {
        $value = parent::lueJaTarkistaRequest();
        if( $_REQUEST['salasana'] !== $_REQUEST['salasana2'] ) {
                  $value = FALSE;
                  $this->addError("Salasanat eivät täsmää!");
            }
            return $value;
    }
}

?>

