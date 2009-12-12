

-- Yhteystieto(@yhtietoID, puhelinumero, faxi, email, katuosoite, postinumero,
-- postitoimipaikka, maa, selite)
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

-- Henkilo(@hloID, yhtietoID->YHTEYSTIETO, etunimi, sukunimi, syntymäaika,
-- paino, pituus, kuva, kuvaus, lempinimi)
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


-- Pelaaja(pelaajaID->HENKILO(hloID), katisyys, maila)
create table Pelaaja(
    pelaajaID integer not null primary key references Henkilo(hloID),

    -- L = left, R = right, E = don't know
    katisyys character(1) not null default 'L',
    maila varchar(40)
);


-- Tyyppi(@tyyppi)
create table Tyyppi(
    -- peli, harjoitus, ...
    tyyppi varchar(20) not null primary key
);


-- Tapahtuma(@tapahtumaID, vastuuhlo->HENKILO(hloID), tyyppi->TYYPPI, paikka,
-- paiva, aika, kuvaus)
create table Tapahtuma(
    tapahtumaID serial not null primary key,
    vastuuhlo integer references Henkilo(hloID),
    tyyppi varchar(20) references Tyyppi,
    paikka varchar(100),
    paiva date not null,
    aika time not null,
    kuvaus text
);


-- Halli(@halliID, yhtiedot->YHTEYSTIETO, kenttien_lkm, lisatieto, alusta)
create table Halli(
    halliID serial not null primary key,
    nimi varchar(40) not null,
    yhtietoID integer references Yhteystieto(yhtietoID),
    kenttienlkm integer not null default '1',
    lisatieto text,
    alusta varchar(200)
);


--Kausi(@vuosi)
create table Kausi(
    -- 2004, 2005, ...
    vuosi integer not null primary key
);


create table SarjaTyyppi(
    -- M4D, harjoituspelisarja
    tyyppi varchar(25) not null primary key
);


--Seura(seuraID, nimi, perustamisvuosi, lisätieto)
create table Seura(
    seuraID serial not null primary key,
    nimi varchar(40) not null,
    perustamispvm date not null,
    lisatieto text
);


--Sarja(@sarjaID, kausi->KAUSI(vuosi), nimi, kuvaus, jarjestaja)
create table Sarja(
    sarjaID serial not null primary key,
    kausi integer not null references Kausi(vuosi),
    tyyppi varchar(25) not null references SarjaTyyppi,
    nimi varchar(40) not null,
    kuvaus text,
    jarjestaja varchar(80)
);


