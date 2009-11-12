<?php
/*
 * Created on Jan 26, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
 require_once("lisattava.php");
 require_once("henkilonlisaysview.php");
 require_once("lomakeelementit.php");

 class HenkilonLisays extends Lisattava
{
    var $kuva; 
    function HenkilonLisays($toiminto = NULL ) {
        if( $toiminto == '' ) {
            $this->Lisattava('henkilonlisays'); // call super
        }
        else {
            $this->Lisattava($toiminto); // call super
        }

        $this->tiedot=array(
          'etunimi'=>array('',TRUE,'TEXT'),
          'sukunimi'=>array('',TRUE,'TEXT'),
          'syntymaaika'=>array('',FALSE,'PVM'),
          'lempinimi'=>array('',FALSE,'TEXT'),
          'paino'=>array('',FALSE,'NUMBER',5),
          'pituus'=>array('',FALSE,'NUMBER',3),
          'kuva'=>array('',FALSE,'FILEUPLOAD',50), // jatkokehitys upload
          'kuvaus'=>array('',FALSE,'TEXTAREA'), 
          'katisyys'=>array('',FALSE,'RADIO'),
          'maila'=>array('',FALSE,'TEXT'),
          'puhelinnumero'=>array('',FALSE,'TEXT',30),
          'faxi'=>array('',FALSE,'TEXT',30),
          'email'=>array('',FALSE,'EMAIL',260),
          'katuosoite'=>array('',FALSE,'TEXT',100),
          'postinumero'=>array('',FALSE,'TEXT',8),
          'postitoimipaikka'=>array('',FALSE,'TEXT',50),
          'maa'=>array('',FALSE,'TEXT',50),
          'selite'=>array('',FALSE,'TEXT',200),
          'pelaajaid'=>array(NULL,FALSE,'HIDDEN'),
          'yhtieto'=>array(NULL,FALSE,'HIDDEN')
         );
        $this->kuva ='';
        $this->viewName = "HenkilonLisaysView";
        $this->taulunNimi = "henkilo";
    }
    function laitaKantaan () {
        // verrataan että onko null, koska jos käytettäis empty funktiota niin id = 0 menisi metsään
        $henkiloArvot = array('etunimi', 'sukunimi', 'syntymaaika', 'paino', 'pituus', 'kuvaus', 'lempinimi');

        // kerrotaan paino tuhannella
        if ( array_key_exists('paino', $_REQUEST) and is_numeric($_REQUEST['paino']) ){
           $_REQUEST['paino'] = $_REQUEST['paino'] *1000;
        }
        // kuvan käsittely tähän


        $pelaajaArvot = array('katisyys', 'maila');

        $yhteystietoArvot = array('puhelinnumero', 'faxi',
             'email', 'katuosoite', 'postinumero', 'postitoimipaikka', 'maa', 'selite');

        $yhtietoid = NULL;

        // open connection to db
        $this->openConnection();

        if ( $this->arvotAsetettu($yhteystietoArvot) ) {
            if ( empty($_REQUEST['yhtieto']) ) {
                // insert, uusi yhteystieto
                // ensin haetaan yhteystiedolle id
                $this->luoID('yhtietoid','yhteystieto_yhtietoid_seq');
                array_push($yhteystietoArvot,'yhtietoid');
                $query = $this->rakennaSQLLauseke($yhteystietoArvot, "yhteystieto");
                $this->db->doQuery($query);

                array_push($henkiloArvot, 'yhtieto');
                $this->tiedot['yhtieto'] = $this->tiedot['yhtietoid']; 

            }
            else {
                // update, yhteystieto on jo olemassa
                $ehdot = "yhtietoid = ".$_REQUEST['yhtieto'];
                $query = $this->paivittavaSQLLauseke($yhteystietoArvot, 'yhteystieto', $ehdot);
                $this->db->doQuery($query);

            }
        }
                       
                
        if ( empty($_REQUEST['hloid']) ) {
            // insert, uusi henkilö
            $this->luoID('hloid', 'henkilo_hloid_seq');
            array_push($henkiloArvot, 'hloid');
            
            $this->tiedot['kuva'][0] = 
                $this->uploadImage('kuva','henkilo',
                        $_REQUEST['sukunimi'].'_'.$_REQUEST['etunimi'].'_'.$this->tiedot['hloid'][0] );
            if ( $this->tiedot['kuva'][0] != NULL ) {
                array_push($henkiloArvot,'kuva');
            }
            $query = $this->rakennaSQLLauseke($henkiloArvot, 'henkilo');
            $this->db->doQuery($query);
        }
        else {
            // update, henkilö on jo olemassa
            $ehdot = 'hloid = '.$_REQUEST['hloid'];
            
            $this->tiedot['kuva'][0] = 
                $this->uploadImage('kuva', 'henkilo', 
                        $_REQUEST['sukunimi'].'_'.$_REQUEST['etunimi'].'_'.$_REQUEST['hloid'] );
                        
            if ( $this->tiedot['kuva'][0] != NULL ) {
                array_push($henkiloArvot,'kuva');
            }

            $query = $this->paivittavaSQLLauseke($henkiloArvot, 'henkilo', $ehdot);
            $this->db->doQuery($query);
            $this->tiedot['hloid'] = array($_REQUEST['hloid'],FALSE,'HIDDEN');
        }

        if ( empty($_REQUEST['pelaajaid']) ) {
            // insert, uusi pelaaja
            array_push($pelaajaArvot,'pelaajaid');
            $this->tiedot['pelaajaid'] = $this->tiedot['hloid'];
            $query = $this->rakennaSQLLauseke($pelaajaArvot, "pelaaja");
            $this->db->doQuery($query);
        }
        else {
            // update, pelaaja on jo olemassa
            $ehdot = "pelaajaid = ".$_REQUEST['hloid'];
            $query = $this->paivittavaSQLLauseke($pelaajaArvot, 'pelaaja', $ehdot);
            $this->db->doQuery($query);

        }
        // do final commit and close
        $this->db->close();

    }

    
    function lueJaTarkistaRequest(){
        $var = parent::lueJaTarkistaRequest();

        if ( !empty($this->tiedot['paino'][0]) ) $this->tiedot['paino'][0] = $this->tiedot['paino'][0]*1000;
        
        return $var;
        
    }

    function taytaErikoisKentat(){
        if(isset($_REQUEST['hloid'])) {
            $this->haeTiedotKannasta();
        }
        $this->kuva = $this->tiedot['kuva'][0];
        $katisyydet = array('L'=>'L','R'=>'R', 'E'=>$this->tm->getText('eitiedossa') );
        $kat = "katisyys";
        $oletusarvo = $this->tiedot['katisyys'][0];
        if( empty($oletusarvo) )
        {
            $oletusarvo = 'E';
        }
        $this->tiedot['katisyys'][0] = new Radiobutton($katisyydet,$kat,$oletusarvo);


        if ( ! empty($_REQUEST['hloid']) ) {
            $this->tiedot['hloid'] = array(NULL,FALSE,"HIDDEN");
            $this->tiedot['hloid'][0] = new Input('hloid', $_REQUEST['hloid'], 'hidden');


            $this->tiedot['pelaajaid'][0] = new Input('pelaajaid', $this->tiedot['pelaajaid'][0], 'hidden');
            $this->tiedot['yhtieto'][0] = new Input('yhtieto', $this->tiedot['yhtieto'][0], 'hidden');


        }
        // tietokannassa paino on grammoina
        if ( !empty($this->tiedot['paino'][0]) ) $this->tiedot['paino'][0] = $this->tiedot['paino'][0]/1000;

    }


    function haeTiedotKannasta () {
        // ensin henkilon tiedot
        $query1 = " SELECT *, to_char(syntymaaika,'DD.MM.YYYY') as syntymaaika FROM henkilo WHERE hloid = ".$_REQUEST['hloid'];
        $this->openConnection();
        $result1 = $this->db->doQuery($query1);


        // sitten pelaajan tiedot

        $query2 = " SELECT * FROM pelaaja WHERE pelaajaid = ".$result1[0]['hloid'];
        $result2 = $this->db->doQuery($query2);
        $result3=NULL;

        $yhttieto = $result1[0]['yhtieto'];
        
        // sitten yhteystiedot jos on merkitty
        if ( ! empty($yhttieto)) {
            $query3 = " SELECT * FROM yhteystieto WHERE  yhtietoid = $yhttieto";
            $result3 = $this->db->doQuery($query3);
        }

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

    }
}
?>
