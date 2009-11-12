<?php
/**
 * yllapito.php  
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * author: Teme
 * created: %date%
 * 
*/


require_once("toiminto.php");
require_once("tietokanta.php");
/**
 * class Yllapito
 * 
 */
class Yllapito extends Toiminto
{

    /** Aggregations: */
	
    /** Compositions: */

     /*** Attributes: ***/

	var $view;
	
    /**
     * Returns the view for this action.
     */
    function &getView () {
        return $this->view;
    }
	
    /**
     * Creates a view for this action.
     * @param string className
     */
    function createView ($class) {
        $registry = &Registry::instance();
        if (!$registry->isEntry('view')) {
            $registry->setEntry(
                    'view', new $class($this));
        }
        $this->view =  &$registry->getEntry('view');        
        //$this->view->setToiminto($this);
    }
	
	// Lähetettiinkö lomake vai tultiinko sivulle ensimmäistä kertaa
	function lomakkeenLahetys() {
		if (isset( $etunimi )) {
			luoKayttaja ();
		} else {
			return;
		}
	}
	
	function luoKayttaja () {
	
		// Ovatko pakolliset tiedot syötetty
		if (empty($etunimi)) {
			// TODO: ilmoitus: "syötä etunimi"
			return;
		}
		if (empty($sukunimi)) {
			// TODO: ilmoitus: "syötä sukunimi"
			return;
		}
		if (empty($katuosoite)) {
			// TODO: ilmoitus: "syötä katuosoite"
			return;
		}
		if (empty($postinumero)) {
			// TODO: ilmoitus: "syötä postinumero"
			return;
		}
		if (empty($postitoimipaikka)) {
			// TODO: ilmoitus: "syötä postitoimipaikka"
			return;
		}
		if (empty($email)) {
			// TODO: ilmoitus: "syötä sähköpostiosoite"
			return;
		}
		if (empty($kayttajatunnus)) {
			// TODO: ilmoitus: "syötä käyttäjätunnus"
			return;
		}
		if (empty($salasana) || empty($salasana2)) {
			// TODO: ilmoitus: "syötä salasana kahteen kertaan"
			return;
		}
		else if ( $salasana !== $salasana2 ) {
			// TODO: ilmoitus: "Syöttämäsi salasanat eivät täsmänneet"
			return;
		}
		if (empty($oikeudet)) {
			// TODO: ilmoitus: "Määritä oikeudet"
			return;
		}
		
		// suoritetaan varsinainen käyttäjän luominen
		if ($this->lisaaKayttajaTietokantaan($etunimi, $sukunimi, 
											 $katuosoite, $postinumero, 
											 $postitoimipaikka, $email, 
											 $kayttajatunnus, $salasana, 
											 $oikeudet)) {
			// TODO: Ilmoitus: kättäjän luominen tietokantaan onnistui
			$this->tyhjennaTekstikentat();
		} else {
			// TODO: Ilmoitus: kättäjän luominen tietokantaan epäonnistui
		}
	}
	
	// Lisää käyttäjä tietokantaan
	function lisaaKayttajaTietokantaan($etunimi, $sukunimi, $katuosoite, $postinumero, 
									$postitoimipaikka, $email, $kayttajatunnus, $salasana, 
									$oikeudet) {
		// komennetaan Toiminto-luokasta periytynyttä funktiota
		
/*
create table Yhteystieto(
	yhtietoID serial not null primary key,
	puhelinnumero VARCHAR(30),
	faxi VARCHAR(30),
	email VARCHAR(260)
		CHECK (email is null OR email like '%@%'),
	katuosoite VARCHAR(100),
	postinumero VARCHAR(8),
	postitoimipaikka VARCHAR(50),
	maa VARCHAR(50) default 'Suomi',
	selite VARCHAR(200)
);
create table Henkilo(
	hloID serial not null primary key,
	yhtieto integer references Yhteystieto(yhtietoID),
	etunimi varchar(40) not null,
	sukunimi varchar(40) not null,
	syntymaaika date,
	-- grammoina
	paino integer,
	-- senttimetreinä
	pituus integer,
	kuva varchar(50),
	kuvaus text,
	lempinimi varchar(40)
);
create table Kayttajat(
	tunnus varchar(16) not null primary key,
	-- md5 koodattu
	salasana varchar(255),
	henkilo integer references Henkilo(hloID)
);
*/

		// TODO: $yhtieto JA $henkilo
		// eli yhteystieto-, henkilo- ja kayttajat-taulun yhteyden määrittäminen
		$sqlQuery1 = "INSERT INTO Yhteystieto 
					(email, katuosoite, postinumero, postitoimipaikka)
					VALUES(".$email.", ".$katuosoite.", ".$postinumero.", ".$postitoimipaikka.")";
		// TODO SELECT 
		$sqlQuery2 = "INSERT INTO Henkilo 
					(yhtieto, etunimi, sukunimi)
					VALUES(".$yhtieto.", ".$etunimi.", ".$sukunimi.")";
		$sqlQuery3 = "INSERT INTO Kayttajat 
					(tunnus, salasana, henkilo)
					VALUES(".$kayttajatunnus.", ".$salasana.", ".$henkilo.")";
		
		// Suoritetaan muodostetut SQL-lauseet
		// Tallennetaan käyttäjän tiedot tietokantaan
		if (!($this->executeSQLquery( sqlQuery1 ))) {
			return false;
		} else if (!($this->executeSQLquery( sqlQuery2 ))) {
			return false;
		} else if (!($this->executeSQLquery( sqlQuery3 ))) {
			return false;
		} else {
			return true;							
		}
	}
	
	// Tyhjennä tekstikentät uuden käyttäjän syöttöä varten
	function tyhjennaTekstikentat() {
		$etunimi = "";
	    $sukunimi = "";
		$katuosoite = "";
		$postinumero = "";
		$postitoimipaikka = "";
		$email = "";
		$kayttajatunnus = "";
		$salasana = "";
		$oikeudet = "";
		 
		// TODO: päivitä/lataa uudelleen kyseinen sivu
	}
	
	// Tyhjennä tekstikentät uuden käyttäjän syöttöä varten
	function keskeyta() {
		tyhjennaTekstikentat();
	}
} // end of Yllapito
?>
