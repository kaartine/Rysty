<?php
/*
 * Created on Jan 30, 2005
 *
 * Created by Teemu Siitarinen
 * (c) Lämmi
 * tää on varmaan ihan turha
 */
 require_once("poistettava.php");
 require_once("poistettavaview.php");
 require_once("lomakeelementit.php");

 class KayttajanPoisto extends Poistettava
{

    var $drawForm;
    var $notset;
    var $result;

    function KayttajanPoisto(){

        $this->Poistettava(); // call super
        $this->drawForm = true;
        unset($this->notset);
        unset($this->result);

        $this->tiedot=array('etunimi'=>"", 'sukunimi'=>"",
          'katuosoite'=>"",
          'postinumero'=>"",
          'postitoimipaikka'=>"",
          'email'=>"",
          'tunnus'=>"",
          'salasana'=>"",
          'salasana2'=>"",
          'oikeusryhma'=>"",
          'henkilo'=>NULL,
          'yhtieto'=>NULL
         );
        $this->pakollisetTiedot=array('tunnus');
        $this->viewName = "PoistettavaView";
        $this->taulunNimi = "kayttaja";
        $this->toiminnonNimi = 'kayttajanpoisto';
    }
    function poistaKannasta () {

        $kayttajaArvot = 'tunnus';

        $oikeusryhmaArvot = 'tunnus';

        // open connection to db
        $this->openConnection();

		if ( $this->arvotAsetettu($kayttajaArvot) ) {
			if ( empty($_REQUEST['tunnus']) ) { 
			
           	 // delete, käyttaja
	            $query = $this->poistavaSQLLauseke($kayttajaArvot, "kayttajat");
	            $this->db->doQuery($query);
	            D($query);
			
				// Haetaan kyseessä oleva oikeusryhmä
				/* Oikeusryhmä on joku seuraavista:
		        'yllapitooikeudet'
		        'lisaamuokkaaoikeudet'
		        'joukkueenalueoikeudet'
		        'omattiedotoikeudet'
		        */
				$oikryhma="";
				$query2="";
				$result2="";
				$ktunnus = $_REQUEST['tunnus'];
			
				$query2 = " SELECT * FROM omattiedotoikeudet WHERE tunnus = ".$ktunnus;
	            $result2 = $this->db->doQuery($query2);
	            if (count($result2) == 1) {
	                $oikryhma = "omattiedotoikeudet";
	            } else {
	                $query2 = " SELECT * FROM joukkueenalueoikeudet WHERE tunnus = ".$ktunnus;
	                $result2 = $this->db->doQuery($query2);
	                if (count($result2) == 1) {
	                    $oikryhma = "joukkueenalueoikeudet";
	                } else {
	                    $query2 = " SELECT * FROM lisaamuokkaaoikeudet WHERE tunnus = ".$ktunnus;
	                    $result2 = $this->db->doQuery($query2);
	                    if (count($result2) == 1) {
	                        $oikryhma = "lisaamuokkaaoikeudet";
	                    } else {
	                        $query2 = " SELECT * FROM yllapitooikeudet WHERE tunnus = ".$ktunnus;
	                        $result2 = $this->db->doQuery($query2);
	                        if (count($result2) == 1) {
	                            $oikryhma = "yllapitooikeudet";
    	                    }
	                    }
    	            }
	            }
			
				// delete, oikeusryhma
				$query = $this->poistavaSQLLauseke($oikeusryhmaArvot, $oikryhma);
	            $this->db->doQuery($query);
    	        D($query);

	            /*
	            array_push($henkiloArvot, 'yhtieto');
	            D("<pre>");
	            D($_REQUEST);
	            D("</pre>");
	            */
	        }
	        else {
	            // Anna virheilmoitus puuttuvasta tiedosta (käyttäjätunnus)
	        }
    	}
		else {
	    	// Anna virheilmoitus puuttuvasta tiedosta (käyttäjätunnus)
	    }
	}
	