-- Joukkue(@joukkueID, seura->SEURA(seuraID), lyhytnimi, pitkänimi, email,
-- kuvaus, maskotti
create table Joukkue(
    joukkueID serial not null primary key,
    seuraID integer references Seura,
    lyhytnimi varchar(10) not null,
    pitkanimi varchar(40) not null,    
    maskotti varchar(80),
    email varchar(260)
        check (email is null or email like '%@%'),

    logo varchar(50),
        
    kuvaus text
);

-- Kaudenjoukkue(@kaudenjID, kotihalli->HALLI(halliID), kausi->KAUSI(vuosi),
-- kuva, logo, kotipaikka, kuvaus)
create table Kaudenjoukkue(
    joukkueID serial not null references Joukkue,
    kausi integer not null references Kausi(vuosi),
    kotihalli integer references Halli(halliID),
    kuva varchar(50),
    logo varchar(50),
    kotipaikka varchar(40) not null,
    kuvaus text,
    primary key(joukkueID, kausi)
);

-- Peli(@peliID->TAPAHTUMA(@tapahtumaID),
-- vierasjoukkue->KAUDENJOUKKUE(kaudenjID),
-- kotijoukkue->KAUDENJOUKKUE(kaudenjID), sarja->SARJA(sarjaID),
-- toimihenkilo1->HENKILO(hloID), toimihenkilo2->HENKILO(hloID),
-- toimihenkilo3->HENKILO(hloID), toimihenkilo4->HENKILO(hloID),
-- toimihenkilo5->HENKILO(hloID), pelipaikka->HALLI(halliID),
-- kotimaalit, vierasmaalit, tuomari1, tuomari2,
-- toimitsija1, toimitsija2, toimitsija3, huomio, aikalisaA, aikalisaB,
-- yleisomaara)
create table Peli(
    peliID serial not null primary key references Tapahtuma(tapahtumaID),
    vierasjoukkue integer not null references Joukkue(joukkueID)
        check (vierasjoukkue <> kotijoukkue),
    kotijoukkue integer not null references Joukkue(joukkueID)
        check (vierasjoukkue <> kotijoukkue),
    sarja integer not null references Sarja(sarjaID),

    -- kotijoukkueen toimihenkilöt
    Atoimihenkilo1 integer references Henkilo(hloID),
    Atoimihenkilo2 integer references Henkilo(hloID),
    Atoimihenkilo3 integer references Henkilo(hloID),
    Atoimihenkilo4 integer references Henkilo(hloID),
    Atoimihenkilo5 integer references Henkilo(hloID),

    -- vierasjoukkueen toimihenkilöt
    Btoimihenkilo1 integer references Henkilo(hloID),
    Btoimihenkilo2 integer references Henkilo(hloID),
    Btoimihenkilo3 integer references Henkilo(hloID),
    Btoimihenkilo4 integer references Henkilo(hloID),
    Btoimihenkilo5 integer references Henkilo(hloID),

    pelipaikka integer not null references Halli(halliID),
    kotimaalit integer,
    vierasmaalit integer,
    tuomari1 varchar(80),
    tuomari2 varchar(80),
    toimitsija1 varchar(80),
    toimitsija2 varchar(80),
    toimitsija3 varchar(80),
    huomio text,
    aikalisaA time,
    aikalisaB time,
    yleisomaara integer default -1
);


--Tilastomerkinta(@timerkintaID, peli->PELI(peliID), tapahtumisaika)
create table Tilastomerkinta(
    timerkintaID serial not null primary key,
    peliID integer not null references Peli(peliID),
    joukkueID integer not null references Joukkue(joukkueID),

    tapahtumisaika time
);


-- Maali(@maaliID->TILASTOMERKINTA(@timerkintaID), tekija->HENKILO(hloID),
-- syottaja->HENKILO(hloID), rankku, tyypppi, tyhjä, siirrangaikana)
create table Maali(
    maaliID integer not null primary key
        references Tilastomerkinta(timerkintaID),
    tekija integer not null references Henkilo(hloID),
    syottaja integer references Henkilo(hloID),

    -- no = normaali, yv = ylivoima, av=alivoima
    tyyppi varchar(2) not null default 'no'
        check(tyyppi in ('no', 'yv', 'av','rl')),
    tyhjamaali boolean not null default 'false',
    siirrangaikana boolean not null default 'false',
    rangaistuslaukaus boolean not null default 'false'
);


-- Epaonnisrankku(@epaonrankkuID->TILASTOMERKINTA(@timerkintaID),
-- tekija->HENKILO(hloID), tyyppi, siirrangaikana)
-- Kun lasketaan pisteitä yhteen niin ei tarvitse kikkailla. Sen takia oma taulu
-- epäonnistuneelle rankulle.
create table Epaonnisrankku(
    epaonnisrankkuID integer not null references Tilastomerkinta(timerkintaID),
    tekija integer not null references Pelaaja(pelaajaID),

    -- no = normaali, yv = ylivoima, av=alivoima
    tyyppi varchar not null default 'no'
        check(tyyppi in ('no', 'yv', 'av','rl')),
    tyhjamaali boolean not null default 'false',
    siirrangaikana boolean not null default 'false'
);



-- Rangaistus(@rangaistusID->TILASTOMERKINTA(@timerkintaID),
-- pelaaja->HENKILO(hloID), syy, minuutit, paattymisaika)
create table Rangaistus(
    rangaistusID integer not null references Tilastomerkinta(timerkintaID),

    saaja integer not null references Henkilo(hloID),
    syy integer not null,
    minuutit integer not null
        check (minuutit in (2,5,10,20)),
    paattymisaika time
);


-- Pelaaja_tilasto(@tilastoID, peliID->PELI(peliID),
-- pelaaja->PELAAJA(pelaajaID), plusmiinus, numero, kapteeni, maalivahti,
-- kapteeniksi tulo aika, maalivahdiksi tulo aika,
-- peliaika, torjunnat, paastetyt_maalit)
create table Pelaajatilasto(
    tilastoID serial not null primary key,
    peliID integer not null references Peli,
    joukkue integer not null references Joukkue(joukkueID),
    pelaaja integer not null references Henkilo(hloID),
    plusmiinus integer not null default 0,
    numero integer not null default 0,
    kapteeni boolean not null default 'false',
    maalivahti boolean not null default 'false',

    -- kapteeniksi tuloaika
    kaptuloaika time,

    -- maalivahdiksi tuloaika
    mvtuloaika time,
    peliaika time,
    torjunnat integer,
    paastetytmaalit integer,
    lisatieto text
);

create table Toimenkuva(
    -- valmentaja, lääkäri, huoltaja
    toimenkuva varchar(20) not null primary key
);

-- Toimi(@tehtava, @kaudenjoukkue->KAUDENJOUKKUE(kaudenjID),
-- @henkilo->HENKILO(hloID))
create table Toimi(
    -- valmentaja, lääkäri, huoltaja
    tehtava varchar(20),
    kaudenjoukkue integer not null,
    kausi integer not null,
    FOREIGN KEY (kaudenjoukkue, kausi)
                        REFERENCES Kaudenjoukkue(joukkueID, kausi),
    --kaudenjoukkue integer not null references Kaudenjoukkue(joukkueID, kausi),
    henkilo integer not null references Henkilo(hloID),
    primary key(kaudenjoukkue, henkilo, kausi)
);


-- Osallistuja(@tapahtumaID->TAPAHTUMA, @osallistuja->HENKILO(hloID))
create table Osallistuja(
    tapahtumaID integer not null references Tapahtuma,
    osallistuja integer not null references Henkilo(hloID),
    paasee boolean not null,
    selite text,
    primary key(tapahtumaID, osallistuja)
);


-- Pelaajat(@joukkue->KAUDENJOUKKUE(kaudenjID), @pelaaja->HENKILO(hloID),
-- pelinumero, pelipaikka)
create table Pelaajat(
    joukkue integer not null,
    kausi integer not null,
    FOREIGN KEY (joukkue, kausi)
                        REFERENCES Kaudenjoukkue(joukkueID, kausi),
--    joukkue integer not null references Kaudenjoukkue(joukkueID, kausi),
    pelaaja integer not null references Henkilo(hloID),

    -- Oletus numero
    pelinumero integer,

    -- VL = Vasenlaita, OL = Oikealaita, KE = Keskushyökkääjä,
    -- PU = Puolustaja ja MV = Maalivahti
    pelipaikka varchar(2) default NULL
        check (pelipaikka in ('VL', 'OL', 'KE', 'PU', 'MV', NULL)),
    kapteeni boolean default 'false',
    
    --
    aloituspvm date default NULL,
    lopetuspvm date default NULL
    	check (aloituspvm < lopetuspvm),
    
    primary key(joukkue, pelaaja, kausi)
);


-- SarjanJoukkueet(@sarja->SARJA(sarjaID),
-- @kaudenjoukkue->KAUDENJOUKKUE(kaudenjID))
create table Sarjanjoukkueet(
    sarjaID integer not null references Sarja,
    joukkue integer not null,
    kausi integer not null,
    FOREIGN KEY (joukkue, kausi)
                        REFERENCES Kaudenjoukkue(joukkueID, kausi),
    FOREIGN KEY (kausi)
                        REFERENCES Kausi(vuosi),
    --joukkue integer not null references Kaudenjoukkue(joukkueID, kausi),
    primary key(sarjaID, joukkue, kausi)
);


-- Uutinen(@uutineID, pvm, ilmoittaja, otsikko, uutinen)
create table Uutinen(
    uutinenID serial not null primary key,
    -- pitäiskö olla date and time
    pvm date not null,
    ilmoittaja varchar(80) not null,
    otsikko varchar(100) not null,
    uutinen text not null
);


-- Kayttajat(@tunnus, salasana, henkilo->HENKILO(hloID))
create table Kayttajat(
    tunnus varchar(16) not null primary key,
    -- md5 koodattu
    salasana varchar(255),
    henkilo integer references Henkilo(hloID)
);


-- Yllapito_oikeudet(@tunnus->KAYTTAJAT)
create table Yllapitooikeudet(
    tunnus varchar(16) not null primary key references Kayttajat ON DELETE CASCADE
);


-- Lisää_muokkaa_poista_oikeudet(@tunnus->KAYTTAJAT)
create table lisaamuokkaaoikeudet(
    tunnus varchar(16) not null primary key references Kayttajat ON DELETE CASCADE
);


-- Joukkueenalueoikeudet(@tunnus->KAYTTAJAT)
create table joukkueenalueoikeudet(
    tunnus varchar(16) not null primary key references Kayttajat ON DELETE CASCADE
);


-- Omattiedotoikeudet(@tunnus->KAYTTAJAT)
create table Omattiedotoikeudet(
    tunnus varchar(16) not null primary key references Kayttajat ON DELETE CASCADE
);


commit work;

