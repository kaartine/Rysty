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
	
	// L�hetettiink� lomake vai tultiinko sivulle ensimm�ist� kertaa
	function lomakkeenLahetys() {
		if (isset( $etunimi )) {
			luoKayttaja ();
		} else {
			return;
		}
	}
	
	function luoKayttaja () {
	
		// Ovatko pakolliset tiedot sy�tetty
		if (empty($etunimi)) {
			// TODO: ilmoitus: "sy�t� etunimi"
			return;
		}
		if (empty($sukunimi)) {
			// TODO: ilmoitus: "sy�t� sukunimi"
			return;
		}
		if (empty($katuosoite)) {
			// TODO: ilmoitus: "sy�t� katuosoite"
			return;
		}
		if (empty($postinumero)) {
			// TODO: ilmoitus: "sy�t� postinumero"
			return;
		}
		if (empty($postitoimipaikka)) {
			// TODO: ilmoitus: "sy�t� postitoimipaikka"
			return;
		}
		if (empty($email)) {
			// TODO: ilmoitus: "sy�t� s�hk�postiosoite"
			return;
		}
		if (empty($kayttajatunnus)) {
			// TODO: ilmoitus: "sy�t� k�ytt�j�tunnus"
			return;
		}
		if (empty($salasana) || empty($salasana2)) {
			// TODO: ilmoitus: "sy�t� salasana kahteen kertaan"
			return;
		}
		else if ( $salasana !== $salasana2 ) {
			// TODO: ilmoitus: "Sy�tt�m�si salasanat eiv�t t�sm�nneet"
			return;
		}
		if (empty($oikeudet)) {
			// TODO: ilmoitus: "M��rit� oikeudet"
			return;
		}
		
		// suoritetaan varsinainen k�ytt�j�n luominen
		if ($this->lisaaKayttajaTietokantaan($etunimi, $sukunimi, 
											 $katuosoite, $postinumero, 
											 $postitoimipaikka, $email, 
											 $kayttajatunnus, $salasana, 
											 $oikeudet)) {
			// TODO: Ilmoitus: k�tt�j�n luominen tietokantaan onnistui
			$this->tyhjennaTekstikentat();
		} else {
			// TODO: Ilmoitus: k�tt�j�n luominen tietokantaan ep�onnistui
		}
	}
	
	// Lis�� k�ytt�j� tietokantaan
	function lisaaKayttajaTietokantaan($etunimi, $sukunimi, $katuosoite, $postinumero, 
									$postitoimipaikka, $email, $kayttajatunnus, $salasana, 
									$oikeudet) {
		// komennetaan Toiminto-luokasta periytynytt� funktiota
		
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
	-- senttimetrein�
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
		// eli yhteystieto-, henkilo- ja kayttajat-taulun yhteyden m��ritt�minen
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
		// Tallennetaan k�ytt�j�n tiedot tietokantaan
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
	
	// Tyhjenn� tekstikent�t uuden k�ytt�j�n sy�tt�� varten
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
		 
		// TODO: p�ivit�/lataa uudelleen kyseinen sivu
	}
	
	// Tyhjenn� tekstikent�t uuden k�ytt�j�n sy�tt�� varten
	function keskeyta() {
		tyhjennaTekstikentat();
	}
} // end of Yllapito
?>