    function taytaErikoisKentat(){
        if(isset($_REQUEST['hloid'])) {
            $this->haeTiedotKannasta();
        }

        $oikeusryhmat = array('yllapitooikeudet', 'lisaamuokkaaoikeudet', 'joukkueenalueoikeudet', 'omattiedotoikeudet');
        $oik = "Oikeusryhm&auml;";
        $oletusarvo = $this->tiedot['oikeusryhma'];
        if( empty($oletusarvo) )
        {
            $oletusarvo = 'omattiedotoikeudet';
        }
        $this->tiedot['oikeusryhma'] = new Select($oikeusryhmat, $oik, $oletusarvo);

        D("<pre>");
        D($this->tiedot);
        D("</pre>");

        if ( ! empty($_REQUEST['hloid']) ) {
            $this->tiedot['yhtieto'] = new Input('yhtietoid', $this->tiedot['yhtieto'], 'hidden');
            $this->tiedot['hloid'] = new Input('hloid', $_REQUEST['hloid'], 'hidden');
            $this->tiedot['henkilo'] = new Input('pelaajaid', $this->tiedot['pelaajaid'], 'hidden');
        }
    }


    function haeTiedotKannasta () {
        // ensin henkilon tiedot
        $query1 = " SELECT *, to_char(syntymaaika,'DD.MM.YYYY') as syntymaaika FROM henkilo WHERE hloid = ".$_REQUEST['hloid'];
        $this->openConnection();
        $result1 = $this->db->doQuery($query1);
        $yhttieto = $result1[0]['yhtieto'];

        // sitten käyttäjän tiedot
        $query2 = " SELECT * FROM kayttajat WHERE henkilo = ".$result1[0]['hloid'];
        $result2 = $this->db->doQuery($query2);
        $ktunnus = $result2[0]['tunnus'];

        $result3=NULL;
        // sitten yhteystiedot jos on merkitty
        if ( ! empty($yhttieto)) {
            $query3 = " SELECT * FROM yhteystieto WHERE yhtietoid = ".$yhttieto;
            $result3 = $this->db->doQuery($query3);
        }

        $result4=NULL;
        $oikryhma="";
        
		// sitten oikeusryhmä jos on merkitty
        if ( ! empty($ktunnus)) {
            $query4 = " SELECT * FROM omattiedotoikeudet WHERE tunnus = ".$ktunnus;
            $result4 = $this->db->doQuery($query4);
            if (count($result4) == 1) {
                $oikryhma = "omattiedotoikeudet";
            } else {
                $query4 = " SELECT * FROM joukkueenalueoikeudet WHERE tunnus = ".$ktunnus;
                $result4 = $this->db->doQuery($query4);
                if (count($result4) == 1) {
                    $oikryhma = "joukkueenalueoikeudet";
                } else {
                    $query4 = " SELECT * FROM lisaamuokkaaoikeudet WHERE tunnus = ".$ktunnus;
                    $result4 = $this->db->doQuery($query4);
                    if (count($result4) == 1) {
                        $oikryhma = "lisaamuokkaaoikeudet";
                    } else {
                        $query4 = " SELECT * FROM yllapitooikeudet WHERE tunnus = ".$ktunnus;
                        $result4 = $this->db->doQuery($query4);
                        if (count($result4) == 1) {
                            $oikryhma = "yllapitooikeudet";
                        }
                    }
                }
            }
        }

        $this->db->commit();
        $this->db->close();

         // summataan taulukot yhdeksi isoksi
        $result = &$result1[0];
        if ( count($result2) == 1) {
            $result = $result + $result2[0];
        }
        if ( count($result3) == 1) {
            $result = $result + $result3[0];
        }

//        print "<pre>";
//        print_r($result1);
//        print_r($result2);
//        print_r($result3);
//        print "</pre>";

        // täytetään kannan taulukon tulokset luokan tiedoiksi
        $this->tiedot['oikeusryhma'] = $oikryhma;
        foreach ( $this->tiedot as $k => $v ) {
            if ( array_key_exists($k, $result) ) {
                $this->tiedot[$k] = $result[$k];
            }
        }

    }
}
?>
