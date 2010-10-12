
insert into Yhteystieto
values (
       1,
       '+358 40 5419552',
       NULL,
       'jukka.kaartinen@tut.fi',
       'Tumppi 3 D 114',
       '33500',
       'Tampere',
       'Suomi',
       'Kotiosoiteja');
       

insert into Henkilo values(
	1,
	1,
	'Jukka',
	'Kaartinen',
	'1980-06-18',
	78000,
	178,
	NULL,
	NULL,
	'Jukkis');

insert into Henkilo values(
	2,
	NULL,
	'Lauri',
	'Oksanen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	'Oka');

insert into Henkilo values(
	3,
	NULL,
	'Teemu',
	'Siitarinen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	'Teme');

insert into Henkilo values(
	4,
	NULL,
	'Timo',
	'Rouhonen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	'Timo');

insert into Henkilo values(
	5,
	NULL,
	'Juha',
	'Kurki',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	'Kurki');

insert into Henkilo values(
	6,
	NULL,
	'Teemu',
	'Lahtela',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	'Tepe');
	
insert into Henkilo values(
	7,
	NULL,
	'Aapo',
	'Repo',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

insert into Henkilo values(
	8,
	NULL,
	'Lauri',
	'Yli-Huhtala',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

insert into Henkilo values(
	9,
	NULL,
	'Kari',
	'Mäkinen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

insert into Henkilo values(
	10,
	NULL,
	'Ilari',
	'Lehtinen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);
	
insert into Henkilo values(
	11,
	NULL,
	'Pasi',
	'Kautiala',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	'Jumalan käsi');
	
insert into Henkilo values(
	12,
	NULL,
	'Niko',
	'Suoranta',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);
    
insert into Henkilo values(
	13,
	NULL,
	'Pekka',
	'Hiltunen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);
    
insert into Henkilo values(
	14,
	NULL,
	'Juha',
	'Kaartinen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	'Lämmi');
    
insert into Henkilo values(
	15,
	NULL,
	'Juha',
	'Aalto',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

insert into Henkilo values(
	16,
	NULL,
	'Jarno',
	'Leppänen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);
    
insert into Henkilo values(
	17,
	NULL,
	'J-P',
	'Saarinen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

insert into Henkilo values(
	18,
	NULL,
	'Jani',
	'Lähteenmäki',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

insert into Henkilo values(
	19,
	NULL,
	'Petri',
	'Lassila',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);
    
insert into Henkilo values(
	20,
	NULL,
	'Ville',
	'Salonen',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

insert into Henkilo values(
	21,
	NULL,
	'Jarkko',
	'Koskela',
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL);

-- Pelaaja(pelaajaID->HENKILO(hloID), katisyys, maila)
insert into Pelaaja values(
       1,
       'L',
       'Fat Pipe'
);

-- Pelaaja(pelaajaID->HENKILO(hloID), katisyys, maila)
insert into Pelaaja values(
       2,
       'L',
       'Fat Pipe'
);

-- Pelaaja(pelaajaID->HENKILO(hloID), katisyys, maila)
insert into Pelaaja values(
       3,
       'L',
       'Fat Pipe'
);

-- Pelaaja(pelaajaID->HENKILO(hloID), katisyys, maila)
insert into Pelaaja values(
       4,
       'L',
       'Fat Pipe'
);


-- Pelaaja(pelaajaID->HENKILO(hloID), katisyys, maila)
insert into Pelaaja values(
       5,
       'L',
       'Fat Pipe'
);

-- Tyyppi(@tyyppi)
insert into Tyyppi values(
	'harjoitus'
);
insert into Tyyppi values(
	'peli'
);
insert into Tyyppi values(
	'treenit'
);


-- Tapahtuma(@tapahtumaID, vastuuhlo->HENKILO(hloID), tyyppi->TYYPPI, paikka,
-- paiva, aika, kuvaus)
insert into Tapahtuma values(
	1,
	NULL,
	'peli',
	'Jäähalli',
	'2005-05-16',
	'13:10:00.00',
	NULL
);

insert into Tapahtuma values(
	2,
	NULL,
	'harjoitus',
	'Kaukajärvi',
	'2005-05-12',
	'12:00:00.00',
	NULL
);


--Halli(@halliID, nimi, yhtiedot->YHTEYSTIETO, kenttien_lkm, lisatieto, alusta)
insert into Halli values(
	1,
	'Tamppi Areena', 
	NULL,
	1,
	'Soittorasian kotipesä.',
	'massa'
);

--Halli(@halliID, yhtiedot->YHTEYSTIETO, kenttien_lkm, lisatieto, alusta)
insert into Halli values(
	2,
	'Spiral-salit Kaukajärvi',
	NULL,
	4,
	NULL,
	'massa'
);


--Kausi(@vuosi)
insert into Kausi values(
	2004
);

insert into Kausi values(
	2005
);


insert into SarjaTyyppi values(
	-- M4D, harjoituspelisarja
	'M4D'
);

insert into SarjaTyyppi values(
	-- M4D, harjoituspelisarja
	'harjoituspelisarja'
);


--Sarja(@sarjaID, kausi->KAUSI(vuosi), nimi, kuvaus, jarjestaja)
insert into Sarja values(
	1,
	2004,
	'M4D',
	'Miesten 4 divisioona',
	NULL,
	'SSBL'
);

--Seura(seuraID, nimi, perustamisvuosi, lisätieto)
insert into Seura values(
	1,
	'KooVee',
	'1929-01-01',
	NULL
);

insert into Seura values(
	2,
	'Pirkkalan Pirkat',
	'1935-01-01',
	NULL
);

-- Joukkue(@joukkueID, seura->SEURA(seuraID), lyhytnimi, pitkänimi, email,
-- kuvaus, maskotti
insert into Joukkue values(
	1,
	1,
	'KooVee II',
	'KooVee II miehet',
	NULL,
	'koovee2@beer.com',
	NULL
);

insert into Joukkue values(
	2,
	2,
	'Pirpi II',
	'Pirkkalan Pirkat II',
	NULL,
	NULL,
	NULL
);

-- Kaudenjoukkue(@kaudenjID, kotihalli->HALLI(halliID), kausi->KAUSI(vuosi), 
-- kuva, logo, kotipaikka, kuvaus)
insert into Kaudenjoukkue values(
	1,
	2004,
	2,
	NULL,
	NULL,
	'Tampere',
	'Kovin salibandy joukkue ikinä.'
);


insert into Kaudenjoukkue values(
	1,
	2005,
	2,
	NULL,
	NULL,
	'Tampere',
	'Sama tahti jatkuu.'
);


insert into Kaudenjoukkue values(
	2,
	2004,
	NULL,
	NULL,
	NULL,
	'Pirkkala',
	NULL
);

-- Peli(@peliID->TAPAHTUMA(@tapahtumaID), 
-- vierasjoukkue->KAUDENJOUKKUE(kaudenjID), 
-- kotijoukkue->KAUDENJOUKKUE(kaudenjID), 
-- sarja->SARJA(sarjaID),
-- Atoimihenkilo1->HENKILO(hloID), Atoimihenkilo2->HENKILO(hloID),
-- Atoimihenkilo3->HENKILO(hloID), Atoimihenkilo4->HENKILO(hloID),
-- Atoimihenkilo5->HENKILO(hloID),
-- Btoimihenkilo1->HENKILO(hloID), Btoimihenkilo2->HENKILO(hloID),
-- Btoimihenkilo3->HENKILO(hloID), Btoimihenkilo4->HENKILO(hloID),
-- Btoimihenkilo5->HENKILO(hloID), 
-- pelipaikka->HALLI(halliID),
-- kotimaalit, vierasmaalit, tuomari1, tuomari2,
-- toimitsija1, toimitsija2, toimitsija3, huomio, aikalisaA, aikalisaB,
-- yleisomaara)
insert into Peli values(
	1,
	2,
	1,
	1,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	1,
	2,
	5,
	'Jukka Suominen',
	'Aapi Järvinen',
	'Tino Silfver',
	'Matti Partanen',
	NULL,
	'Toimitsijakortti OK',
	'00:39:42',
	NULL,
	-1
);


--Tilastomerkinta(@timerkintaID, peli->PELI(peliID), tapahtumisaika)
insert into Tilastomerkinta values(
	1,
	1,
	1,
	'00:26:54'
);

insert into Tilastomerkinta values(
	2,
	1,
	1,
	'00:44:03'
);

insert into Tilastomerkinta values(
	3,
	1,
	2,
	'00:02:46'
);

insert into Tilastomerkinta values(
	4,
	1,
	2,
	'00:19:26'
);

insert into Tilastomerkinta values(
	5,
	1,
	2,
	'00:03:09'
);

insert into Tilastomerkinta values(
	6,
	1,
	2,
	'00:14:24'
);

insert into Tilastomerkinta values(
	7,
	1,
	2,
	'00:20:09'
);

insert into Tilastomerkinta values(
	8,
	1,
	2,
	'00:31:33'
);

insert into Tilastomerkinta values(
	9,
	1,
	2,
	'00:44:31'
);

insert into Tilastomerkinta values(
	10,
	1,
	2,
	'00:16:06'
);

insert into Tilastomerkinta values(
	11,
	1,
	1,
	'00:26:24'
);

insert into Tilastomerkinta values(
	12,
	1,
	2,
	'00:42:02'
);

-- Maali(@maaliID->TILASTOMERKINTA(@timerkintaID), tekija->HENKILO(hloID),
-- syottaja->HENKILO(hloID), rankku, tyypppi, tyhjä, siirrangaikana)
insert into Maali values(
	1,
	2,
	NULL,

	-- no = normaali, yv = ylivoima, av=alivoima
	'yv',
	'false',
	'false'
);

insert into Maali values(
	2,
	6,
	14,
	-- no = normaali, yv = ylivoima, av=alivoima
	'no',
	'false',
	'false'
);

insert into Maali values(
	5,
	15,
	16,
	-- no = normaali, yv = ylivoima, av=alivoima
	'yv',
	'false',
	'false'
);

insert into Maali values(
	6,
	17,
	NULL,
	-- no = normaali, yv = ylivoima, av=alivoima
	'no',
	'false',
	'false'
);

insert into Maali values(
	7,
	18,
	NULL,
	-- no = normaali, yv = ylivoima, av=alivoima
	'yv',
	'false',
	'false'
);

insert into Maali values(
	8,
	15,
	16,
	-- no = normaali, yv = ylivoima, av=alivoima
	'no',
	'false',
	'false'
);

insert into Maali values(
	9,
	19,
	17,
	-- no = normaali, yv = ylivoima, av=alivoima
	'no',
	'false',
	'false'
);

-- Rangaistus(@rangaistusID->TILASTOMERKINTA(@timerkintaID),
-- pelaaja->HENKILO(hloID), syy, minuutit, paattymisaika)
insert into Rangaistus values(
	3,
	4,
	61,
	2,
	'00:03:09'
);

insert into Rangaistus values(
	4,
	13,
	65,
	2,
	'00:20:09'
);

insert into Rangaistus values(
	10,
	20,
	67,
	2,
	'00:18:06'
);

insert into Rangaistus values(
	11,
	19,
	67,
	2,
	'00:26:54'
);

insert into Rangaistus values(
	12,
	21,
	65,
	2,
	'00:44:02'
);


-- Pelaaja_tilasto(@tilastoID, peliID->PELI(peliID), 
-- pelaaja->PELAAJA(pelaajaID), plusmiinus, numero, kapteeni, maalivahti,
-- kapteeniksi tulo aika, maalivahdiksi tulo aika,
-- peliaika, torjunnat, paastetyt_maalit)
insert into Pelaajatilasto values(
	1,
	1,
	1,
	1,
	0,
	23,
	'false',
	'false',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	2,
	1,
	1,
	2,
	0,
	44,
	'false',
	'false',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	3,
	1,
	1,
	3,
	0,
	5,
	'false',
	'false',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	4,
	1,
	1,
	4,
	0,
	23,
	'false',
	'false',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	5,
	1,
	1,
	5,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	6,
	1,
	1,
	6,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	7,
	1,
	2,
	14,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	8,
	1,
	2,
	17,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	9,
	1,
	2,
	16,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	10,
	1,
	2,
	18,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	11,
	1,
	2,
	15,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	12,
	1,
	2,
	19,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	13,
	1,
	2,
	13,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	14,
	1,
	2,
	20,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Pelaajatilasto values(
	51,
	1,
	2,
	21,
	0,
	23,
	'false',
	'true',

	-- kapteeniksi tuloaika
	NULL,

	-- maalivahdiksi tuloaika
	NULL,
	NULL,
	NULL,
	NULL
);

insert into Toimenkuva values(
	'huoltaja'
);

insert into Toimenkuva values(
	'pelaajavalmentaja'
);

-- Toimi(@tehtava, @kaudenjoukkue->KAUDENJOUKKUE(kaudenjID), 
-- @henkilo->HENKILO(hloID))
insert into Toimi values(
	-- valmentaja, lääkäri, huoltaja
	'pelaajavalmentaja',
	1,
	2004,
	5
);


-- Osallistuja(@tapahtumaID->TAPAHTUMA, @osallistuja->HENKILO(hloID))
insert into Osallistuja values(
	1,
	1,
	'1'
);
insert into Osallistuja values(
	1,
	2,
	'0',
	'tentti'
);


-- Pelaajat(@joukkue->KAUDENJOUKKUE(kaudenjID), @pelaaja->HENKILO(hloID), 
-- pelinumero, pelipaikka)
insert into Pelaajat values(
	1,
	2004,
	1,

	-- Oletus numero
	80,

	-- VL = Vasenlaita, OL = Oikealaita, KE = Keskushyökkääjä,
	-- PU = Puolustaja ja MV = Maalivahti
	'VL',
	'false'
);

insert into Pelaajat values(
	1,
	2004,
	2,

	-- Oletus numero
	88,

	-- VL = Vasenlaita, OL = Oikealaita, KE = Keskushyökkääjä,
	-- PU = Puolustaja ja MV = Maalivahti
	'VL',
	'false'
);

insert into Pelaajat values(
	1,
	2004,
	5,

	-- Oletus numero
	3,

	-- VL = Vasenlaita, OL = Oikealaita, KE = Keskushyökkääjä,
	-- PU = Puolustaja ja MV = Maalivahti
	'VL',
	'false'
);

-- SarjanJoukkueet(@sarja->SARJA(sarjaID),
-- @kaudenjoukkue->KAUDENJOUKKUE(kaudenjID))
insert into Sarjanjoukkueet values(
	1,
	1,
	2004
);

insert into Sarjanjoukkueet values(
	1,
	2,
	2004
);


-- Uutinen(@uutineID, pvm, ilmoittaja, otsikko, uutinen)
insert into Uutinen values(
	1,
	-- pitäiskö olla date and time
	'2005-01-16',
	'WebAdmin',
	'Ensimmäinen <b>testi</b> uutinen.',
	'Tämä on ensimmäinen testi uutinen <br /> uudessa <b>Rysty</b> j&auml;rjestelm&auml;ss&auml;!'
);


-- Kayttajat(@tunnus, salasana, henkilo->HENKILO(hloID))
insert into Kayttajat values(
	'tepe',
	-- md5 koodattu
	md5('tepe'),
	6
);

insert into Kayttajat values(
	'jukka',
	-- md5 koodattu
	md5('jukka'),
	1
);


-- Yllapito_oikeudet(@tunnus->KAYTTAJAT)
insert into Yllapitooikeudet values(
	'tepe'
);

insert into Yllapitooikeudet values(
	'jukka'
);
     


-- SELECT setval('epaonnisrankku_epaonnisrankkuid_seq', 1000);
SELECT setval('halli_halliid_seq', 1000);
SELECT setval('henkilo_hloid_seq', 1000);
SELECT setval('joukkue_joukkueid_seq', 1000);
SELECT setval('kaudenjoukkue_joukkueid_seq', 1000);
-- SELECT setval('maali_maaliid_seq', 1000);
SELECT setval('pelaajatilasto_tilastoid_seq', 1000);
SELECT setval('peli_peliid_seq', 1000);
-- SELECT setval('rangaistus_rangaistusid_seq', 1000);
SELECT setval('sarja_sarjaid_seq', 1000);
SELECT setval('seura_seuraid_seq', 1000);
SELECT setval('tapahtuma_tapahtumaid_seq', 1000);
SELECT setval('tilastomerkinta_timerkintaid_seq', 1000);
SELECT setval('uutinen_uutinenid_seq', 1000);
SELECT setval('yhteystieto_yhtietoid_seq', 1000);



