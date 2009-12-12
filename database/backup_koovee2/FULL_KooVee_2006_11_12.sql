--
-- PostgreSQL database dump
--

SET client_encoding = 'SQL_ASCII';
SET check_function_bodies = false;

--
-- TOC entry 2 (OID 0)
-- Name: koovee; Type: DATABASE; Schema: -; Owner: kaartine
--

CREATE DATABASE koovee WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII';


\connect koovee kaartine

SET client_encoding = 'SQL_ASCII';
SET check_function_bodies = false;

--
-- TOC entry 4 (OID 2200)
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- TOC entry 5 (OID 109896)
-- Name: yhteystieto; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE yhteystieto (
    yhtietoid serial NOT NULL,
    puhelinnumero character varying(30),
    faxi character varying(30),
    email character varying(260),
    katuosoite character varying(100),
    postinumero character varying(8),
    postitoimipaikka character varying(50),
    maa character varying(50) DEFAULT 'Suomi'::character varying,
    selite character varying(200),
    CONSTRAINT yhteystieto_email CHECK (((email IS NULL) OR ((email)::text ~~ '%@%'::text)))
);


--
-- TOC entry 6 (OID 109896)
-- Name: yhteystieto; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE yhteystieto FROM PUBLIC;
GRANT ALL ON TABLE yhteystieto TO "www-data";


--
-- TOC entry 7 (OID 109905)
-- Name: henkilo; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE henkilo (
    hloid serial NOT NULL,
    yhtieto integer,
    etunimi character varying(40) NOT NULL,
    sukunimi character varying(40) NOT NULL,
    syntymaaika date,
    paino integer,
    pituus integer,
    kuva character varying(50),
    kuvaus text,
    lempinimi character varying(40)
);


--
-- TOC entry 8 (OID 109905)
-- Name: henkilo; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE henkilo FROM PUBLIC;
GRANT ALL ON TABLE henkilo TO "www-data";


--
-- TOC entry 9 (OID 109917)
-- Name: pelaaja; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE pelaaja (
    pelaajaid integer NOT NULL,
    katisyys character(1) DEFAULT 'L'::bpchar NOT NULL,
    maila character varying(40)
);


--
-- TOC entry 10 (OID 109917)
-- Name: pelaaja; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE pelaaja FROM PUBLIC;
GRANT ALL ON TABLE pelaaja TO "www-data";


--
-- TOC entry 11 (OID 109926)
-- Name: tyyppi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE tyyppi (
    tyyppi character varying(20) NOT NULL
);


--
-- TOC entry 12 (OID 109926)
-- Name: tyyppi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE tyyppi FROM PUBLIC;
GRANT ALL ON TABLE tyyppi TO "www-data";


--
-- TOC entry 13 (OID 109932)
-- Name: tapahtuma; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE tapahtuma (
    tapahtumaid serial NOT NULL,
    vastuuhlo integer,
    tyyppi character varying(20),
    paikka character varying(100),
    paiva date NOT NULL,
    aika time without time zone NOT NULL,
    kuvaus text
);


--
-- TOC entry 14 (OID 109932)
-- Name: tapahtuma; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE tapahtuma FROM PUBLIC;
GRANT ALL ON TABLE tapahtuma TO "www-data";


--
-- TOC entry 15 (OID 109950)
-- Name: halli; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE halli (
    halliid serial NOT NULL,
    nimi character varying(40) NOT NULL,
    yhtietoid integer,
    kenttienlkm integer DEFAULT 1 NOT NULL,
    lisatieto text,
    alusta character varying(200)
);


--
-- TOC entry 16 (OID 109950)
-- Name: halli; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE halli FROM PUBLIC;
GRANT ALL ON TABLE halli TO "www-data";


--
-- TOC entry 17 (OID 109963)
-- Name: kausi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE kausi (
    vuosi integer NOT NULL
);


--
-- TOC entry 18 (OID 109963)
-- Name: kausi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE kausi FROM PUBLIC;
GRANT ALL ON TABLE kausi TO "www-data";


--
-- TOC entry 19 (OID 109967)
-- Name: sarjatyyppi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE sarjatyyppi (
    tyyppi character varying(25) NOT NULL
);


--
-- TOC entry 20 (OID 109967)
-- Name: sarjatyyppi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE sarjatyyppi FROM PUBLIC;
GRANT ALL ON TABLE sarjatyyppi TO "www-data";


--
-- TOC entry 21 (OID 109973)
-- Name: seura; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE seura (
    seuraid serial NOT NULL,
    nimi character varying(40) NOT NULL,
    perustamispvm date NOT NULL,
    lisatieto text
);


--
-- TOC entry 22 (OID 109973)
-- Name: seura; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE seura FROM PUBLIC;
GRANT ALL ON TABLE seura TO "www-data";


--
-- TOC entry 23 (OID 109983)
-- Name: sarja; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE sarja (
    sarjaid serial NOT NULL,
    kausi integer NOT NULL,
    tyyppi character varying(25) NOT NULL,
    nimi character varying(40) NOT NULL,
    kuvaus text,
    jarjestaja character varying(80)
);


--
-- TOC entry 24 (OID 109983)
-- Name: sarja; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE sarja FROM PUBLIC;
GRANT ALL ON TABLE sarja TO "www-data";


--
-- TOC entry 25 (OID 110001)
-- Name: joukkue; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE joukkue (
    joukkueid serial NOT NULL,
    seuraid integer,
    lyhytnimi character varying(10) NOT NULL,
    pitkanimi character varying(40) NOT NULL,
    maskotti character varying(80),
    email character varying(260),
    logo character varying(50),
    kuvaus text,
    CONSTRAINT joukkue_email CHECK (((email IS NULL) OR ((email)::text ~~ '%@%'::text)))
);


--
-- TOC entry 26 (OID 110001)
-- Name: joukkue; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE joukkue FROM PUBLIC;
GRANT ALL ON TABLE joukkue TO "www-data";


--
-- TOC entry 27 (OID 110016)
-- Name: kaudenjoukkue; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE kaudenjoukkue (
    joukkueid serial NOT NULL,
    kausi integer NOT NULL,
    kotihalli integer,
    kuva character varying(50),
    logo character varying(50),
    kotipaikka character varying(40) NOT NULL,
    kuvaus text
);


--
-- TOC entry 28 (OID 110016)
-- Name: kaudenjoukkue; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE kaudenjoukkue FROM PUBLIC;
GRANT ALL ON TABLE kaudenjoukkue TO "www-data";


--
-- TOC entry 29 (OID 110038)
-- Name: peli; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE peli (
    peliid serial NOT NULL,
    vierasjoukkue integer NOT NULL,
    kotijoukkue integer NOT NULL,
    sarja integer NOT NULL,
    atoimihenkilo1 integer,
    atoimihenkilo2 integer,
    atoimihenkilo3 integer,
    atoimihenkilo4 integer,
    atoimihenkilo5 integer,
    btoimihenkilo1 integer,
    btoimihenkilo2 integer,
    btoimihenkilo3 integer,
    btoimihenkilo4 integer,
    btoimihenkilo5 integer,
    pelipaikka integer NOT NULL,
    kotimaalit integer,
    vierasmaalit integer,
    tuomari1 character varying(80),
    tuomari2 character varying(80),
    toimitsija1 character varying(80),
    toimitsija2 character varying(80),
    toimitsija3 character varying(80),
    huomio text,
    aikalisaa time without time zone,
    aikalisab time without time zone,
    yleisomaara integer DEFAULT -1,
    CONSTRAINT peli_kotijoukkue CHECK ((vierasjoukkue <> kotijoukkue)),
    CONSTRAINT peli_vierasjoukkue CHECK ((vierasjoukkue <> kotijoukkue))
);


--
-- TOC entry 30 (OID 110038)
-- Name: peli; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE peli FROM PUBLIC;
GRANT ALL ON TABLE peli TO "www-data";


--
-- TOC entry 31 (OID 110111)
-- Name: tilastomerkinta; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE tilastomerkinta (
    timerkintaid serial NOT NULL,
    peliid integer NOT NULL,
    joukkueid integer NOT NULL,
    tapahtumisaika time without time zone
);


--
-- TOC entry 32 (OID 110111)
-- Name: tilastomerkinta; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE tilastomerkinta FROM PUBLIC;
GRANT ALL ON TABLE tilastomerkinta TO "www-data";


--
-- TOC entry 33 (OID 110124)
-- Name: maali; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE maali (
    maaliid integer NOT NULL,
    tekija integer NOT NULL,
    syottaja integer,
    tyyppi character varying(2) DEFAULT 'no'::character varying NOT NULL,
    tyhjamaali boolean DEFAULT false NOT NULL,
    siirrangaikana boolean DEFAULT false NOT NULL,
    rangaistuslaukaus boolean DEFAULT false NOT NULL,
    CONSTRAINT maali_tyyppi CHECK ((((((tyyppi)::text = 'no'::text) OR ((tyyppi)::text = 'yv'::text)) OR ((tyyppi)::text = 'av'::text)) OR ((tyyppi)::text = 'rl'::text)))
);


--
-- TOC entry 34 (OID 110124)
-- Name: maali; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE maali FROM PUBLIC;
GRANT ALL ON TABLE maali TO "www-data";


--
-- TOC entry 35 (OID 110145)
-- Name: epaonnisrankku; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE epaonnisrankku (
    epaonnisrankkuid integer NOT NULL,
    tekija integer NOT NULL,
    tyyppi character varying DEFAULT 'no'::character varying NOT NULL,
    tyhjamaali boolean DEFAULT false NOT NULL,
    siirrangaikana boolean DEFAULT false NOT NULL,
    CONSTRAINT epaonnisrankku_tyyppi CHECK ((((((tyyppi)::text = 'no'::text) OR ((tyyppi)::text = 'yv'::text)) OR ((tyyppi)::text = 'av'::text)) OR ((tyyppi)::text = 'rl'::text)))
);


--
-- TOC entry 36 (OID 110162)
-- Name: rangaistus; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE rangaistus (
    rangaistusid integer NOT NULL,
    saaja integer NOT NULL,
    syy integer NOT NULL,
    minuutit integer NOT NULL,
    paattymisaika time without time zone,
    CONSTRAINT rangaistus_minuutit CHECK (((((minuutit = 2) OR (minuutit = 5)) OR (minuutit = 10)) OR (minuutit = 20)))
);


--
-- TOC entry 37 (OID 110162)
-- Name: rangaistus; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE rangaistus FROM PUBLIC;
GRANT ALL ON TABLE rangaistus TO "www-data";


--
-- TOC entry 38 (OID 110175)
-- Name: pelaajatilasto; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE pelaajatilasto (
    tilastoid serial NOT NULL,
    peliid integer NOT NULL,
    joukkue integer NOT NULL,
    pelaaja integer NOT NULL,
    plusmiinus integer DEFAULT 0 NOT NULL,
    numero integer DEFAULT 0 NOT NULL,
    kapteeni boolean DEFAULT false NOT NULL,
    maalivahti boolean DEFAULT false NOT NULL,
    kaptuloaika time without time zone,
    mvtuloaika time without time zone,
    peliaika time without time zone,
    torjunnat integer,
    paastetytmaalit integer,
    lisatieto text
);


--
-- TOC entry 39 (OID 110175)
-- Name: pelaajatilasto; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE pelaajatilasto FROM PUBLIC;
GRANT ALL ON TABLE pelaajatilasto TO "www-data";


--
-- TOC entry 40 (OID 110199)
-- Name: toimenkuva; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE toimenkuva (
    toimenkuva character varying(20) NOT NULL
);


--
-- TOC entry 41 (OID 110203)
-- Name: toimi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE toimi (
    tehtava character varying(20),
    kaudenjoukkue integer NOT NULL,
    kausi integer NOT NULL,
    henkilo integer NOT NULL
);


--
-- TOC entry 42 (OID 110203)
-- Name: toimi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE toimi FROM PUBLIC;
GRANT ALL ON TABLE toimi TO "www-data";


--
-- TOC entry 43 (OID 110215)
-- Name: osallistuja; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE osallistuja (
    tapahtumaid integer NOT NULL,
    osallistuja integer NOT NULL,
    paasee boolean NOT NULL,
    selite text
);


--
-- TOC entry 44 (OID 110215)
-- Name: osallistuja; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE osallistuja FROM PUBLIC;
GRANT ALL ON TABLE osallistuja TO "www-data";


--
-- TOC entry 45 (OID 110230)
-- Name: pelaajat; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE pelaajat (
    joukkue integer NOT NULL,
    kausi integer NOT NULL,
    pelaaja integer NOT NULL,
    pelinumero integer,
    pelipaikka character varying(2),
    kapteeni boolean DEFAULT false,
    aloituspvm date,
    lopetuspvm date,
    CONSTRAINT pelaajat_lopetuspvm CHECK ((aloituspvm < lopetuspvm)),
    CONSTRAINT pelaajat_pelipaikka CHECK ((((((((pelipaikka)::text = 'VL'::text) OR ((pelipaikka)::text = 'OL'::text)) OR ((pelipaikka)::text = 'KE'::text)) OR ((pelipaikka)::text = 'PU'::text)) OR ((pelipaikka)::text = 'MV'::text)) OR ((pelipaikka)::text = NULL::text)))
);


--
-- TOC entry 46 (OID 110230)
-- Name: pelaajat; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE pelaajat FROM PUBLIC;
GRANT ALL ON TABLE pelaajat TO "www-data";


--
-- TOC entry 47 (OID 110245)
-- Name: sarjanjoukkueet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE sarjanjoukkueet (
    sarjaid integer NOT NULL,
    joukkue integer NOT NULL,
    kausi integer NOT NULL
);


--
-- TOC entry 48 (OID 110245)
-- Name: sarjanjoukkueet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE sarjanjoukkueet FROM PUBLIC;
GRANT ALL ON TABLE sarjanjoukkueet TO "www-data";


--
-- TOC entry 49 (OID 110263)
-- Name: uutinen; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE uutinen (
    uutinenid serial NOT NULL,
    pvm date NOT NULL,
    ilmoittaja character varying(80) NOT NULL,
    otsikko character varying(100) NOT NULL,
    uutinen text NOT NULL
);


--
-- TOC entry 50 (OID 110263)
-- Name: uutinen; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE uutinen FROM PUBLIC;
GRANT ALL ON TABLE uutinen TO "www-data";


--
-- TOC entry 51 (OID 110271)
-- Name: kayttajat; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE kayttajat (
    tunnus character varying(16) NOT NULL,
    salasana character varying(255),
    henkilo integer
);


--
-- TOC entry 52 (OID 110271)
-- Name: kayttajat; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE kayttajat FROM PUBLIC;
GRANT ALL ON TABLE kayttajat TO "www-data";


--
-- TOC entry 53 (OID 110279)
-- Name: yllapitooikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE yllapitooikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 54 (OID 110279)
-- Name: yllapitooikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE yllapitooikeudet FROM PUBLIC;
GRANT ALL ON TABLE yllapitooikeudet TO "www-data";


--
-- TOC entry 55 (OID 110287)
-- Name: lisaamuokkaaoikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE lisaamuokkaaoikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 56 (OID 110287)
-- Name: lisaamuokkaaoikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE lisaamuokkaaoikeudet FROM PUBLIC;
GRANT ALL ON TABLE lisaamuokkaaoikeudet TO "www-data";


--
-- TOC entry 57 (OID 110295)
-- Name: joukkueenalueoikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE joukkueenalueoikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 58 (OID 110295)
-- Name: joukkueenalueoikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE joukkueenalueoikeudet FROM PUBLIC;
GRANT ALL ON TABLE joukkueenalueoikeudet TO "www-data";


--
-- TOC entry 59 (OID 110303)
-- Name: omattiedotoikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE omattiedotoikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 60 (OID 110303)
-- Name: omattiedotoikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE omattiedotoikeudet FROM PUBLIC;
GRANT ALL ON TABLE omattiedotoikeudet TO "www-data";


--
-- Data for TOC entry 100 (OID 109896)
-- Name: yhteystieto; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY yhteystieto (yhtietoid, puhelinnumero, faxi, email, katuosoite, postinumero, postitoimipaikka, maa, selite) FROM stdin;
1036	0504839705	\N	jarno.jokinen@gmail.com	Vasaratie 20 B 16	33710	Tampere	Suomi	\N
2	03 3561 733	03 3561 734	toimisto@spiral-salit.fi	Juvankatu 16	33710	Tampere	Suomi	\N
1012	040-7369942	\N	\N	\N	\N	Tampere	Suomi	\N
1016	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1004	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1027	040-5520798	\N	\N	\N	\N	Tampere	Suomi	\N
1029	040-8210725	\N	antti.paukkio@gmail.com	\N	\N	Tampere	Suomi	\N
1033	044-7047717	\N	sami.peiponen@elisanet.fi	\N	\N	Tampere	Suomi	\N
1010	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1006	040-7177317	\N	\N	\N	\N	Tampere	Suomi	\N
1035	044 534 8913	\N	heikki.korhonen@uta.fi	Pellervonkatu 9 A306	33540	Tampere	Suomi	\N
1024	040-0968072	\N	\N	\N	\N	Tampere	Suomi	\N
1025	040-8390388	\N	jussi.innanen@salibandy.koovee.fi	Opiskelijankatu 19 B 29	33720	Tampere	Suomi	\N
1020	\N	\N	\N	Kääjäntie 4	\N	Orivesi	Suomi	\N
1015	+358 400 983 450	\N	kaartine@cs.tut.fi	Tumppi 3 D 114	33720	Tampere	Suomi	\N
1001	\N	\N	matti.haapaniemi@tut.fi	\N	\N	Tampere	Suomi	\N
1019	03 254 4100	03 3126 2511	areena@metroautoareena.fi	Jäähallinraitti 3	33501	Tampere	Suomi	\N
1	+358 40 5419552	\N	jukka.kaartinen@tut.fi	Tumppi 3 D 114	33720	Tampere	Suomi	Kotiosoite
1038	040 771 5778	\N	kai.vallaskangas@piramk.fi	\N	\N	\N	Suomi	\N
1023	03 3115 2797	\N	\N	Korkeakoulunkatu 12	33720	Tampere	Suomi	\N
1011	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1032	\N	\N	petteri.hiltunen@uta.fi	\N	\N	\N	Suomi	\N
1013	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1018	(03) 542 0410	(03) 542 0415	\N	Köyvärintie 3	37800	Tampere	Suomi	\N
1022	\N	\N	\N	\N	\N	Vilppula	Suomi	\N
1021	\N	\N	\N	Teerivuorenkatu	\N	Tampere	Suomi	\N
1008	\N	\N	pasik69@gmx.de	\N	\N	Tampere	Suomi	\N
1037	\N	\N	\N	\N	\N	Parkano	Suomi	\N
1003	040-5681890	\N	\N	\N	\N	\N	Suomi	\N
1007	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1014	040-5799004	\N	\N	\N	\N	Tampere	Suomi	\N
1026	040-7073304	\N	jani.singh@cs.tamk.fi	Hatanpään Valtatie 12	33100	Tampere	Suomi	\N
1009	\N	\N	jarnomus@dnainternet.net	\N	\N	Tampere	Suomi	\N
1028	040-7153624	\N	janim@saunalahti.fi	Parkanonkatu 4 E 63	33720	Tampere	Suomi	\N
1005	040-5664972	\N	\N	\N	\N	Tampere	Suomi	\N
1017	\N	\N	lauri.yli-huhtala@tut.fi	\N	\N	Tampere	Suomi	\N
1002	040-7396316	\N	teemu.siitarinen@tut.fi	Sammonkatu 23 F 95	33540	Tampere	Suomi	\N
1031	040-5424194	\N	aapo.repo@me.tamk.fi	Tahmelankatu 3	33240	tampere	Suomi	\N
1030	040-7515818	\N	lauri_oksanen@hotmail.com	\N	\N	Tampere	Suomi	\N
1034	044-7047717	\N	sami.peiponen@elisanet.fi	\N	\N	Tampere	Suomi	\N
\.


--
-- Data for TOC entry 101 (OID 109905)
-- Name: henkilo; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY henkilo (hloid, yhtieto, etunimi, sukunimi, syntymaaika, paino, pituus, kuva, kuvaus, lempinimi) FROM stdin;
1061	\N	Juha	Halme	\N	\N	\N	\N	\N	\N
1062	\N	Otto-Ville	Riikilä	\N	\N	\N	\N	\N	\N
1072	1036	Jarno	Jokinen	\N	72000	184	kuvat/henkilo/Jokinen_Jarno_1072.jpg	Joukkueen toinen nestori Becks-tukalla	JAska
1001	\N	Mikko	Koskinen	\N	\N	\N	\N	\N	\N
1002	\N	Heikki	Vaittinen	\N	\N	\N	\N	\N	\N
1003	\N	Mikko	Immonen	\N	\N	\N	\N	\N	\N
1004	\N	Markus	Lintula	\N	\N	\N	\N	\N	\N
1005	\N	Kimmo	Kiprianoff	\N	\N	\N	\N	\N	\N
1006	\N	Tomi	Matilainen	\N	\N	\N	\N	\N	\N
1007	\N	Teemu	Aronen	\N	\N	\N	\N	\N	\N
1008	\N	Juha	Siekkinen	\N	\N	\N	\N	\N	\N
1009	\N	Marko	Lintula	\N	\N	\N	\N	\N	\N
1010	\N	Tommi	Liedes	\N	\N	\N	\N	\N	\N
1017	1005	Kari	Mäkinen	\N	\N	\N	kuvat/henkilo/M_kinen_Kari_1017.jpg	&quot;KooVee 2:n Legenda&quot;	\N
1012	\N	Juha	Mähönen	\N	\N	\N	\N	\N	\N
1013	\N	Niko	Aronen	\N	\N	\N	\N	\N	\N
1064	\N	Heikki	Mikkonen	\N	\N	\N	\N	\N	\N
1028	1016	Teemu	Lahtela	1978-04-02	80000	184	\N	\N	tepe
1016	1004	Jaakko	Hiltunen	\N	\N	\N	\N	\N	Veli-Pekka
1027	1015	Jukka	Kaartinen	1980-06-18	80000	178	kuvat/henkilo/Kaartinen_Jukka_1027.gif	&quot;Puuha-Pete&quot; taitaa parhaiten saunailtojen järjestämisen- joten on joukkueen arvokkain pelaaja.	Jukkis
1018	1006	Jaakko	Ailio	\N	\N	\N	\N	Jalkapalloilija Marco Di Vaion näköisyyttä ja ailahtelevuutta.	\N
1029	1017	Lauri	Yli-Huhtala	\N	\N	\N	\N	Omaa kovan kudin, jos vaan joskus pääsisi ampumaan.	Late
1	1	Jukka	Kaartinen(WebAdmin)	1980-06-18	78000	178	\N	\N	Jukkis
1022	1010	Timo	Lautamatti	\N	\N	\N	\N	\N	Timppa
1014	1002	Teemu	Siitarinen	1979-01-08	82000	192	kuvat/henkilo/Siitarinen_Teemu_1014.jpg	Pitkän huiskea lentopalloilija..?	Teme
2	\N	Teemu	WebAdmin	\N	\N	\N	\N	\N	\N
1048	\N	Antti-Jussi	Kaukonen	\N	\N	\N	\N	\N	\N
1046	1031	Aapo	Repo	\N	\N	\N	\N	\N	\N
1047	1030	Lauri	Oksanen	\N	\N	\N	kuvat/henkilo/Oksanen_Lauri_1047.jpg	&quot;Yhden käden syötön- isä&quot;	Oka
1041	1034	Sami	Peiponen	\N	\N	\N	\N	Joukkueen nestori veskari.	Peipo
1030	\N	Tuomas	Männistö	\N	\N	\N	\N	\N	\N
1031	\N	Jarkko	Ahomaa	\N	\N	\N	\N	\N	\N
1032	\N	Sami	Hänninen	\N	\N	\N	\N	\N	\N
1033	\N	Lauri	Pörhönen	\N	\N	\N	\N	\N	\N
1034	\N	Timo	Saros	\N	\N	\N	\N	\N	\N
1035	\N	Antti	Huuskonen	\N	\N	\N	\N	\N	\N
1036	\N	Jussi	Pietilä	\N	\N	\N	\N	\N	\N
1037	\N	Olli	Kukkamäki	\N	\N	\N	\N	\N	\N
1038	\N	Joni	Kiiskinen	\N	\N	\N	\N	\N	\N
1039	\N	Jari-Pekka	Koljus	\N	\N	\N	\N	\N	\N
1040	\N	Kalle	Tamminen	\N	\N	\N	\N	\N	\N
1011	1001	Matti	Haapaniemi	\N	\N	\N	\N	\N	Masa
1042	\N	Juha	Mustamo	\N	\N	\N	\N	\N	\N
1043	\N	Kari	Ahonjoki	\N	\N	\N	\N	\N	\N
1044	\N	Jan	Nigman	\N	\N	\N	\N	\N	\N
1045	\N	Niko	Suoranta	\N	\N	\N	\N	\N	\N
1024	1012	Johannes	Järvinen	1979-05-14	115000	190	\N	Joukkueen iso mies Isolla I:llä kaukalossa ja sen ulkopuolella.	Jay Jay
1066	1027	Juuso	Koivisto	\N	\N	\N	\N	Nuoruuden innolla pitää palloa, muttei siitä luovu.	Juuso
1049	\N	Vill	Rönn	\N	\N	\N	\N	\N	\N
1050	\N	Tuukka	Rantanen	\N	\N	\N	\N	\N	\N
1051	\N	Mikko	Korhonen	\N	\N	\N	\N	\N	\N
1074	1035	Heikki	Korhonen	1981-03-03	\N	\N	\N	Hämeenlinnan lahja KooVee 2:lle.	Kosti
1052	\N	Olli	Aaltonen	\N	\N	\N	\N	\N	\N
1053	\N	Simo	Ruponen	\N	\N	\N	\N	\N	\N
1054	\N	Mika	Pykälistö	\N	\N	\N	\N	\N	\N
1055	\N	Kimmo	Suominen	\N	\N	\N	\N	\N	\N
1056	\N	Jussi	Vainio	\N	\N	\N	\N	\N	\N
1057	\N	Jani	Kallio	\N	\N	\N	\N	\N	\N
1058	\N	Lauri	Pihlajasalo	\N	\N	\N	\N	\N	\N
1059	\N	Jan Kristian	Lahti	\N	\N	\N	\N	\N	\N
1060	\N	Aapo	Peltonen	\N	\N	\N	\N	\N	\N
1023	1011	Timo	Ruohonen	\N	\N	\N	kuvat/henkilo/Ruohonen_Timo_1023.jpg	\N	\N
1071	1032	Petteri	Hiltunen	\N	\N	\N	\N	\N	\N
1020	1008	Pasi	Kautiala	\N	\N	\N	\N	\N	\N
1025	1013	Juha	Kurki	\N	\N	\N	kuvat/henkilo/Kurki_Juha_1025.jpg	\N	\N
1068	1029	Antti	Paukkio	1981-05-11	78000	183	kuvat/henkilo/Paukkio_Antti_1068.jpg	&quot;Ei oo häpee olla nopee&quot;.	Antzas
1070	1024	Jussi	Pättiniemi	\N	\N	\N	\N	\N	\N
1015	1003	Pekka	Hiltunen	\N	\N	\N	\N	\N	Pekkis
1065	1025	Jussi	Innanen	1982-05-06	78000	181	kuvat/henkilo/Innanen_Jussi_1065.jpg	Harvoin näkee juoksemassa, ellei ole palloa itsellään.	Jute, Zasi
1075	1038	Kai	Vallaskangas	\N	\N	\N	\N	\N	\N
1019	1007	Ilari	Lehtinen	1979-12-09	76660	177	\N	\N	\N
1026	1014	Juha	Kaartinen	1982-01-12	90000	185	\N	&quot;KooVee 2:sen 50 Cent&quot;, jos on käsivarsiin katsomista. Koko kauden 06-07 vaihdossa Meksikossa.	Lämmi
1069	1026	Jani	Singh	1982-06-23	80000	180	kuvat/henkilo/Singh_Jani_1069.jpg	Uskomaton liike ja se lähtönopeus...	Singi, Joe Sakic
1063	\N	Samu	Löövi	\N	\N	\N	\N	\N	\N
1021	1009	Jarno	Mustonen	\N	\N	\N	kuvat/henkilo/Mustonen_Jarno_1021.jpg	Näkymätön mutta yllättävä surffari.	\N
1067	1028	Jani	Myllynen	1982-03-19	95000	184	kuvat/henkilo/Myllynen_Jani_1067.jpg	&quot;Hervannan iso vaalee Jallu Rantanen&quot; taitaa maalinteon ellei satu olemaan kebabilla.	Myllyne
\.


--
-- Data for TOC entry 102 (OID 109917)
-- Name: pelaaja; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY pelaaja (pelaajaid, katisyys, maila) FROM stdin;
1001	L	\N
1002	L	\N
1003	L	\N
1004	L	\N
1005	L	\N
1006	L	\N
1007	L	\N
1008	L	\N
1009	L	\N
1010	L	\N
1072	L	Exel
1012	L	\N
1013	L	\N
1015	L	\N
1016	L	\N
1048	L	\N
1028	L	Fat Pipe Wabor
1024	L	Fatpipe Raw
1025	L	\N
1022	L	\N
1066	L	Exel Edge 2.5
2	L	\N
1068	L	\N
1018	L	\N
1061	L	\N
1	L	\N
1074	L	\N
1030	L	\N
1031	L	\N
1032	L	\N
1033	L	\N
1034	L	\N
1035	L	\N
1036	L	\N
1037	L	\N
1038	L	\N
1039	L	\N
1040	L	\N
1065	R	Exel Edge 2.3
1042	L	\N
1043	L	\N
1044	L	\N
1045	L	Excel
1075	E	\N
1027	L	Fat Pipe Wiz
1049	L	\N
1050	L	\N
1051	L	\N
1062	L	\N
1052	L	\N
1053	L	\N
1054	L	\N
1055	L	\N
1056	L	\N
1057	L	\N
1058	L	\N
1059	L	\N
1060	L	\N
1071	E	\N
1064	L	\N
1011	L	\N
1023	L	\N
1070	L	\N
1020	L	\N
1019	L	Exel
1026	L	Hand of Doom2 25
1069	L	Fat Pipe Wiz
1063	L	\N
1021	R	Fat Pipe
1067	L	Exel Edge 2.3
1017	L	\N
1029	L	Fat Pipe Wiz
1014	L	Fat Pipe Wabor
1046	L	\N
1047	L	Fat Pipe
1041	L	\N
\.


--
-- Data for TOC entry 103 (OID 109926)
-- Name: tyyppi; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY tyyppi (tyyppi) FROM stdin;
harjoitus
peli
talkoot
Saunailta
muu
\.


--
-- Data for TOC entry 104 (OID 109932)
-- Name: tapahtuma; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY tapahtuma (tapahtumaid, vastuuhlo, tyyppi, paikka, paiva, aika, kuvaus) FROM stdin;
1051	\N	harjoitus	Kaukajärvi	2005-05-12	18:00:00	\N
1147	\N	harjoitus	Kaukajärvi	2006-03-30	18:00:00	SB NMP-peliin valmistavat treenit:\r\n-alkulämpö: sveitsiläinen\r\n-puolen tai koko kentän 2vs.2 (3vs.3)\r\n-keskialueen ruotsalainen\r\n-yv\r\n-pienpeliä tai viisikoittain 5vs.5
1010	\N	peli	\N	2004-10-09	13:00:00	\N
1012	\N	peli	\N	2005-01-16	13:00:00	\N
1015	\N	peli	\N	2005-02-06	16:00:00	\N
1016	\N	peli	\N	2005-01-22	13:00:00	\N
1017	\N	peli	\N	2005-02-12	13:00:00	\N
1018	\N	peli	\N	2005-03-12	15:00:00	\N
1019	\N	peli	\N	2005-02-27	15:00:00	\N
1022	\N	peli	\N	2004-12-19	15:00:00	\N
1023	\N	peli	\N	2004-11-06	13:00:00	\N
1026	\N	peli	\N	2004-10-31	16:00:00	\N
1027	\N	peli	\N	2004-02-15	14:00:00	\N
1028	\N	peli	\N	2004-02-21	10:00:00	\N
1029	\N	peli	\N	2004-12-04	15:00:00	\N
1025	\N	peli	\N	2004-12-11	13:00:00	\N
1020	\N	peli	\N	2005-03-19	13:00:00	\N
1031	\N	peli	\N	2004-03-13	13:00:00	\N
1032	\N	peli	\N	2004-03-14	13:00:00	\N
1033	\N	peli	\N	2004-04-03	11:00:00	\N
1034	\N	peli	\N	2004-02-28	11:00:00	\N
1035	\N	peli	\N	2003-10-25	16:00:00	\N
1036	\N	peli	\N	2003-11-23	13:00:00	\N
1037	\N	peli	\N	2003-11-09	11:00:00	\N
1038	\N	peli	\N	2003-10-25	11:30:00	\N
1039	\N	peli	\N	2003-11-29	09:30:00	\N
1040	\N	peli	\N	2003-11-08	10:30:00	\N
1041	\N	peli	\N	2003-09-28	10:00:00	\N
1042	\N	peli	\N	2003-09-27	15:00:00	\N
1043	\N	peli	\N	2004-01-04	12:00:00	\N
1044	\N	peli	\N	2004-01-04	17:00:00	\N
1045	\N	peli	\N	2004-01-24	12:00:00	\N
1046	\N	peli	\N	2004-01-25	12:00:00	\N
1030	\N	peli	\N	2004-09-04	14:00:00	\N
1047	\N	peli	\N	2004-09-04	17:00:00	\N
1048	\N	peli	\N	2005-04-02	15:00:00	\N
1142	\N	peli	Rahola	2006-04-09	16:15:00	5.div YLS KooVee 2 - SC Inter
1011	\N	peli	\N	2004-10-03	11:00:00	\N
1162	\N	harjoitus	Kaukajärvi	2006-06-29	18:00:00	salibandy\r\n-alkuverryttely\r\n- pienpeliä tai koko kentällä
1021	\N	peli	\N	2004-10-16	12:00:00	\N
1053	\N	peli	\N	2004-09-04	11:00:00	\N
1054	\N	peli	Forssa	2004-09-18	12:00:00	\N
1055	\N	peli	Forssa	2004-09-18	15:00:00	\N
1148	\N	harjoitus	Kaukajärvi	2006-04-06	18:00:00	SC Inter-matsiin valmistavat treenit:\r\n- alkuverryttely: ristikkäislaidoista lähtevä-kuljetus-seinäsyöttö-veto\r\n- koko kentän 2vs.2/3vs.3\r\n- ylivoiman harjoittelua koko kentällä (5vs.4, 5vs.3 ja 6 pelaajalla ilman mv:tä)\r\n- pienpeliä 3vs.3 tai isolla kentällä 5vs.5
1150	\N	harjoitus	Kaukajärvi	2006-04-20	18:00:00	nousukarsinta-peliin valmistavat treenit:\r\n- alkuverryttely: ruotsalainen - 2vs.0 - 2vs-1\r\n- keskialueen ruotsalainen\r\n- Erikoistilanteet: yv, vaparit, sisäänlyönnit +rankkarit\r\n- viisikoittain peliä
1058	\N	harjoitus	Kaujajärvi	2005-06-09	18:00:00	\N
1059	\N	harjoitus	Kaukajärvi, Spiral-salit	2005-06-16	18:00:00	\N
1060	\N	harjoitus	Kaukajärvi, Spiral-salit	2005-06-23	18:00:00	\N
1064	\N	harjoitus	Kaukajärvi	2005-07-21	18:00:00	\N
1061	\N	harjoitus	Kaukajärvi	2005-06-30	18:00:00	\N
1062	\N	harjoitus	Kaukajärvi	2005-07-07	18:00:00	\N
1063	\N	harjoitus	Spiral-salit kaukajärvi	2005-07-14	18:00:00	\N
1065	\N	harjoitus	Kaukajärvi	2005-07-28	18:00:00	\N
1066	\N	harjoitus	Kaukajärvi	2005-08-04	18:00:00	\N
1067	\N	harjoitus	Kaukajärvi	2005-08-11	18:00:00	\N
1068	\N	harjoitus	Kaukajärvi	2005-08-18	18:00:00	\N
1154	\N	peli	Kaukajärvi	2006-04-22	10:00:00	Karsinta-peli 4.divariin\r\n\r\n10.00 KooVee 2 - TFT\r\n(Kaukajärvelle paikalle viimeistään klo 9.45)
1069	\N	peli	Kaukajärvi	2005-08-25	18:00:00	Harjoituspeli Pälkäneen Lukkoa vastaan.
1229	\N	peli	Kaukajärvi	2006-10-19	18:00:00	Harj.peli Classic 3 (3.div) vastaan
1074	\N	peli	\N	2005-09-25	12:00:00	Kauden ensimmäinen 5.div ottelu Sc Nemesistä vastaan
1083	\N	harjoitus	Peltolammin koulu	2005-10-03	20:00:00	Luvassa kovaa reeniä koville jätkille.
1075	\N	harjoitus	Peltolammin koulu	2005-09-12	20:00:00	2vs.2/3vs.3/4vs.4 \\\\\\&quot;höntsyä\\\\\\&quot;. Koripallo, sisä-fudis tai käsipallo lisänä.
1076	\N	harjoitus	Kaukajärvi	2005-09-15	18:00:00	Yv-viisikoiden, avauspelin- ja karvauspelin harjoittelua.\r\n5v.5 viisikoittain peliä.
1077	\N	harjoitus	Peltolammin koulu	2005-09-19	20:00:00	Perus pienpelit ja oheislajit määrästä riippuen.
1081	\N	harjoitus	Peltolammin koulu	2005-09-26	20:00:00	Pienpeli-höntsyt 2vs.2, 3vs.3.
1084	\N	harjoitus	Kaukajärvi	2005-10-06	18:00:00	Harjoitukset: \r\n- alkuverryttely\r\n- 2vs.2 puolella tai koko kentällä\r\n- vetoharjoitteita\r\n- pienpeliä 3vs.3\r\n- ylivoima\r\n- viisikoittain 5vs.5 peliä
1073	\N	peli	Kaukajärvi	2005-09-08	18:00:00	Kauden toinen harjoituspeli Sc Interiä(5.div)vastaan.\r\n(Ennen ottelua pukukopissa kapteenin valinta tulevalle kaudelle)
1078	\N	peli	Kaukajärvi	2005-09-22	18:00:00	HARJ.PELI PERUTTU KU-68:N PUOLESTA! \r\n\r\nKooVee 2:lla normaalit/ 5.div peliin valmistavat treenit!
1082	\N	harjoitus	Kaukajärvi	2005-09-29	18:00:00	Lauantain (1.10) FBC Nokia-otteluun valmistavat harjoitukset (viisikkopeli: avaus, karvaus, vaparit jne.)+ yv
1079	\N	peli	Rahola	2005-10-01	10:00:00	5.divari FBC Nokia - Koovee 2
1080	\N	peli	Raholan Liikuntakeskus	2005-10-08	13:00:00	KooVee 2 vastuujoukkueena klo 10-14 (toimitsija-hommia 4 ottelua)\r\n 5.div: KooVee 2 - AWE
1085	\N	harjoitus	Peltolammin koulu	2005-10-10	20:00:00	pienpeliä ja reeniä
1086	\N	harjoitus	Kaukajärvi	2005-10-13	18:00:00	Lauantain 15.10 5.div: V&amp;L-peliin valmistavat harkat
1089	\N	peli	Rahola	2005-10-29	12:00:00	5.divisioonan ottelu SC Lättyä vastaan
1088	\N	peli	Rahola	2005-10-23	10:00:00	5.div-peli KoSByä vastaan
1087	\N	peli	Rahola	2005-10-15	13:00:00	5.divari-ottelu Tottijärven V&amp;L- vastaan
1090	\N	peli	Rahola	2005-11-06	10:00:00	10.00 Raholassa 5.div peli ManPo-KooVee 2
1143	\N	harjoitus	Kaukajärvi	2006-03-02	18:00:00	Pelitreenit alkuverryttelyn kera
1094	\N	harjoitus	Peltolammin koulu	2005-10-24	20:00:00	Höntsypelit tai jotain treeniä
1092	\N	harjoitus	Peltolammin koulu	2005-10-17	20:00:00	\\&quot;Legendaariset höntsyt legendaarisilla miehillä\\&quot;
1093	\N	harjoitus	Kaukajärvi	2005-10-20	18:00:00	Sunnuntain KoSBy-peliin valmistavat harjoitukset: \r\n-alkuverryttely: sveitsiläinen, mato jne.\r\n-2vs.2 koko- tai puolikentällä\r\n-keskialueen ruotsalainen (seinäsyöttäjällä)\r\n-2vs.1 keskialueelta lähtevä\r\n-vaparikuviot ja sisäänlyönnit viisikoittain\r\n-yv ja av (+6)\r\n-viisikkopeliä 5vs.5
1100	\N	peli	Kaukajärvi	2005-11-03	18:00:00	Harjoitusottelu PäLua(4.div) vastaan Kauksun 4-kentällä klo 18.00
1095	\N	harjoitus	Kaukajärvi	2005-10-27	18:00:00	SCL-peliin valmistavat treenit: \r\n-Alkuverryttely: syöttömylly, mato, sveitsiläinen\r\n- koko- tai puolen kentän 2vs.2/3vs.3\r\n-yv ja av\r\n-vaparikuviot\r\n-avaus- ja karvauspeliä\r\n\r\n PS. Toinen maalivahti tulee reeneihimme kokeilemaan harj.veskariksi ?!
1102	\N	harjoitus	Kaukajärvi	2005-11-10	18:00:00	-alkuverryttely\r\n- 2vs.2/3vs.3 koko kentällä\r\n- &quot;pelailua&quot;\r\n\r\n (Paikalle tulee harjoitusveskariksi Erkka Javanainen eli kaksi maalivahtia tulee treeneihin!)
1096	\N	harjoitus	Peltolammin koulu	2005-10-31	20:00:00	&quot;Peltsun pelit&quot;
1091	\N	muu	Rahola	2005-10-25	17:35:00	Koovee-salibandyjoukkueiden valokuvaukset Raholan liikuntakeskuksessa ja kuvaus aloitetaan klo 17.35 joten ajoissa paikalle. Tarkemmat tiedot myöhemmin.
1103	\N	Saunailta	Kaupinkatu 19 asunto 15	2005-11-12	16:00:00	Koovee 2-joukkueen saunailta klo 16 alkaa Kaartisten vanhempien asunnossa Kaupinkatu 19 ja Asunto 15.
1099	\N	peli	Kaukajärvi	2005-09-03	18:00:00	Harjoituspeli PäLua vastaan klo 18.00 K-järvi 4
1097	\N	peli	Kaukajärvi	2005-09-03	18:00:00	Harj.peli PäLua vastaan klo 18.00 Kauksun 4-kentällä
1101	\N	harjoitus	Peltolammin koulu	2005-11-07	20:00:00	&quot;Peltsun hönyt&quot;
1111	\N	harjoitus	Peltolammin koulu	2005-11-14	20:00:00	Peltsun koulun pienimuotoiset höntsyt
1112	\N	harjoitus	Kaukajärvi 2-kenttä	2005-11-17	18:00:00	Sunnuntain SC Nemesis-peliin valmistavat harkat
1113	\N	harjoitus	Peltolammin koulu	2005-11-21	20:00:00	&quot;Peltsun hönyt&quot;
1114	\N	harjoitus	Kaukajärvi	2005-11-24	18:00:00	Sunnuntain FBC Nokia-otteluun valmistavat harjoitukset
1098	\N	harjoitus	Peltolammin koulu	2005-10-31	20:00:00	&quot;Peltsun pelit&quot;
1115	\N	harjoitus	Peltolammin koulu	2005-11-28	20:00:00	Legendaariset höntsyt
1118	\N	harjoitus	Kaukajärvi	2005-12-08	18:00:00	Sunnuntain 11.12 AWE-otteluun valmistavat treenit:\r\n- alkuverryttely: &quot;sveitsiläinen, mato, syöttömylly,\r\n- koko kentän 2vs.2/ 3vs.3\r\n- 2 X läpiajo tai 2 X laukaus\r\n- yv ja av-pelaaminen\r\n- viisikkopeliä ketjuittain (avauspeli: alakolmio ja pakki-pakki) (karvauspeli: 2-1-2, 2-2-1)
1104	\N	peli	Rahola	2005-11-20	12:00:00	5.div-peli SC Nemesistä vastaan
1105	\N	peli	Rahola	2005-11-27	10:00:00	10.00 KooVee 2 - FBC Nokia
1117	\N	harjoitus	Peltolammin koulu	2005-12-05	20:00:00	Kolmenneksi viimeiset &quot;Peltsun koulun höntsypelit&quot;
1125	\N	peli	Rahola	2005-12-18	13:00:00	Koovee 2:n vastuu-turnaus klo 10-14.00\r\nOma peli KooVee 2 - V&amp;L klo 13.00
1119	\N	harjoitus	Peltolammin Koulu	2005-12-12	20:00:00	Toiseksi viimeiset harjoitukset Peltolammilla
1108	\N	peli	Raholan Liikuntakeskus	2006-01-07	10:00:00	5.divarin alkusarjan kolmanneksi viimeinen ottelu: KoSBy-KooVee 2
1116	\N	harjoitus	Kaukajärvi	2005-12-01	18:00:00	alkulämpö, 2vs.2/3vs.3 koko kentällä, pienpeliä tai viisikkopeliä
1127	\N	harjoitus	Kaukajärvi	2006-01-12	18:00:00	5.divari-peliin KooVee 2- SCL valmistavat treenit:\r\n- alkuverryttely: &quot;sveitsiläinen&quot;\r\n- jatkuva 2vs.2 / 3vs.3\r\n- avauspeli/karvaus
1129	\N	harjoitus	Kaukajärvi	2006-01-26	18:00:00	-alkuverryttely\r\n- 3vs.3 pienpelinä tai koko kentällä\r\n- 5vs.5
1121	\N	harjoitus	Peltolammin koulu	2005-12-19	20:00:00	Viimeinen kerta Peltolammin koululla, vuoro loppuu tähän !!!
1122	\N	harjoitus	Kaukajärvi	2005-12-22	18:00:00	Vapaaehtoiset pelitreenit
1123	\N	harjoitus	Kaukajärvi	2005-12-29	18:00:00	Vapaaehtoiset pelitreenit
1110	\N	peli	\N	2006-01-21	13:00:00	5.divisioonan alkusarjan viimeinen ottelu: KooVee 2 - ManPo
1124	\N	peli	Rahola	2005-12-11	13:00:00	5.div peli AWEa vastaan
1138	\N	peli	Rahola	2006-02-25	15:15:00	Yjs-peli Raholassa SC Inter - KooVee 2
1144	\N	harjoitus	Kaukajärvi	2006-03-09	18:00:00	Yjs Dolphins-peliin valmistavat treenit:\r\n- alkuverryttely: mato\r\n- 2vs.2 puolella kentällä\r\n- päätypelaaminen 3v.2 tai 4vs.3\r\n- yv\r\n- 5vs.5
1120	\N	harjoitus	Kaukajärvi	2005-12-15	18:00:00	Sunnuntain vastuu-turnauksen V&amp;L-peliin valmistavat treenit:\r\n-alkuverryttely: &quot;sveitsiläinen&quot; tai syöttömylly&quot;\r\n- koko/puolen kentän 2vs.2/3vs.3\r\n- kulmasta lähtevä 2vs.1\r\n- keskialueen &quot;ruotsalainen&quot;\r\n- yv/av ja viisikoittain peliä
1126	\N	harjoitus	Kaukajärven Spiral-salit kenttä 2	2006-01-05	18:00:00	5.div-ottelu KoSBy-KooVee 2 valmistavat treenit: \r\n- alkuverryttely: &quot;sveitsiläinen&quot;\r\n- 2vs.2 / 3vs.3\r\n- kulmasta lähtevä 2vs.1\r\n- yv/av , 5vs.5 pelaamista
1131	\N	harjoitus	Kaukajärvi	2006-02-09	18:00:00	Viikonlopun YLS:n Dolphins ja SBMR-peleihin valmistavat treenit:\r\n- alkuverryttely: sveitsiläinen\r\n- laukaisutreeni\r\n- jatkuva 2vs.2 - 3vs.3\r\n- yv\r\n- 5vs.5 pelaaminen
1133	\N	harjoitus	Kaukajärvi	2006-02-23	18:00:00	SC Inter-peliin valmistavat harjoitukset:\r\n-alkuverryttely: syöttömylly\r\n- &quot;keskialueen ruotsalainen&quot;\r\n- yv/av\r\n- 5vs.5 peliä
1128	\N	harjoitus	Kaukajärvi	2006-01-19	18:00:00	Viimeiseen 5.div-alkusarjan ManPo-peliin valmistavat harjoitukset:\r\n-alkuverryttely: &quot;sveitsiläinen&quot; tai syöttömylly\r\n-&quot;keskialueen ruotsalainen&quot;\r\n- puolen kentän 2vs.2\r\n- 3vs.3 tai 5vs.5 peliä ketjuittain
1135	\N	peli	Rahola	2006-02-11	16:15:00	5.div YLS Dolphins-KooVee 2
1139	\N	peli	Rahola	2006-03-12	13:15:00	Yls:n 2.kierroksen ensimmäinen ottelu Dolphinsia vastaan
1137	\N	peli	\N	2006-02-19	16:15:00	KooVee 2:n vastuu turnaus klo 13.15 alkaen (4 peliä)\r\nOma peli 16.15 SB NMP:tä vastaan
1149	\N	harjoitus	Kaukajärven Spiral-salit	2006-04-13	18:00:00	Pelitreenit lämmittelyjen kanssa
1140	\N	peli	Rahola	2006-03-18	14:15:00	Yls SBMR-KooVee
1134	\N	peli	Tampere	2006-01-14	12:00:00	5.div KooVee 2-SCL
1151	\N	harjoitus	Kaukajärvi	2006-04-27	18:00:00	Vapaat höntsy pelitreenit
1146	\N	harjoitus	Kaukajärvi	2006-03-23	18:00:00	Pelitreenit alkulämmön jälkeen
1141	\N	peli	Rahola	2006-04-01	14:15:00	5.div YLS SB NMP - KOOVEE 2
1130	\N	harjoitus	Kaukajärvi	2006-02-02	18:00:00	\N
1136	\N	peli	Rahola	2006-02-12	14:15:00	5.div YLS KooVee 2- SBMR
1132	\N	harjoitus	Kaukajärvi	2006-02-16	18:00:00	SBNMP-peliin valmistavat treenit:\r\n-alkuverryttely: syöttömylly\r\n- puolen kentän 2vs.2\r\n- avauspelaaminen (pakki-pakki ja alakolmio) ja karvaus (1-2-2 ja 2-1-2/2-2-1)\r\n- yv\r\n- 5vs.5
1145	\N	harjoitus	Kaukajärvi	2006-03-16	18:00:00	SBMR-matsiin valmistavat treenit:
1285	\N	peli	\N	2006-11-11	12:00:00	\N
1201	\N	peli	\N	2006-11-10	19:00:00	Tampere-kakkonen: KoKo - KooVee 2
1175	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-07-31	19:30:00	Kesäharjoittelu:\r\n\r\n-alkuverryttely: lenkki ja venyttely\r\n-pelit: jalkapallo ja ultimate
1174	\N	harjoitus	Kaukajärvi	2006-07-27	18:00:00	-alkuverryttely\r\n-pienpeliä tai koko kentällä
1195	\N	harjoitus	Kaukajärvi	2006-08-03	18:00:00	-alkuverryttely\r\n-pienpeliä tai koko kentällä
1196	\N	harjoitus	Kaukajärven Spiral-salit	2006-08-10	18:00:00	-alkuverryttely:\r\n-harjoitteita\r\n-peliä
1176	\N	harjoitus	PERUTTU	2006-08-01	00:00:00	Viimeiset kesätreenit: PERUTTU  !!!!!\r\n\r\n- juoksuharjoitteet\r\n- kuntopiiri\r\n- pelit
1168	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-06-14	20:00:00	Kesätreenit:\r\n- alkuverryttely: lenkki + venyttely\r\n- pelit: jalkapallo\r\n \r\n EI OHJATTUNA !!!
1156	\N	harjoitus	Kaukajärvi	2006-05-04	18:00:00	pelailua
1165	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-07-05	20:00:00	Kesäharjoittelu  PERUTTU !!!\r\n\r\n- alkuverryttely\r\n- kimmoisuus\r\n- pelit
1225	\N	harjoitus	Kaukajärvi	2006-09-21	18:00:00	Lauantain ensimmäiseen 4.div-peliin TAMKOa vastaan valmistavat treenit:\r\n- alkuverryttely:\r\n- harjoitteita\r\n- yv\r\n- ketjuittain 5v.5 peliä
1198	\N	peli	Rahola	2006-09-29	19:00:00	Tamperesarja-2: KooVee 2 - Nokian KRP
1157	\N	harjoitus	Kaukajärvi	2006-05-11	18:00:00	höntsypeliä
1158	\N	harjoitus	Kaukajärvi	2006-05-25	18:00:00	höntsy pelitreenit
1159	\N	harjoitus	Kaukajärvi	2006-06-01	18:00:00	pelailua
1160	\N	harjoitus	Kaukajärvi	2006-06-15	18:00:00	salibandy: höntsypeliä \r\n\r\n EI OHJATTUNA !!!
1155	\N	muu	Kaukajärven Spiral-salit	2006-06-08	18:00:00	KooVee 2:n kauden 2006-07 aloituspalaveri\r\n- pelaajat\r\n- kesäharjoittelu\r\n- sarjat/peluutus\r\n- tavoitteet\r\n- hankinnat\r\n- toimintatavat\r\n- maksut\r\n- muut asiat ?
1199	\N	peli	\N	2006-10-13	19:00:00	Tamperesarja-2:n peli Classic XL - KooVee 2
1167	\N	harjoitus	Kalevan Uimahallin nurmi-alue	2006-06-12	19:30:00	Ensimmäiset kesätreenit:\r\n- alkuverryttely: lenkki + venyttely\r\n- lihaskuntopiiri\r\n- pelit: jalkapallo
1164	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-07-03	19:30:00	Kesäharjoittelu:\r\n\r\n- lenkki + venyttely\r\n- pelit: jalkapallo ja ultimate
1169	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-06-19	19:30:00	Kesäharjoittelu:\r\n\r\n- lenkki + venyttely\r\n- pelit: Jalkapallo
1161	\N	harjoitus	Kaukajärvi	2006-06-22	18:00:00	- alkuverryttely   PERUTTU !!!\r\n- Juoksuharjoitteet\r\n- pelit: sisäfudis, salibandy, käsipallo, ultimate
1170	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-06-26	19:30:00	Kesäharjoittelu:\r\n\r\n- lenkki + venyttely\r\n- pelit
1163	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-06-28	20:00:00	Kesäharjoittelu\r\n\r\n- lenkki + venyttely\r\n- juoksuharjoitteet \r\n- pelit
1180	\N	peli	\N	2006-10-15	11:00:00	4.div: Ilves 3 - Koovee 2
1226	\N	harjoitus	Kaukajärvi	2006-09-28	18:00:00	Perjantain (Tre2: KRP) ja lauantain (4.div: B) peleihin valmistavat harjoitukset:\r\n-alkuverryttely\r\n-laukaisuharjoitteita\r\n-yv \r\n-viisikkopeliä 5vs.5
1182	\N	peli	\N	2006-11-19	13:00:00	4.div: KooVee 2 - Punakone
1270	\N	peli	\N	2006-10-09	12:00:00	\N
1197	\N	peli	Rahola	2006-09-13	20:00:00	Kauden 06-07 ensimmäinen Tamperesarjan ottelu Raholassa: AWE-KooVee 2
1272	\N	peli	\N	2006-10-09	12:00:00	\N
1166	\N	harjoitus	Kaukajärvi	2006-07-06	18:00:00	salibandy\r\n-alkuverryttely\r\n- peliä\r\n- kuntopiiriä
1171	\N	harjoitus	Kaukajärvi	2006-07-13	18:00:00	VAPAAEHTOINEN SALIBANDY\r\n(Ensimmäinen huiliviikko kesäharjoittelusta!)
1172	\N	harjoitus	Kaukajärvi	2006-07-20	18:00:00	VAPAAEHTOINEN SALIBANDY\r\n(Toinen huiliviikko kesäharjoittelusta!)
1173	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-07-24	19:30:00	Kesäharjoittelu:\r\n\r\n- lenkki + venyttely\r\n- kimmoisuus\r\n- pelit
1228	\N	harjoitus	Kaukajärvi	2006-10-12	18:00:00	Classic XL (Tre2) ja Ilves 3 (4.div)-otteluihin valmistavat treenit:\r\n-alkiverryttely\r\n-maalinteko ja laukaisutreeniä\r\n-viisikoittain 5vs.5 peliä
1213	\N	harjoitus	Kaukajärvi	2006-08-31	18:00:00	Valmistavat treenit lauantain Punakone-turnaukseen:
1274	\N	peli	\N	2006-10-09	12:00:00	\N
1276	\N	peli	\N	2006-10-09	12:00:00	\N
1187	\N	peli	\N	2007-01-06	11:00:00	\N
1188	\N	peli	\N	2007-01-20	10:00:00	\N
1189	\N	peli	\N	2007-02-03	10:00:00	\N
1190	\N	peli	\N	2007-02-10	13:00:00	\N
1191	\N	peli	\N	2007-02-17	11:00:00	\N
1192	\N	peli	\N	2007-03-03	13:00:00	\N
1193	\N	peli	\N	2007-03-10	13:00:00	KooVee 2:n Vastuu-turnaus klo 10-14
1215	\N	harjoitus	Pirkkahalli	2006-10-31	21:00:00	\N
1231	\N	harjoitus	Kaukajärvi	2006-11-02	18:00:00	4.divarin KoKo-peliin valmistavat harjoitukset:\r\n-alkuverryttely: mato\r\n-harjoitteita\r\n-yv\r\n-viisikoittain peliä
1049	\N	harjoitus	Kaukajärvi Spiral-halli	2005-05-05	18:00:00	\N
1057	\N	harjoitus	Kaukajärvi (Spiral-salit)	2005-06-02	18:00:00	\N
1181	\N	peli	\N	2006-11-05	13:00:00	4.div: KooVee 2 - KoKo
1052	\N	harjoitus	Kaukajärvi, Spiral-salit	2005-05-19	18:00:00	\N
1050	\N	Saunailta	Ilarilla (Tiilikatu 13)	2005-05-14	18:30:00	\N
1056	\N	harjoitus	Kaukajärvi	2005-05-26	18:00:00	\N
1070	\N	harjoitus	Peltolammin koulu	2005-08-29	20:00:00	Peltolammin Koulun liikuntasalissa pienimuotoisia harjoituksia ja pienpeliä.
1071	\N	harjoitus	Kaukajärvi	2005-09-01	18:00:00	Ylivoiman ja alivoiman harjoittelua ja viisikoittain peliä
1072	\N	harjoitus	Peltolammin koulu	2005-09-05	20:00:00	Pienpeliä 2vs.2/ 3vs.3. Oheislajeina sisä-fudis ja koripallo
1278	\N	peli	\N	2006-10-09	12:00:00	\N
1280	\N	peli	\N	2006-10-09	12:00:00	\N
1205	\N	peli	\N	2007-01-12	20:00:00	\N
1282	\N	peli	\N	2006-10-09	12:00:00	\N
1211	\N	muu	Kaukajärven Spiral-salit	2006-09-02	10:00:00	Punakoneen 10-vuotis Juhlaturnaus:\r\n10.00 Punakone\r\n11.30 SB Luja\r\n13.45 SFC\r\n15.15 IRA\r\n\r\n16.15 Mahdollinen finaali tai pronssipeli\r\n\r\nHUOM!\r\nKOO-VEE Salibandyjoukkueiden kuvaukset Kaukajärvellä: Miesten Kakkonen klo 15.10 !!!!!!
1207	\N	peli	\N	2007-02-07	20:00:00	\N
1209	\N	peli	\N	2007-03-07	20:00:00	\N
1240	\N	harjoitus	Kalevan Uimahallin nurmialue	2006-08-21	19:30:00	Ulkoharjoitukset:\r\n-lenkki ja venyttely\r\n-jalkapallo tai ultimate
1241	\N	harjoitus	Kaukajärvi	2006-08-24	18:00:00	alkuverryttely:\r\nharjoitteet:\r\nviisikkopelaaminen 5vs.5 tai pienpelaaminen 3vs.3
1212	\N	harjoitus	Kaukajärvi	2006-08-17	18:00:00	alkuverryttely: \r\nharjoitteet:\r\npeliä: 5vs.5 viisikoittain
1223	\N	peli	Kaukajärvi	2006-09-07	18:00:00	Harjoituspeli KooVee 2 - KooVee B-89
1244	\N	peli	\N	2006-09-01	12:00:00	\N
1245	\N	peli	\N	2006-09-01	12:00:00	\N
1246	\N	peli	\N	2006-09-01	12:00:00	\N
1269	\N	harjoitus	Pirkkahalli	2006-11-14	21:00:00	\N
1271	\N	peli	\N	2006-10-09	12:00:00	\N
1233	\N	harjoitus	Kaukajärvi	2006-11-16	18:00:00	4.divarin Punakone-peliin valmistavat harjoitukset:\r\n\r\n-alkuverryttely:\r\n-kevyt harjoite\r\n-yv ja av\r\n-viisikoittain 5vs.5-peliä
1275	\N	peli	\N	2006-10-09	12:00:00	\N
1277	\N	peli	\N	2006-10-09	12:00:00	\N
1279	\N	peli	\N	2006-10-09	12:00:00	\N
1284	\N	peli	\N	2006-11-11	11:00:00	\N
1273	\N	peli	\N	2006-10-09	12:00:00	\N
1177	\N	peli	\N	2006-09-23	11:00:00	Kauden 2006-07 ensimmäinen 4.divisioona-ottelu Kaukajärvellä: KooVee 2 - TAMKO SB
1242	\N	Saunailta	Tumppi, Hervanta	2006-09-02	17:00:00	Saunailta: klo 17.00 eteenpäin. Paikkana: Tumppi (Hervanta) E-rapun kerhohuone
1200	\N	peli	\N	2006-10-25	20:00:00	Tampere-kakkonen: KooVee 2 - Team Showtime
1194	\N	peli	\N	2007-03-24	12:00:00	Kauden viimeinen 4div.ottelu
1214	\N	harjoitus	Pirkkahalli	2006-10-24	21:00:00	Ensimmäiset treenit uudessa Pirkkahallin salibandykaukalossa. \r\nValmistavat treenit Tre2:n Showtime-peliin:\r\n-alkuverryttely\r\n-harjoitteet\r\n-peliä
1230	\N	harjoitus	Kaukajärvi	2006-10-26	18:00:00	-alkuverryttely: ruotsalainen\r\n-jatkuva 2vs.2\r\n-3vs.2\r\n-viisikoittain peliä 5vs.5
1178	\N	peli	\N	2006-09-30	12:00:00	4.div: B - KooVee 2
1224	\N	harjoitus	Kaukajärvi	2006-09-14	18:00:00	-alkuverryttely:\r\n-keskialueen ruotsalainen\r\n-päätypelaaminen 3vs.2\r\n-pienpeliä 3vs.3 tai koko kentällä 5vs.5
1227	\N	harjoitus	Kaukajärvi	2006-10-05	18:00:00	Sunnuntain 8.10 Soolo-peliin valmistavat treenit:\r\n-alkuverryttely\r\n-harjoitteita\r\n-yv\r\n-5vs.5
1179	\N	peli	\N	2006-10-08	10:00:00	4.div: KooVee 2 - Soolo
1247	\N	peli	\N	2006-09-01	12:00:00	\N
1210	\N	peli	Rahola	2007-03-23	19:00:00	Kauden viimeinen Tamperesarjan ottelu.
1208	\N	peli	\N	2007-02-23	19:00:00	\N
1206	\N	peli	\N	2007-01-26	20:00:00	\N
1286	\N	peli	\N	2006-11-11	14:00:00	\N
1283	\N	peli	\N	2006-10-09	12:00:00	\N
1216	\N	harjoitus	Pirkkahalli	2006-11-07	21:00:00	-alkuverryttely: mato, sveitsiläinen tai ruotsalainen\r\n-puolen kentän 2vs.2\r\n-päätypelaaminen 3vs.2 tai 4vs.3\r\n-pienpeliä tai koko kentällä
1249	\N	peli	\N	2006-09-01	12:00:00	\N
1250	\N	peli	\N	2006-09-01	12:00:00	\N
1251	\N	peli	\N	2006-09-01	12:00:00	\N
1252	\N	peli	\N	2006-09-01	12:00:00	\N
1253	\N	peli	\N	2006-09-01	12:00:00	\N
1254	\N	peli	\N	2006-09-01	12:00:00	\N
1255	\N	peli	\N	2006-09-01	12:00:00	\N
1256	\N	peli	\N	2006-09-01	12:00:00	\N
1257	\N	peli	\N	2006-09-01	12:00:00	\N
1281	\N	peli	\N	2006-10-09	12:00:00	\N
1259	\N	peli	\N	2006-09-01	12:00:00	\N
1260	\N	peli	\N	2006-09-01	12:00:00	\N
1261	\N	peli	\N	2006-09-01	12:00:00	\N
1232	\N	harjoitus	Kaukajärvi	2006-11-09	18:00:00	Valmistavat treenit Tre2-peliin KoKoa vastaan:\r\n\r\n-alkuverryttely:\r\n-harjoitteita\r\n-yv\r\n-viisikoittain 5vs.5-peliä
1262	\N	peli	\N	2006-09-01	12:00:00	\N
1258	\N	peli	\N	2006-09-01	12:00:00	\N
1202	\N	peli	\N	2006-11-22	20:00:00	Tampere-2: KooVee 2 - SB NMP
1217	\N	harjoitus	Pirkkahalli	2006-11-21	21:00:00	Tamperesarjan SB NMP-peliin valmistavat treenit:\r\n-\r\n-\r\n-\r\n-
1183	\N	peli	\N	2006-11-25	13:00:00	4.div: KooVee 2 - DTT
1234	\N	harjoitus	Kaukajärvi	2006-11-23	18:00:00	4.divarin Tigers-peliin valmistavat treenit:\r\n-\r\n-\r\n-
1184	\N	peli	\N	2006-12-02	13:00:00	KooVee 2:n vastuu-turnaus klo 10-14. Oma peli: FiBa-KooVee 2 klo 13.00
1218	\N	harjoitus	Pirkkahalli	2006-11-28	21:00:00	Pelitreenit
1235	\N	harjoitus	Kaukajärvi	2006-11-30	18:00:00	4.divarin FiBa-peliin valmistavat treenit:\r\n-\r\n-\r\n-\r\n-
1185	\N	peli	\N	2006-12-09	13:00:00	4.div: SBT PaPo - KooVee 2   (pelataan Parkanossa!)
1203	\N	peli	\N	2006-12-08	19:00:00	Tre2: SB Luuppi - KooVee 2
1236	\N	harjoitus	Kaukajärvi	2006-12-07	18:00:00	Viikonlopun peleihin (Tre2: SB Luuppi ja 4.div: SBT PaPo) valmistavat treenit:\r\n\r\n-\r\n-\r\n-\r\n-
1219	\N	harjoitus	Pirkkahalli	2006-12-05	21:00:00	Pelitreenit alkuverryttelyjen kera
1220	\N	harjoitus	Pirkkahalli	2006-12-12	21:00:00	-alkuverryttely:\r\n-harjoitteita\r\n-peliä
1237	\N	harjoitus	Kaukajärvi	2006-12-14	18:00:00	4.div: TAMKO-Koovee 2 peliin valmistavat treenit:\r\n-\r\n-\r\n-
1221	\N	harjoitus	Pirkkahalli	2006-12-19	21:00:00	Tre2: Koovee 2 - AWE peliin valmistavat treenit:\r\n-\r\n-\r\n-
1186	\N	peli	\N	2006-12-17	11:00:00	4.divaria: TAMKO SB - KooVee 2
1204	\N	peli	\N	2006-12-20	20:00:00	Tre2: KooVee 2-AWE
1238	\N	harjoitus	Kaukajärvi	2006-12-21	18:00:00	Vapaaehtoiset pelitreenit
1222	\N	harjoitus	Pirkkahalli	2006-12-26	21:00:00	Vapaaehtoiset pelitreenit
1239	\N	harjoitus	Kaukajärvi	2006-12-28	18:00:00	Vapaaehtoiset pelitreenit
1263	\N	peli	\N	2006-11-05	11:00:00	\N
1264	\N	peli	\N	2006-11-05	12:00:00	\N
1265	\N	peli	\N	2006-11-05	10:00:00	\N
\.


--
-- Data for TOC entry 105 (OID 109950)
-- Name: halli; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY halli (halliid, nimi, yhtietoid, kenttienlkm, lisatieto, alusta) FROM stdin;
2	Kaukajärvi Spiral-halli	2	4	\N	Muovimatto
1004	Metroauto Areena	1019	4	\N	Muovimatto
1006	Oriveden liikuntahalli	1020	1	\N	Parketti
1012	Pirkkalan Liikuntatalo	\N	1	\N	Parketti
1014	Tamppi-Areena	1023	1	\N	Muovimatto
1002	Toijalan Monitoimihalli	1018	1	\N	Parketti
1010	Vilppulan urheilutalo	1022	1	\N	Parketti
1008	Raholan Liikuntakeskus	1021	4	\N	Muovimatto
1016	Renska Areena Forssa	\N	1	\N	Matto
1018	Parkanon Urheilutalo	1037	1	\N	\N
1020	Ei tiedossa	\N	0	\N	\N
\.


--
-- Data for TOC entry 106 (OID 109963)
-- Name: kausi; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY kausi (vuosi) FROM stdin;
2003
2004
2006
2005
\.


--
-- Data for TOC entry 107 (OID 109967)
-- Name: sarjatyyppi; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY sarjatyyppi (tyyppi) FROM stdin;
M 5. Div
M 4. Div
Suomen Cup
M 5. Div yj
M 2. Div
Tre 2. Div
\.


--
-- Data for TOC entry 108 (OID 109973)
-- Name: seura; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY seura (seuraid, nimi, perustamispvm, lisatieto) FROM stdin;
1032	B	2003-01-01	\N
1001	Soittorasia	1995-01-01	\N
1002	SC Teho	1995-01-01	\N
1038	Classic XL	2006-06-01	\N
1004	New Village Stones	1995-01-01	\N
1006	FBC Nokia	1995-01-01	\N
1007	FiBa	1995-01-01	\N
1008	Pro Stars	1995-01-01	\N
1009	Pirkkalan Pirkat	1995-01-01	\N
1010	Vihuri	1995-01-01	\N
1011	Peve Bandy	1995-01-01	\N
1012	KilMy	1995-01-01	\N
1013	KU-68	1995-01-01	\N
1014	Kurttu	1995-01-01	\N
1015	JU 2	1995-01-01	\N
1016	Sahku	1995-01-01	\N
1017	SC Läsimäki	1995-01-01	\N
1039	Nokian KRP	1999-01-01	\N
1019	Athletic Club Aulanko ry	2002-01-01	\N
1	Koo-Vee	1929-01-01	\N
1033	TAMKO SB	2002-01-01	\N
1034	Soolo	1999-06-07	\N
1003	Ilves 3	1930-01-01	\N
1021	Forssan Suupparit Ry	1993-01-14	\N
1035	KoKo	2001-01-01	\N
1025	Koskenmäen Salibandy ry	1997-01-01	\N
1026	SC Lätty	2005-01-01	\N
1036	Punakone	1996-01-01	\N
1027	Manse Pojat	2005-01-01	\N
1029	SB Manse Rangers	1990-01-01	\N
1030	Salibandy NMP	1990-01-01	\N
1031	SC Inter	1990-01-01	\N
1037	SBT PaPo	1997-01-01	\N
1023	AWE	2005-01-01	\N
1040	WMP	2006-06-01	\N
1018	SB Ontto	1993-01-01	\N
1020	TFT	1990-01-01	\N
1022	SC Nemesis	2005-01-01	\N
2	D-Kone	2001-01-01	\N
1041	SB Luuppi	1997-01-01	\N
1024	Tottijärven V&amp;L ry	1998-01-01	\N
1028	Dolphins Tampereen Kiekko 83	1983-01-01	\N
1042	Nokian KRP	1998-01-01	\N
1044	DownTown Tigers	1999-01-01	\N
1043	Team Showtime	1996-01-01	\N
\.


--
-- Data for TOC entry 109 (OID 109983)
-- Name: sarja; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY sarja (sarjaid, kausi, tyyppi, nimi, kuvaus, jarjestaja) FROM stdin;
1	2003	M 5. Div	Sisä-Suomi	Miesten 5. divisioona	Suomen Salibandyliitto
1002	2004	Suomen Cup	Lohko H	Kierrokset 1. ja 2.	Suomen Salibandyliitto
1001	2004	M 4. Div	Sisä-Suomi	Miesten 4. divisioona	Suomen Salibandyliitto
1005	2006	Tre 2. Div	Tamperesarja	Tamperesarjan 2.divisioona	Suomen Salibandyliitto
1004	2005	M 5. Div yj	Sisä-Suomi	Ylempi jatkosarja	Suomen Salibandyliitto
1003	2005	M 5. Div	Sisä-Suomi	Miesten 5. divisioona	Suomen Salibandyliitto
1006	2006	M 4. Div	Sisä-Suomi	Miesten 4. divisioona	Suomen Salibandyliitto
\.


--
-- Data for TOC entry 110 (OID 110001)
-- Name: joukkue; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY joukkue (joukkueid, seuraid, lyhytnimi, pitkanimi, maskotti, email, logo, kuvaus) FROM stdin;
2	2	D-Kone	Tampereen D-Kone	\N	\N	\N	\N
1021	1	KooVee	KooVee Edustus	\N	\N	\N	\N
1001	1001	SR 3	Soittorasia 3	teekkari	\N	\N	\N
1002	1002	SC Teho	SC Teho	\N	\N	\N	\N
1003	1003	Ilves 2	Ilves 2	\N	\N	kuvat/joukkue/Ilves_2/defaultlogo.gif	jee
1004	1004	NVS	New Village Stones	\N	\N	\N	\N
1025	1023	AWE	AWE	\N	\N	\N	\N
1007	1007	FiBa	FiBa	\N	\N	\N	\N
1008	1008	Pro Stars	Pro Stars	\N	\N	\N	\N
1009	1009	PirPi 2	Pirkkalan Pirkat 2	\N	\N	\N	\N
1010	1017	SC Läsimäk	SC Läsimäki	\N	\N	\N	\N
1012	1012	KilMy	Killinkosken Myrsky	\N	\N	\N	\N
1011	1010	Vihuri	Vihuri	\N	\N	\N	\N
1013	1013	KU-68	Kangasala\r\nKU-68	\N	\N	\N	\N
1014	1014	Kurttu	Kurun Kurttu	\N	\N	\N	\N
1015	1015	JU 2	Juupajoki 2	\N	\N	\N	\N
1016	1016	Sahku	Sahku	\N	\N	\N	\N
1017	1011	Peve Bandy	Peve Bandy	\N	\N	\N	\N
1018	1018	SB Ontto	SB Ontto	\N	\N	\N	http://www.ontto.fi/
1019	1019	AC Aulanko	Athletic Club Aulanko	\N	aulanko@acaulanko.com	\N	Hämeenlinnalainen jalkapallo ja salibandyseura.
1046	1043	Showtime	Team Showtime	\N	\N	\N	\N
1020	1020	TFT	Toijalan floorball team	\N	\N	\N	\N
1022	1021	FoSu	Forssan Suupparit	\N	\N	\N	\N
1026	1024	V&amp;L	Tottijärven vauhti ja lämäri	\N	tottijarvenvauhtijalamari@kolumbus.fi	\N	Nokialta
1027	1026	SCL	SC Lätty	\N	sc.latty@luukku.com	\N	\N
1006	1006	FBC Nokia	Floor Ball Club Nokia	\N	\N	\N	\N
1023	1022	SC Nemesis	SC Nemesis	\N	info@scnemesis.com	\N	http://www.scnemesis.com
1028	1025	KoSBy	Koskenmäen salibandy	\N	toimisto@kosby.net	\N	\N
1029	1027	ManPo	Manse Pojat	\N	\N	\N	\N
1030	1028	Dolphins	Dolphins	\N	\N	\N	\N
1032	1030	SB NMP	SB NMP	\N	\N	\N	\N
1033	1031	SC Inter	SC Inter	\N	\N	\N	\N
1034	1029	SBMR	SB Manse Rangers	\N	\N	\N	\N
1035	1032	B	B	\N	\N	\N	\N
1036	1033	TAMKO	TAMKO Salibandy	\N	\N	\N	\N
1037	1034	Soolo	Urheiluseura Soolo	\N	\N	\N	\N
1038	1003	Ilves 3	Tampereen Ilves	\N	\N	\N	\N
1039	1035	KoKo	Koillisten Kojootit	\N	\N	\N	\N
1040	1036	Punakone	Tampereen Punakone 1996	\N	\N	\N	\N
1041	1037	SBT PaPo	Salibandy Team Parkanon Ponteva	\N	\N	\N	\N
1042	1039	N-KRP	Nokian KRP	\N	\N	\N	\N
1043	1038	Classic XL	Classic XL	\N	\N	\N	\N
1044	1040	WMP	WMP	\N	\N	\N	\N
1045	1041	SB Luuppi	SB Luuppi	\N	\N	\N	\N
1	1	Koo-Vee 2	Koo-Vee 2	\N	\N	kuvat/joukkue/Koo-Vee_2/defaultlogo.gif	Vanha perinteikäs urheilun monitoimiseura
1047	1044	DTT	DownTown Tigers	\N	\N	\N	\N
\.


--
-- Data for TOC entry 111 (OID 110016)
-- Name: kaudenjoukkue; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY kaudenjoukkue (joukkueid, kausi, kotihalli, kuva, logo, kotipaikka, kuvaus) FROM stdin;
1	2003	2	\N	\N	Tampere	Koo-Vee 2 pelasi kaudella 2003-2004 5. divisioonassa
2	2004	2	\N	\N	Tampere	\N
1019	2004	\N	\N	\N	Hämeenlinna	\N
1018	2004	\N	\N	\N	Tampere	\N
1	2004	2	kuvat/joukkue/Koo-Vee_2/ryhmakuva_2004.jpg	\N	Tampere	Miehet 4 divisioona, Pirkanmaa lohko 2
1	2005	2	kuvat/joukkue/Koo-Vee_2/ryhmakuva_2005.jpg	\N	Tampere	\N
1035	2006	\N	\N	\N	Tampere	\N
1	2006	2	kuvat/joukkue/Koo-Vee_2/ryhmakuva_2006.jpg	\N	Tampere	Miehet 4 divisioona
1047	2006	\N	\N	\N	Tampere	\N
1007	2006	\N	\N	\N	Tampere	\N
1038	2006	\N	\N	\N	Tampere	\N
1039	2006	\N	\N	\N	Tampere	\N
1040	2006	\N	\N	\N	Tampere	\N
1041	2006	\N	\N	\N	Tampere	\N
1037	2006	\N	\N	\N	Tampere	\N
1036	2006	\N	\N	\N	Tampere	\N
1025	2006	\N	\N	\N	Tre	\N
1042	2006	\N	\N	\N	Nokia	\N
1032	2006	\N	\N	\N	Tre	\N
1045	2006	\N	\N	\N	Tre	\N
1043	2006	\N	\N	\N	Tre	\N
1046	2006	\N	\N	\N	Tre	\N
\.


--
-- Data for TOC entry 112 (OID 110038)
-- Name: peli; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY peli (peliid, vierasjoukkue, kotijoukkue, sarja, atoimihenkilo1, atoimihenkilo2, atoimihenkilo3, atoimihenkilo4, atoimihenkilo5, btoimihenkilo1, btoimihenkilo2, btoimihenkilo3, btoimihenkilo4, btoimihenkilo5, pelipaikka, kotimaalit, vierasmaalit, tuomari1, tuomari2, toimitsija1, toimitsija2, toimitsija3, huomio, aikalisaa, aikalisab, yleisomaara) FROM stdin;
1045	1015	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1006	6	6	Michael Hokkanen	Kari Karjalainen	Hilma Honkala	Jonna Kääriäinen	Henni Kääriäinen	\N	\N	\N	-1
1044	1	1017	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	4	12	Jussi Rajanti	Juhani Leppänen	\N	\N	\N	\N	\N	\N	-1
1030	1	1019	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1002	1	3	Jussi Panula	Toni Joronen	Joona Laukkanen	Toni Joronen	\N	\N	\N	\N	-1
1017	1	1004	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	7	2	Niskanen Sisu	Leppänen Juhani	Hiltunen Jaakko	Hiltunen Asko	\N	\N	\N	\N	-1
1027	1014	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	7	3	Seppo Lattu	Lasse Lepola	Jari Lampinen	Eemeli Ilkonen	Aki Jukoukkala	\N	\N	\N	\N
1028	1	1013	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	1	6	Pekka Kesäläinen	\N	Aki Jukkola	Otso Suokas	\N	\N	00:11:45	\N	\N
1074	1023	1	1003	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	6	1	Janne Koskinen	Lauri Moberg	Vesa Koivu	Susanna Savolainen	\N	\N	\N	00:20:15	\N
1039	1003	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	2	2	Koskinen Janne	Hokkanen Michael	Pekka Säynäjoki	Marko Pääkkönen	Ville Lehtisaari	\N	\N	00:42:37	\N
1041	1	1015	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	1	3	Kuusinen Jussi	\N	Väisänen Petri	Moisio Mika	\N	\N	00:44:18	\N	\N
1021	1006	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	4	5	Seppo Markkanen	Jani Hautakorpi	Teemu Vartimo	Matti Hietala (aika)	\N	\N	00:42:56	\N	\N
1037	1012	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	6	1	Alaruka Jeke	Martansaari Marko	Kari Järvinen	Petteri Rintamäki	\N	\N	\N	\N	\N
1025	1	1003	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1012	6	3	Saarinen Katriina	Simonen Minna	Jussi Janhunen	Juha Aaltonen	Petri Kimpanpää	\N	\N	\N	-1
1038	1013	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1010	5	3	Olli Nuutinen	Markku Summelvall	Jani Käpylä	Jaakko Orpana	\N	\N	\N	\N	\N
1022	1	2	1001	\N	\N	\N	\N	\N	1015	\N	\N	\N	\N	2	5	4	Riku Henrikson	Juha-Matti Henrikson	Matti Mikkonen	Markus Lahdensuo	\N	\N	\N	00:38:24	\N
1048	2	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	8	Panula	Ylönen	Silvo	Puronurmi	Vode	\N	\N	\N	\N
1020	1003	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1012	8	4	Jukka Innanen	Seppo Auvinen	Jukka Kunnas (aika)	Jarkko Koskela (kirjuri)	Harri Iatja (kello)	\N	\N	\N	\N
1034	1	1012	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	2	7	Ari Lähteenmäki	Petri Heikkilä	Pirttikoski Timo	Innala Miikka	Pirttikoski Hannu	\N	\N	\N	\N
1042	1016	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1006	6	4	Pekka Arola	Raimo Sompa	Mari Humalajoki	Niina Viljamaa	Katja Viljamaa	\N	\N	\N	-1
1029	1001	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	1	6	Riku Henrikson	Juha-Matti Henrikson	Joni Niskanen	Henry Nieminen (aika)	\N	\N	00:40:43	\N	\N
1035	1010	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1010	5	5	Tom Saarela	Olli Nuuttinen	Jaakko Orpana	Jani Käpylä	\N	\N	\N	\N	\N
1036	1	1011	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	4	4	Laakso Jussi	Simonen Minna	\N	\N	\N	\N	\N	\N	\N
1040	1	1014	1	\N	\N	\N	\N	\N	1017	\N	\N	\N	\N	1004	2	5	Katriina Saarinen	Minna Simonen	Heikki Setälä	Mika Sappinen	\N	\N	\N	\N	\N
1053	1	1020	1002	\N	\N	\N	\N	\N	1015	\N	\N	\N	\N	2	6	2	Jussi Panula	Jani Hautakorpi	Laura Saarela (aika)	Anne-Mari Vintola	\N	\N	\N	\N	\N
1079	1	1006	1003	\N	\N	\N	\N	\N	1026	1065	\N	\N	\N	1008	7	3	Pekka Kesäläinen	Marko Sandelin	Marko Kujansivu	Toni Kivelä	\N	\N	\N	00:40:24	\N
1054	1021	1	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1016	1	12	Siitonen Pertti	Kuussaari Karo	Erkko Kikka (aika)	Lähteenkorva Perttu	\N	\N	00:42:19	\N	\N
1055	1	1022	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1016	13	1	Kuussaari Karo	Riihenperä Petri	Erkko Kikka	Vellamo Tomi (aika)	\N	\N	\N	\N	\N
1088	1028	1	1003	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	7	3	Hannu Santanen	Jussi Panula	Jari Ansamaa	Allan Martimo	Markus Tapola	\N	\N	\N	\N
1080	1025	1	1003	1065	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	6	3	Jere Alaruka	Dimitri Galeh	Jukka Kaartinen	\N	\N	\N	00:41:37	\N	\N
1089	1	1027	1003	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	3	6	Sisu Niskanen	Jani Hautakorpi	Janne Myllykallio	Mika Leino	\N	\N	00:34:00	\N	\N
1087	1	1026	1003	\N	\N	\N	\N	\N	1027	1065	\N	\N	\N	1008	2	6	Petri Väisänen	Kari Mikkonen	Pinja Lamminpohja	\N	\N	\N	\N	\N	\N
1043	1	1016	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	9	4	Marko Martamaa	Pasi Summanen	Heikki Setälä	Johanna Aromaa	\N	\N	\N	\N	-1
1046	1	1010	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	0	5	Seppo	\N	Toni Helperi	Mikko Pekkonen	Sonja Hurtamo	\N	\N	\N	-1
1023	1004	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	7	Timo Karinki	Sami Tunturi	Mikko Immonen (aika)	Kimmo Kiprionoff	\N	\N	00:40:23	\N	-1
1047	1018	1	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1002	5	13	Jussi Panula	Jani Hautakorpi	Joona Laukkanen	Toni Joronen	\N	\N	\N	\N	-1
1026	1	1002	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	2	Marko Salminen	Petri Heikkilä	Tanja Jääskeläinen	Pekka Hiltunen	\N	\N	\N	\N	-1
1010	1008	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	4	Roselund Mika	Ruokosalo Jukka	Järvinen Antti	Alvinen Petri	Martimo Allan	\N	\N	00:44:06	\N
1090	1	1029	1003	\N	\N	\N	\N	\N	1027	1065	\N	\N	\N	1008	4	9	Seppo Markkanen	Pekka Arola	Markus Määttä	Elias Heikkinen	\N	\N	\N	\N	\N
1016	1	1008	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	3	Mika Vallin	Jukka Innanen	Teemu Turunen	Ari Ruoholahti	\N	\N	\N	\N	\N
1015	1002	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	5	3	Lähteenmäki Ari	Makkaranen Seppo	Kortemaa Mauri (aika)	Makkonen Teijo	\N	\N	\N	00:42:55	\N
1018	1	1001	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	5	4	Ari Kuusisto	J. Innonen	Jussi Ylönen	Ari Vasarainen	\N	\N	00:40:49	\N	\N
1104	1	1023	1003	\N	\N	\N	\N	\N	1065	1027	\N	\N	\N	1008	5	5	Riku Henriksson	J-M Henriksson	Janne Tuononen	Sami Järvinen	Timo Walli	\N	\N	00:42:30	\N
1011	1	1009	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1014	5	1	Marko Salminen	Petri Heikkilä	Janne Tikkakoski	Aki Hänninen (aika)	\N	\N	\N	00:23:18	\N
1019	1007	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	2	Laakso Jussi	Leponen Joonas	Sari Ilola	Markus Lintula	Mikko Koskinen	\N	\N	\N	\N
1012	1009	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	5	Jukka Suominen	Aapo Järvinen	Tino Silfver	Matti Partanen	\N	\N	00:39:42	\N	\N
1031	1011	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	7	5	Jussi Innanen	Seppo Lehtonen	Timo Mäkinen	Marjaana Martikainen	\N	\N	\N	\N	\N
1032	1	1003	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1014	3	3	Juhani Leppänen	Lasse Lepola	Juha Kauppinen	Karri Saarinen	\N	\N	00:44:46	00:41:14	\N
1033	1017	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	9	1	Antti Tomminen	Tero Ylönen	Väisänen Petri	Lahtinen Perttu (aika)	Kansula Joonas	\N	00:36:24	\N	\N
1105	1006	1	1003	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	3	0	Joona Laukkanen	Joni Leväjärvi	Markus Ilva	Vesa Koivu	\N	\N	\N	\N	\N
1125	1026	1	1003	1069	1068	1024	1065	1027	\N	\N	\N	\N	\N	1008	8	2	Jussi Panula	Riku Henriksson	Marjaana Martikainen	\N	\N	\N	\N	\N	\N
1108	1	1028	1003	\N	\N	\N	\N	\N	1065	\N	\N	\N	\N	1008	2	5	Seppo Auvinen	Jani Maunuksela	Mika Rantanen	Tommi Nieminen	\N	\N	\N	\N	\N
1110	1029	1	1003	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	5	7	Lauri Moberg	Jussi Kuusirnne	Marko Kujansivu	Mika Rautio (aika)	\N	\N	00:43:12	\N	\N
1134	1027	1	1003	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	7	6	Seppo Markkanen	Dimitri Galeh	Juha-Antti Kalliosalo	Mika Paananen	Tero Välimäki	\N	\N	00:40:03	\N
1124	1	1025	1003	\N	\N	\N	\N	\N	1027	1065	\N	\N	\N	1008	3	15	Pekka Arola	Mikko Kivioja	J-P Rantanen	\N	\N	\N	\N	\N	\N
1135	1	1030	1004	\N	\N	\N	\N	\N	1065	1027	\N	\N	\N	1008	5	11	Jere Alaruka	Dimitri Galeh	Markku Roppo	Marko Järvinen	\N	\N	\N	\N	\N
1139	1030	1	1004	1027	1065	1026	\N	\N	\N	\N	\N	\N	\N	1008	6	2	Joni Leväjärvi	Joona Laukkanen	Tapani Lehtilä	J-M Henriksson	\N	\N	\N	\N	\N
1140	1	1034	1004	\N	\N	\N	\N	\N	1065	1027	\N	\N	\N	1008	3	3	Juha Tiainen	Marko Sandelin	Arno Suhonen	Henri Mäkinen	\N	\N	00:40:23	00:41:49	\N
1141	1	1032	1004	\N	\N	\N	\N	\N	1065	1027	\N	\N	\N	1008	3	15	Michael Hokkanen	Kari Karjalainen	Ari Laine	Jari Viitanen	\N	\N	00:10:53	\N	\N
1138	1	1033	1004	\N	\N	\N	\N	\N	1026	1065	\N	\N	\N	1008	4	16	Joni Leväjärvi	Kari Mikkonen	Robert Niloson	Hannu Nevala	\N	\N	\N	\N	\N
1200	1046	1	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	5	5	\N	\N	\N	\N	\N	\N	\N	\N	\N
1136	1034	1	1004	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	7	5	Minna Simonen	Jannne Koskinen	Jari Ansamaa	Timo Lehtinen	Pasi Lehtikangas	\N	\N	00:42:37	\N
1137	1032	1	1004	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	12	5	Jannne Hiukka	Kalle Tamminen	Marjaana Martikainen	Teemu Lahtela	Ilari Lehtinen	\N	\N	\N	\N
1142	1033	1	1004	1065	1027	1027	\N	\N	\N	\N	\N	\N	\N	1008	12	5	Kari Karjalainen	Pekka Kesäläinen	Petri Kirjavainen	Petri Partanen	\N	\N	\N	\N	\N
1177	1036	1	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	1	Juhani Leppänen	Petri Väisänen	Juha Leikko (aika)	Rauli Korpi	Risto Prepula	\N	00:43:26	00:41:46	\N
1180	1	1038	1006	\N	\N	\N	\N	\N	1027	1072	1065	\N	\N	2	2	7	Jens Kallstrom	Henrik Joki	Jaakko Nurmi	Matias Ramstedt	\N	\N	\N	\N	\N
1154	1020	1	1004	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	2	4	3	Seppo Markkanen	Jens Källström	Pirjo Pelto	Tiina Björkholm	\N	\N	\N	00:43:38	\N
1199	1	1043	1005	\N	\N	\N	\N	\N	1065	\N	\N	\N	\N	1008	3	10	Seppo Auvinen	Joona Laukkanen	\N	\N	\N	\N	\N	\N	\N
1270	1032	1046	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	2	7	\N	\N	\N	\N	\N	\N	\N	\N	-1
1182	1040	1	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1244	1037	1039	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	4	10	\N	\N	\N	\N	\N	\N	\N	\N	-1
1184	1	1007	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1185	1	1041	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1018	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1186	1	1036	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1187	1035	1	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1188	1	1037	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1189	1041	1	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1190	1	1039	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1191	1	1040	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1192	1038	1	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1193	1007	1	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1179	1037	1	1006	1027	1072	1065	\N	\N	\N	\N	\N	\N	\N	2	4	3	Juhani Leppänen	Pekka Arola	Mika Lahtinen	Seppo Eerola	\N	\N	00:44:41	00:43:47	\N
1178	1	1035	1006	\N	\N	\N	\N	\N	1027	1065	1072	\N	\N	2	3	0	Joonas Leponen	Janne Koskinen	Konsta Airanne	Sami Jokinen	\N	\N	\N	\N	\N
1245	1040	1038	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	7	\N	\N	\N	\N	\N	\N	\N	\N	-1
1198	1042	1	1005	1027	1072	\N	\N	\N	\N	\N	\N	\N	\N	1008	4	4	Seppo Auvinen	Pekka Kesäläinen	Jani Myllynen	Jussi Innanen	\N	\N	\N	\N	\N
1246	1007	1040	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	3	\N	\N	\N	\N	\N	\N	\N	\N	-1
1284	1035	1040	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	1	2	\N	\N	\N	\N	\N	\N	\N	\N	-1
1202	1032	1	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1203	1	1045	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1204	1025	1	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1205	1	1042	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1206	1043	1	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1207	1	1046	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1208	1039	1	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1209	1	1032	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1210	1045	1	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1194	1	1047	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1183	1047	1	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1197	1	1025	1005	\N	\N	\N	\N	\N	1065	1072	1027	\N	\N	1008	3	2	Jani Hautakorpi	\N	Joonas Vilppula	\N	\N	\N	\N	\N	\N
1247	1039	1038	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	5	\N	\N	\N	\N	\N	\N	\N	\N	-1
1181	1039	1	1006	1065	1072	1027	\N	\N	\N	\N	\N	\N	\N	2	10	1	Ari Kuusisto	Jukka Innanen	Jani Virtanen	Jani Penttinen	\N	\N	\N	\N	\N
1249	1041	1037	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	9	5	\N	\N	\N	\N	\N	\N	\N	\N	-1
1250	1047	1036	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	1	7	\N	\N	\N	\N	\N	\N	\N	\N	-1
1251	1036	1007	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	5	4	\N	\N	\N	\N	\N	\N	\N	\N	-1
1252	1040	1039	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	12	\N	\N	\N	\N	\N	\N	\N	\N	-1
1253	1035	1047	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	5	1	\N	\N	\N	\N	\N	\N	\N	\N	-1
1254	1038	1041	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	5	\N	\N	\N	\N	\N	\N	\N	\N	-1
1255	1041	1039	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	12	4	\N	\N	\N	\N	\N	\N	\N	\N	-1
1256	1036	1040	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	1	\N	\N	\N	\N	\N	\N	\N	\N	-1
1257	1047	1037	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	4	\N	\N	\N	\N	\N	\N	\N	\N	-1
1263	1036	1035	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	0	\N	\N	\N	\N	\N	\N	\N	\N	-1
1259	1041	1035	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	4	3	\N	\N	\N	\N	\N	\N	\N	\N	-1
1260	1041	1040	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	4	3	\N	\N	\N	\N	\N	\N	\N	\N	-1
1261	1047	1041	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	4	6	\N	\N	\N	\N	\N	\N	\N	\N	-1
1264	1007	1037	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	4	4	\N	\N	\N	\N	\N	\N	\N	\N	-1
1262	1007	1047	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	6	\N	\N	\N	\N	\N	\N	\N	\N	-1
1258	1007	1035	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	3	\N	\N	\N	\N	\N	\N	\N	\N	-1
1265	1038	1047	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	5	4	\N	\N	\N	\N	\N	\N	\N	\N	-1
1271	1045	1043	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	6	13	\N	\N	\N	\N	\N	\N	\N	\N	-1
1272	1039	1042	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	8	4	\N	\N	\N	\N	\N	\N	\N	\N	-1
1201	1	1039	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	2	7	Jussi Hietaranta	Petri Heikkilä	\N	\N	\N	\N	\N	\N	\N
1274	1046	1045	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	9	5	\N	\N	\N	\N	\N	\N	\N	\N	-1
1275	1025	1032	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	4	4	\N	\N	\N	\N	\N	\N	\N	\N	-1
1276	1032	1042	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	4	6	\N	\N	\N	\N	\N	\N	\N	\N	-1
1277	1045	1025	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	9	5	\N	\N	\N	\N	\N	\N	\N	\N	-1
1285	1036	1037	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	6	\N	\N	\N	\N	\N	\N	\N	\N	-1
1278	1039	1046	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	8	5	\N	\N	\N	\N	\N	\N	\N	\N	-1
1279	1025	1039	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	3	8	\N	\N	\N	\N	\N	\N	\N	\N	-1
1280	1042	1045	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	5	7	\N	\N	\N	\N	\N	\N	\N	\N	-1
1286	1047	1039	1006	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	6	\N	\N	\N	\N	\N	\N	\N	\N	-1
1273	1043	1039	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	5	6	\N	\N	\N	\N	\N	\N	\N	\N	-1
1282	1042	1043	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	2	16	\N	\N	\N	\N	\N	\N	\N	\N	-1
1283	1046	1025	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	6	1	\N	\N	\N	\N	\N	\N	\N	\N	-1
1281	1043	1032	1005	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1020	4	5	\N	\N	\N	\N	\N	\N	\N	\N	-1
\.


--
-- Data for TOC entry 113 (OID 110111)
-- Name: tilastomerkinta; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY tilastomerkinta (timerkintaid, peliid, joukkueid, tapahtumisaika) FROM stdin;
1013	1045	1	00:00:00
1014	1045	1	00:00:00
1015	1045	1	00:00:00
1016	1045	1	00:00:00
1017	1045	1	00:00:00
1018	1045	1	00:00:00
1233	1028	1	00:18:02
1234	1028	1	00:22:05
1235	1028	1	00:22:17
1019	1045	1	00:24:00
1020	1045	1	00:43:00
1030	1044	1	00:00:00
1031	1044	1	00:00:00
1032	1044	1	00:00:00
1033	1044	1	00:00:00
1034	1044	1	00:00:00
1035	1044	1	00:00:00
1036	1044	1	00:00:00
1037	1044	1	00:00:00
1038	1044	1	00:00:00
1039	1044	1	00:00:00
1040	1044	1	00:00:00
1041	1044	1	00:00:00
1042	1044	1	00:08:00
1043	1030	1019	00:44:31
1044	1030	1019	00:23:59
1045	1030	1019	00:26:32
1046	1030	1019	00:34:55
1047	1030	1	00:13:17
1048	1030	1	00:18:50
1049	1030	1	00:41:57
1050	1030	1	00:26:32
1051	1030	1	00:29:53
1052	1017	1	00:23:12
1053	1017	1	00:43:10
1054	1017	1	00:13:38
1055	1017	1	00:23:45
1056	1025	1	00:28:55
1057	1025	1	00:31:40
1058	1025	1	00:39:48
1059	1025	1	00:43:38
1067	1042	1	00:00:00
1068	1042	1	00:00:00
1069	1042	1	00:00:00
1070	1042	1	00:00:00
1071	1042	1	00:00:00
1072	1042	1	00:00:00
1073	1042	1	00:20:00
1081	1043	1	00:00:00
1082	1043	1	00:00:00
1083	1043	1	00:00:00
1084	1043	1	00:00:00
1085	1043	1	00:04:00
1086	1043	1	00:37:00
1087	1043	1	00:41:00
1088	1046	1	00:00:16
1089	1046	1	00:00:30
1090	1046	1	00:00:32
1091	1046	1	00:00:41
1092	1046	1	00:00:42
1093	1046	1	00:17:00
1095	1023	1	00:00:36
1096	1023	1	00:07:21
1097	1023	1	00:14:38
1098	1023	1	00:23:37
1099	1023	1	00:31:03
1100	1023	1	00:40:41
1101	1023	1	00:37:39
1102	1047	1	00:21:42
1103	1047	1	00:24:29
1104	1047	1	00:34:01
1105	1047	1	00:43:21
1106	1047	1	00:44:31
1107	1047	1	00:31:00
1108	1047	1018	00:06:43
1109	1047	1018	00:08:40
1110	1047	1018	00:15:47
1111	1047	1018	00:23:40
1112	1047	1018	00:29:20
1113	1047	1018	00:31:25
1114	1047	1018	00:32:03
1115	1047	1018	00:33:33
1116	1047	1018	00:35:18
1117	1047	1018	00:39:34
1118	1047	1018	00:40:49
1119	1047	1018	00:42:31
1120	1047	1018	00:43:52
1121	1047	1018	00:24:19
1122	1026	1	00:07:29
1123	1026	1	00:17:04
1124	1026	1	00:17:10
1197	1019	1	00:43:50
1198	1019	1	00:17:12
1199	1012	1	00:26:54
1200	1012	1	00:44:03
1201	1012	1	00:02:46
1133	1016	1	00:33:18
1134	1016	1	00:39:15
1135	1016	1	00:43:06
1136	1016	1	00:19:13
1137	1015	1	00:05:47
1138	1015	1	00:07:17
1139	1015	1	00:14:23
1140	1015	1	00:23:46
1141	1015	1	00:44:54
1142	1015	1	00:30:36
1143	1015	1	00:35:24
1144	1018	1	00:05:21
1145	1018	1	00:17:39
1146	1018	1	00:29:34
1147	1018	1	00:32:45
1148	1018	1	00:12:23
1292	1053	1	00:26:05
1293	1053	1	00:44:56
1294	1053	1	00:06:51
1295	1054	1	00:18:51
1296	1054	1	00:44:23
1202	1012	1	00:19:26
1203	1031	1	00:13:56
1204	1031	1	00:15:51
1205	1031	1	00:19:38
1158	1021	1	00:17:33
1159	1021	1	00:22:58
1160	1021	1	00:25:34
1161	1021	1	00:31:48
1162	1021	1	00:13:34
1163	1021	1	00:44:37
1236	1028	1	00:43:01
1237	1028	1	00:43:37
1238	1028	1	00:44:53
1239	1028	1	00:09:54
1171	1022	2	00:36:36
1172	1022	2	00:37:56
1173	1022	2	00:39:28
1174	1022	2	00:43:16
1175	1022	2	00:44:55
1176	1022	2	00:26:47
1177	1022	1	00:20:41
1178	1022	1	00:25:31
1179	1022	1	00:28:58
1180	1022	1	00:29:46
1181	1022	1	00:41:23
1182	1029	1	00:21:29
1183	1029	1	00:10:29
1184	1029	1	00:24:08
1185	1029	1	00:38:29
1186	1010	1	00:24:38
1187	1010	1	00:28:30
1188	1010	1	00:23:02
1189	1010	1	00:44:42
1190	1011	1	00:44:41
1191	1011	1	00:29:50
1192	1019	1	00:06:59
1193	1019	1	00:09:19
1194	1019	1	00:23:34
1195	1019	1	00:28:57
1196	1019	1	00:30:42
1308	1074	1	00:04:29
1309	1074	1	00:11:07
1310	1074	1	00:20:04
1311	1074	1	00:20:15
1312	1074	1	00:30:22
1313	1074	1	00:37:25
1314	1074	1	00:09:49
1315	1074	1	00:15:00
1316	1074	1	00:36:55
1206	1031	1	00:35:31
1207	1031	1	00:36:13
1208	1031	1	00:37:05
1209	1031	1	00:41:58
1210	1032	1	00:01:28
1211	1032	1	00:24:19
1212	1032	1	00:31:05
1213	1033	1	00:06:11
1214	1033	1	00:11:47
1215	1033	1	00:19:15
1216	1033	1	00:21:46
1217	1033	1	00:24:04
1218	1033	1	00:25:12
1219	1033	1	00:25:33
1220	1033	1	00:25:54
1221	1033	1	00:32:19
1222	1033	1	00:08:47
1223	1033	1	00:36:42
1224	1027	1	00:06:27
1225	1027	1	00:10:59
1226	1027	1	00:22:44
1227	1027	1	00:34:32
1228	1027	1	00:36:43
1229	1027	1	00:37:06
1230	1027	1	00:43:19
1231	1027	1	00:03:31
1232	1027	1	00:37:58
1240	1039	1	00:31:54
1241	1039	1	00:39:44
1242	1039	1	00:32:24
1243	1039	1	00:42:37
1244	1041	1	00:01:03
1245	1041	1	00:06:30
1246	1041	1	00:13:47
1247	1041	1	00:35:01
1248	1037	1	00:00:23
1249	1037	1	00:09:42
1250	1037	1	00:11:15
1251	1037	1	00:18:27
1252	1037	1	00:34:32
1253	1037	1	00:43:40
1254	1037	1	00:44:36
1255	1038	1	00:07:44
1256	1038	1	00:08:49
1257	1038	1	00:17:34
1258	1038	1	00:27:38
1259	1038	1	00:32:41
1260	1038	1	00:39:19
1261	1034	1	00:00:36
1262	1034	1	00:11:30
1263	1034	1	00:14:41
1264	1034	1	00:25:51
1265	1034	1	00:28:22
1266	1034	1	00:31:12
1267	1034	1	00:39:50
1268	1034	1	00:32:34
1269	1034	1	00:38:50
1270	1035	1	00:07:03
1271	1035	1	00:12:46
1272	1035	1	00:17:19
1273	1035	1	00:19:49
1274	1035	1	00:29:29
1275	1035	1	00:10:30
1276	1036	1	00:18:21
1277	1036	1	00:24:13
1278	1036	1	00:28:03
1279	1036	1	00:25:59
1280	1036	1	00:12:19
1281	1040	1	00:07:07
1282	1040	1	00:08:36
1283	1040	1	00:23:43
1284	1040	1	00:24:10
1285	1040	1	00:44:31
1286	1040	1	00:29:13
1287	1048	1	00:22:04
1288	1048	1	00:31:29
1289	1048	1	00:34:36
1290	1048	1	00:27:40
1291	1048	1	00:44:45
1297	1055	1	00:21:44
1298	1055	1	00:22:41
1299	1020	1	00:07:56
1300	1020	1	00:10:14
1301	1020	1	00:11:08
1302	1020	1	00:12:35
1303	1020	1	00:18:46
1304	1020	1	00:22:58
1305	1020	1	00:28:30
1306	1020	1	00:42:23
1307	1020	1	00:43:15
1317	1074	1	00:40:11
1318	1074	1	00:42:43
1319	1079	1	00:05:58
1320	1079	1	00:12:30
1321	1079	1	00:12:51
1322	1079	1	00:16:13
1323	1079	1	00:40:08
1324	1079	1	00:42:46
1341	1087	1	00:13:06
1342	1087	1	00:20:12
1343	1087	1	00:24:48
1344	1087	1	00:32:44
1345	1087	1	00:41:45
1346	1087	1	00:44:17
1347	1088	1	00:08:03
1348	1088	1	00:24:50
1333	1080	1	00:07:03
1334	1080	1	00:12:29
1335	1080	1	00:17:45
1336	1080	1	00:19:56
1337	1080	1	00:31:13
1338	1080	1	00:44:37
1339	1080	1	00:26:20
1340	1080	1	00:39:38
1349	1088	1	00:29:53
1350	1088	1	00:32:24
1351	1088	1	00:36:20
1352	1088	1	00:38:26
1353	1088	1	00:43:55
1354	1088	1	00:44:37
1355	1088	1	00:34:21
1356	1089	1	00:00:42
1357	1089	1	00:14:30
1358	1089	1	00:26:06
1359	1089	1	00:30:50
1360	1089	1	00:31:53
1361	1089	1	00:44:43
1362	1089	1	00:00:42
1363	1090	1	00:01:54
1364	1090	1	00:07:31
1365	1090	1	00:08:17
1366	1090	1	00:08:54
1367	1090	1	00:09:34
1368	1090	1	00:10:08
1369	1090	1	00:29:58
1370	1090	1	00:38:08
1371	1090	1	00:41:00
1372	1090	1	00:14:21
1373	1090	1	00:21:02
1374	1104	1	00:13:46
1375	1104	1	00:21:06
1376	1104	1	00:29:23
1377	1104	1	00:39:14
1378	1104	1	00:42:44
1379	1104	1	00:30:00
1380	1105	1	00:12:40
1381	1105	1	00:20:15
1382	1105	1	00:21:15
1413	1125	1	00:01:35
1414	1125	1	00:05:30
1415	1125	1	00:10:04
1416	1125	1	00:16:54
1417	1125	1	00:20:53
1418	1125	1	00:29:54
1419	1125	1	00:39:46
1420	1125	1	00:42:41
1421	1125	1	00:41:11
1422	1108	1	00:00:17
1423	1108	1	00:04:39
1424	1108	1	00:08:38
1425	1108	1	00:11:16
1426	1108	1	00:29:04
1427	1108	1	00:34:30
1398	1124	1	00:01:48
1399	1124	1	00:04:28
1400	1124	1	00:04:52
1401	1124	1	00:05:53
1402	1124	1	00:10:49
1403	1124	1	00:13:50
1404	1124	1	00:15:49
1405	1124	1	00:16:21
1406	1124	1	00:19:40
1407	1124	1	00:24:54
1408	1124	1	00:29:36
1409	1124	1	00:38:03
1410	1124	1	00:42:36
1411	1124	1	00:44:21
1412	1124	1	00:44:58
1428	1108	1	00:42:20
1429	1134	1	00:04:23
1430	1134	1	00:08:28
1431	1134	1	00:11:08
1432	1134	1	00:20:22
1433	1134	1	00:20:39
1434	1134	1	00:22:56
1435	1134	1	00:36:42
1436	1134	1	00:27:39
1437	1110	1	00:14:30
1438	1110	1	00:20:57
1439	1110	1	00:26:55
1440	1110	1	00:39:30
1441	1110	1	00:44:59
1442	1110	1	00:29:41
1443	1135	1	00:10:31
1444	1135	1	00:11:04
1445	1135	1	00:13:20
1446	1135	1	00:16:02
1447	1135	1	00:21:23
1448	1135	1	00:22:12
1449	1135	1	00:27:01
1450	1135	1	00:31:39
1451	1135	1	00:35:48
1452	1135	1	00:44:06
1453	1135	1	00:44:36
1454	1135	1	00:07:37
1455	1135	1	00:32:59
1456	1136	1	00:11:04
1457	1136	1	00:11:20
1458	1136	1	00:17:26
1459	1136	1	00:34:22
1460	1136	1	00:35:01
1461	1136	1	00:36:34
1462	1136	1	00:39:26
1463	1136	1	00:00:52
1464	1137	1	00:05:44
1465	1137	1	00:15:54
1466	1137	1	00:16:40
1467	1137	1	00:18:46
1468	1137	1	00:25:39
1469	1137	1	00:25:59
1470	1137	1	00:27:07
1471	1137	1	00:30:39
1472	1137	1	00:30:45
1473	1137	1	00:36:04
1474	1137	1	00:40:57
1475	1137	1	00:41:33
1476	1138	1	00:04:36
1477	1138	1	00:07:31
1478	1138	1	00:09:10
1479	1138	1	00:09:52
1480	1138	1	00:09:57
1481	1138	1	00:10:27
1482	1138	1	00:12:39
1483	1138	1	00:15:31
1484	1138	1	00:21:55
1485	1138	1	00:28:12
1486	1138	1	00:32:52
1487	1138	1	00:34:03
1488	1138	1	00:35:20
1489	1138	1	00:36:01
1490	1138	1	00:37:23
1491	1138	1	00:38:07
1492	1139	1	00:00:23
1493	1139	1	00:09:11
1494	1139	1	00:09:42
1495	1139	1	00:16:12
1496	1139	1	00:22:36
1497	1139	1	00:40:55
1498	1139	1	00:24:36
1499	1139	1	00:31:24
1500	1139	1	00:43:26
1501	1140	1	00:27:00
1502	1140	1	00:35:24
1503	1140	1	00:38:16
1504	1141	1	00:06:32
1505	1141	1	00:07:54
1506	1141	1	00:09:37
1507	1141	1	00:10:53
1508	1141	1	00:12:56
1509	1141	1	00:20:08
1510	1141	1	00:20:38
1511	1141	1	00:21:24
1512	1141	1	00:21:53
1513	1141	1	00:22:35
1514	1141	1	00:24:05
1515	1141	1	00:28:25
1516	1141	1	00:30:10
1517	1141	1	00:32:56
1518	1141	1	00:36:58
1519	1141	1	00:15:56
1520	1141	1	00:33:29
1521	1142	1	00:07:04
1522	1142	1	00:13:13
1523	1142	1	00:14:38
1524	1142	1	00:21:10
1525	1142	1	00:21:49
1526	1142	1	00:34:23
1527	1142	1	00:35:23
1528	1142	1	00:36:21
1529	1142	1	00:37:11
1530	1142	1	00:41:13
1531	1142	1	00:42:33
1532	1142	1	00:43:38
1572	1179	1	00:33:28
1586	1180	1	00:02:03
1587	1180	1	00:07:45
1569	1179	1	00:04:41
1570	1179	1	00:06:29
1571	1179	1	00:27:46
1588	1180	1	00:17:35
1589	1180	1	00:22:14
1590	1180	1	00:34:47
1591	1180	1	00:42:46
1592	1180	1	00:43:01
1565	1178	1	00:39:10
1566	1177	1	00:03:43
1567	1177	1	00:07:53
1547	1154	1	00:06:05
1548	1154	1	00:07:16
1549	1154	1	00:24:01
1550	1154	1	00:41:27
1551	1154	1	00:38:35
1552	1154	1	00:41:10
1553	1154	1	00:34:45
1568	1177	1	00:25:27
1604	1181	1	00:05:04
1605	1181	1	00:12:11
1606	1181	1	00:13:12
1607	1181	1	00:13:37
1608	1181	1	00:20:15
1609	1181	1	00:29:13
1610	1181	1	00:31:58
1611	1181	1	00:39:28
1612	1181	1	00:41:50
1613	1181	1	00:44:27
1614	1181	1	00:34:49
\.


--
-- Data for TOC entry 114 (OID 110124)
-- Name: maali; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY maali (maaliid, tekija, syottaja, tyyppi, tyhjamaali, siirrangaikana, rangaistuslaukaus) FROM stdin;
1013	1026	1017	no	f	f	f
1014	1018	\N	no	f	f	f
1015	1022	1018	no	f	f	f
1016	1026	1018	no	f	f	f
1017	1027	\N	no	f	f	f
1224	1019	1028	no	f	f	f
1018	1019	1029	no	f	f	f
1030	1020	1026	no	f	f	f
1031	1026	1015	no	f	f	f
1032	1028	1016	no	f	f	f
1033	1016	1014	no	f	f	f
1034	1015	1021	no	f	f	f
1035	1026	1024	no	f	f	f
1036	1016	\N	no	f	f	f
1037	1020	1027	no	f	f	f
1038	1019	1014	no	f	f	f
1039	1017	1027	no	f	f	f
1040	1017	1016	no	f	f	f
1041	1026	1024	no	f	f	f
1043	1059	\N	no	f	f	f
1047	1021	1047	no	f	f	f
1048	1047	1019	no	f	f	f
1049	1026	1047	no	f	f	f
1052	1027	1017	no	f	f	f
1053	1046	1017	no	f	f	f
1056	1028	1027	no	f	f	f
1057	1027	1020	no	f	f	f
1058	1027	1047	no	f	f	f
1067	1026	1019	no	f	f	f
1068	1017	1024	no	f	f	f
1069	1017	1018	no	f	f	f
1070	1015	1027	no	f	f	f
1071	1017	\N	no	f	f	f
1072	1019	1016	no	f	f	f
1081	1016	\N	no	f	f	f
1082	1020	1018	no	f	f	f
1083	1026	1018	no	f	f	f
1084	1027	\N	no	f	f	f
1088	1026	1028	no	f	f	f
1089	1018	1020	no	f	f	f
1090	1029	1025	no	f	f	f
1091	1020	1027	no	f	f	f
1092	1026	1029	no	f	f	f
1095	1046	1018	no	f	f	f
1096	1026	1018	yv	f	f	f
1097	1017	\N	no	f	f	f
1098	1046	1017	no	f	f	f
1099	1020	1027	yv	f	f	f
1100	1046	1026	no	f	f	f
1102	1020	1027	no	f	f	f
1103	1020	1027	yv	f	f	f
1104	1028	1023	no	f	f	f
1105	1026	1028	no	f	f	f
1106	1027	\N	no	f	f	f
1108	1030	1036	no	f	f	f
1109	1036	1037	no	f	f	f
1110	1030	1036	no	f	f	f
1111	1031	1039	no	f	f	f
1112	1039	1035	no	f	f	f
1113	1036	1030	no	f	f	f
1114	1039	1031	no	f	f	f
1115	1034	\N	no	f	f	f
1116	1039	1037	no	f	f	f
1117	1039	1034	no	f	f	f
1118	1039	1031	no	f	f	f
1119	1031	1034	no	f	f	f
1120	1031	1035	no	f	f	f
1122	1020	1048	no	f	f	f
1123	1029	1047	no	f	f	f
1238	1026	1017	no	f	f	f
1240	1018	1026	yv	f	f	f
1241	1018	\N	no	f	f	t
1133	1027	1045	no	f	f	f
1134	1019	1017	no	f	f	f
1135	1047	1017	no	f	f	f
1137	1020	1045	no	f	f	f
1138	1028	1045	no	f	f	f
1139	1027	1020	no	f	f	f
1140	1021	1017	no	f	f	f
1141	1045	\N	no	f	f	f
1144	1046	1017	no	f	f	f
1145	1023	1028	no	f	f	f
1146	1015	1017	no	f	f	f
1147	1015	1045	no	f	f	f
1292	1026	1018	yv	f	f	f
1293	1021	1017	no	f	f	f
1295	1026	1045	no	f	f	f
1244	1017	\N	no	f	f	f
1245	1028	1019	no	f	f	f
1246	1027	1024	no	f	f	f
1248	1018	1027	no	f	f	f
1249	1020	1027	no	f	f	f
1158	1017	\N	no	f	f	f
1159	1026	1028	no	f	f	f
1160	1021	1017	no	f	f	f
1161	1021	1047	no	f	f	f
1225	1011	1015	no	f	f	f
1226	1011	1016	yv	f	f	f
1227	1027	1024	no	f	f	f
1228	1019	1029	no	f	f	f
1229	1015	1021	yv	f	f	f
1171	1003	1005	no	f	f	f
1172	1005	1003	no	f	f	f
1173	1005	1003	no	f	f	f
1174	1003	1005	yv	f	f	f
1175	1005	1008	no	f	f	f
1177	1021	1029	no	f	f	f
1178	1017	1018	no	f	f	f
1179	1019	1047	no	f	f	f
1180	1024	1047	no	f	f	f
1182	1027	1025	no	f	f	f
1186	1020	1026	av	f	f	f
1187	1020	1021	no	f	f	f
1190	1019	\N	no	f	f	f
1192	1046	1027	no	f	f	f
1193	1028	1019	no	f	f	f
1194	1047	1017	no	f	f	f
1195	1027	1047	no	f	f	f
1196	1029	1014	no	f	f	f
1197	1014	1028	no	f	f	f
1199	1047	1014	yv	f	f	f
1200	1028	1019	no	f	f	f
1203	1023	1029	no	f	f	f
1204	1021	1011	no	f	f	f
1205	1019	1024	no	f	f	f
1206	1021	1024	no	f	f	f
1207	1028	1011	no	f	f	f
1208	1019	1014	no	f	f	f
1209	1021	1014	no	f	f	f
1210	1020	1024	no	f	f	f
1211	1021	1028	yv	f	f	f
1212	1026	1017	no	f	f	f
1213	1026	1017	no	f	f	f
1214	1027	1026	no	f	f	f
1215	1028	1011	no	f	f	f
1216	1029	\N	no	f	f	t
1217	1027	1017	no	f	f	f
1218	1019	1023	no	f	f	f
1219	1026	\N	no	f	f	f
1220	1027	1017	no	f	f	f
1221	1027	1017	no	f	f	f
1230	1015	\N	no	f	f	f
1233	1020	1027	no	f	f	f
1234	1017	1011	no	f	f	f
1235	1024	\N	no	f	f	f
1236	1019	1025	no	f	f	f
1237	1027	1028	no	f	f	f
1308	1066	1021	no	f	f	f
1309	1027	1065	av	f	f	f
1310	1046	1018	no	f	f	f
1311	1069	1065	no	f	f	f
1312	1014	\N	no	f	f	f
1313	1066	\N	av	f	f	f
1319	1021	1024	no	f	f	f
1320	1065	\N	no	f	f	f
1250	1019	1026	no	f	f	f
1251	1021	1015	no	f	f	f
1252	1021	1029	no	f	f	f
1253	1028	1029	no	f	f	f
1255	1011	1021	no	f	f	f
1256	1011	1015	no	f	f	f
1257	1019	1028	no	f	f	f
1258	1015	1024	no	f	f	f
1259	1026	1018	no	f	f	f
1261	1024	1028	no	f	f	f
1262	1021	1026	yv	f	f	f
1263	1028	1026	no	f	f	f
1264	1026	1014	no	f	f	f
1265	1021	1028	no	f	f	f
1266	1026	1019	no	f	f	f
1267	1026	1029	av	f	f	f
1270	1028	1019	no	f	f	f
1271	1011	1015	no	f	f	f
1272	1026	1021	no	f	f	f
1273	1027	1026	no	f	f	f
1274	1022	1019	no	f	f	f
1276	1027	1018	no	f	f	f
1277	1014	1027	no	f	f	f
1278	1020	1027	no	f	f	f
1279	1027	1026	no	f	f	f
1281	1026	1019	no	f	f	f
1282	1029	\N	no	f	f	f
1283	1027	1020	no	f	f	f
1284	1022	1014	no	f	f	f
1285	1011	\N	no	f	f	f
1287	1027	\N	no	f	f	f
1288	1026	1045	no	f	f	f
1289	1047	1026	no	f	f	f
1297	1020	1027	no	f	f	f
1299	1027	1026	no	f	f	f
1300	1028	1027	no	f	f	f
1301	1026	1045	no	f	f	f
1302	1027	1019	no	f	f	f
1303	1023	\N	no	f	f	f
1304	1027	1028	yv	f	f	f
1305	1021	\N	no	f	f	f
1306	1026	1027	no	f	f	f
1321	1029	1018	no	f	f	f
1341	1069	1065	no	f	f	f
1342	1067	1047	no	f	f	f
1343	1047	1018	no	f	f	f
1344	1067	1026	no	f	f	f
1345	1067	1046	no	f	f	f
1346	1067	1065	no	f	f	f
1333	1069	1065	no	f	t	t
1334	1047	1018	no	f	f	f
1335	1067	1024	no	f	f	f
1336	1029	1018	no	f	f	f
1337	1065	1067	no	f	f	f
1338	1067	1026	yv	f	f	f
1347	1065	1046	no	f	f	f
1348	1026	1018	no	f	f	f
1349	1066	1068	no	f	f	f
1350	1027	1067	no	f	f	f
1351	1027	1066	yv	f	f	f
1352	1065	1067	no	f	f	f
1353	1018	1026	no	f	f	f
1356	1067	1066	no	f	f	f
1357	1047	1018	no	f	f	f
1358	1066	\N	no	f	f	f
1359	1067	1027	no	f	f	f
1360	1047	1018	no	f	f	f
1361	1066	1027	no	f	f	f
1363	1047	1018	no	f	f	f
1364	1065	1047	no	f	f	f
1365	1029	1026	no	f	f	f
1366	1067	1018	no	f	f	f
1367	1066	1026	no	f	f	f
1368	1066	1021	no	f	f	f
1369	1067	\N	no	f	f	f
1370	1066	\N	no	f	f	f
1371	1066	1018	no	f	f	f
1374	1066	1065	no	f	f	f
1375	1066	1024	no	f	f	f
1376	1066	1026	no	f	f	f
1377	1065	1026	yv	f	f	f
1378	1066	1018	no	f	f	f
1380	1065	1026	yv	f	f	f
1381	1065	\N	no	f	f	f
1382	1027	1014	no	f	f	f
1413	1067	1065	no	f	f	f
1414	1065	1021	no	f	f	f
1415	1029	1067	no	f	f	f
1416	1029	1067	no	f	f	f
1417	1067	1029	no	f	f	f
1418	1018	1027	no	f	f	f
1419	1021	1067	no	f	f	f
1420	1065	1026	no	f	f	f
1422	1021	1066	no	f	f	f
1423	1066	\N	yv	f	f	f
1424	1066	1024	yv	f	f	f
1425	1026	1029	no	f	f	f
1426	1021	1066	no	f	f	f
1429	1067	1069	no	f	f	f
1430	1021	1024	no	f	f	f
1398	1047	1065	no	f	f	f
1399	1066	1027	no	f	f	f
1400	1069	1065	no	f	f	f
1401	1027	1066	no	f	f	f
1402	1066	1018	no	f	f	f
1403	1014	\N	no	f	f	f
1404	1027	1018	no	f	f	f
1405	1069	1065	no	f	f	f
1406	1014	1065	no	f	f	f
1407	1066	1018	no	f	f	f
1408	1066	\N	no	f	f	f
1409	1027	1018	no	f	f	f
1410	1066	1027	no	f	f	f
1411	1027	1066	no	f	f	f
1412	1014	1027	no	f	f	f
1431	1018	1027	no	f	f	f
1432	1067	1065	no	f	f	f
1433	1026	1021	no	f	f	f
1434	1067	1069	no	f	f	f
1435	1065	1069	no	f	f	f
1437	1069	1026	no	f	f	f
1438	1018	1067	no	f	f	f
1439	1026	1066	no	f	f	f
1440	1066	1065	no	f	f	f
1441	1066	1067	no	f	f	f
1443	1067	1018	no	f	f	f
1444	1067	\N	no	f	f	f
1445	1069	1067	no	f	f	f
1446	1027	1024	no	f	f	f
1447	1069	1067	no	f	f	f
1448	1027	1047	no	f	f	f
1449	1018	1067	yv	f	f	f
1450	1018	1026	no	f	f	f
1451	1027	1029	no	f	f	f
1452	1067	1069	no	f	f	f
1453	1029	1018	no	f	f	f
1456	1018	1026	no	f	f	f
1457	1067	1065	no	f	f	f
1458	1027	1047	no	f	f	f
1459	1065	1069	no	f	f	f
1460	1067	1065	no	f	f	f
1461	1067	1065	yv	f	f	f
1462	1067	1069	no	f	f	f
1464	1018	1029	no	f	f	f
1465	1066	1065	no	f	f	f
1466	1026	1018	no	f	f	f
1467	1014	1066	no	f	f	f
1468	1027	1029	no	f	f	f
1469	1029	1027	no	f	f	f
1470	1066	1065	no	f	f	f
1471	1066	1065	no	f	f	f
1472	1067	1018	no	f	f	f
1473	1024	1067	no	f	f	f
1474	1065	\N	no	f	f	f
1475	1029	\N	no	f	f	f
1476	1067	1069	no	f	f	f
1477	1026	1065	no	f	f	f
1478	1066	1018	no	f	f	f
1479	1069	1065	no	f	f	f
1480	1021	1066	no	f	f	f
1481	1021	1018	no	f	f	f
1482	1069	1067	no	f	f	f
1483	1066	1018	no	f	f	f
1484	1065	1069	no	f	f	f
1485	1065	1067	no	f	f	f
1486	1066	1021	no	f	f	f
1487	1067	1026	no	f	f	f
1488	1066	1065	no	f	f	f
1489	1069	1067	no	f	f	f
1490	1066	1018	no	f	f	f
1491	1069	1065	no	f	f	f
1492	1014	1066	no	f	f	f
1493	1066	\N	no	f	f	f
1494	1067	1024	no	f	f	f
1495	1067	1065	no	f	f	f
1496	1066	1065	yv	f	f	f
1497	1018	1065	yv	f	f	f
1501	1065	1027	no	f	f	f
1502	1024	\N	no	f	f	f
1503	1067	1065	no	f	f	f
1504	1018	1067	no	f	f	f
1505	1067	1065	no	f	f	f
1506	1021	1066	no	f	f	f
1507	1018	\N	no	f	f	f
1508	1067	1066	no	f	f	f
1509	1021	1018	no	f	f	f
1510	1066	1024	no	f	f	f
1511	1067	1018	no	f	f	f
1512	1067	1021	no	f	f	f
1513	1066	1065	no	f	f	f
1514	1065	1067	no	f	f	f
1515	1024	1065	no	f	f	f
1516	1067	1065	no	f	f	f
1517	1066	1018	no	f	f	f
1518	1067	1027	no	f	f	f
1521	1067	1026	no	f	f	f
1522	1066	1018	no	f	f	f
1523	1014	\N	no	f	f	f
1524	1065	1026	no	f	f	f
1525	1021	1066	no	f	f	f
1526	1066	1065	no	f	f	f
1527	1014	1021	no	f	f	f
1528	1066	1018	no	f	f	f
1529	1067	1065	no	f	f	f
1530	1026	1065	no	f	f	f
1531	1066	1018	no	f	f	f
1532	1066	1018	no	f	f	f
1604	1029	1072	no	f	f	f
1605	1067	1027	no	f	f	f
1569	1065	1069	no	f	f	f
1570	1065	1067	no	f	f	f
1571	1066	1065	yv	f	f	f
1606	1029	1072	no	f	f	f
1607	1067	\N	no	f	f	f
1608	1066	1074	no	f	f	f
1547	1027	1018	no	f	f	f
1548	1067	1063	no	f	f	f
1549	1067	1047	no	f	f	f
1550	1065	1063	no	f	f	f
1609	1027	1065	no	f	f	f
1566	1066	1072	no	f	f	f
1567	1067	1047	no	f	f	f
1568	1067	1029	no	f	f	f
1572	1067	1065	no	f	f	f
1610	1069	1065	no	f	f	f
1611	1065	1027	no	f	f	f
1612	1029	\N	no	f	f	f
1613	1069	1067	no	f	f	f
1586	1066	1027	no	f	f	f
1587	1067	1065	no	f	f	f
1588	1027	1066	no	f	f	f
1589	1014	1065	no	f	f	f
1590	1067	1069	no	f	f	f
1591	1067	1072	no	f	f	f
1592	1066	1027	no	f	f	f
\.


--
-- Data for TOC entry 115 (OID 110145)
-- Name: epaonnisrankku; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY epaonnisrankku (epaonnisrankkuid, tekija, tyyppi, tyhjamaali, siirrangaikana) FROM stdin;
1055	1019	no	f	f
1355	1066	no	f	f
1553	1067	no	f	f
\.


--
-- Data for TOC entry 116 (OID 110162)
-- Name: rangaistus; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY rangaistus (rangaistusid, saaja, syy, minuutit, paattymisaika) FROM stdin;
1019	1024	71	2	00:26:00
1231	1015	95	2	00:05:31
1020	1011	94	2	00:45:00
1042	1015	71	2	00:10:00
1044	1058	83	2	00:27:59
1045	1056	91	2	00:28:32
1046	1050	86	2	00:35:55
1050	1023	91	2	00:28:32
1051	1018	71	2	00:31:53
1054	1028	71	2	00:14:03
1059	1026	73	2	00:45:00
1073	1021	93	2	00:22:00
1085	1018	95	2	00:06:00
1086	1023	73	2	00:39:00
1087	1028	62	2	00:42:00
1093	1020	94	2	00:19:00
1101	1017	83	2	00:38:34
1107	1027	95	2	00:31:25
1121	1035	94	2	00:24:29
1124	1047	95	2	00:19:10
1294	1047	73	2	00:07:51
1296	1028	94	2	00:45:00
1136	1045	73	2	00:20:49
1142	1026	94	2	00:32:36
1143	1024	91	2	00:37:24
1148	1045	67	2	00:14:23
1314	1067	94	2	00:11:49
1162	1024	94	2	00:15:34
1163	1047	73	2	00:45:00
1176	1010	65	2	00:28:47
1181	1017	73	2	00:43:16
1183	1047	61	2	00:12:29
1184	1017	95	2	00:25:10
1185	1020	61	2	00:39:11
1188	1023	93	2	00:25:02
1189	1026	91	2	00:44:45
1191	1026	94	2	00:31:50
1198	1014	73	2	00:19:12
1201	1023	61	2	00:03:09
1202	1015	65	2	00:20:09
1222	1026	81	2	00:10:47
1223	1020	73	2	00:38:42
1232	1029	71	2	00:39:58
1239	1029	93	2	00:11:54
1242	1016	81	2	00:34:14
1243	1014	94	2	00:44:37
1247	1014	86	2	00:37:01
1254	1027	95	2	00:45:00
1260	1027	87	2	00:41:19
1268	1017	65	2	00:33:28
1269	1017	65	2	00:40:50
1275	1024	95	2	00:11:11
1280	1028	86	2	00:14:19
1286	1024	65	2	00:31:13
1290	1046	65	2	00:29:40
1291	1046	73	2	00:45:00
1298	1023	73	2	00:23:21
1307	1047	67	2	00:45:00
1315	1014	61	2	00:17:00
1316	1047	65	2	00:38:55
1317	1027	95	2	00:42:11
1318	1029	61	2	00:44:43
1322	1026	95	2	00:18:03
1323	1065	81	2	00:40:24
1324	1026	73	2	00:43:24
1354	1046	71	2	00:45:00
1362	1067	46	2	00:01:05
1339	1065	91	2	00:28:20
1340	1067	91	2	00:41:38
1372	1066	75	2	00:16:21
1373	1024	73	2	00:23:02
1379	1069	61	2	00:32:00
1421	1014	94	2	00:43:11
1427	1047	65	2	00:36:30
1428	1067	93	2	00:44:20
1436	1018	93	2	00:29:39
1442	1018	71	2	00:30:54
1454	1065	67	2	00:09:37
1455	1067	67	2	00:33:13
1463	1027	42	2	00:02:52
1498	1066	85	2	00:26:36
1499	1024	83	2	00:33:24
1500	1029	41	2	00:45:00
1519	1029	81	2	00:16:13
1520	1018	87	2	00:35:29
1614	1027	94	2	00:36:49
1565	1027	95	2	00:41:10
1551	1047	71	2	00:40:35
1552	1014	91	2	00:43:10
\.


--
-- Data for TOC entry 117 (OID 110175)
-- Name: pelaajatilasto; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY pelaajatilasto (tilastoid, peliid, joukkue, pelaaja, plusmiinus, numero, kapteeni, maalivahti, kaptuloaika, mvtuloaika, peliaika, torjunnat, paastetytmaalit, lisatieto) FROM stdin;
1032	1045	1	1011	1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1033	1045	1	1015	0	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1034	1045	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1035	1045	1	1017	1	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1036	1045	1	1018	1	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1037	1045	1	1019	1	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1038	1045	1	1021	-2	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1039	1045	1	1022	3	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1040	1045	1	1024	2	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1041	1045	1	1026	2	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1042	1045	1	1027	3	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1043	1045	1	1028	1	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1044	1045	1	1029	-2	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1069	1044	1	1011	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1070	1044	1	1014	3	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1071	1044	1	1015	3	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1072	1044	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1073	1044	1	1017	6	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1074	1044	1	1018	1	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1075	1044	1	1019	5	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1076	1044	1	1020	2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1077	1044	1	1021	1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1078	1044	1	1022	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1079	1044	1	1024	4	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1080	1044	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	4	\N
1081	1044	1	1026	4	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1082	1044	1	1027	3	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1083	1044	1	1028	5	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1084	1044	1	1029	3	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1085	1030	1019	1049	0	8	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1086	1030	1019	1050	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1087	1030	1019	1051	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1088	1030	1019	1052	0	11	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1089	1030	1019	1053	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1090	1030	1019	1054	0	22	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1091	1030	1019	1055	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1092	1030	1019	1056	0	31	f	t	00:00:00	00:00:00	\N	\N	3	\N
1093	1030	1019	1057	0	33	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1094	1030	1019	1059	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1095	1030	1019	1060	0	81	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1096	1030	1019	1058	0	44	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1097	1030	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1098	1030	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1099	1030	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1100	1030	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1101	1030	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1102	1030	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1103	1030	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	3	\N
1104	1030	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	1	\N
1105	1030	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1106	1030	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1107	1030	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1108	1030	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	3	\N
1109	1030	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1110	1030	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	3	\N
1111	1030	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1112	1017	1	1061	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1113	1017	1	1063	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1114	1017	1	1064	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1115	1017	1	1062	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1116	1017	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1117	1017	1	1017	0	10	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1118	1017	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1119	1017	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1120	1017	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	7	\N
1121	1017	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1122	1017	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1123	1017	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1124	1017	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1125	1025	1	1063	0	8	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1126	1025	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1127	1025	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1128	1025	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1129	1025	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1130	1025	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1131	1025	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	6	\N
1132	1025	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1133	1025	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1134	1025	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1135	1025	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1136	1025	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1650	1035	1	1015	0	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1417	1022	2	1001	0	1	f	t	00:00:00	00:00:00	\N	\N	4	\N
1418	1022	2	1002	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1419	1022	2	1003	0	11	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1420	1022	2	1004	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1421	1022	2	1005	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1422	1022	2	1006	0	22	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1423	1022	2	1007	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1424	1022	2	1008	0	34	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1425	1022	2	1009	0	41	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1426	1022	2	1010	0	66	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1427	1022	2	1012	0	69	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1428	1022	2	1013	0	81	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1429	1022	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1430	1022	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1152	1042	1	1014	1	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1153	1042	1	1015	0	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1154	1042	1	1016	2	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1155	1042	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1156	1042	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1157	1042	1	1019	2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1158	1042	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1159	1042	1	1021	1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1160	1042	1	1022	2	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1161	1042	1	1023	1	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1162	1042	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1163	1042	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	4	\N
1164	1042	1	1026	-1	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1165	1042	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1166	1042	1	1028	1	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1583	1039	1	1011	-1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1584	1039	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1195	1043	1	1011	0	3	f	f	00:00:00	00:00:00	\N	\N	4	\N
1196	1043	1	1014	-3	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1197	1043	1	1015	-2	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1198	1043	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1199	1043	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1200	1043	1	1018	-1	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1201	1043	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1202	1043	1	1020	-1	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1203	1043	1	1021	-1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1204	1043	1	1022	0	25	f	f	00:00:00	00:00:00	\N	\N	4	\N
1205	1043	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1206	1043	1	1024	-3	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1207	1043	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	9	\N
1208	1043	1	1026	-1	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1209	1043	1	1027	-1	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1210	1043	1	1028	-1	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1211	1043	1	1029	-2	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1212	1046	1	1011	2	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1213	1046	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	5	\N
1214	1046	1	1015	2	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1215	1046	1	1016	1	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1216	1046	1	1017	1	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1217	1046	1	1018	2	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1218	1046	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	5	\N
1219	1046	1	1020	2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1220	1046	1	1021	1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1221	1046	1	1022	0	25	f	f	00:00:00	00:00:00	\N	\N	5	\N
1222	1046	1	1023	1	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1223	1046	1	1024	4	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1224	1046	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	0	\N
1225	1046	1	1026	4	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1226	1046	1	1027	2	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1227	1046	1	1028	1	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1228	1046	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1243	1023	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1244	1023	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1245	1023	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1246	1023	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1247	1023	1	1019	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1248	1023	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1249	1023	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1250	1023	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1251	1023	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1252	1023	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1253	1023	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1254	1023	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1255	1023	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1256	1023	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1257	1023	1	1048	0	1	f	t	00:00:00	00:00:00	\N	\N	7	\N
1258	1047	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1259	1047	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1260	1047	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1261	1047	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1262	1047	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1263	1047	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1264	1047	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1265	1047	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	\N	\N
1266	1047	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1267	1047	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1268	1047	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1269	1047	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1270	1047	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1271	1047	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1272	1047	1018	1030	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1273	1047	1018	1031	0	6	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1274	1047	1018	1032	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1275	1047	1018	1033	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1276	1047	1018	1034	0	11	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1277	1047	1018	1035	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1278	1047	1018	1036	0	13	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1279	1047	1018	1037	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1280	1047	1018	1038	0	18	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1281	1047	1018	1039	0	20	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1282	1047	1018	1040	0	39	f	t	00:00:00	00:00:00	\N	\N	\N	\N
1283	1047	1018	1041	0	1	f	t	00:00:00	00:00:00	\N	\N	\N	\N
1284	1026	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1285	1026	1	1017	0	10	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1286	1026	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1287	1026	1	1019	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1288	1026	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1289	1026	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1290	1026	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1291	1026	1	1025	0	73	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1292	1026	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1293	1026	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1294	1026	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1295	1026	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1296	1026	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1297	1026	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1298	1026	1	1048	0	1	f	t	00:00:00	00:00:00	\N	\N	2	\N
1651	1035	1	1016	2	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1652	1035	1	1018	1	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1653	1035	1	1019	1	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1654	1035	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1655	1035	1	1022	1	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1656	1035	1	1023	-1	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1657	1035	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1658	1035	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	5	\N
1659	1035	1	1026	3	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1660	1035	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1661	1035	1	1028	1	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1662	1036	1	1011	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1663	1036	1	1014	2	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1664	1036	1	1015	0	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1330	1016	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1331	1016	1	1019	0	73	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1332	1016	1	1023	0	2	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1333	1016	1	1025	0	1	f	t	00:00:00	00:00:00	\N	\N	6	\N
1334	1016	1	1026	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1335	1016	1	1027	0	23	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1336	1016	1	1028	0	33	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1337	1016	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1338	1016	1	1045	0	22	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1339	1016	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1340	1016	1	1047	0	44	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1341	1015	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1342	1015	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1343	1015	1	1017	0	10	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1344	1015	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1345	1015	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1346	1015	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1347	1015	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1348	1015	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1349	1015	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	3	\N
1350	1015	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1351	1015	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1352	1015	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1353	1015	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1354	1015	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1355	1015	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1356	1015	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1357	1018	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1358	1018	1	1015	0	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1359	1018	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1360	1018	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1361	1018	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1362	1018	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1363	1018	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1364	1018	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1365	1018	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	5	\N
1366	1018	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1367	1018	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1368	1018	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1369	1018	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1370	1018	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1371	1018	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1372	1018	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1703	1053	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1704	1053	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1705	1053	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1706	1053	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1707	1053	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1708	1053	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1709	1053	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1710	1053	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	6	\N
1711	1053	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1712	1053	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1713	1053	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1714	1053	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1385	1021	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1386	1021	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1387	1021	1	1017	0	10	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1388	1021	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1389	1021	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1390	1021	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1391	1021	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1392	1021	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1393	1021	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1394	1021	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1395	1021	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1396	1021	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	1	\N
1397	1021	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	1	\N
1398	1021	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	1	\N
1399	1021	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	1	\N
1400	1021	1	1048	0	1	f	t	00:00:00	00:00:00	\N	\N	5	\N
1556	1027	1	1011	2	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1557	1027	1	1014	2	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1558	1027	1	1015	2	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1559	1027	1	1016	2	13	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1560	1027	1	1017	2	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1561	1027	1	1018	-1	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1562	1027	1	1019	2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1563	1027	1	1020	-2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1564	1027	1	1021	2	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1565	1027	1	1024	-1	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1566	1027	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	3	\N
1567	1027	1	1026	3	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1568	1027	1	1027	-2	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1569	1027	1	1028	2	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1570	1027	1	1029	-2	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1431	1022	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1432	1022	1	1019	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1433	1022	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1434	1022	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1435	1022	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	5	\N
1436	1022	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1437	1022	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1438	1022	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1439	1022	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1440	1022	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1441	1022	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1442	1029	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1443	1029	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1444	1029	1	1017	0	10	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1445	1029	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1446	1029	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1447	1029	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1448	1029	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1449	1029	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1450	1029	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	\N	\N
1451	1029	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1452	1029	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1453	1029	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1454	1029	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1455	1029	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1456	1029	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1457	1029	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1458	1010	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1459	1010	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1460	1010	1	1019	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1461	1010	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1462	1010	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1463	1010	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1464	1010	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1465	1010	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	4	\N
1466	1010	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1467	1010	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1468	1010	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1469	1010	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1470	1010	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1471	1010	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1472	1010	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1473	1011	1	1064	0	11	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1474	1011	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1475	1011	1	1019	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1476	1011	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1477	1011	1	1021	0	6	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1478	1011	1	1023	0	2	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1479	1011	1	1024	0	21	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1480	1011	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	5	\N
1481	1011	1	1026	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1482	1011	1	1027	0	23	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1483	1011	1	1028	0	33	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1484	1011	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1485	1011	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1486	1019	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1487	1019	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1488	1019	1	1017	0	10	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1489	1019	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1490	1019	1	1020	0	69	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1491	1019	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1492	1019	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1493	1019	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1494	1019	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1495	1019	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1496	1019	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1497	1019	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1498	1019	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1499	1019	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1500	1019	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1501	1019	1	1048	0	1	f	t	00:00:00	00:00:00	\N	\N	2	\N
1502	1012	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1503	1012	1	1015	0	67	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1504	1012	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1505	1012	1	1019	0	73	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1506	1012	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1507	1012	1	1023	0	2	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1508	1012	1	1025	0	72	f	t	00:00:00	00:00:00	\N	\N	5	\N
1509	1012	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1510	1012	1	1027	0	23	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1511	1012	1	1028	0	33	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1512	1012	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1513	1012	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1514	1012	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1515	1012	1	1047	0	44	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1516	1031	1	1011	1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1517	1031	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1518	1031	1	1019	1	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1519	1031	1	1020	-2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1520	1031	1	1021	2	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1521	1031	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1522	1031	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1523	1031	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	5	\N
1524	1031	1	1026	2	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1525	1031	1	1027	-2	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1526	1031	1	1028	2	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1527	1031	1	1029	1	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1528	1032	1	1011	1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1529	1032	1	1014	-2	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1530	1032	1	1016	-2	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1531	1032	1	1017	2	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1532	1032	1	1019	-2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1533	1032	1	1020	2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1534	1032	1	1021	-1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1535	1032	1	1023	-2	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1536	1032	1	1024	1	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1537	1032	1	1025	0	73	t	t	00:00:00	00:00:00	\N	\N	3	\N
1538	1032	1	1026	1	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1539	1032	1	1027	2	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1540	1032	1	1028	-1	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1541	1032	1	1029	-2	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1542	1033	1	1011	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1543	1033	1	1014	3	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1544	1033	1	1016	4	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1545	1033	1	1017	5	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1546	1033	1	1019	2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1547	1033	1	1020	5	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1548	1033	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1549	1033	1	1023	2	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1550	1033	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1551	1033	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	1	\N
1552	1033	1	1026	7	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1553	1033	1	1027	5	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1554	1033	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1555	1033	1	1029	2	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1571	1028	1	1011	3	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1572	1028	1	1015	0	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1573	1028	1	1017	3	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1574	1028	1	1019	2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1575	1028	1	1020	2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1576	1028	1	1021	3	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1577	1028	1	1024	2	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1578	1028	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	1	\N
1579	1028	1	1026	2	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1580	1028	1	1027	3	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1581	1028	1	1028	3	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1582	1028	1	1029	3	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1585	1039	1	1015	-1	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1586	1039	1	1016	-1	18	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1587	1039	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1588	1039	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1589	1039	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1590	1039	1	1021	-1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1591	1039	1	1022	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1592	1039	1	1024	-1	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1593	1039	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	2	\N
1594	1039	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1595	1039	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1596	1041	1	1014	1	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1597	1041	1	1015	1	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1598	1041	1	1016	2	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1599	1041	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1600	1041	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1601	1041	1	1019	1	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1602	1041	1	1020	1	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1603	1041	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1604	1041	1	1022	1	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1605	1041	1	1024	1	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1606	1041	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	1	\N
1607	1041	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1608	1041	1	1027	1	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1609	1041	1	1028	1	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1610	1037	1	1011	1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1611	1037	1	1014	4	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1612	1037	1	1015	0	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1613	1037	1	1018	3	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1614	1037	1	1019	2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1615	1037	1	1020	2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1616	1037	1	1021	1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1617	1037	1	1022	2	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1618	1037	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	1	\N
1619	1037	1	1026	3	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1620	1037	1	1027	2	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1621	1037	1	1028	3	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1622	1037	1	1029	3	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1623	1038	1	1011	1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1624	1038	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1625	1038	1	1015	1	8	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1626	1038	1	1016	2	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1627	1038	1	1017	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1628	1038	1	1018	1	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1629	1038	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1630	1038	1	1021	1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1631	1038	1	1022	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1632	1038	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1633	1038	1	1024	1	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1634	1038	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	3	\N
1635	1038	1	1026	1	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1636	1038	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1637	1038	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1638	1034	1	1014	4	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1639	1034	1	1017	4	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1640	1034	1	1019	2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1641	1034	1	1021	3	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1642	1034	1	1023	1	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1643	1034	1	1024	1	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1644	1034	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	2	\N
1645	1034	1	1026	5	77	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1646	1034	1	1028	4	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1647	1034	1	1029	2	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1648	1035	1	1011	-1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1649	1035	1	1014	-2	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1745	1074	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1746	1074	1	1046	0	3	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1747	1074	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1748	1074	1	1066	0	8	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1749	1074	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1750	1074	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1751	1074	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1752	1074	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1753	1074	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	1	\N
1754	1074	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1755	1074	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1756	1074	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1715	1054	1	1048	0	1	f	t	00:00:00	00:00:00	\N	\N	\N	\N
1716	1054	1	1019	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1717	1054	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1665	1036	1	1016	0	9	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1666	1036	1	1018	2	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1667	1036	1	1019	-2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1668	1036	1	1020	2	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1669	1036	1	1021	-1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1670	1036	1	1022	-2	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1671	1036	1	1023	2	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1672	1036	1	1024	-2	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1673	1036	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	4	\N
1674	1036	1	1026	-2	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1675	1036	1	1027	3	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1676	1036	1	1028	-2	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1677	1040	1	1011	1	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1678	1040	1	1014	2	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1679	1040	1	1018	-1	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1680	1040	1	1019	2	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1681	1040	1	1020	-1	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1682	1040	1	1021	1	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1683	1040	1	1022	2	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1684	1040	1	1024	2	42	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1685	1040	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	2	\N
1686	1040	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1687	1040	1	1027	-1	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1688	1040	1	1028	2	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1689	1040	1	1029	1	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1690	1048	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1691	1048	1	1017	0	73	f	t	00:00:00	00:00:00	\N	\N	8	\N
1692	1048	1	1019	0	13	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1693	1048	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1694	1048	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1695	1048	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1696	1048	1	1025	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1697	1048	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1698	1048	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1699	1048	1	1029	0	17	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1700	1048	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1701	1048	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1702	1048	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1718	1054	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1719	1054	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1720	1054	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	\N	\N
1721	1054	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1722	1054	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1723	1054	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1724	1055	1	1048	0	1	f	t	00:00:00	00:00:00	\N	\N	13	\N
1725	1055	1	1019	0	14	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1726	1055	1	1020	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1727	1055	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1728	1055	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1729	1055	1	1025	0	89	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1730	1055	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1731	1055	1	1027	0	80	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1732	1055	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1733	1020	1	1046	0	3	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1734	1020	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1735	1020	1	1019	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1736	1020	1	1021	0	19	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1737	1020	1	1045	0	25	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1738	1020	1	1023	0	27	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1739	1020	1	1024	0	42	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1740	1020	1	1025	0	73	f	t	00:00:00	00:00:00	\N	\N	4	\N
1741	1020	1	1026	0	77	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1742	1020	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1743	1020	1	1028	0	87	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1744	1020	1	1047	0	88	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1757	1074	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1758	1079	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1759	1079	1	1046	0	3	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1760	1079	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1761	1079	1	1066	0	8	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1762	1079	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1763	1079	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1764	1079	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1765	1079	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	7	\N
1766	1079	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1767	1079	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1768	1079	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1769	1079	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1770	1079	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1791	1087	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1792	1087	1	1046	0	3	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1793	1087	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1794	1087	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1802	1088	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1803	1088	1	1046	0	3	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1804	1088	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1805	1088	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1795	1087	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1796	1087	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	2	\N
1781	1080	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1782	1080	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1783	1080	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1784	1080	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1785	1080	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	3	\N
1786	1080	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1787	1080	1	1065	0	79	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1788	1080	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1789	1080	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1790	1080	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1797	1087	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1798	1087	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1799	1087	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1800	1087	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1801	1087	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1806	1088	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1807	1088	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1808	1088	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1809	1088	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1810	1088	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1811	1088	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	3	\N
1812	1088	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1813	1088	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1814	1089	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1815	1089	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1816	1089	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1817	1089	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1818	1089	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1819	1089	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1820	1089	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1821	1089	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1822	1089	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1823	1089	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	3	\N
1824	1090	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1825	1090	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1826	1090	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1827	1090	1	1021	0	6	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1828	1090	1	1026	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1829	1090	1	1066	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1830	1090	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1831	1090	1	1047	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1832	1090	1	1024	0	15	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1833	1090	1	1067	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1834	1090	1	1069	0	73	f	t	00:00:00	00:00:00	\N	\N	4	\N
1835	1090	1	1065	0	79	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1836	1104	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1837	1104	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1838	1104	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1839	1104	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1840	1104	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1841	1104	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1842	1104	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1843	1104	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	5	\N
1844	1104	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1845	1104	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1846	1105	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1847	1105	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1848	1105	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1849	1105	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1850	1105	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1851	1105	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1852	1105	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1853	1105	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	\N	\N
1854	1105	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1855	1105	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1876	1125	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1877	1125	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1878	1125	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1879	1125	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1880	1125	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1881	1125	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1882	1125	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1883	1125	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1884	1125	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1885	1125	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1866	1124	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1867	1124	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1868	1124	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1869	1124	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1870	1124	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1871	1124	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1872	1124	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1873	1124	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	3	\N
1874	1124	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1875	1124	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1886	1125	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	2	\N
1887	1125	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1888	1108	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1889	1108	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1890	1108	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1891	1108	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1892	1108	1	1026	0	7	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1893	1108	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1894	1108	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1895	1108	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1896	1108	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1897	1108	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1898	1108	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	2	\N
1899	1108	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1900	1134	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1901	1134	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1902	1134	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1903	1134	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1904	1134	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1905	1134	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1906	1134	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1907	1134	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1908	1134	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1909	1134	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	6	\N
1910	1134	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1911	1110	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1912	1110	1	1065	0	79	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1913	1110	1	1021	0	6	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1914	1110	1	1026	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1915	1110	1	1066	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1916	1110	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1917	1110	1	1067	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1918	1110	1	1068	0	30	f	t	00:00:00	00:00:00	\N	\N	\N	\N
1919	1110	1	1069	0	73	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1920	1135	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1921	1135	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1922	1135	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1923	1135	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1924	1135	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1925	1135	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1926	1135	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1927	1135	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1928	1135	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	5	\N
1929	1135	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1930	1136	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1931	1136	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1932	1136	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1933	1136	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1934	1136	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1935	1136	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1936	1136	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1937	1136	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1938	1136	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1939	1136	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	5	\N
1940	1136	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1941	1137	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1942	1137	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1943	1137	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1944	1137	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1945	1137	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1946	1137	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1947	1137	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1948	1137	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1949	1137	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1950	1137	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1951	1137	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1952	1137	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	5	\N
1953	1137	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1954	1138	1	1027	0	80	f	t	00:00:00	00:00:00	00:45:00	\N	4	\N
1955	1138	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1956	1138	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1957	1138	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1958	1138	1	1026	0	7	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1959	1138	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1960	1138	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1961	1138	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1962	1138	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1963	1138	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1964	1138	1	1069	0	73	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1965	1139	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1966	1139	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1967	1139	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1968	1139	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1969	1139	1	1026	0	7	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1970	1139	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1971	1139	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1972	1139	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1973	1139	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1974	1139	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1975	1139	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	2	\N
1976	1140	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1977	1140	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1978	1140	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1979	1140	1	1021	0	6	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1980	1140	1	1026	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1981	1140	1	1018	0	12	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1982	1140	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1983	1140	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1984	1140	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
1985	1140	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	3	\N
1986	1141	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1987	1141	1	1065	0	79	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1988	1141	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1989	1141	1	1021	0	6	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1990	1141	1	1066	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1991	1141	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1992	1141	1	1024	0	15	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1993	1141	1	1067	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1994	1141	1	1068	0	30	f	t	00:00:00	00:00:00	\N	\N	3	\N
1995	1142	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
1996	1142	1	1065	0	79	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1997	1142	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1998	1142	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
1999	1142	1	1021	0	6	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2000	1142	1	1026	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2001	1142	1	1066	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2002	1142	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2003	1142	1	1067	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2004	1142	1	1068	0	30	f	t	00:00:00	00:00:00	\N	\N	5	\N
2130	1180	1	1069	0	8	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2131	1180	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2132	1180	1	1074	0	13	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2133	1180	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2134	1180	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2135	1180	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2136	1180	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	2	\N
2147	1181	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2148	1181	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2149	1181	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2150	1181	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2095	1179	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2096	1179	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2097	1179	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2098	1179	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2099	1179	1	1072	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2100	1179	1	1069	0	8	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2101	1179	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2102	1179	1	1074	0	13	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2103	1179	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2104	1179	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2105	1179	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	3	\N
2027	1154	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
2028	1154	1	1065	0	79	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2029	1154	1	1063	0	3	f	f	00:00:00	00:00:00	\N	\N	4	\N
2030	1154	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	4	\N
2031	1154	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2032	1154	1	1021	0	6	f	f	00:00:00	00:00:00	\N	\N	4	\N
2033	1154	1	1026	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2034	1154	1	1066	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2035	1154	1	1018	0	12	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2036	1154	1	1047	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2037	1154	1	1024	0	15	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2038	1154	1	1067	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2039	1154	1	1068	0	30	f	t	00:00:00	00:00:00	\N	\N	3	\N
2151	1181	1	1072	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2152	1181	1	1069	0	8	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2153	1181	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2154	1181	1	1074	0	13	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2155	1181	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2156	1181	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	1	\N
2073	1178	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2074	1178	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2075	1178	1	1029	0	4	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2076	1178	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2077	1178	1	1072	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2078	1178	1	1066	0	10	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2079	1178	1	1074	0	13	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2080	1178	1	1047	0	14	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2081	1178	1	1024	0	15	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2082	1178	1	1067	0	16	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2083	1178	1	1068	0	30	f	t	00:00:00	00:00:00	00:45:00	\N	3	\N
2084	1177	1	1027	0	80	t	f	00:00:00	00:00:00	\N	\N	\N	\N
2085	1177	1	1029	0	4	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2086	1177	1	1014	0	5	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2087	1177	1	1072	0	7	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2088	1177	1	1069	0	8	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2089	1177	1	1066	0	10	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2090	1177	1	1074	0	13	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2091	1177	1	1047	0	14	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2092	1177	1	1024	0	15	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2093	1177	1	1067	0	16	f	f	00:00:00	00:00:00	\N	\N	\N	\N
2094	1177	1	1068	0	30	f	t	00:00:00	00:00:00	\N	\N	1	\N
2126	1180	1	1027	0	80	t	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2127	1180	1	1065	0	79	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2128	1180	1	1014	0	5	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
2129	1180	1	1072	0	7	f	f	00:00:00	00:00:00	00:45:00	\N	\N	\N
\.


--
-- Data for TOC entry 118 (OID 110199)
-- Name: toimenkuva; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY toimenkuva (toimenkuva) FROM stdin;
huoltaja
Joukkueenjohtaja
\.


--
-- Data for TOC entry 119 (OID 110203)
-- Name: toimi; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY toimi (tehtava, kaudenjoukkue, kausi, henkilo) FROM stdin;
\N	1018	2004	1042
\N	1018	2004	1043
\N	1018	2004	1044
Joukkueenjohtaja	1	2005	1027
Joukkueenjohtaja	1	2005	1065
Joukkueenjohtaja	1	2006	1027
Joukkueenjohtaja	1	2006	1065
\.


--
-- Data for TOC entry 120 (OID 110215)
-- Name: osallistuja; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY osallistuja (tapahtumaid, osallistuja, paasee, selite) FROM stdin;
1051	1027	t	\N
1050	1029	f	Serkun polttarit
1049	1021	t	\N
1049	1	f	Olen laivalla menossa kohti saksaa.
1049	1027	f	Olen ruotsinlaivalla menossa kohti saksaa.
1050	1027	t	\N
1049	1029	t	\N
1049	1026	t	\N
1050	1026	t	\N
1050	1021	f	Laivalla
1050	1019	t	\N
1050	1025	t	\N
1049	1025	t	\N
1051	1025	t	\N
1050	1020	t	\N
1051	1020	f	töissä
1050	1023	t	\N
1050	1028	t	
1051	1029	t	\N
1051	1024	t	\N
1051	1026	t	\N
1051	1019	f	jalkapohja reistaa
1051	1023	t	\N
1051	1028	t	\N
1051	1021	t	\N
1052	1028	f	menoja
1052	1027	t	\N
1050	1014	t	
1052	1020	t	\N
1052	1029	t	\N
1052	1021	f	muuta menoa
1052	1026	t	\N
1056	1027	t	\N
1056	1026	t	\N
1056	1024	f	töissä
1056	1028	t	\N
1056	1029	t	\N
1056	1021	t	\N
1056	1023	t	\N
1057	1027	t	\N
1057	1028	f	Suomi-Tanska
1057	1026	t	\N
1058	1027	t	\N
1057	1021	f	Suomi-Tanska
1058	1021	t	\N
1057	1023	f	-
1057	1029	f	työkiireitä ilmaantui
1058	1024	f	Slayer
1058	1020	t	\N
1059	1026	t	\N
1058	1028	f	meen mökille
1058	1029	f	sairaslomalla juhannukseen
1059	1027	t	\N
1059	1024	t	\N
1059	1029	t	\N
1059	1021	t	\N
1059	1028	f	työeste
1061	1027	t	\N
1060	1024	f	Juhannus
1060	1026	f	Himoksella
1060	1021	f	Himos
1061	1029	t	\N
1060	1027	f	Viettämässä juhannusta myöskin himoksella
1061	1021	t	\N
1061	1026	f	flunssa
1061	1024	t	\N
1062	1026	t	\N
1062	1027	t	\N
1062	1021	t	\N
1062	1029	t	\N
1063	1029	f	työeste
1063	1027	t	\N
1063	1021	t	\N
1064	1026	t	\N
1064	1065	t	\N
1064	1027	t	\N
1064	1029	t	\N
1064	1021	t	\N
1065	1026	t	\N
1065	1027	t	\N
1065	1065	t	\N
1065	1021	t	\N
1065	1029	f	alaselkä reistaa
1066	1027	f	HCM
1066	1026	t	\N
1066	1065	t	\N
1066	1029	t	\N
1067	1027	t	\N
1067	1026	t	\N
1067	1021	t	\N
1067	1029	t	\N
1067	1065	t	\N
1068	1	t	\N
1068	1065	t	\N
1068	1026	t	\N
1068	1029	t	\N
1068	1021	t	\N
1069	1027	t	\N
1069	1065	t	\N
1070	1065	t	\N
1069	1029	t	\N
1069	1021	t	\N
1070	1027	t	\N
1069	1026	t	\N
1070	1026	f	saunailta
1071	1026	t	\N
1071	1065	t	\N
1071	1027	t	\N
1070	1021	t	\N
1071	1069	t	\N
1071	1068	t	\N
1071	1029	t	\N
1071	1021	t	\N
1072	1027	t	\N
1073	1026	t	\N
1073	1067	t	\N
1073	1027	t	\N
1072	1065	t	\N
1073	1065	t	\N
1072	1067	t	
1073	1021	t	\N
1072	1021	f	Menoja
1073	1069	t	\N
1073	1029	t	\N
1076	1026	t	\N
1078	1026	f	saksassa
1074	1026	f	saksassa
1077	1026	f	saksassa
1075	1065	t	\N
1075	1069	t	\N
1076	1069	t	\N
1077	1069	t	\N
1078	1069	t	\N
1075	1027	t	\N
1076	1027	t	\N
1076	1065	t	\N
1076	1021	t	\N
1076	1024	t	\N
1077	1065	t	\N
1074	1069	t	\N
1078	1065	t	\N
1074	1065	t	\N
1076	1067	t	\N
1078	1067	t	\N
1074	1067	t	\N
1077	1027	t	\N
1076	1029	f	flunssa
1078	1027	t	\N
1074	1027	t	\N
1078	1068	t	\N
1074	1068	t	\N
1078	1021	t	\N
1074	1021	t	\N
1077	1021	t	\N
1078	1029	t	\N
1074	1029	t	\N
1078	1024	t	\N
1074	1024	t	\N
1074	1046	t	\N
1079	1046	t	\N
1074	1014	t	\N
1082	1065	t	\N
1081	1065	t	\N
1079	1065	t	\N
1081	1069	t	\N
1081	1027	t	\N
1082	1027	t	\N
1079	1027	t	\N
1079	1029	t	\N
1082	1046	t	\N
1082	1029	f	Kangasalalla
1081	1021	f	Menoja
1083	1069	f	kouluhommat painavat päälle
1079	1021	t	\N
1082	1069	t	\N
1079	1069	t	\N
1080	1069	t	\N
1082	1024	f	Helsingissä
1079	1024	t	\N
1082	1068	t	\N
1082	1021	f	Työt
1079	1068	t	\N
1079	1026	t	\N
1083	1065	f	vanhan paikat ei oo palautunu viä lauantaista
1080	1065	t	\N
1084	1065	t	\N
1083	1027	f	Jään kotiin toipumaan nivus revähdyksestä, joka sattui la pelissä
1084	1027	t	\N
1084	1069	t	\N
1083	1021	f	Eihän siällä sitte enää ketää ole
1084	1026	t	\N
1084	1068	t	\N
1080	1027	t	\N
1084	1024	t	\N
1080	1024	t	\N
1084	1021	t	\N
1080	1026	t	\N
1084	1029	t	\N
1080	1029	t	\N
1080	1068	t	\N
1085	1065	t	\N
1086	1065	t	\N
1087	1065	t	\N
1086	1046	f	hämeenkadun appro
1087	1046	t	\N
1086	1069	t	\N
1085	1027	f	Tuli työ kiireitä enkä pääse tulemaan
1086	1027	t	\N
1087	1027	t	\N
1087	1026	t	\N
1086	1026	t	\N
1087	1069	t	\N
1086	1029	f	tentti
1087	1029	f	mökkireissu ruovedellä
1086	1024	t	\N
1087	1024	t	\N
1091	1027	t	\N
1091	1024	f	koulu & lätkämatsi
1086	1068	t	\N
1087	1068	t	\N
1093	1026	f	Ilmasta viinaa
1092	1065	t	\N
1093	1065	t	\N
1088	1065	t	\N
1088	1026	t	\N
1091	1065	t	\N
1093	1069	t	\N
1088	1069	t	\N
1093	1024	f	käsivamma
1088	1024	f	käsivamma
1092	1024	f	käsivamma
1094	1024	f	käsivamma
1093	1027	t	\N
1088	1027	t	\N
1093	1067	t	\N
1088	1067	t	\N
1092	1067	f	menkat..sattuu mahaan..ai ai
1092	1027	t	\N
1091	1067	t	\N
1088	1047	f	Tulva, heinäsirkat syönyt autosta renkaat, vatsatauti, pölynimuri temppuilee, onneksi on If
1094	1027	t	\N
1088	1029	t	\N
1093	1068	f	Pärkeleen koulu
1088	1068	t	\N
1093	1029	f	varvas paskana, toivottavasti toipuu sunnuntaiksi...
1088	1021	t	\N
1089	1026	t	\N
1091	1026	t	\N
1095	1026	t	\N
1094	1065	t	\N
1095	1065	t	\N
1096	1065	f	Keuhkoputken tulehdus
1095	1021	t	\N
1091	1068	t	\N
1095	1024	t	\N
1089	1024	t	\N
1094	1026	t	\N
1091	1069	f	because of the logistics lecture
1089	1069	f	Hiusmallikeikka
1095	1067	t	\N
1089	1067	t	\N
1095	1027	t	\N
1089	1027	t	\N
1095	1069	f	Koulua 17-20,prkl...
1095	1029	t	\N
1089	1068	t	\N
1089	1029	t	\N
1089	1065	f	Kuumetta ja keuhkoputken tulehdus !?
1098	1065	f	Keuhkoputken tulehdus
1096	1027	f	jonkin sortin tauti on iskenyt kyntensä
1100	1027	f	En pysty pelaamaan mutta tuun paikanpäälle.
1100	1065	f	keuhkoihin pistää ja vituttaa
1100	1029	t	\N
1090	1029	t	\N
1090	1027	t	\N
1103	1027	t	\N
1100	1068	t	\N
1090	1068	f	junnujen turnaus
1100	1026	t	\N
1090	1026	t	\N
1100	1069	f	koulua perkele
1090	1069	t	\N
1100	1024	t	\N
1090	1024	t	\N
1100	1021	t	\N
1090	1067	t	\N
1103	1067	t	\N
1101	1027	t	\N
1090	1065	t	\N
1090	1021	t	\N
1102	1026	t	\N
1103	1026	t	\N
1103	1065	t	\N
1102	1027	t	\N
1101	1065	f	Muuta meininkiä
1101	1026	t	\N
1102	1065	t	\N
1102	1069	f	Koulua 17-20,prkl...
1103	1069	t	\N
1102	1021	t	\N
1103	1021	t	\N
1102	1029	f	kouluhommia
1103	1029	f	en ole tampereella vkonloppuna
1102	1024	t	\N
1103	1024	t	\N
1102	1068	f	flussaa pukkaa vielä
1102	1067	t	\N
1111	1027	t	\N
1112	1026	t	\N
1104	1026	t	\N
1111	1065	t	\N
1112	1024	t	\N
1104	1024	t	\N
1111	1026	t	\N
1112	1027	t	\N
1104	1027	t	\N
1104	1069	t	\N
1112	1067	t	\N
1104	1067	t	\N
1113	1067	f	mutsi leipoo pullia
1112	1065	t	\N
1104	1065	t	\N
1112	1069	f	Koulua 17-20,prkl...
1112	1021	t	\N
1104	1021	f	En oo Tampereella
1113	1027	t	\N
1112	1029	t	\N
1104	1029	t	\N
1113	1069	t	\N
1114	1069	t	\N
1105	1069	t	\N
1114	1027	t	\N
1113	1026	t	\N
1114	1026	t	\N
1105	1026	t	\N
1113	1065	t	\N
1114	1024	t	\N
1105	1024	t	\N
1105	1027	t	\N
1114	1065	t	\N
1115	1027	f	en taida sittenkään jaksaa lähteä
1114	1021	t	\N
1105	1021	t	\N
1114	1068	t	\N
1105	1068	t	\N
1114	1067	f	oon pipi
1115	1067	f	vittu jaksa siä käydä
1105	1029	f	nilkka vääntyi lenkillä =/
1116	1024	t	\N
1105	1065	f	huilia salibandystä ennen TO-harkkoja
1115	1065	f	salibandystä huilia ennen TO-reenejä
1116	1027	t	\N
1115	1026	f	Tiistaina tentti
1115	1069	f	Iltavaksi-mummo sano et mul ei o sinne mitää asiaa
1116	1069	t	\N
1117	1069	f	Treffit SEN(tiärätte kyl) jumppamaikan kans Herwoodin Kultases Apinas
1116	1065	t	\N
1116	1026	t	\N
1116	1067	t	\N
1116	1068	f	Silmätulehdus
1116	1029	t	\N
1117	1067	f	täytyy tyhjentää säkkejä
1117	1065	f	ei siä oo tarpeeks jengiä
1118	1065	t	\N
1117	1027	f	en oo trella
1118	1027	t	\N
1118	1069	f	Treffit Peltsun jumppamaikan kans,osa 2
1117	1021	f	Emmääkään siällä ole
1118	1021	t	\N
1124	1021	f	Saksassa
1118	1026	t	\N
1124	1069	t	\N
1118	1068	t	\N
1124	1068	t	\N
1124	1027	t	\N
1118	1067	t	\N
1118	1029	f	pikkujoulut
1124	1067	t	\N
1118	1024	t	\N
1124	1024	t	\N
1118	1047	t	\N
1124	1026	t	\N
1124	1029	t	\N
1120	1065	t	\N
1119	1069	f	Jumppamaikka part 3,Eric Prydz-call on me ja haarahyppelly
1124	1065	t	
1119	1029	t	\N
1120	1029	t	\N
1119	1065	f	eturauhastulehdus päällä
1125	1065	t	\N
1120	1027	t	\N
1120	1024	t	\N
1125	1024	t	\N
1120	1026	t	\N
1125	1026	t	\N
1120	1069	f	tentti,17-
1125	1069	t	\N
1121	1065	t	
1120	1068	t	\N
1125	1068	t	\N
1125	1027	t	\N
1125	1021	t	\N
1125	1067	t	\N
1123	1024	t	\N
1125	1029	t	\N
1121	1069	t	\N
1121	1027	t	\N
1122	1027	t	\N
1122	1065	f	odotan pelkkää pukkia
1121	1026	t	\N
1122	1024	t	\N
1122	1067	f	odotan innasta perse rasvattuna
1122	1069	f	Odotan Jutee,se on luvannu olla pukkina kaikille mun 13 muksulle ja Zei Myllynen leipoo piparitalon
1122	1026	t	\N
1123	1027	f	Lewillä katkomassa jalat ja hakemassa kokovartalo puudutusta
1122	1021	f	Voi olla etten kerkee
1110	1024	f	ulkomailla
1123	1065	t	\N
1123	1026	f	Levillä...
1123	1029	t	\N
1123	1067	t	\N
1123	1021	t	\N
1123	1069	f	En osaa sanoo viä ku pitäs paistaa laskiaispullia
1126	1065	t	\N
1108	1065	t	\N
1126	1024	t	\N
1108	1024	t	\N
1127	1065	t	\N
1127	1027	t	\N
1126	1027	f	kuumetta
1108	1026	t	\N
1126	1021	t	\N
1108	1021	t	\N
1126	1068	t	\N
1108	1068	t	\N
1127	1024	f	luennolla
1128	1024	f	matkalla
1126	1069	t	\N
1108	1069	t	\N
1126	1026	f	flunssa
1126	1029	t	\N
1108	1029	t	\N
1108	1027	f	kipeenä
1129	1026	t	\N
1129	1027	t	\N
1129	1069	t	\N
1129	1065	t	\N
1127	1068	t	\N
1130	1069	f	Pariisissa
1127	1026	t	\N
1127	1021	t	\N
1127	1069	t	\N
1129	1021	t	\N
1129	1024	f	luennolla
1128	1065	t	\N
1110	1065	t	\N
1128	1026	t	\N
1110	1026	t	\N
1128	1069	t	\N
1128	1027	t	\N
1110	1027	t	\N
1128	1068	t	\N
1110	1068	t	\N
1128	1021	t	\N
1110	1021	t	\N
1110	1069	t	\N
1128	1029	t	\N
1110	1029	t	\N
1128	1067	t	\N
1110	1067	t	\N
1129	1067	f	plop
1130	1026	t	\N
1135	1067	t	\N
1136	1067	t	\N
1130	1065	t	\N
1130	1027	t	\N
1130	1067	f	kebapilla
1130	1024	f	luennolla
1130	1021	t	\N
1130	1029	f	tentti
1130	1068	t	\N
1131	1024	t	\N
1135	1024	t	\N
1136	1024	t	\N
1131	1026	f	Bodomin keikalla
1135	1026	t	\N
1136	1026	t	\N
1131	1065	t	\N
1135	1065	t	\N
1136	1065	t	\N
1131	1027	t	\N
1135	1027	t	\N
1131	1069	t	\N
1131	1021	t	\N
1136	1021	t	\N
1136	1027	t	\N
1131	1067	t	\N
1135	1069	t	\N
1136	1069	t	\N
1132	1069	t	\N
1131	1029	t	\N
1135	1029	t	\N
1136	1029	t	\N
1131	1068	t	\N
1135	1068	t	\N
1136	1068	t	\N
1132	1026	t	\N
1132	1065	t	\N
1132	1027	t	\N
1132	1068	t	\N
1137	1068	t	\N
1132	1024	f	luennolla
1137	1024	t	\N
1132	1029	t	\N
1137	1029	f	tod näk en ole ajoissa takaisin Treella, koitan ehtiä paikalla jos pystyn
1137	1065	t	\N
1132	1067	t	\N
1137	1067	t	\N
1132	1021	t	\N
1137	1021	t	\N
1137	1027	t	\N
1137	1026	t	\N
1137	1069	t	\N
1133	1069	t	\N
1133	1026	t	\N
1138	1026	t	\N
1133	1065	t	\N
1138	1065	t	\N
1133	1027	t	\N
1138	1027	t	\N
1133	1068	t	\N
1138	1068	f	Serkun häät
1133	1021	t	\N
1138	1021	t	\N
1133	1029	f	luento
1133	1067	t	\N
1138	1067	t	\N
1138	1069	t	\N
1143	1027	t	\N
1143	1026	t	\N
1138	1029	f	vatsatauti
1143	1069	t	\N
1143	1024	f	tentti
1139	1067	t	\N
1140	1067	t	\N
1143	1067	t	\N
1143	1065	t	\N
1143	1068	t	\N
1143	1029	t	\N
1143	1021	t	\N
1144	1021	f	nytei ehdikkään
1144	1065	t	
1144	1026	t	\N
1144	1024	t	\N
1139	1024	t	\N
1144	1027	t	\N
1147	1067	t	\N
1144	1068	t	\N
1139	1068	t	\N
1144	1029	t	\N
1139	1029	t	\N
1144	1067	t	\N
1147	1026	t	\N
1145	1067	t	\N
1139	1065	t	
1144	1014	t	\N
1139	1026	t	\N
1139	1027	f	Kuumetta
1139	1021	t	\N
1145	1065	t	\N
1140	1065	t	\N
1146	1014	t	\N
1140	1024	t	\N
1145	1068	f	Meen Naantaliin
1140	1068	t	\N
1145	1026	t	\N
1140	1026	t	\N
1146	1026	f	Hartwal excursio
1141	1067	t	\N
1145	1027	t	\N
1140	1027	t	\N
1145	1021	t	\N
1140	1021	t	\N
1145	1024	f	flunssa
1145	1029	f	luento
1140	1029	t	\N
1146	1024	t	\N
1146	1027	t	\N
1146	1029	t	\N
1141	1026	f	Skanskan turnaus
1141	1069	f	Koovee ei maksa lentoja
1146	1021	f	flunssaa pukkaa
1146	1065	f	ruokatorvitulehdus/jalkahermostojen kipu
1146	1068	t	\N
1146	1067	f	saa ny nähä
1147	1065	t	\N
1141	1065	t	\N
1147	1027	t	\N
1142	1026	t	\N
1147	1024	t	\N
1141	1024	t	\N
1147	1029	t	\N
1141	1029	t	\N
1147	1068	t	\N
1141	1068	t	\N
1147	1021	t	\N
1141	1021	t	\N
1141	1027	t	\N
1141	1047	f	Olen töissä
1148	1065	t	\N
1142	1065	t	\N
1148	1024	f	töissä
1142	1024	f	töissä
1148	1026	t	\N
1148	1027	t	\N
1148	1068	t	\N
1148	1029	t	\N
1142	1029	t	\N
1148	1067	t	\N
1142	1067	t	\N
1154	1065	t	\N
1148	1021	t	\N
1142	1021	t	\N
1142	1027	t	\N
1142	1068	t	\N
1142	1014	t	\N
1149	1026	t	\N
1149	1065	t	\N
1150	1027	t	\N
1149	1024	t	\N
1150	1026	t	\N
1154	1067	t	\N
1149	1027	t	\N
1154	1029	t	\N
1149	1068	t	\N
1150	1065	t	\N
1154	1027	t	\N
1150	1029	t	\N
1149	1029	f	vatsatauti
1150	1067	t	\N
1149	1067	t	\N
1150	1068	t	\N
1154	1068	t	\N
1154	1026	t	\N
1150	1021	t	\N
1154	1021	t	\N
1154	1024	t	\N
1151	1026	t	\N
1151	1024	f	töissä
1151	1029	t	\N
1151	1027	t	\N
1151	1065	f	meen lenkille, heh
1151	1069	f	Berlin City Marathon
1151	1067	f	lätkä peli...on on!
1151	1068	t	\N
1151	1021	t	\N
1155	1065	t	\N
1156	1026	t	\N
1156	1065	t	\N
1156	1067	t	\N
1155	1067	t	\N
1155	1027	t	\N
1156	1021	t	\N
1157	1026	t	\N
1156	1029	t	\N
1156	1024	t	
1156	1027	t	\N
1157	1068	f	Futispeli
1157	1027	f	Parantelen jalkaani
1157	1029	f	työreissussa
1157	1065	t	\N
1157	1067	f	kiakko peli
1155	1021	t	\N
1158	1024	f	futista
1158	1067	f	peppureijässä kakkaa
1155	1024	t	\N
1159	1065	f	nilkan nivelsiteen venähdys
1155	1029	t	\N
1158	1065	f	oli matsi jo päivällä
1158	1026	f	-
1159	1026	t	\N
1155	1026	t	\N
1159	1067	f	nain jutee pyppyyn
1167	1065	t	\N
1158	1027	f	Jätän väliin henkilökohtaisista syistä
1167	1027	t	\N
1167	1067	t	\N
1167	1029	f	töitä, konferenssipuhelu jenkkeihin
1167	1021	t	\N
1168	1067	f	töitä, lähetän kirjeen Nigeriaan
1168	1065	f	Kevätsarjan välierä
1160	1072	t	\N
1168	1024	f	tentti
1161	1024	f	juhannus
1168	1027	f	Kevätsarjan välierä
1160	1027	f	Kesälomalla Barcelonassa
1160	1065	t	
1168	1072	f	on minun vuoroni laittaa lapset nukkumaan
1161	1072	f	edustuksen sponsoreiden voitelutapahtuma
1160	1026	f	Barcelonassa
1168	1029	f	lähden lenkille =)
1161	1071	f	töitä helsingissä
1170	1071	f	töitä helsingissä
1161	1021	f	juhannus
1163	1071	f	töitä helsingissä
1169	1065	t	\N
1169	1072	f	kaverin tytön synttärit
1170	1072	f	edustuksen reenit
1162	1067	t	\N
1162	1071	f	töitä helsingissä
1161	1027	f	juhannus
1169	1067	f	ku kukaan muukaan ei pääse, ja kiva ku kaikki on vaivautunu ilmottaa et pääseekö vai ei
1170	1065	t	\N
1169	1021	f	ei siällä sitte taaskaa ketää ole
1169	1071	f	töitä helsingissä
1170	1027	t	\N
1161	1029	f	juhannus
1161	1026	f	ryyppäämässä
1161	1067	f	kai se sit on juhannus
1162	1027	t	\N
1161	1065	f	ei varmaa oo paikka auki
1170	1021	f	huono tekosyy
1170	1029	f	juhannuksen jälkeinen huono olo
1162	1026	t	\N
1162	1065	t	\N
1170	1067	f	liiasta makkaran syömisestä paha olo?viinaan mies ei oo koskenu kuitenkaa
1162	1021	f	Englannissa
1164	1021	f	Englannissa
1163	1027	t	\N
1163	1024	f	Unitedin peli
1162	1024	f	edustustehtäviä
1165	1021	f	Englannissa
1164	1027	t	\N
1163	1067	f	jointti suussa regee bileissä bob marleyn kanssa
1166	1027	t	\N
1163	1072	f	edustuksen reenit
1162	1072	t	\N
1163	1065	f	on Jouluaatto
1163	1029	f	ei siellä näkyny ketään
1162	1029	t	\N
1164	1065	t	
1166	1065	t	\N
1171	1065	f	Lomalla Turkissa
1172	1065	f	Lomalla Turkissa
1164	1067	f	Turkissa
1165	1067	f	Turkissa
1166	1067	f	Turkissa
1171	1067	f	Turkissa
1164	1071	f	vielä viikko helsingissä
1165	1071	f	vielä viikko helsingissä
1166	1071	f	vielä viikko helsingissä
1171	1071	t	\N
1164	1024	f	tentti
1164	1026	t	\N
1166	1026	t	\N
1165	1072	f	saunan panelointi
1166	1072	t	\N
1165	1027	f	reenit peruttu
1171	1027	f	Kaverit on kylässä
1171	1029	f	lomalla Italiassa
1171	1069	f	italia maailmanmestari
1172	1071	t	\N
1165	1065	f	reenit peruttu
1165	1024	t	\N
1165	1018	t	\N
1173	1071	t	\N
1166	1041	t	\N
1172	1029	f	lomalla Italiassa
1166	1029	f	työkiireitä
1172	1069	f	italia maailmanmestari
1173	1069	t	\N
1174	1069	t	\N
1175	1069	t	\N
1172	1026	t	\N
1174	1071	t	\N
1175	1071	t	\N
1172	1024	t	\N
1172	1027	t	
1172	1067	t	\N
1173	1026	t	\N
1173	1027	t	\N
1173	1024	t	\N
1174	1024	f	Tamun peli
1174	1027	t	\N
1174	1067	t	\N
1174	1065	t	\N
1195	1065	t	\N
1174	1021	t	\N
1175	1065	t	\N
1174	1029	t	\N
1174	1074	t	\N
1175	1021	t	\N
1175	1027	t	\N
1175	1067	t	\N
1175	1029	f	leffareissu
1176	1065	f	junnujen reenit
1175	1024	f	kipeä
1176	1071	f	töitä
1196	1071	t	\N
1195	1027	t	\N
1195	1021	t	\N
1195	1029	t	\N
1195	1072	f	Nilkka ei oikein kestä pelaamista. Saatan kyllä tulla lasten kanssa käymään!
1195	1067	t	\N
1195	1024	f	mökillä
1196	1027	t	\N
1196	1074	f	töissä hml:ssä
1196	1065	t	\N
1196	1072	t	\N
1211	1029	t	\N
1196	1029	t	\N
1212	1071	t	\N
1196	1024	t	\N
1196	1069	t	\N
1212	1069	t	\N
1196	1067	t	\N
1212	1074	f	töissä hml:ssä
1212	1065	t	\N
1211	1065	t	\N
1212	1027	t	\N
1213	1069	t	\N
1212	1072	f	Pokeri-ilta
1213	1072	t	\N
1212	1029	t	\N
1212	1024	t	\N
1212	1021	t	\N
1241	1069	t	\N
1213	1065	t	\N
1240	1065	f	en sittenkään pääse Koska: En sittenkään pääse
1213	1027	t	\N
1241	1065	t	\N
1241	1027	t	\N
1240	1072	f	hoidan lapsia
1240	1067	t	\N
1241	1067	t	\N
1211	1067	t	\N
1213	1067	t	\N
1241	1024	t	\N
1240	1027	f	Kurkku on kipeä. :-(
1240	1021	f	Ketään tuu
1211	1069	t	\N
1241	1029	t	\N
1241	1021	t	\N
1211	1027	t	\N
1213	1024	t	\N
1211	1024	t	\N
1213	1029	t	\N
1211	1072	t	
1242	1065	t	\N
1242	1067	t	\N
1242	1027	t	\N
1213	1021	t	\N
1213	1014	t	\N
1211	1074	f	En ole vielä tampereella, ens vkolla sitten kunnolla rosterissa
1242	1074	f	en ole vielä trella; en vkosta eteenpäin mukana
1242	1029	f	kaverin polttarit, tulen ennen niitä poikkeamaan jos ehdin
1211	1068	t	\N
1242	1068	t	\N
1223	1065	t	\N
1223	1069	t	\N
1223	1024	t	\N
1197	1027	t	\N
1223	1029	t	\N
1197	1069	t	\N
1223	1067	t	\N
1223	1021	t	\N
1223	1027	t	
1223	1074	t	\N
1197	1024	t	\N
1197	1065	t	\N
1197	1029	t	\N
1225	1065	t	\N
1224	1027	t	\N
1224	1065	t	\N
1197	1072	t	\N
1224	1024	t	\N
1224	1069	t	\N
1225	1027	t	\N
1224	1074	f	kipeenä..flunssa !!
1224	1029	f	selkä prakaa
1224	1021	f	menoa
1224	1067	t	\N
1226	1024	t	\N
1226	1074	t	\N
1225	1024	t	\N
1177	1024	t	\N
1225	1029	t	\N
1225	1067	t	\N
1177	1067	t	\N
1198	1067	f	Toimitsijana
1225	1074	t	\N
1177	1029	t	\N
1225	1068	t	\N
1177	1068	t	\N
1225	1021	f	Kurssilla
1226	1068	t	\N
1177	1072	t	\N
1177	1074	t	\N
1226	1027	t	\N
1198	1027	t	\N
1178	1068	t	\N
1177	1027	t	
1226	1065	t	\N
1226	1069	t	\N
1177	1065	f	hautajaisissa Ruovedella
1198	1069	t	\N
1198	1065	f	toimitsijana
1178	1069	t	\N
1198	1068	t	\N
1226	1029	t	\N
1198	1029	t	\N
1178	1029	t	\N
1198	1024	t	\N
1178	1024	t	\N
1226	1021	t	\N
1226	1067	t	\N
1178	1065	t	\N
1179	1024	f	Turussa
1178	1067	t	\N
1178	1027	t	\N
1179	1065	t	\N
1227	1065	t	\N
1227	1027	t	\N
1227	1024	t	\N
1227	1069	t	\N
1179	1069	t	\N
1228	1069	t	\N
1227	1068	t	\N
1179	1068	t	\N
1227	1029	t	\N
1227	1072	t	\N
1179	1072	t	\N
1227	1021	f	Kurssilla
1179	1027	t	\N
1179	1029	t	\N
1228	1068	t	\N
1228	1024	t	\N
1199	1024	t	\N
1228	1027	t	
1180	1024	t	\N
1199	1027	f	Huilivuorossa
1199	1065	t	\N
1229	1027	t	
1228	1065	t	\N
1180	1065	t	\N
1199	1069	t	\N
1180	1069	t	\N
1229	1014	f	menee todennäköisesti ylitöiksi
1214	1069	t	\N
1228	1074	t	\N
1228	1021	f	Taas koulussa
1229	1021	t	\N
1228	1029	t	\N
1199	1029	t	\N
1229	1029	t	\N
1228	1072	f	krapula eilisen keikan jäljiltä
1180	1029	f	-
1180	1027	t	\N
1199	1072	f	edelleen toistaitoinen
1180	1072	t	\N
1180	1068	t	\N
1229	1024	t	\N
1229	1065	f	pidän säbästä tän vkon lomaa
1214	1065	t	\N
1229	1069	f	Ilves-HPK; 1. vitja Pesonen-Lindgren-Singh
1229	1067	t	\N
1214	1027	t	\N
1214	1029	t	\N
1200	1029	t	\N
1230	1029	t	\N
1200	1065	t	\N
1214	1021	t	\N
1200	1021	t	\N
1230	1021	t	\N
1214	1024	t	\N
1200	1024	t	\N
1230	1024	t	\N
1200	1027	t	\N
1214	1067	t	\N
1200	1067	t	\N
1230	1065	t	\N
1230	1027	t	\N
1200	1072	t	\N
1230	1072	t	\N
1231	1065	t	\N
1181	1065	t	\N
1215	1072	f	mailan lavasta on puolet hioutunut pois
1215	1065	f	raholasarjan "kuuma vääntö" samaan aikaan
1231	1027	t	\N
1215	1069	f	massiiviset rintalihakset kipeet salitreenistä
1231	1069	t	\N
1181	1069	t	\N
1215	1024	f	jaksan paikalle vaan, jos saadaan edes jotain höntsyjä kasaan
1181	1027	t	\N
1231	1024	t	\N
1215	1047	f	Reenit
1231	1072	t	\N
1231	1068	t	\N
1181	1068	t	\N
1215	1027	f	Ei tuolla taida mitään yksin tehdä... :-(
1216	1065	t	\N
1231	1014	t	\N
1231	1029	f	flunssan poikanen
1231	1067	t	\N
1231	1021	f	Koulu/Peli
1216	1069	f	leivon pullia jouluksi pakkaseen
1181	1067	t	\N
1181	1024	f	krapula
1181	1029	t	\N
1232	1065	t	\N
1216	1029	t	\N
1232	1029	t	\N
1216	1027	t	\N
1216	1024	t	\N
1232	1024	t	\N
1201	1024	t	\N
1232	1027	t	\N
1216	1074	f	Mulla yks "projektipalaveri" samaanaikaan!
1232	1074	t	\N
1216	1021	t	\N
1216	1067	f	räkää valuu ja talvi vituttaa..sais ees pillua
1232	1069	t	\N
1201	1069	t	\N
1269	1065	f	on raholasarjan peli
1232	1072	t	\N
1232	1068	t	\N
1232	1067	t	\N
1201	1027	t	\N
1201	1065	t	\N
1233	1065	t	\N
1182	1065	t	\N
\.


--
-- Data for TOC entry 121 (OID 110230)
-- Name: pelaajat; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY pelaajat (joukkue, kausi, pelaaja, pelinumero, pelipaikka, kapteeni, aloituspvm, lopetuspvm) FROM stdin;
1	2005	1063	\N	\N	f	\N	\N
1	2003	1011	3	KE	f	\N	\N
1	2003	1014	5	PU	f	\N	\N
1	2003	1015	8	OL	t	\N	\N
1	2003	1016	9	PU	f	\N	\N
1	2003	1017	10	KE	f	\N	\N
1	2003	1018	12	VL	f	\N	\N
1	2003	1019	14	KE	f	\N	\N
1	2003	1020	16	OL	f	\N	\N
1	2003	1021	19	VL	f	\N	\N
1	2003	1022	25	OL	f	\N	\N
1	2003	1023	27	VL	f	\N	\N
1	2003	1024	42	PU	f	\N	\N
1	2003	1025	73	MV	f	\N	\N
1	2003	1026	77	PU	f	\N	\N
1	2003	1027	80	VL	f	\N	\N
1	2003	1028	87	VL	f	\N	\N
1	2003	1029	17	OL	f	\N	\N
2	2004	1001	\N	\N	f	\N	\N
2	2004	1002	\N	\N	f	\N	\N
2	2004	1003	\N	\N	f	\N	\N
2	2004	1004	\N	\N	f	\N	\N
2	2004	1005	\N	\N	f	\N	\N
2	2004	1006	\N	\N	f	\N	\N
2	2004	1007	\N	\N	f	\N	\N
2	2004	1008	\N	\N	f	\N	\N
2	2004	1009	\N	\N	f	\N	\N
2	2004	1010	\N	\N	f	\N	\N
2	2004	1012	\N	\N	f	\N	\N
2	2004	1013	\N	\N	f	\N	\N
1018	2004	1030	3	VL	f	\N	\N
1018	2004	1031	6	VL	f	\N	\N
1018	2004	1032	7	VL	f	\N	\N
1018	2004	1033	9	VL	f	\N	\N
1018	2004	1034	11	VL	t	\N	\N
1018	2004	1035	12	VL	f	\N	\N
1018	2004	1036	13	VL	f	\N	\N
1018	2004	1037	17	VL	f	\N	\N
1018	2004	1038	18	VL	f	\N	\N
1018	2004	1039	20	VL	f	\N	\N
1018	2004	1040	39	MV	f	\N	\N
1018	2004	1041	1	MV	f	\N	\N
1019	2004	1049	-1	\N	f	\N	\N
1019	2004	1050	-1	\N	f	\N	\N
1019	2004	1052	-1	\N	f	\N	\N
1019	2004	1053	-1	\N	f	\N	\N
1019	2004	1054	-1	\N	f	\N	\N
1019	2004	1055	-1	\N	f	\N	\N
1019	2004	1056	-1	\N	f	\N	\N
1019	2004	1057	-1	\N	f	\N	\N
1019	2004	1059	-1	\N	f	\N	\N
1019	2004	1060	-1	\N	f	\N	\N
1019	2004	1058	-1	\N	f	\N	\N
1018	2004	1042	\N	\N	f	\N	\N
1018	2004	1043	\N	\N	f	\N	\N
1018	2004	1044	\N	\N	f	\N	\N
1	2004	1048	1	MV	f	\N	\N
1	2004	1046	3	PU	f	\N	\N
1	2004	1014	5	PU	f	\N	\N
1	2004	1015	8	OL	f	\N	\N
1	2004	1016	9	PU	f	\N	\N
1	2004	1017	10	KE	t	\N	\N
1	2004	1018	12	VL	f	\N	\N
1	2004	1019	14	VL	f	\N	\N
1	2004	1020	16	VL	f	\N	\N
1	2004	1029	17	OL	f	\N	\N
1	2004	1021	19	VL	f	\N	\N
1	2004	1045	25	KE	f	\N	\N
1	2004	1023	27	OL	f	\N	\N
1	2004	1024	42	PU	f	\N	\N
1	2004	1025	73	MV	f	\N	\N
1	2004	1026	77	PU	f	\N	\N
1	2004	1027	80	VL	f	\N	\N
1	2004	1028	87	OL	f	\N	\N
1	2004	1047	88	PU	f	\N	\N
1	2004	1061	-1	\N	f	\N	\N
1	2004	1063	-1	\N	f	\N	\N
1	2004	1064	-1	\N	f	\N	\N
1	2004	1062	-1	\N	f	\N	\N
1019	2004	1051	-1	\N	f	\N	\N
1	2005	1029	4	OL	f	\N	\N
1	2005	1014	5	PU	f	\N	\N
1	2005	1021	6	VL	f	\N	\N
1	2005	1026	7	PU	f	\N	\N
1	2005	1066	10	KE	f	\N	\N
1	2005	1018	12	KE	f	\N	\N
1	2005	1047	14	OL	f	\N	\N
1	2005	1024	15	PU	f	\N	\N
1	2005	1067	16	OL	f	\N	\N
1	2005	1068	30	MV	f	\N	\N
1	2005	1069	73	VL	f	\N	\N
1	2005	1065	79	KE	f	\N	\N
1	2005	1027	80	VL	t	\N	\N
1	2005	1046	3	\N	f	\N	2005-10-25
1	2006	1041	1	MV	f	\N	\N
1	2006	1029	4	OL	f	\N	\N
1	2006	1014	5	PU	f	\N	\N
1	2006	1021	6	VL	f	\N	\N
1	2006	1072	7	PU	f	\N	\N
1	2006	1069	8	OL	f	\N	\N
1	2006	1066	10	OL	f	\N	\N
1	2006	1018	12	KE	f	\N	\N
1	2006	1074	13	VL	f	\N	\N
1	2006	1047	14	PU	f	\N	\N
1	2006	1024	15	PU	f	\N	\N
1	2006	1067	16	OL	f	\N	\N
1	2006	1068	30	MV	f	\N	\N
1	2006	1065	79	KE	f	\N	\N
1	2006	1027	80	VL	t	\N	\N
\.


--
-- Data for TOC entry 122 (OID 110245)
-- Name: sarjanjoukkueet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY sarjanjoukkueet (sarjaid, joukkue, kausi) FROM stdin;
1002	1019	2004
1002	1	2004
1002	1018	2004
1001	1	2004
1	1	2004
1003	1	2005
1004	1	2005
1005	1	2006
1006	1	2006
1006	1035	2006
1006	1047	2006
1006	1007	2006
1006	1038	2006
1006	1039	2006
1006	1040	2006
1006	1041	2006
1006	1037	2006
1006	1036	2006
1005	1025	2006
1005	1043	2006
1005	1039	2006
1005	1042	2006
1005	1045	2006
1005	1032	2006
1005	1046	2006
\.


--
-- Data for TOC entry 123 (OID 110263)
-- Name: uutinen; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY uutinen (uutinenid, pvm, ilmoittaja, otsikko, uutinen) FROM stdin;
1009	2005-08-25	Jussi Innanen	Koovee 2 ja PäLu harj.pelissä tasavahvat	Kauden ensimmäinen harjoitusottelu 4.divarin Pälkäneen Lukkoa vastaan päättyi tasan 4-4. Ottelu sujui suurimman osan ajasta Pälkäneen hallitessa, mutta Koovee-vahtimme Antti Paukkio oli hyvässä vedossa tolppien välissä. \r\n\r\nPäLu rokotti kylmästi karkeista keskialueen virheistämme miltei kaikki neljä maaliaan. Joukkueemme pelissä positiivista oli maalivahtipelin lisäksi miltei maksimaalinen maalipaikkojen hyödyntäminen.\r\n\r\nMaaleistamme vastasivat Lauri Oksanen (1-2 kavennus), Jani Singh (2-2 tasoitus), Jussi Innanen (3-2 johto) sekä Jani Myllynen, joka tasoitti 4-4:een parikymmentä sekuntia ennen loppua ylivoimalla.
1004	2005-07-08	Jukka Kaartinen	Joukkue kaudella 2005-2006	Kauden 2005-2006 kokoonpano on julkaistu.
1003	2005-10-12	Jussi Innanen	KooVeen joukkueiden valokuvaukset	Koovee-salibandyjoukkueiden valokuvaukset suoritetaan ammattilaisten toimesta tiistaina 25.10 klo 19 alkaen Raholan Liikuntakeskuksessa. Joukkueille ilmoitetaan tarkka ajankohta myöhemmin.
1033	2005-10-19	Jussi Innanen	Kaksi pakkia pois KoSBy-pelistä (23.10)	Puolustajat Johannes "Jay-Jay" Järvinen ja Lauri Oksanen ovat sivussa ensi sunnuntain 23.10 5.div-ottelusta Koovee 2-KoSBy. Järvinen on sivussa käsivamman vuoksi ja Oksasella on "bisneksiä".
1007	2005-08-16	Jussi Innanen	Ensimmäinen harjoitusottelu	Kauden 2005-06 ensimmäinen harjoitusottelu on torstaina 25.8.05 klo 18-19.00 Kaukajärven 2-kentällä Pälkäneen Lukkoa (4.div) vastaan.
1006	2005-08-12	Jussi Innanen	Uusi harjoitusvuoro viikolle	Toinen harjoitusvuoro viikolle alkaa viikolla 35. Treenipäivä on maanantai ja paikkana toimii Peltolammin uuden koulun liikuntasali klo 20.00-21.30. Peltolammin uuden koulun osoite on Säästäjänkatu 16. Vuoro on varattu joukkueellemme 29.8.05-2.1.06.
1005	2005-07-25	Jussi Innanen	Tuleva kausi 2005-06	<p>KooVee 2-joukkue alkaa olla hiomista varten valmis tulevaan 5.div.kauteen, josta tavoite on nousta takaisin 4.divisioonaan ja lopettaa ns."hissiliike" näiden kahden divarin välillä. Elokuussa joukkue alkaa hieman treenata pelillisiä asioita, esim. viisikkopeliä, ylivoimaa, alivoimaa ja muutamia pieniä tärkeitä harjoitteita. Myös harjoitusotteluja pelataan Elokuusta eteenpäin.</p>\r\n\r\n<p> Tällä hetkellä joukkueessa on 13 sitoutunutta pelaajaa, suurinosa vanhoja pelaajia viime kauden joukkueesta, sekä viisi uutta pelaajaa. Joukkuetta todennäköisesti täydennetään vielä yhdellä pelimiehellä, jos on tarvetta.</p>\r\n\r\n<p>Harjoitukset jatkuu normaalisti Torstaisin Kaukajärven Spiral-salien 2-kentällä klo 18-19.00, sekä on mahdollista että tulee viikolle vielä toinenkin harjoitusvuoro.</p>
1008	2005-08-20	Jussi Innanen	Pelaajakortteja päivitetty	Tulevan kauden joukkueen pelaajakortit alkavat olla pikku hiljaa kuosissaan, joten kannattaa käydä katsastamassa paremman puutteessa.
1016	2005-09-08	Jussi Innanen	Jukka Kaartinen nimetty kapteeniksi	Ennen harjoitusottelua oli edessä joukkueen uuden kapteenin valinta. Äänestyksen voitti niukasti vasen laituri ja joukkueen "puuha-pete" Jukka Kaartinen, joten Jukkis aloitti kapteeni-kautensa jo samana päivänä harj.pelissä Sc Interiä vastaan.
1001	2005-09-02	Jussi Innanen	Miesten 5.div. sarjajärjestelmä	Tulevalla kaudella 2005-06 Miesten 5.divisioonassa Sisä-Suomen alueella pelataan 8 lohkossa ja jokaisessa lohkossa on 7-8 joukkuetta. Pelataan kaksinkertainen sarja, josta kustakin lohkosta 4 parasta pääsee Ylempään loppusarjaan ja loput jatkosarjaan. Kumpiakin sarjan lohkoja tulee neljä. Niissä kummassakin myös kaksinkertainen sarja, mutta aikasemmin kohdattuja joukkueita vastaan ei enää pelata, vaan alkusarjan keskinäisten ottelujen pisteet jäävät voimaan. Ylempien jatkosarjojen voittajat nousevat suoraan 4.divariin ja kakkoseksi sijoittuneet pelaavat toisen lohkon kakkosta vastaan yhden ottelun noususta.
1010	2005-08-25	Jussi Innanen	Harjoitusvuoroista muistutus	Ensi viikosta eteenpäin torstain harjoitusvuoron lisäksi tulee siis toinen vuoro maanantaille, eli kaksi harjoitusta viikossa:\r\n\r\n\r\n\r\nMaanantai 20.00-21.30 Peltolammin koulu,\r\nTorstai 18.00-19.00 Kaukajärven Spiral-salit 2
1011	2005-08-29	Jussi Innanen	Kari Mäkinen jättää joukkueen	Joukkueemme "El Capitano" Kari Mäkinen on päättänyt jättää Koovee-kakkosen juuri tulevan kauden alla ja siirtynee vahvistamaan Spiral-liigajoukkue SB Postia. Mäkisen lähdön syynä on että pelejä tulisi kahdessa joukkueessa liikaa sekä mahdolliset päällekkäisyydet. Koovee 2 kiittää Karia joukkueessa vietetyistä kausista ja toivottaa onnea Spiral-peleihin.
1013	2005-09-02	Jussi Innanen	5.divisioona lohkot valmiina	SSBL:n Sisä-Suomen 5.divisioonan Pirkanmaan lohko 5:ssa pelaavat kaudella 05-06 seuraavat joukkueet: KOOVEE 2(Tre), AWE(Ylöjärvi), SC Lätty(Tre), SC Nemesis(Tre), ManPo(Tre), V&L(Nokia), KoSBy(Nokia) ja FBC Nokia. Ensimmäinen ottelu on SC Nemesistä vastaan 25.9 sunnuntaina Raholan Liikuntakeskuksessa klo 12.00.
1012	2005-09-02	Jussi Innanen	Tulevat harjoitusottelut	Harjoitusottelut jatkuvat vielä kahdella pelillä ennen kuin 5.div.kausi alkaa. Viimeiset harkkapelit ovat 8.9 SC Inter(5.div) ja 22.9 KU-68(4.div). Kummatkin ottelut pelataan joukkueemme torstain harkkavuorolla klo 18.00 Kaukajärven 2-kentällä.
1015	2005-09-07	Jussi Innanen	Keskustelu-foorumi aukeaa ensi viikolla	Koovee 2-joukkueen kotisivuilla avataan ensi viikon alussa keskustelu-foorumi, josta enemmän informaatiota myöhemmin.
1014	2005-09-02	Jussi Innanen	Joukkueen kapteenin valinta	Uusi "El Capitano" joukkueelle valitaan 8.9 torstaina ennen harjoituspeliä Sc Interiä vastaan. Kaikki peliin tulevat äänestävät ja kapun nauha luovutetaan eniten ääniä saaneelle henkilölle.
1019	2005-09-15	Jussi Innanen	KooVee 2:n kauden 2005-06 pelipaidat	Joukkueen tulevan 5.divari kauden ykkös-pelipaita tulee olemaan puna-musta Edustuksen vanha paita, jossa siis on KooVeen logo ja mainoksia mm. LJH Computers sekä Lammi Kivitalot. Kakkos eli varapaitana on edelleen Karhun keltainen paita, jota käytetään vain silloin kun vastustajalla on saman värinen pelipaita (puna-musta) ja olemme vierasjoukkueena velvollinen vaihtamaan pelipaitaa.
1018	2005-09-14	Jussi Innanen	Joukkueen sisäinen foorumi valmiina	Tällä viikolla avattiin KooVee 2-joukkueen oma sisäinen keskustelufoorumi näillä kotisivuilla. Foorumiin pääsee ensin kirjautumalla sisään KooVee 2-sivuille eli kaikki pelaajat, joille on annettu tunnukset. Alakulmassa on linkki, josta pääsee keskusteluun, kun on ensin rekisteröinyt tietonsa.
1017	2005-09-11	Jussi Innanen	Jälleen tasapeli harjoituspelissä	Harjoituspeli Sc Interiä(5.div) ei tarjonnut kuin erän verran hyvää viisikkopeliä joukkueeltamme. Jälleen turhia virheitä pelin rakentelussa ja huono liike veivät voiton, tosin tasatulos 4-4 mairittelee enemmän vastustajaa, joilla oli yksi hyvä kentällinen. Tason pitää parantua huomattavasti viimeiseen harj.otteluun (22.9 KU-68) ja sitä mukaan tuleviin 5.div.sarjapeleihin. Joukkueemme maalit tekivät Johannes Järvinen, Aapo Repo, Jani Myllynen ja Juha Kaartinen.
1020	2005-09-18	Jussi Innanen	Juha Kaartinen poissa 5.div-avauksesta	Luottopuolustaja ja raudanlujan vedon omaava Juha Kaartinen lähtee reissuun Saksaan, joten Lämmi ei ole käytettävissä tulevan viikon viimeisessä torstain harj.pelissä KU-68 vastaan eikä myöskään pääse "kauan odotettuun" 5.div. avaukseen Sc Nemesistä vastaan sunnuntaina.
1021	2005-09-21	Jussi Innanen	KU-68 perui huomisen harjoituspelin	Harjoitusottelu (22.9)Koovee 2- KU-68 on peruttu näin viime hetkellä eli päivää ennen. Syynä on että KU ei saa kentällistä enempää pelaajia otteluun. Joten kyseinen harj.peli pelataan joskus tulevaisuudessa.\r\n\r\nHuomisen harj.pelin vuorolla siis normaalit/ 5.div peliin valmistavat harjoitukset.
1022	2005-09-22	Jussi Innanen	Koovee 2 valmiina SC Nemesis-otteluun	Kuten jo aiemminkin on todettu 5.divari alkaa joukkueemme osalta nyt tulevana sunnuntaina 25.9 klo 12.00 SC Nemesistä vastaan Raholan Liikuntakeskuksessa. Joukkueemme on hionut hieman viisikkopeliä sekä ylivoimaa ja välillä homma on sujunut niinkuin on pitänytkin, mutta parannettavaa on vielä paljon joka osa-alueella. Kauden ensimmäisestä 5.div vastustuksesta SC Nemesiksestä ei ole paljon tietoa, muuta kuin että joukkue vasta perustettiin ja se osallistuu ensimmäistä kertaa liiton sarjaan. Todennäköisesti sunnuntaina vastaan tulee nuori ja innokas ryhmä kovalla sykkeellä. Joten varuilla pitää olla!
1024	2005-09-26	Jussi Innanen	Myllynen ei pääse FBC Nokia-peliin	Koovee 2:n laituri Jani Myllynen ei ole mukana lauantain (1.10) 5.div pelissä FBC Nokiaa vastaan. Joukkueen hyökkäys"vahvistus" joka saapui Kooveeseen VaLusta lähtee työpaikan "nestepitoiselle reissulle" ja on näin poissa kakkosjoukkueen vahvuudesta.
1023	2005-09-25	Jussi Innanen	5.div-kausi käyntiin selvällä voitolla	Koovee 2 aloitti 5.divarin vakuuttavasti 6-1 voitolla SC Nemesiksestä. Ottelun kulku oli selvä, vaikka vastustaja meni yllättäen johtoon jo ekalla minuutilla. Sen jälkeen joukkueemme ryhdistäytyi ja meni menojaan. Ainoa miinus ottelussa oli joukkueeltamme lukuisat turhat jäähyt, mutta toisaalta tehtiin kaksi alivoima-maalia ja peli oli koko ajan hallussamme. Joukkueemme tehot iskivät Juuso Koivisto 2+0, Jussi Innanen 0+2, Teemu Siitarinen 1+0, Jani Singh 1+0, Jukka Kaartinen 1+0, Aapo Repo 1+0, Jarno Mustonen 0+1, Jaakko Ailio 0+1. 5.divari jatkuu ensi lauantaina FBC Nokiaa vastaan.
1025	2005-09-29	Jussi Innanen	Koovee 2 haastaa FBC Nokian lauantaina	Ensimmäisten 5.divari-otteluiden jälkeen on luvassa lauantaina 2.kierros ja Koovee 2 kohtaa myöskin ekan pelinsä voittaneen(8-2 KosBy) FBC Nokian lohkon kärkipelissä klo 10.00 Raholassa. FBC Nokia putosi viime kauden päätteeksi 4.divarista kuten Kooveekin, joten varmaankin tasokas ja tasainen ottelu luvassa, jossa nokialaiset ovat kuitenkin ennakkosuosikin asemassa.
1027	2005-10-06	Jussi Innanen	Lauantaina Koovee 2:n vastuu-turnaus	Nyt tulevana lauantaina 8.10 5.divarin Pirkanmaan 3A-lohkon 3.kierros Raholan Liikuntakeskuksessa klo 10-14.00. KooVee 2 vastuu-joukkueena hoitaa toimitsija-hommat eli 4 ottelua: 10.00 KoSBy-V&L, 11.00 ManPo-SC Nemesis, 12.00 SC Lätty-FBC Nokia, 13.00 KooVee 2-AWE. (Foorumista löytyy toimitsijoiden nimet!)
1026	2005-10-01	Jussi Innanen	FBC Nokia jyräsi 3.erässä voittoon	Ottelu alkoi hyvin ja yllättävä 3-0 johto meille jo 13 minuutin jälkeen toi joukkueelle jonkinlaisen "hyvänolon tunteen", koska oma pelimme jäikin sitten siihen ja vastustaja pelasi järkevästi iskien pallon nopeata tekopaikoille ja ansaitsi voittonsa lopulta nousten 3-0 tappio-asemasta 7-3 voittoon. 2.erän jälkeen johdettiinkin vielä 3-2, mutta 3.erä oli surkea ja nokialaiset laittoi pallon viidesti maaliin ja takaa-ajomme tyssäsi jälleen kerran tyhmiin jäähyihin. Koovee 2:n maalit tekivät Jarno Mustonen, Jussi Innanen ja Lauri Yli-Huhtala. Pelin on parannuttava ja turhien jäähyjen loputtava jatkossa jos joukkue haluaa tavoitella nousua 4.divariin. Seuraavassa pelissä ja KooVee 2:n vastuu-turnauksessa vastaan asettuu AWE Ylöjärveltä.
1031	2005-10-15	Jussi Innanen	Myllynen upotti V&L:n	Koovee 2 jatkoi voitokkaita esityksiään nyt Tottijärven V&L:n kustannuksella lukemin 6-2. Kooveen paras pelimies oli oikea laitahyökkääjä Jani Myllynen, jonka ruuti oli kuivaa. Myllynen iski 4 maalia ylä-kulma vedoillaan. Peli ei ollut vauhdiltaan päätä huimaava, mutta Kooveen hallinnassa mentiin, vaikka V&L:llä olikin pahoja vastahyökkäyksiä. Koovee 2:n tehopisteet: Jani Myllynen 4+0, Lauri Oksanen 1+1, Jussi Innanen 0+2, Jani Singh 1+0, Jaakko Ailio 0+1, Aapo Repo 0+1, Juha Kaartinen 0+1. Koovee 2:n seuraava ottelu on ensi sunnuntaina ja vastassa on KoSBy Nokialta.
1029	2005-10-12	Jussi Innanen	Kolme laituria poissa V&L-pelistä	Laitahyökkääjät Lauri Yli-Huhtala, Juuso Koivisto ja Jarno Mustonen puuttuvat lauantaina 15.10 V&L-pelistä. Koivisto on armeijassa "gineksessä", Mustonen kertausharjoituksissa ja Yli-Huhtala on Ruovedella.
1028	2005-10-11	Jussi Innanen	Koovee 2 voitti AWEn kuumassa pelissä	5.divarin Koovee 2:n omassa vastuu-turnauksessa kohdattiin AWE Ylöjärveltä. Joukkueestamme puuttui Mustonen, Koivisto, Repo ja Jukka Kaartinen eli pelaajia oli yhdeksän ja maalivahti Paukkio, joka oli tänäänkin mies paikallaan Koovee 2:n 6-3 voittoon päättyneessä ottelussa. Kohtalaisen tasainen vääntö, mutta tunteet eivät pysyneet kurissa kummallakaan joukkueella. Vastustaja AWE pelasi vauhdikkaasti mutta todella rumaa ja ei kaukana ollut viisi minuuttia ennen loppua tappelukaan AWEn kapteenin toimesta. Onneksi siltä säästyttiin ja tärkeät kaksi pistettä Kooveelle eikä tullut loukkaantumisia. Koovee 2:n tehopelaajat olivat Jani Myllynen 2+1, Jussi Innanen 1+1 ja Jaakko Ailio 0+2. Ensi lauantaina Koovee 2 kohtaa Raholassa klo 13.00 Tottijärven V&L:n, joka voitti tänään KoSByn 8-6.
1002	2005-10-12	Jussi Innanen	5.div-lohkon sarjataulukon tilanne	5.divisioonan Pirkanmaan 3A-lohkon kärjessä puhtaalla pelillä 3.kierroksen jälkeen jatkaa FBC Nokia 6 pisteellä, toisena on SC Lätty 4 pisteellä ja kolmantena huonommalla maalierolla KooVee 2 myöskin 4 pisteellä. Lohkossa neljäntenä eli viimeisen ylempään jatkosarjaan oikeuttavalla paikalla on V&L 3 pisteellä ja sen jälkeen KoSBy (2p.), SC Nemesis (2p.), ManPo (2p.) ja AWE pitää peräpäätä yhdellä pisteellä. Tarkempi sarjataulukko löytyy Liiton sivuilta osoitteesta www.salibandy.net.
1030	2005-10-14	Jussi Innanen	Ennakko: V&L - Koovee 2, LA 15.10	Huomena lauantaina Raholassa klo 13.00 Koovee 2 kohtaa Tottijärven Vauhti&Lämärin eli V&L:n, joka on sarjataulukossa pisteen jäljessä Kooveeta eli neljäntenä. Koovee 2 on selvä ennakkosuosikki kyseisessä pelissä, mutta V&L voi yllättää vielä monet joukkueet tässä 5.div-lohkossa. Kamppailu tulee ratkeamaan todennäköisesti Kooveen tasaisuuteen vaikka kahdella ketjulla pelataankin, saa myöskin nähdä paljon tottijärviläisillä on pelaajia matkassa. V&L hyökkää yleensä vauhdikkaasti, mutta unohtuuko omaan pään peli. Huomena nähdään miten käy...
1032	2005-10-15	Jussi Innanen	Toinen PäLu-harjoituspeli suunnitteilla	Koovee 2 pelasi 4.divarin PäLua vastaan (4-4) Elokuun 25.päivä harjoituspelin Kooveen harjoitusvuorolla joten nyt olisi lähiviikkoina suunnitteilla sovittu toinen ottelu Pälkäneen Lukon vuorolla. Asiasta informoidaan myöhemmin.
1037	2005-10-20	Jussi Innanen	Harj.peli PäLua vastaan torstaina 3.11.	Kahden viikon päästä torstaina 3.11 pelataan toinen harjoitusottelu PäLua(4.div) vastaan niiden treenivuorolla Kaukajärven 4-kentällä klo 18.00.
1034	2005-10-18	Jussi Innanen	25.10 TI valokuvaus klo 17.35 Raholassa	Koovee-salibandyjoukkueiden valokuvaus ajat ovat varmistuneet ensi viikon tiistaiksi 25.10 Raholassa. Valokuvaukset alkavat klo 17.35, joten silloin jokainen paikalle punamusta-pelipaita ja muu varustus mukana.
1036	2005-10-19	Jussi Innanen	Koovee 2:n saunailta	Koovee 2:n tämän kauden ensimmäinen saunailta pidetään 12.11 lauantaina. Aika, paikka ja muut tiedot löytyy myöhemmin sisäisestä foorumista.
1038	2005-10-23	Jussi Innanen	Voitto KoSBystä vaisulla pelillä	Kauden viidennessä 5.div-pelissä KooVee 2 voitti KoSByn lopulta 7-3 huonollakin pelillä. Lohkon jumbojoukkue KoSBylla oli vain 7 pelaajaa ja maalivahti matkassa ja taas meillä puolestaan 11 kenttäpelaajaa, mutta silti tehtiin vaikea ottelua huonon asenteen vuoksi. Onneksi kuitenkin tarvittavat maalit tehtiin ja hätää ei ollut, vaikka KoSBy piti pelin tasoissa aina 2.erän puoleen väliin asti. Kakkosjoukkueen tehopelaajat olivat Jukka Kaartinen 2+0, Jussi Innanen 2+0, Juha Kaartinen 1+1, Jaakko Ailio 1+1, Juuso Koivisto 1+1 ja Jani Myllynen 0+2. Ensi lauantaina asenteen on oltava eri luokkaa kun vastaan tulee lohkon kolmonen SCL (SC Lätty).
1043	2005-11-01	Jussi Innanen	Muistutus torstain harjoitusottelusta	Muistutukseksi vielä, eli nyt torstaina 3.11 pelataan harjoituspeli PäLu-KooVee 2 Kaukajärven 4-kentällä klo 18-19.00. Foorumissa lisää tietoa tulevasta pelistä.
1035	2005-10-21	Jussi Innanen	Ennakko: Koovee 2 - KoSBy, SU 23.10	Sunnuntaina 23.10 5.divarin aamupelissa Raholassa klo 10.00 vastakkain ovat Koovee 2 - KoSBy. Koovee 2 ylivoimaisena suosikkina voi kaatua ainoastaan "takki auki-pelailuun". Lohkon jumbo-joukkue Koskenmäen Salibandy (KoSBy) tunnetusti "kuumana" joukkueena, yrittää minimoida jäähynsä, jos aikoo voittaa. Jos ja kun kaikki menee niin kuin pitääkin eli Koovee pelaa omalla tasollaan, ei voittajasta tule olemaan epäselvyyttä.
1039	2005-10-25	Jussi Innanen	Aapo Repo lopettaa kakkosjoukkueessa	Puolustaja Aapo Repo lopettaa Kooveen kakkosjoukkueessa. Repo ilmoitti salibandyn lopettamis päätöksensä maanantaina joukkueen "puuha-miehelle" Jukka Kaartiselle. Koovee 2 jatkaa kauttaan 12 kenttäpelaajalla ja yhdellä maalivahdilla.
1041	2005-10-27	Jussi Innanen	Ennakko: KooVee 2 - SCL 29.10 LA	5.divarin Pirkanmaa 3A-lohkon kakkonen(KooVee 2) kohtaa lauantaina 29.10 klo 12 Raholassa lohko-kolmosen(SCL). Vaikka Koovee 2 onkin niukasti ylempänä taulukossa niin silti SC Lätty on suosikki tässä pelissä. Peli on tärkeä kummallekin tulevan Ylemmän loppusarjan takia, koska keskinäisistä peleistä saavutetut pisteet jäävät voimaan lähtöpisteinä. Mikäli tietenkin että sinne ensin pääsee. SCL vahvistui hiukkasen viime kaudesta muutamalla pelaajalla ja pelaakin parhaillaan kontrolloivaa ja taitavaa koko viisikon salibandyä. KooVee 2:n saumat on vastaiskuissa ja kurinalaisessa puolustamisessa. Tuskin kumpikaan joukkue peliä murskaten voittaa.
1044	2005-11-02	Jussi Innanen	KooVee-joukkueiden kuvat netissä	Kaikkien jotka olivat 25.10.05 KooVee-salibandyjoukkueiden kuvauksessa mukana Raholassa, kuvat näkyvillä netissä osoitteessa www.youngace.com. Paikan päällä valokuvaajalta saadulla kuvaustunnuksella pääsee katselemaan kuvia.
1047	2005-11-04	Jussi Innanen	Ennakko: ManPo - KooVee 2  SU 6.11	Heikon harjoituspelin jälkeen jatkuu 5.divari sunnuntaina klo 10.00 Raholassa ottelulla ManPo - KooVee 2. Kuudenneksi noussut Manse-Pojat haastaa KooVee 2:n joka on toisena sarjassa ja voittanut neljä peliä putkeen. ManPo on varteenotettava vastus, jos sillä on tarpeeksi pelaajia mukana, muuten kyyti voi olla kylmää kuten SCL-peli(2-14) osoitti, jonka he pelasivat aluksi 4 tai 5 miehellä. KooVeen voittoputki jatkuu varmasti jos peli kulkee niin kuin viimeksikin SCL:ää vastaan.
1048	2005-11-04	Jussi Innanen	KooVee 2:n joukkuekuva lisätty sivuille	Kakkosjoukkueen joukkuekuva löytyy näiltä sivuilta kun ensin klikkaa kohtaan "Joukkue" ja sen jälkeen "2005 M 5.div" niin ruutuun tulee "ryhmäkuva". Kuvasta puuttuu viisi pelaajaa.
1042	2005-10-30	Jussi Innanen	KooVee 2:lle tärkeä voitto SCL:stä	KooVee 2 voitti 6-3 SC Lätyn Miesten 5.divarissa hyvällä esityksillä. SCL piti tyylilleen uskollisena palloa suurimman osan ja pyöritti leveällä peliä, mutta KooVee 2 puolusti kurinalaisesti ja iski vastaiskuista hienoilla maaleilla. Oman pään peli oli kauden parasta tähän saakka, eikä SCL päässyt kunnon tekopaikoille oikeastaan missään vaiheessa ottelua. Tärkeä ja hieno voitto Ylempää jatkosarjaa ajatellen. KooVee 2:n tehomiehet olivat Juuso Koivisto 2+1, Jani Myllynen 2+0, Lauri Oksanen 2+0, Jukka Kaartinen 0+2 sekä Jaakko Ailio 0+2. Ensi viikon sunnuntaina vastaan Raholassa tulee Manse Pojat(ManPo).
1040	2005-10-30	Jussi Innanen	Singh ja Innanen poissa SCL-pelistä	Tällä kaudella salibandyn joukkueessa aloittanut laitahyökkääjä Jani Singh ei pääse lauantaina 29.10 5.div-peliin SC Lättyä vastaan hiusmallikeikan takia. Poissa on myös sentteri Jussi Innanen, jolla on keuhkoputken tulehdus ja kuumetta.
1049	2005-11-06	Jussi Innanen	Voitto ManPosta hurlumhei-pelillä 9-4	Viides peräkkäin 5.divari voitto oli tosiasia ManPon kustannuksella lukemin 9-4. Ykkösveskari Antti Paukkio puuttui maalista, joten maalissa pelasi laituri Jani Singh ensimmäistä kertaa ja suoriutui ihan mallikkaasti. 1.erä oli KooVeelta hyvää joukkuepeliä, mutta kun peli repesi ja vastustaja ei jaksanut juosta omalle puoliskolleen niin peli oli melkoista hurlumheitä. Lopulta selvä voitto tuli aika helpolla, ja tulihan pelissä komeita koulumaaleja. KooVee 2:n tehopelaajat olivat Juuso Koivisto 4+0, Jaakko Ailio 0+3, Jani Myllynen 2+0, Lauri Oksanen 1+1 ja Juha Kaartinen 0+2
1045	2005-11-03	Jussi Innanen	PäLu pyöritti harjoituspelissä 8-3	Kauden kolmas harjoituspeli ja samalla toinen peli Pälkäneen Lukkoa(4.div) vastaan päättyi PäLun selvään 8-3 voittoon. PäLulla pelaajia oli kahdeksan ja veskari ja KooVeella puolestaan seitsemän ja maalivahti. Löysävauhtinen ja vähän humoristinenkin peli oli tasainen, mutta PäLu viimeisteli paremmalla prosentilla ja ansaitsi voiton. KooVeen maalit tekivät Jani Myllynen kahdesti ja Lauri Oksanen kerran. Kakkosjoukkueen pelistä puuttuivat Jani Singh, Jussi Innanen, Jukka Kaartinen, Juuso Koivisto ja Teemu Siitarinen.
1050	2005-11-07	Jussi Innanen	KooVee jatkaa lohkokakkosena 5.divarissa	5.divisioonan Pirkanmaa 3A-lohkon alkusarjan ensimmäisen sarjakierroksen (7 peliä) jälkeen KooVee 2 jatkaa vankkana lohko-kakkosena 12 pisteellä. Lohkoa johtaa 14 pisteellä FBC Nokia edelleen puhtaalla pelillä. Kolmantena on AWE-Team 7 pisteellä ja neljäntenä SCL myöskin 7 pisteellä, tosin keskinäisen pelin hävinneenä. Tulokas-joukkue SC Nemesis on viides 6 pisteellä, ManPo kuudentena 4 pisteellä ja lohkojumboilla V&L:llä ja KoSByllä on vain 3 pistettä kasassa. Tarkka sarjataulukko osoitteessa www.salibandy.net.
1051	2005-11-15	Jussi Innanen	Ennakko: SC Nemesis-KooVee 2  SU 20.11	5.divarin alkusarjan toinen kierros alkaa sunnuntaina 20.11 Raholassa. Ottelu SC Nemesis-KooVee 2 pelataan klo 12.00 ja kausihan alkoi juuri samalla matsilla. Silloin KooVee 2 voitti selvästi 6-1 numeroin tulokas-Nemesiksen, mutta nyt peli voi olla vaikeampi ja tasaisempi. SC Nemesis aloitti kauden heikosti, mutta on pikku hiljaa päässyt kohtalaiseen vireeseen ja on sarjassa viidentenä, KooVee puolestaan on toisena viidellä perättäisellä voitolla. Voitto irtoaa Nemesiksestä normaali suorituksella, ellei "saunailta-fiilarit" ole jäänyt porukalle päälle.
1046	2005-11-03	Jussi Innanen	Jani Singh maalissa ManPo-pelissä 6.11	Jani Singhin maalivahti-debyytti nähdään nyt sunnuntaina 6.11 ManPo-ottelussa, kun ykkösveskari Antti Paukkio ei pääse paikalle valmentamansa joukkueen turnauksen vuoksi.
1062	2005-12-22	Jussi Innanen	Peltolammin treenivuoro on päättynyt	Kakkosjoukkueen Peltolammin koulun harjoitusvuoro on päättynyt tähän vuoteen. Torstain Kaukajärven 18.00-19.00 vuoro jatkuu normaalisti ainoana harjoituksena kauden loppuun asti.
1052	2005-11-20	Jussi Innanen	Kakkosjoukkueelle ensimmäinen tasapeli	5.divari-kauden kahdeksannessa pelissä SC Nemesistä vastaan päädyttiin pistejakoon numeroin 5-5. Tasapeli oli aivan oikeudenmukainen tulos tähän peliin, jossa Nemesis jyräsi alussa ja KooVee 2 puolestaan lopussa. Vastustaja SC Nemesis pelasi aivan eri lailla kuin kauden ekassa kohtaamisessa ja välillä pyörittikin heikko-asenteista ja löysää kakkosjoukkuetta. KooVee 2 piristyi kuitenkin 3.erässä ja vei peliä täysin, mutta voittomaali jäi lopun painostuksesta puuttumaan. Kakkosjoukkueen tehomies oli neljä maalia ampunut Juuso Koivisto ja loput tehot menivät Jussi Innaselle 1+1, Juha Kaartiselle 0+2, Johannes Järviselle 0+1 sekä Jaakko Ailiolle 0+1. Viikon päästä sunnuntaina on edessä vaikea ottelu sarjajohtaja FBC Nokiaa vastaan, joka voitti tänään KoSByn peräti 12-0.
1054	2005-11-27	Jussi Innanen	KooVee 2 yllätti sarjajohtaja FBC Nokian	Miesten 5.divarin Pirkanmaa 3A-lohkon kärkikamppailussa KooVee 2 yllätti kahdeksan peliä putkeen voittaneen FBC Nokian 3-0 lukemin. Tärkeät kaksi pistettä Ylempää jatkosarjaa varten tuli kovalla ja kurinalaisella puolustuspelillä, vaikka FBC Nokia pyöritti näyttävästi välillä. Ilman Kakkosjoukkueen vahti Antti Paukkion loistavia torjuntoja, FBC olisi pelin voittanut. KooVee 2 iski paikoistaan maalit hyvällä prosentilla ja pelasi muutenkin uhrautuvasti omalla alueella, ja siitä seurauksena makea voitto ja samalla Nokialaisille ensimmäinen tappio sarjassa. Kakkosjoukkueen tehopelaaja oli Jussi Innanen, joka iski kaksi maalia. Muut tehot menivät kapteeni Jukka Kaartiselle 1+0, Juha Kaartiselle 0+1 ja Teemu Siitariselle 0+1.
1053	2005-11-25	Jussi Innanen	Ennakko: KooVee 2 - FBC Nokia  SU 27.11	5.divisioonan Pirkanmaa 3A-lohkon kärkikamppailu KooVee 2 - FBC Nokia pelataan sunnuntaina 27.11 klo 10.00 Raholan Liikuntakeskuksessa. Ensimmäinen kohtaaminen päättyi FBC Nokian 7-3 voittoon, vaikka KooVee 2 johti parhaimmillaan 3-0, mutta FBC tuli väkisin ohi ja lopussa numerot turhaan repesivät. Nokialaiset ovat jälleen selvä suosikki kärkipelissä puhtaalla kahdeksan pelin voittoputkellaan. KooVeen oman pään peli on oltava huippuluokkaa ja paikoista tehtävä hyvällä prosentilla maalit, jos voittoa mielii. FBC Nokia on kovan luokan joukkue 5.divarissa joka pelaa dominoivaa salibandyä vaikka ei aina olisi edes kahta kentällistä miehiä mukana. Mielenkiintoinen ja tasokas matsi toivottavasti tulossa.
1055	2005-12-02	Jussi Innanen	Juuso Koivisto sisäisen pörssin kärjessä	KooVee 2:n sisäisessä pistepörssissä tulokas Juuso Koivisto on ykkösenä kuudessa pelissä tekemillään 13+2=15 tehoillaan. Tasaisessa pistepörssissä seuraavana ovat myöskin uudet pelaajat Jussi Innanen 8.8+6=14 ja Jani Myllynen 7.10+3=13. Neljäntenä on Kakkosjoukkueen oma "Raimo Helminen" eli Jaakko Ailio tehoilla 9.1+12=13. Pitää myös muistaa puolustuksen pitävyys ja maalivahti Antti Paukkion vain 23 päästettyä maalia kahdeksassa pelissä.
1057	2005-12-11	Jussi Innanen	Kakkosjoukkue murjoi AWEn 15-3	5.div-pelissä KooVee 2 murjoi AWEn maalein 15-3 ja peli keskeytettiin vain sekunti ennen päätössummeria. Ottelusta odotettiin paljon tasaisempaa, mutta sitä ei tullut. Ylöjärven AWE oli aivan eri joukkue kuin ekassa kohtaamisessa ja pelasi löysän ja virheellisen pelin, josta ei jäänyt muuta muistettavaa kuin KooVee 2:n komeat maalit. Todellisen "höntsypelin" tehot menivät Kakkosjoukkueen Juuso Koivistolle 5+2, Jukka Kaartiselle 4+3, Jussi Innaselle 0+4, Jaakko Ailiolle 0+4, Teemu Siitariselle 3+0, Jani Singhille 2+0 ja Lauri Oksaselle 1+0. Ensi lauantain 17.10 KooVee 2:n vastuu-turnauksessa vastaan tulee V&L Tottijärveltä.
1056	2005-12-08	Jussi Innanen	Ennakko: AWE - KooVee 2  SU 11.12	Sunnuntaina 11.12.05 Raholassa pelataan klo 13.00 5.divari-ottelu AWE-KooVee 2. Ylöjärven AWE on lohkossa viidentenä tavoitellen neljättä sijaa eli viimeisenä pääsyä Ylempään jatkosarjaan. AWE on pelannut kaksijakoisesti koko kauden, mutta on varteenotettava vastus, kuten ensimmäisessä keskinäisessä pelissä huomattiin. KooVee 2 voitti todella kuumaluonteisen pelin silloin 6-3, vaikka tasaista vääntöä oli. Jos KooVee 2 pelaa yhtä hyvää peliä kuin FBC:tä vastaan, niin kaksi pistettä irtoaa. Mutta jos pelihalut ja asenne ei ole kohdallaan niin vaikea peli tulee.
1058	2005-12-12	Jussi Innanen	Sisäistä jäähytilastoa johtaa Myllynen	KooVee 2:n 5.divisioona peleissä ei ole joukkueelle paljon jäähyjä kertynyt. Ainoastaan kahden minuutin jäähyjä ja niitäkin aika tasaisesti melkein kaikille. Kakkosjoukkueelle on tuomarit viheltäneet vain yhteensä 30 minuuttia jäähyjä kymmenessä pelissä. Sisäisen jäähytilaston kärjessä on Jani Myllynen 6 minuutilla. Seuraavana tulevat Jussi Innanen ja Juha Kaartinen, kummallakin 4 minuuttia. Yhteensä kahdeksalla pelaajalla on 2 minuutin jäähyt. 5.divarin alkusarjaa on jäljellä vielä neljä ottelua, jonka jälkeen alkaa jatkosarjat.
1059	2005-12-15	Jussi Innanen	Ennakko: KooVee 2 - V&L  SU 18.12.05	5.divaripeli KooVee 2 - V&L pelataan tulevana sunnuntaina 18.12.05 Raholan Liikuntakeskuksessa klo 13.00. KooVee 2:n vastuu-turnauksen viimeinen peli, jossa lohkon jumbo Tottijärven Vauhti ja Lämäri haastaa lohkokakkosen KooVeen. V&L:llä on hyviä vastahyökkäyksiä ja muutama yksilö, joita nähtiin ekassa kohtaamisessa, joka kuitenkin päättyi Kakkosjoukkueen selvään 6-2 voittoon. Ottelussa ei ole jatkosarjojen suhteen panosta, mutta KooVee 2 ei halua tietenkään että kahdeksan tappiottoman pelin ja muutenkin hyvien esitysten putki katkeaa sarja-jumbolle.
1061	2005-12-20	Jussi Innanen	Sarjatilanne joulutauolle mentäessä	5.divarin Pirkanmaan 3A-lohkon sarjatilanne joulutauolle mentäessä on seuraava: Kärjessä jatkaa FBC Nokia, joka on napannut yhdestätoista sarjapelistä 20 pistettä. Kakkosena KooVee 2 pisteen päässä (19 pist.) FBC:stä. Kärkikaksikosta selvästi jääneenä eli kolmantena on SCL, jolla on kasassa 13 pistettä ja Ylemmän jatkosarjan viimeiseen paikkaan oikeuttavalla sijalla on SC Nemesis 11 pisteellä. Alempaan jatkosarjaan ovat menossa tällä hetkellä viidentenä oleva ManPo (9 p.), kuudes KoSBy (7 p.), seitsemäs AWE (7 p.) ja jumbojoukkue V&L (2 p.). Alkusarjaa on jäljellä vielä kolme ottelua. Tarkemmat taulukot ja tilastot löytyvät osoitteesta www.salibandy.net
1060	2005-12-18	Jussi Innanen	Kakkosjoukkue pyöritteli V&L:ää 8-2	Miesten 5.divarin Pirkanmaan 3A-lohkon viimeiset pelit ennen joulutaukoa pelattiin KooVee 2:n isännöimässä turnauksessa, jossa Kakkosjoukkue pyöritteli lohko-jumbo V&L:ää numeroin 8-2. Heikko vauhtinen peli kummaltakin joukkueelta, ja peli ratkesikin jo 2.erässä Kakkosjoukkueen nopeisiin maaleihin. Selvä voitto lopulta jälleen KooVeelle ja samalla yhdeksäs perättäinen tappioton ottelu 5.divarissa (8 voittoa ja yksi tasapeli). Kakkosjoukkueen aikaiset "joululahjat" saivat pelissä Jani Myllynen 2+3, Lauri Yli-Huhtala 2+1, Jussi Innanen 2+1, Jarno Mustonen 1+1, Jaakko Ailio 1+0, Juha Kaartinen 0+1 ja Jukka Kaartinen 0+1. Maalivahti Antti Paukkio pelasi maalissaan jälleen kerran hyvän pelin. KooVee 2:n seuraava 5.div-ottelu pelataan ensi vuoden Tammikuussa 7.päivä KoSByä vastaan Raholassa.
1066	2006-01-09	Jussi Innanen	Maalitykki-Koivisto poissa SCL-pelistä	Tulevan lauantain tärkeästä SCL-ottelusta Kakkosjoukkueelta puuttuu joukkueen tehokkain pelaaja, Juuso Koivisto (20+6=26). Koivistolla jatkuu armeija vielä puoli vuotta alikersanttina.
1118	2006-06-04	Jussi Innanen	Kauden 2006-07 aloituspalaveri	KooVee 2:n ensi kauden 2006-07 aloituspalaveri pidetään 8.6.2006 torstaina Kaukajärven Spiral-saleilla klo 18.00. Käsiteltävät asiat löytyvät joukkuelaisille sisäisestä foorumista.
1063	2005-12-30	Jussi Innanen	Yhteenveto kuluneesta 2005 vuodesta	Vuosi 2005 alkaa oleen pikku hiljaa historiaa myöskin salibandyn puolelta, joten on aika lyhyelle yhteenvedolle: Kulunut vuosi toi KooVeen Kakkosjoukkueelle tärkeitä sarjapisteitä tulevaa ajatellen ja hyvästä asemasta lähdetään sarjataulukonkin puolesta seuraaviin v.2006 otteluihin. Joukkueenakin peli on alkanut kulkee mainiosti, vaikka montaa todella kovaa mittaria ei vielä ole vastaan tullut 5.divarissa. Edelleen joukkueen tavoitteena on nousta takaisin 4.divariin ja myöskin vakiinnuttaa paikka siellä. Alkukausi tähän asti on antanut uskoa omaan tekemiseen ja tavoitteeseen lukuisten onnistumisien johdosta. Mutta nousuun on vielä pitkä ja vaikea matka, kuten jokainen tietää uuden sarjajärjestelmänkin puolesta.  Kerta viikossa-harjoitus on tietenkin vähän, mutta kun välillä on oikein treenattukin niin pakkohan sen on kantaa hedelmää. Joukkueenjohto kiittää jokaista Kakkosjoukkueen pelaajaa kuluneesta vuodesta ja toivottaa kaikille HYVÄÄ UUTTA VUOTTA 2006 !!!
1064	2006-01-05	Jussi Innanen	Ennakko: KoSBy-KooVee 2  LA 7.1.	Joulutauko on vietetty ja vuosi vaihtunut, joten jälleen jatkuu Miesten 5.divarikin Raholassa lauantaina 7.1 klo 10.00 Pirkanmaan 3A-lohkon pelillä KoSBy-KooVee 2. Kauden ensimmäisessä koitoksessa KooVee oli parempi 7-3 numeroin, vaikka ottelu oli pitkään tasatuloksessa ja tasaväkistä vääntöä. KoSBy on toiseksi viimeisenä lohkossa ja sillä on vielä pieni mahdollisuus päästä Ylempään Jatkosarjaan, mutta se vaatisi voittoa Kakkosjoukkueesta. KoSBy on fyysinen joukkue, ja sellaiset ovat aina olleet vaikeita KooVeelle. Taitoero on huomattava KooVeen eduksi, mutta saa nähdä jatkuuko viime vuoden hyvät otteet myöskin tänä vuonna.
1068	2006-01-14	Jussi Innanen	KooVee 2 voitti SCL:n niukasti 7 - 6	Miesten V-divisioonan Pirkanmaa 3A-lohkon runkosarjan toiseksi viimeisellä eli 13.kierroksella KooVee 2 voitti tiukassa väännössä toistamiseen SC Lätyn maalein 7-6. Ottelussa oli panoksena tärkeät lähtöpisteet ylempään jatkosarjaan ja Kakkosjoukkue nappasi SCL:ltä kaikki neljä pistettä kahdessa kohtaamisessa. Pelistä ei vauhtia puuttunut, mutta virheitä tuli kummassakin päässä. Ottelu muistutti välillä maalinteko-kilpailua: Kakkosjoukkue johti parhaillaan kahteenkin otteeseen kolmella maalilla, mutta SCL ei luovuttanut. SC Lätty tuli lopulta maalin päähän kun Kakkosjoukkueen viisikkopuolustaminen oli aika vaisua. Seitsemän komeaa KooVee 2-maalia kuitenkin riittivät tasaisessa pelissä tärkeään voittoon. KooVeen tehopelaajat olivat Jani Myllynen 3+0 ja Jani Singh 0+3. Muut tehot tekivät Jarno Mustonen 1+1, Jussi Innanen 1+1, Juha Kaartinen 1+0, Jaakko Ailio 1+0, kapteeni Jukka Kaartinen 0+1 ja Johannes Järvinen 0+1. Viimeisessä runkosarjan pelissä Kakkosjoukkue kohtaa ensi lauantaina 21.1 Manse Pojat (ManPo).
1065	2006-01-07	Jussi Innanen	Kakkosjoukkue voitti KoSByn 5 - 2	5.divarin runkosarjan kolmanneksi viimeisessä ottelussa KooVee 2 voitti odotetusti KoSByn lukemin 5-2. Ottelussa ei ollut varsinaisesti mitään panosta ja siltä se välillä kentälläkin näytti. KoSByllä ei ollut oikein montakaan tekopaikkaa, joten lukemat vähän mairittelevat Koskenmäkiläisiä. Kakkosjoukkue pelasi aika heikon pelin, mutta silti tuli voitto mikä oli tärkeintä. KooVeen tehomies oli jälleen Juuso Koivisto, joka käytännössä yksin kaatoi KoSByn tehoillaan 2+2. Muut tehot menivät Jarno Mustoselle 2+0, Juha Kaartiselle 1+0, Johannes Järviselle 0+1 sekä Lauri Yli-Huhtalalle 0+1. Ensi lauantaina on edessä tärkeä peli SC Lättyä vastaan Ylemmän jatkosarjan lähtöpisteistä. Joukkuepelaamisen pitää olla silloin aivan eri luokkaa kuin tänään, jotta SCL kaatuisi.
1067	2006-01-12	Jussi Innanen	Ennakko: KooVee 2 - SCL  LA 14.1	Lauantaina 14.1.2006 klo 12.00 Raholan Liikuntakeskuksessa SC Lätty haastaa KooVee 2:n 5.divarin runkosarjan toiseksi viimeisessä kamppailussa. Jälleen panoksena ottelussa on lähtöpisteet tulevaan ylempään jatkosarjaan. Ensimmäinen kohtaaminen päättyi 6-3 lukemin Kakkosjoukkueen voittoon hyvällä kurinalaisella oman pään pelillä ja muutenkin tasaisella esityksellä. Lohkon toisena oleva Kakkosjoukkue on pelannut kymmenen perättäistä tappiotonta ottelua, joista peräti yhdeksän on voittoa. SC Lätty on pelannut vaihtelevasti, mutta pääasiassa hyvin tuloksin ja on lohkossa kolmantena menossa ylempään jatkosarjaan. Tasaiset joukkueet vastakkain ja vauhdikas peli tulossa, jossa Kakkosjoukkue on pienoinen ennakkosuosikki.
1069	2006-01-15	Jussi Innanen	Kakkosjoukkueella yhdeksän lähtöpistettä	Ennen viimeisiä 5.divari-otteluita on tiedossa 3A-lohkosta ylempään jatkosarjaan menevät neljä joukkuetta. FBC Nokia ja KooVee 2 saalistivat 9 lähtöpistettä 12:sta mahdollisesta, kun puolestaan lohkon kolmonen SCL saa 4 pistettä ja neljäs joukkue SC Nemesis vain 2 pistettä mukaan. Toisesta 5.divarin 3B-lohkosta ylempään jatkosarjaan on tulossa todennäköisesti SB NMP, SC Inter, Dolphins ja SBMR. Ensi viikonloppuna selviää myös näiden joukkueiden tarkat lähtöpisteet.
1070	2006-01-19	Jussi Innanen	Ennakko: KooVee 2 - ManPo  LA 21.1.06	V-divarin Pirkanmaan 3A-lohkon runkosarjan viimeinen eli 14.kierros pelataan lauantaina 21.1.06 Raholan Liikuntakeskuksessa. Kello 13.00 KooVee 2 pelaa Mansen Poikia (ManPo) vastaan päivän viimeisen pelin. Jos SC Nemesis häviää aikaisemmin aamupäivällä AWE Teamille ja ManPo yllättää KooVeen, niin Nemesis putoaa ylemmästä sarjasta ja ManPo pääsee sen paikalle, ottaen samalla kaksi lähtöpistettä KooVeelta mukaansa. Ensimmäinen joukkueiden kohtaaminen päättyi 9-4 Kakkosjoukkueelle, jolla ei ollut mitään vaikeuksia koko pelin aikana. KooVee 2 voittaa normaali suorituksella ManPon ja kasvattaa perättäisten tappiottomien ottelujen putken jo kahteentoista.
1072	2006-01-21	Jussi Innanen	ManPo yllätti Kakkosjoukkueen 7 - 5	5.divisioonan Pirkanmaa 3A-lohkon runkosarjan viimeisessä ottelussa ManPo yllätti sarjakakkosen Koovee 2:n numeroin 7-5. Kakkosjoukkueen pitkä tappioton putki katkesi nololla tavalla ja varsinkin kauden surkeimmalla esityksellä ansaitusti ManPolle, jolla oli hyvä vauhti päällä ja he pelasivat järkevästi koko ottelun. Vaikka ottelussa ei ollut muuta panosta kuin kunnia niin silti esitys oli todella vaisu ja hengetön. Sekapelipaikat eivät toimineet alusta lähtien, joten pelin henki oli selvä: ManPo pyöritti laitojen kautta peliään kun KooVee ei jaksanut liikkua. Lopussa ManPo teki 6-4 maalin korkealla mailalla tuomarin hyväksyessä sen aivan vierestä ja sen jälkeen vielä tyhjiin 7-4. Pari sekuntia ennen loppua Koivisto kaunisteli lukemat 7-5:een. Kakkosjoukkueen tehot: Juuso Koivisto 2+1, Juha Kaartinen 1+1, Jani Myllynen 0+2, Jani Singh 1+0, Jaakko Ailio 1+0 ja Jussi Innanen 0+1. Ylempi jatkosarja eli noususarja alkaa Helmikuun 11.päivä lauantaina Raholassa.
1071	2006-01-21	Jussi Innanen	ManPo-pelistä poissa 4 pelaajaa	Kakkosjoukkueen puolustajat Lauri Oksanen, Teemu Siitarinen, Johannes Järvinen sekä hyökkääjä Lauri Yli-Huhtala puuttuvat lauantaina 21.1 viimeisestä 5.divarin runkosarjapelistä ManPoa vastaan.
1076	2006-01-23	Jussi Innanen	Ylemmän jatkosarjan joukkueet selvillä	5.divarin ylempi jatkosarja (noususarja) alkanee Helmikuun 11.päivä Raholassa kahdeksalla joukkueella, jotka pelaavat kaksinkertaisen sarjan. Joukkueet ovat FBC Nokia (9 lähtöpist.), KooVee 2 (9 lähtöpist.), SC Inter (7 lähtöpist.), SB NMP (7 p.), SBMR (5 p.), Dolphins (5 p.), SCL (4 p.) ja SC Nemesis (2 p.). Sarjan voittaja nousee suoraan 4.divariin ja kakkonen pelaa yhden ratkaisuottelun noususta Pirkanmaan toisten ylempien jatkosarjan arvottua kakkosta vastaan.
1079	2006-02-03	Jukka Kaartinen	Yls-joukkuiden ennakko-katsaus	Viikon kuluttua alkavan 5.divarin noususarjan (Ylempi loppusarja) joukkueiden pienimuotoinen ennakko-katsaus:<br /> \r\n<br />\r\nFBC Nokia: Monien mielestä noususarjan voittaja-suosikki ja täten suoran 4.divari-paikan nappaaja. Joukkueessa on paljon kokemusta ja henk.kohtaista taitoa. Ainoa kysymysmerkki on että saako aina tarpeeksi pelaajia otteluihin. (FBC Nokia-KooVee 2 7-3, KooVee 2-FBC Nokia 3-0)<br /> \r\n<br />\r\nKooVee 2: Taistelee lohkon ykköspaikasta Nokian kanssa tai vähintään kakkospaikasta, jotta pääsee ratkomaan yhdessä pelissä noususta 4.divariin. Myöskin taitava joukkue, jonka kruunaa mainio maalivahti. Asenteen on pysyttävä kohdallaan pelistä toiseen.<br />\r\n<br />\r\nSB NMP: Voitti oman alkusarja-lohkonsa ja on ollut vuodesta toiseen 5.divarin kärkipään joukkueita. Yrittää iskeä kahden parhaan joukkoon myöskin.<br />\r\n<br />\r\nSC Inter: SB NMP:n tavoin toisen lohkon parhaimpia joukkueita, joka voi yllättää terävillä vastahyökkäyksillä, mutta yhdellä hyvällä ketjulla ei ole helppo 4.divariin nousta. (Harj.peli KooVee 2-SC Inter 5-5)<br />\r\n<br />\r\nSCL: Pääsi viime kaudella 4.div.karsintoihin, muttei noussut. Pelaa taitavaa ja hyökkäävää salibandyä, mutta kuten alkusarjassa nähtiin, tulee liian paljon ailahtelevia esityksiä. (SCL-KooVee 2 3-6, KooVee 2-SCL 7-6)<br />\r\n<br />\r\nDolphins: Jääkiekkotaustainen salibandyjoukkue pelannee todennäköisesti fyysistä peliä, ja on vaikea voittaa. Mahdollisuudet on nousta kahden parhaan joukkoon.<br />\r\n<br />\r\nSBMR: Alkusarja meni heikosti pisteiden valossa, mutta pelasi hyviä tuloksia muita kärkijoukkueita vastaan. Joukkue muuttui paljon viime kaudesta, mutta pyrkii säilyttämään ensi kaudeksi paikkansa 5.divarissa.<br />\r\n<br />\r\nSC Nemesis: Heikolla pistemäärällä myöskin nipin napin ylempään jatkosarjaan, jossa voi yllättää kärkijoukkueita, kuten alkusarjassakin. SBMR:n kanssa kilpailee sarjapaikkansa puolesta. (KooVee 2-SC Nemesis 6-1, SC Nemesis-KooVee 2 5-5)
1078	2006-01-25	Jussi Innanen	Ensimmäiset ylemmän jatkosarjan pelit	Miesten 5.divisioonan Pirkanmaa 3:n ylemmän jatkosarjan ensimmäiset ottelut pelataan 11.2.06 lauantaina Raholan Liikuntakeskuksessa. Ensimmäisessä ottelussaan klo 16.15 KooVee 2 saa vastaan Dolphinsin. Toiset ottelut pelataan heti seuraavana päivänä 12.2 sunnuntaina myöskin Raholassa, jolloin vastaan tulee puolestaan SBMR (SB Manse Rangers) klo 14.15. Otteluohjelma löytyy sisäisestä foorumista sekä liiton sivuilta www.salibandy.net
1080	2006-02-06	Jussi Innanen	Yls-joukkueiden kotisivu osoitteita	Ylemmän loppusarjan joukkueiden kotisivuja: Dolphins = www.dolphins.fi, SBMR = www.sbmr.fi, SCL = www.kolumbus.fi/simo.honkanen/scl/, SC Nemesis = www.scnemesis.com. FBC Nokian, SB NMP:n ja SC Interin sivut ei ole tiedossa.
1081	2006-02-09	Jussi Innanen	Ennakot tulevan viikonlopun peleistä	Miesten 5.divarin Ylemmässä loppusarjassa (noususarja) KooVee 2 kohtaa nyt tulevana viikonloppuna Raholassa, ensin 11.2 lauantaina Dolphinsin klo 16.15 ja 12.2 sunnuntaina SBMR:n klo 14.15. <br /> <br /> Dolphins-ottelu tulee olemaan todennäköisesti vaikea Kakkosjoukkueelle, kun vastustajalla on kiekkotausta, jotka pelaavat fyysisesti ja asenteella. Pallon pitää liikkua koko viisikon kautta, jotta peli ei mene vaikeaksi ja tällä tavoin tehdä tarvittavat maalit voittoon. <br /> <br /> SBMR-peliin Kakkosjoukkue lähtee selvänä suosikkina, muttei parane aliarvioida vastustajaa, muuten ikävä yllätys voi tapahtua jo tässä vaiheessa. Normaalilla hyvällä pallollisella pelillä kummatkin ed.mainitut joukkueet pitäisi voittaa ja jatkaa näin hyvällä mallilla eteenpäin.
1077	2006-01-22	Jussi Innanen	Koivisto voitti sisäisen pistepörssin	KooVeen Kakkosjoukkueen sisäisen pistepörssin 5.divarin runkosarjassa voitti Juuso Koivisto, tehden tehot 22+7=29 vain yhdeksässä pelaamassaan ottelussa. Toinen oli Jussi Innanen 13.11+13=24, kolmas Jani Myllynen 11.15+8=23 ja neljäs joka sai kaksikymmentä tehopistettä rikki oli Jaakko Ailio 14.4+16=20. Pelaajat-osiosta löytyvät kaikkien Kakkosjoukkuelaisten tehopisteet ja koko 5.divari-lohkon tilastot (sarjataulukko, tulokset ja pistepörssi) ovat liiton sivuilla www.salibandy.net.
1082	2006-02-09	Jussi Innanen	Siitarinen ja Mustonen  puuttuu LA 11.2	Ensimmäisestä 5.div yls-pelistä 11.2 lauantaina Dolphinsia vastaan Kakkosjoukkueen kokoonpanosta puuttuvat puolustaja Teemu "Teme" Siitarinen ja laitahyökkääjä Jarno Mustonen.
1084	2006-02-12	Jussi Innanen	Kakkosjoukkue voitti SBMR:n 7-5	5.divarin ylemmän loppusarjan toisessa pelissä KooVee 2 voitti SBMR:n 7-5, vaikka tulos ei kuvaa peliä kokonaan. Kakkosjoukkue oli selvästi parempi kuin vastustajansa, muttei saanut enempää maaleja lukuisista tekopaikoistaan. Vastustaja SB Manse Rangers iski hyvällä prosentilla maalinsa kooveelaisten merkkausvirheistä. <br> <br> Kakkosjoukkueen tehopisteet: Jani Myllynen 4+0, Jussi Innanen 1+3, Jani Singh 0+2, Jukka Kaartinen 1+0, Jaakko Ailio 1+0, Juha Kaartinen 0+1 ja Lauri Oksanen 0+1. <br> <br> Kakkosjoukkueen on pelattava paljon kurinalaisemmin ja minimoida virheet ensi lauantaina vastuu-turnauksessaan, kun vastaan tulee tänään SC Nemesiksen murskannut toisen lohkon voittajajoukkue SB NMP.
1083	2006-02-11	Jussi Innanen	KooVee 2 kaatoi Dolphinsin selvästi 11-5	Miesten 5.divarin ylempi loppusarja saatiin tänään käyntiin Raholassa. Päivän viimeisessä pelissä KooVee 2 piti alku vaikeuksista huolimatta pintansa ja latoi 11 maalia Dolphinsin verkkoon voittaen selvästi 11-5. Kuten ennakoitiinkin, niin vastustaja "jääkiekkojoukkue" Dolphins olikin todella vauhdikas ja fyysinen joukkue, joka pelasi ajoittain todella törkeästi ja huuteli hävyttömyyksiä, joita tuomarit eivät saaneet kuriin. Onneksi parempi joukkue jälleen voitti todella kuuman ottelun, jossa ei silti vihelletty kuin yhteensä kolme 2min-jäähyä. Kakkosjoukkue ratkaisi vaikean pelin 2.erän salama-maaleillaan ja lannisti rumasti pelanneen vastustajansa. <br> <br> KooVeen tehomies oli Jani Myllynen, joka iski ottelussa 6 pistettä (3+3). Loput tehoilijat olivat Jaakko Ailio 2+2, Jukka Kaartinen 3+0, Jani Singh 2+1, Lauri Yli-Huhtala 1+1, Juha Kaartinen 0+1, Lauri Oksanen 0+1 sekä Johannes Järvinen 0+1. Huomena Raholassa jatkuu ylempi loppusarja KooVeen kohdatessa tänään FBC Nokialle hävinneen SBMR:n.
1075	2006-01-22	Jussi Innanen	FBC Nokia voitti 5.divarin 3A-alkusarjan	5.divisioonan Pirkamaan 3A-lohko (runkosarja) on saatu päätökseen, jonka FBC Nokia voitti keräten 14 ottelusta 25 pistettä. Kakkonen oli KooVee 23 pisteellä, kolmonen SCL 17 pisteellä ja viimeisenä ylempään jatkosarjaan eli neljäs oli SC Nemesis 14 pisteellä. Alempaan jatkosarjaan menivät lohkon neljä viimeistä joukkuetta eli viides ManPo (13p.), kuudes AWE-Team (9p.), seitsemäs KoSBy (7p.) sekä lohkon jumbo V&L (4p.). Tarkat tilastot löytyvät liiton sivuilta www.salibandy.net.
1087	2006-02-17	Jussi Innanen	Kaikki pelaajat ruodussa SB NMP-pelissä?	Pitkästä aikaa Kakkosjoukkue päässee todennäköisesti täydellä 12+mv kokoonpanolla 5.div yls-peliin SB NMP:tä vastaan nyt sunnuntaina. Ainoa kysymysmerkki on Lauri "Late" Yli-Huhtala, että ehtiikö hän Tampereelle peliin. <br> <br> Ylemmän loppusarjan ensimmäisen viikonlopun kahdesta pelistä puuttuivat Juuso Koivisto ja Teemu Siitarinen. Jarno Mustonen pelasi yhden ottelun.
1124	2006-06-13	Jussi Innanen	HUOM! Kesätreenit KE 14.6 ja TO 15.6	KooVee 2:n tämän viikon kesätreeneissä keskiviikkona 14.6 sekä torstaina 15.6 ei ole ohjattua toimintaa, kun vetäjät puuttuvat. Maanantaina 19.6 treenit jatkuu jälleen ohjattuna normaalisti.
1086	2006-02-17	Jussi Innanen	Ennakko: KooVee 2 - SB NMP  SU 19.2	5.divarin ylemmän jatkosarjan kolmas ottelu KooVee 2-SB NMP pelataan 19.2 sunnuntaina Raholassa klo 16.15 Kakkosjoukkueen vastuu-turnauksessa. <br> <br>  Sarjakärki-KooVee yrittää pitää hallussaan ykköspaikkaa, kun vastaan tulee jaetulla kolmannella sijalla oleva SB NMP, joka voitti runkosarja-lohkon 3B:n. Panokset ovat tässäkin pelissä kovat kuten kaikissa muissakin yls-peleissä, joten Kakkosjoukkueella ei ole varaa hävitä, jos aikoo pitää kärkipaikkansa. SB NMP hävisi ekan yls-pelinsä murskaavasti, mutta toisen puolestaan taas voitti ylivoimaisella esityksellä SC Nemesiksestä, joka kanssa on pelannut hyvin tässä sarjassa. <br> <br> KooVeelta pitää löytyä tasainen esitys koko 45 min ajan, eikä samanlaista hetkittäistä kuten viime viikonloppuna. Positiivista kuitenkin Kakkosjoukkueen pelissä on ollut tehojen jakaantuminen kahdelle viisikolle, joten ratkaisijoita luulisi riittävän laajalta rintamalta myöskin NMP:tä vastaan.
1085	2006-02-13	Jussi Innanen	KooVee 2  yls-taulukon kärkeen	Miesten 5.divarin ylemmän loppusarjan taulukon kärkeen ja samalla suoran 4.divariin nousijapaikalle siirtyi KooVee 2 kahden yls-pelin jälkeen. <br> <br> KooVee johtaa lohkoa keräämällä kahdeksasta pelistä 13 pistettä (sisältää runkosarjan lähtöpisteet). Toisena eli 4.div.karsijan paikalle putosi FBC Nokia, jolla on piste vähemmän kuin KooVee 2:lla (12p.). Kolmantena on SB NMP (9p.), neljäntenä SCL (8p.), viidentenä SC Inter (8p.), kuudentena Dolhins (6p.), seitsemäntenä SBMR (5p.) ja suoraan 6.divariin putoajan paikalla eli viimeisenä on SC Nemesis (3p.). <br> <br> Ylemmässä loppusarjassa pelataan yhteensä kahdeksan ottelua (sisältäen siis alkusarjan jo pelatut keskinäiset kuusi ottelua )
1092	2006-02-25	Jussi Innanen	KooVee 2 löylytti vajaamiehistä Interiä	Miesten 5.divisioonan Pirkanmaa 3-Yls:ssa KooVee 2 löylytti SC Interiä numeroin 16-4 (keskeytys ajassa 38 min). <br> <br> Kakkosjoukkueella oli joukkueen kapteeni Jukka Kaartinen maalivahtina, mutta puolestaan vastustaja SC Interilläkin oli mukana vain yksi viisikko ja maalivahtina myöskin kenttäpelaaja. Helpossa "höntsypelissä" tuli komeita kuviomaaleja ja muutenkin pallo liikkui mainiosti viisikoilla pelaajilta toiselle. <br> <br> KooVeen tehot: Juuso Koivisto 5+1, Singh 4+2, Jussi Innanen 2+4, Jani Myllynen 2+3, Jaakko Ailio 0+4, Jarno Mustonen 2+1 ja kapteenina pelannut Juha Kaartinen 1+1. <br> <br> Ensimmäinen ylemmän loppusarjan  kierros on pelattu ja luvassa on nyt noin kahden viikon huili. Toinen kierros alkaa 12.3 jälleen Dolphinsia vastaan.
1088	2006-02-19	Jussi Innanen	Voittoputki jatkui NMP:n kustannuksella	Miesten 5.divisioonan Pirkanmaa 3:n ylemmässä loppusarjassa KooVee 2 kaatoi SB NMP:n 12-5 lukemin vastuu-turnauksessaan Raholan Liikuntakeskuksessa. <br> <br> Sarjakärki KooVee hermoili alussa, mutta sai hyökkäyspelinsä kuntoon ja teki jälleen näyttäviä maaleja. Kakkosjoukkue murskasi 3.erän alussa NMP:n ja peli oli selvä, mutta jälleen viisi osumaa omaan päähän oli liikaa, vaikka selvä voitto tulikin. <br> <br> Kakkosjoukkueen tehopelaajat olivat Juuso Koivisto 3+1, Lauri Yli-Huhtala 2+2 sekä Jussi Innanen 1+3. Muut tehot: Jaakko Ailio 1+2, Jani Myllynen 1+1, kapteeni Jukka Kaartinen 1+1, Teemu Siitarinen 1+0, Juha Kaartinen 1+0 ja Johannes Järvinen 1+0. <br> <br> KooVee 2 kohtaa ensi viikonloppuna 25.2 launtaina Raholassa SC Interin laitahyökkääjä Jani Singhin "jäähyväis-ottelussa". Singh ei pääse viimeisiin yls-peleihin, kun Jani lähtee Saksaan vaihtoppilaaksi 5 kuukaudeksi.
1089	2006-02-20	Jussi Innanen	Joukkueen yls:n sisäinen pistepörssi	Kakkosjoukkueen 5.div-yls:n sisäisen pistepörssin kärkipaikalla on Jani Myllynen, joka on tehnyt kolmessa yls-pelissä tehot 8+4=12. Seuraavana tulevat Jaakko Ailio 4+4=8, Jussi Innanen 2+6=8, Jukka Kaartinen 5+1=6 ja Jani Singh 2+3=5. <br> <br> Kaikkien pelaajien yls-tilastot löytyvät kun klikkaa kohtaa "Pelaajat" ja sieltä valitsee sarjan "2005,M 5.Div yj. Sisä-Suomi". Ylemmän loppusarjan taulukko löytyy osoitteesta www.salibandy.net.
1090	2006-02-24	Jussi Innanen	Ennakko: SC Inter - KooVee 2  LA 25.2	5.divarin ylemmän loppusarjan ensimmäisen kierroksen viimeisessä ottelussa SC Inter haastaa kärki-KooVee 2:n Raholassa 25.2 lauantaina klo 15.15. <br> <br> SC Interin on voitettava Kakkosjoukkue jos mielii vielä pääsemään 4.div-karsintoihin, ja KooVee puolestaan haluaa voitolla säilyttää johtopaikkansa sarjassa. <br> <br> KooVeen hyökkäyspeli on ollut näyttävää ja todella tehokasta kolmessa ekassa pelissä, josta kertoo peräti 30 tehtyä maalia. Ainoana kysymysmerkkinä joukkueen on viisikkopuolustaminen, joka ei ole ollut samalla mallilla kuin runkosarjassa. <br> <br> SC Inter on saalistanut vasta yhden tasapelipisteen kolmesta pelistä, mutta laittoi mm. FBC Nokian ahtaalle. Interin peli perustuu nopeisiin ja tehokkaisiin vastahyökkäyksiin, ja joukkueessa on muutama hyvän laukauksen omaava pelaaja. Nämä asiat tulivat huomattua kauden alussa keskinäisessä harj.pelissä, joka päättyi tuolloin tasan 5-5.
1094	2006-03-02	Jussi Innanen	Jani Singh vaihto-opiskelijaksi Saksaan	Kakkosjoukkueen laitahyökkääjä Jani "Singi" Singh lähtee ensi maanantaina 6.3 vaihto-opiskelijaksi Saksaan viideksi kuukaudeksi ja palaa sitten Heinäkuussa jälleen Suomeen, joten Janilta jää loppukauden 4-5 ottelua väliin. <br> <br> KooVee 2 kiittää Jania kuluneesta kaudesta ja toivottaa hyvää matkaa. <br> <br> Kakkosjoukkue jatkaa kauden 05-06 loppuun 11 kenttäpelaajalla sekä yhdellä maalivahdilla.
1091	2006-02-24	Jussi Innanen	Paukkio poissa  SC Inter-pelistä	Maalivahti Antti Paukkio puuttuu lauantaina Kakkosjoukkueen maalin suulta tärkeässä SC Inter-pelissä sukulaisten häiden vuoksi. <br> <br> Kakkosjoukkueen maalivahtina lauantaina toimii joukkueen kippari ja laitahyökkääjä Jukka "Jukkis" Kaartinen. <br> <br> Myöskin hyökkääjä Juuso Koiviston pelaaminen on vielä epävarmaa armeijan vuoksi lauantaina.
1093	2006-02-26	Jussi Innanen	KooVee 2  yls:n johdossa tauolle	5.divarin Pirkanmaa 3-YLS:n kärjessä jatkaa KooVee 2 ensimmäisen kierroksen jälkeen kerättyään 10 ottelusta 17 pistettä (8 voittoa, 1 tasuri ja 1 tappio). Kakkosena pisteen perässä vaanii FBC Nokia 16 pisteellä. Nämä kaksi ed.mainittua joukkuetta ratkaisee hyvin todennäköisesti lohkon suoran nousijan ja karsijan paikan 4.divisioonaan, koska eroa kolmantena olevaan SCL:ään on jo 5 pistettä. Lisäksi SCL hävisi kummallekkin kärkijoukkueelle kaikki keskinäiset pelit runkosarjassa. <br> <br> Lohkossa neljäntenä on SB NMP (9 p.), viidentenä SC Inter (8 p.), kuudentena Dolphins (8 p.) ja 6.divariin putoamisvaarassa ovat seitsemäs SBMR (6 p.) ja SC Nemesis (5 p.). <br> <br> Pirkanmaa 3-YLS:n pistepörssiä johtaa Kakkosjoukkueen Jani Myllynen tehoin 10+7=17 (ensimmäisen kierroksen eli neljän pelatun pelin jälkeen). Ottelut jatkuvat jälleen 12.3 sunnuntaina Raholan Liikuntakeskuksessa.
1097	2006-03-11	Jussi Innanen	Jukka Kaartinen poissa Dolphins-pelistä	Kakkosjoukkueen perustajajäsen, joukkueen kaikkien aikojen pistemies sekä kapteeni Jukka "Jukkis" Kaartinen huilaa 12.3 sunnuntain Dolphins-matsin kuumeen vuoksi, mutta pääsee tulemaan paikalle toimihenkilöksi.
1096	2006-03-10	Jussi Innanen	Yls:n kakkosten karsinta-parit arvottu	Miesten 5-divisioonan Ylempien loppusarjojen ykkösethän nousee suoraan 4.divisioonaan, mutta kakkoseksi jääneet karsivat noususta yhdessä ottelussa keskenään. <br> <br> Lauantaina 22.4 Kaukajärvellä pelaavat arvotut kakkoset vastakkain, joita ei ole vielä tiedossa, mutta kaavana on että Yls-lohko 1:n kakkonen vastaan Yls-lohko 3:n kakkonen(eli KooVee 2:n lohko) ja puolestaan Yls-lohko 2:n kakkonen kohtaa Yls-lohko 4:n kakkosen.
1098	2006-03-16	Jani Myllynen	Yls:n viides peräkkäinen voitto	Miesten 5-divarin ylemmässä loppusarjassa KooVee 2 voitti Dolphinsin hyvällä esityksellä numeroin 6-2. Ottelusta povattiin kuumaluonteista kuten oli ensimmäinenkin kohtaaminen, mutta lopulta peli oli ihan siistiä, eikä mitään tahallisia vahingoittamisia ottelussa tullut. <br> <br> Kakkosjoukkue pelasi kokonaisuudessaan hyvän ottelun, muutamaa huonompaa minuuttia lukuunottamatta. Ylivoima-pelaaminen oli jälleen mainiota, tuloksena kaksi komeaa maalia, sekä oman päänkin pelissä uhrauduttiin vetojen eteen ja loputhan nappasi hyvän matsin pelannut maalivahti Paukkio. <br> <br> KooVee kakkosen tehomiehet olivat Juuso Koivisto 2+1 ja Jussi Innanen 0+3. Muut tehot menivät Jani Myllyselle 2+0, Teemu Siitariselle 1+0, Jaakko Ailiolle 1+0 sekä Johannes Järviselle 0+1. <br> <br> Sarjan kärkijoukkue KooVee 2 kohtaa ensi lauantaina 18.3 Raholassa jumbona olevan SBMR:n, joka hävisi tänään FBC Nokialle.
1100	2006-03-18	Jussi Innanen	SBMR-maalivahti kovassa vireessä: 3-3	5.divarin yjs:ssa KooVee 2 pelasi tasapelin 3-3 SB Manse Rangersia vastaan. Jumbojoukkue SBMR:n maalivahti masensi Kakkosjoukkueen hyökkääjät loistavilla torjunnoillaan ja esti näin ollen KooVeen voiton. <br> <br> Ottelu oli kaikin puolin hyvää salibandyä, mutta tällä tuloksella Kakkosjoukkue todennäköisesti menetti mahdollisuuden suoraan 4.div-nousijan paikkaan ja samalla siis sarjajohtonsa FBC Nokialle. Maalinteko oli vaikeata lukuisista hyvistä paikoista huolimatta, vaikka muuten peli pyöri hyvin. SBMR pelasi todennäköisesti kauden parhaan pelinsä ja tälläisella esityksellä joukkue ansaitsisi paikkansa 5.divarissa myöskin ensi kaudeksi. <br> <br> KooVeen tehot ottelussa: Jussi Innanen 1+1, Jani Myllynen 1+0, Johannes Järvinen 1+0 ja kapteeni Jukka Kaartinen 0+1. <br> <br> KooVee 2:n seuraava peli on 1.4 lauantaina Raholassa, jolloin vastaan asettuu SB NMP.
1095	2006-03-11	Jussi Innanen	Ennakko: KooVee 2 - Dolphins SU 12.3	Miesten V-divisioonan Pirkanmaa 3:n ylemmässä loppusarjassa 12.3 sunnuntaina Raholassa klo 13.15 Dolphins haastaa jälleen KooVee 2:n toisen kierroksen avausottelussa. <br> <br> Ensimmäinen kohtaaminen joukkueiden välillä päättyi selvään Kakkosjoukkueen 11-5 voittoon, vaikka peli oli pitkään tasaväkinen. Dolphins pelaa vauhdikasta ja todella fyysistä salibandyä ja on näin ollen vaikea vastus KooVeelle, joka on enemmän taitojoukkue kuin fyysisyyden suosija. <br> <br> Ensimmäinen peli oli ajottain todella kuumaluonteista ja törkeääkin käyttäytymistä varsinkin Dolphinsilta ja nyt jääkin nähtäväksi minkälainen vääntö tulee tällä kerralla. Kakkosjoukkueen tarvitsee pitää päät kylmänä ja keskittyä olennaiseen, jotta tärkeä voitto ja 4.divaripaikka alkaa olemaan lähempänä.
1099	2006-03-17	Jussi Innanen	Ennakko: SBMR - KooVee 2  LA 18.3	5.divarin YLS:ssa jumbojoukkue SBMR yrittää kartuttaa pistetiliä sarjakärki KooVee 2:n kustannuksella lauantaina 18.3 Raholassa klo 14.15. <br> <br> Ensimmäisessä pelissä Kakkosjoukkue voitti Manse Rangersit vain 7-5 puolihuolimattomalla pelillä, joten nyt joutuu olemaan tarkkana virheiden kanssa, mutta rutiinisuorituksella voittajasta ei pitäisi olla epäselvyyttä. <br> <br> Lähtökohdat otteluun ovat toisaalta samanlaiset kummallekkin joukkueelle eli voittaa pitäisi. Kakkosjoukkue taistelee pitääkseen suoran 4.div-nousijan paikan ja puolestaan SBMR kamppailee 6.div-putoamista vastaan. Tämän pelin jälkeen on enää kaksi yls-peliä jäljellä, joten panosta riittää loppuun saakka.
1101	2006-03-19	Jussi Innanen	Joukkueen sisäinen yls-pistepörssi	KooVee 2:n sisäistä pistepörssiä 5.divarin ylemmässä loppusarjassa johtaa Jani Myllynen, jolla on tehot 13+7=20 kuudessa ottelussa. Pisteen päässä toisena on Jussi Innanen 5+14=19, kolmantena ovat Juuso Koivisto 10+3=13 ja Jaakko Ailio 5+8=13. <br> <br> Miesten 5.divisioonan Pirkanmaa 3:n ylempää loppusarjaa johtaa nyt FBC Nokia 20 pisteellä ja KooVee 2 on toisena myöskin 20 pisteellä, mutta keskinäisten otteluiden maalien (7-6 eli +1 Nokialle) takia FBC on menossa suoraan 4.divariin ja KooVee karsinta-peliin, kun kaksi yls-peliä on enää pelaamatta.
1102	2006-03-23	Jussi Innanen	Kakkosjoukkueen loppukausi 05-06	Kakkosjoukkueen sisäisessä foorumissa osiossa "yleinen" löytyy kaikille joukkuelaisille luettavaksi suunnitelmat ja asiat loppukaudesta 2005-06.
1103	2006-03-26	Jussi Innanen	KooVeen miesten edustus nousi 1.divariin	Kakkosjoukkue onnittelee KooVeen miesten edustusjoukkuetta noususta 1.divisioonaan ensi kaudeksi.
1105	2006-04-01	Jussi Innanen	Helppo voitto SB NMP:stä 15-3	5.divarin yls:n toiseksi viimeisessä ottelussa KooVee 2 myllytti 15-3 voiton SB NMP:stä keskeytyksellä ajassa 36.58. <br> <br> Kummallakin joukkueella oli pelissä mukana vain 8 kenttäpelaajaa ja maalivahti, joten pelin taso ei ollut päätähuimaavaa ja vauhtiakaan ei ollut kuin puolitoista erää. Kakkosjoukkue ratkaisi pelin käytännössä jo 1.erässä, kun lukemat olivat jo 5-0, sitten 2.erää olikin pelkkää pelailua kummaltakin joukkueelta. <br> <br> KooVee 2:n tehopisteet: Jani Myllynen 6+2, Juuso Koivisto 3+2, Jaakko Ailio 2+3, Jussi Innanen 1+4, Jarno Mustonen 2+1, Johannes Järvinen 1+1 ja Jukka Kaartinen 0+1. <br> <br> Kakkosjoukkueen viimeinen yls-peli on ensi viikon sunnuntaina 9.4 Raholassa SC Interiä vastaan.
1106	2006-04-02	Jussi Innanen	Sarjatilanne ennen viimeistä kierrosta	5.divarin Pirkanmaa 3:n ylemmän loppusarjan sarjatilanne ennen ensi viikonlopun viimeistä kierrosta: <br> <br> FBC Nokia johtaa sarjaa keskinäisen ottelun turvin (+1 maalilla) 22 pisteellä ennen KooVee 2:sta, jolla on siis myöskin 22 pistettä. Nokia on nousemassa suoraan 4.divariin ja KooVee menossa puolestaan karsinta-otteluun (vastustaja: TFT tai Leki 2). <br> <br> Ensi kaudeksikin 5.divaripaikkansa ovat varmistaneet kolmantena oleva SCL 15 pisteellä sekä neljäntenä oleva SB NMP 11 pisteellä. <br> <br> 6.divariin putoamista vastaan kamppailevat viides SC Inter (10 p.), kuudes SC Nemesis (9 p.), seitsemäs Dolphins (8 p.) sekä jumbona oleva SBMR (7 p.). <br> <br> Lopulliset sarjasijoitukset ovat tiedossa siis ensi sunnuntaina 9.4, eli viimeiselläkin kierroksella panosta riittää joka pelissä.
1104	2006-03-31	Jussi Innanen	Ennakko: SB NMP - KooVee 2  LA 1.4	5.divarin Pirkanmaa 3:n yls:n toiseksi viimeisessä ottelussa KooVee 2 kohtaa SB NMP:n Raholan Liikuntakeskuksessa 1.4 lauantaina klo 14.15. <br> <br> Sarjanelonen SB NMP hävisi ekassa kohtaamisessaan Kakkosjoukkueelle 12-5 ja nyt odottaakin revanssia. 4.div-nousukarsijan paikalla eli kakkosena oleva KooVee yrittää elätellä vielä toivoa suorasta noususta, joten viimeiset kaksi ottelua on voitettava ja toivottava että kärkijoukkue FBC Nokialle tulee edes yksi pistemenetys. <br> <br> Kakkosjoukkueen pitää laittaa NMP:tä vastaan paremmalla prosentilla maaleja kuin SBMR:ää vastaan. SB NMP:lle riittää kahdesta viimeisestä pelistä yksi piste varmistamaan 5.divari paikka myöskin ensi kaudeksi. <br> <br> KooVeelta puuttuu lauantaina peräti kolme puolustajaa eli Teemu Siitarinen, Juha Kaartinen ja Lauri Oksanen. Tämä ei voi olla näkymättä itse pelissä.
1110	2006-04-09	Jussi Innanen	KooVee  2:n  sisäinen yls-pistepörssi	KooVee 2:n sisäisen 5.divarin ylemmän loppusarjan pistepörssin voitti Jani Myllynen, joka teki 8 pelissä tehot 21+9=30. <br> <br> Kakkoseksi sijoittunut Jussi Innanen teki 7+21=28 pistettä, kolmas oli Juuso Koivisto 18+6=24 ja neljäs yli kahdenkymmenen tehopisteen joukkoon yltänyt oli Jaakko Ailio 7+15=22. <br> <br> Kaikkien kooveelaisten tehopisteet löytyvät osiosta "Pelaajat" ja sieltä valitsemalla "2005, M5. Div yj.Sisä-Suomi".
1111	2006-04-12	Jussi Innanen	Kauden huipennus edessä 22.4 LA	KooVee 2:n kauden 2005-06 loppuhuipentuma on edessä 4.divisioonan nousukarsintapelin merkeissä Kaukajärven Spiral-saleilla 22.4 launantaina klo 10.00 TFT:tä vastaan. <br> <br> Kakkosjoukkueen kausi tähän mennessä on sujunut tuloksellisesti sekä pelillisesti todella hyvin, vaikka suoraa 4.divari-nousua ei tullutkaan. Pienestä se todella olikin kiinni, mutta silti se meni ansaitusti FBC Nokialle. Nokia oli kieltämättä koko sarjan paras joukkue vaikka jättikin KooVeen keskinäisten otteluiden yhdellä maalillaan (7-3 ja 0-3 yht.7-6) taakseen. <br> <br>    KooVee 2:lla on tähän asti tilastollisestikin todella hieno sarja alla: 22 ottelusta 18 voittoa, 2 tasapeliä ja 2 tappiota ja ylemmässä loppusarjassa siis kahdeksasta ottelusta 7 voittoa ja 1 tasapeli, joka loppuen lopuksi oli kohtalokas suoran nousun suhteen. <br> br> KooVee on pelannut kaikki ottelunsa 2-3 kentällisellä ja joukkueessa onkin tällä hetkellä kaksi iskukykyistä kentällistä sekä erinomainen maalivahti, joten nousumahdollisuudet edelleen ovat. <br> <br> Nousukarsinta-otteluun Toijalan TFT lähtee ennakkosuosikkina, joukkuehan kuitenki pelasi vielä viime kaudella 3.divisioonaa, josta niukasti putosi. Ennakko ilmestyy ensi viikolla KooVee 2 - TFT ottelusta.
1107	2006-04-07	Jussi Innanen	Ennakko: KooVee 2 - SC Inter  SU 9.4	5.divisioonan Pirkanmaa 3:n ylemmän loppusarjan viimeinen eli 8.kierros pelataan sunnuntaina 9.4 Raholan Liikuntakeskuksessa klo 13.15-17.15 välisenä aikana. <br> <br> KooVee Kakkonen kohtaa SC Interin päivän viimeisessä pelissä. KooVeella on panoksena sarjavoitto ja suora nousu neloseen, ainoastaan silloin jos aiemmassa pelissä FBC Nokia jää tasapeliin tai häviää SB NMP:tä vastaan. Jos ed.mainittu ei tapahdu niin silloin KooVee:ta kutsuu nousukarsintapeli 22.4. <br> <br> SC Inter hävisi ekan kohtaamisen Kakkosjoukkueelle rumasti 16-4 keskeytyksellä ja nyt yrittävät laittaa kampoihin 5.divari sarjapaikkansa puolesta. <br> <br> KooVee Kakkoselta puuttuu puolustaja Johannes Järvinen työn takia.
1109	2006-04-09	Jussi Innanen	FBC Nokia nousi suoraan 4.divariin	Miesten 5.divarin Pirkanmaa 3:n ylempi loppusarja on saatu päätökseen ja suoraan 4.divariin nousee sarjan voittaja FBC Nokia (keskinäisten ottelujen perusteella: yhdellä maalilla!) niukasti ennen KooVee 2:sta jolla on myöskin samat pisteet kuin Nokialla eli 8 ottelusta 24 pistettä. KooVeella on siis edessä yksi karsinta-ottelu noususta myöskin 4.divariin. <br> <br> Sarjan kolmas SCL (15 p.), neljäs SB NMP (11 p.), viides SC Nemesis (11 p.) sekä kuudes Dolphins (10 p.) jatkavat ensi kaudellakin 5.divarissa. <br> <br> Ensi kauden 5.divaripaikasta karsimaan joutui SC Inter ja puolestaan SBMR putosi suoraan 6.divariin.
1108	2006-04-09	Jussi Innanen	Voitto tuli, silti nousukarsinta kutsuu	5.divarin Pirkamaa 3:n yls:n viimeisessä eli kahdeksannessa pelissä KooVee 2 voitti selvästi SC Interin 12-5 lukemin. <nr> <br> Pelissä oli enemmän Interille panosta kuin KooVeelle, koska KooVeen suoranousu mahdollisuus meni juuri ennen Inter-ottelua. FBC Nokia murskasi vaajamiehisen SB NMP:n ja jätti näin KooVeen niukalla tavalla kakkoseksi ja karsijan paikalle. Interin olisi pitänyt voittaa Kakkosjoukkue ja välttää näin 5.div-karsintaan joutuminen, mutta se ei toteutunut. <br> <br> Puolivaloillakin KooVee murskasi Interin vaikka peli pysyi tasaisena pitkään ja ottelun taso ei ollut mitenkään erikoinen missään vaiheessa. <br> <br> KooVeen tehot: Juuso Koivisto 5+1, Jussi Innanen 1+3, Jaakko Ailio 0+4, Juha Kaartinen 1+2, Teemu Siitarinen 2+0, Jani Myllynen 2+0 ja Jarno Mustonen 1+1. <br> <br> KooVee 2:n ja TFT:n välinen 4.divarin nousukarsinta-ottelu pelataan Kaukajärvellä 22.4 lauantaina klo 10.00.
1116	2006-04-28	Jussi Innanen	Yhteenveto loppukaudesta 2005-06	Salibandykausi 2005-06 on saatu päätökseen myös 5.divisioonan jatkosarjojen osalta. Nousijat ja putoajat ovat selville Sisä-Suomen alueella: 4.divariin nousivat ensi kaudeksi FBC Nokia, KooVee 2, Leki 2, NOPS Äijät, SBT PaPo ja TAMKO. <br> <br> KooVeen kakkosjoukkueen kautta lyhyesti läpikäytynä tulee siihen tulokseen että kausi meni kokonaisuudessaan erinomaisesti ja tavoite toteutui eli nousu divaria ylemmäksi. Tämä vuosi 2005 ja kauden loppupuolikas eli muutamat alkusarjan pelit sekä kokonaisuudessaan ylempi jatkosarja menivät tuloksellisesti sekä pelillisesti yläkanttiin. Mutta todettakoon että joukkueessa on paljon salibandyä pelanneita jätkiä eri sarjoissa joten mistään suuresta yllätyksestä ei kuitenkaan ollut kyse, paitsi viimeisessä nousukarsintapelissä TFT:tä vastaan, jossa mitattiin joukkueen todellinen taso kuten mm. FBC Nokia peleissä. Tosi asia on että suurinosa vastustajista ei ollut tasokkaita,ei edes ylemmässä jatkosarjassa, mutta pelithän perustuivat siihen että tässä vaikeassa ja hieman kummallisessa uudessa sarjajärjestelmässä piti voittaa ne ns.tärkeät ja merkitykselliset ottelut. <br> <br> Kakkosjoukkueen peli oli pitkin kautta erittäin hyvää suurimmaksi osaksi 5.divari-peleihin lähinnä yksilötaitojen, mutta myöskin joukkuepelaamisen osalta, jolla tavoite saavutettiin niukasti. Tästä lähdetään sitten ensi kaudeksi nelosdivarin otteluihin kesäloman sekä treenamisen kautta. Kakkosjoukkueen joukkueenjohto kiittää jokaista pelaajaa kaudesta 2005-06 ja toivottaa hyvää kesälomaa salibandyn osalta!
1112	2006-04-20	Jussi Innanen	Ennakko: KooVee 2 - TFT  22.4 LA	Nousukarsinnassa 4.divariin KooVee 2 kohtaa TFT:n (Toijala Fumblers Team) 22.4 lauantaina klo 10.00 Kaukajärven Spiral-salien 1-kentällä. <br> <br> Pirkanmaa 1-yls:n toiseksi jäänyt TFT lähtee otteluun ennakkosuosikkina Pirkanmaa 3-yls:n kakkosta eli KooVeeta vastaan. Kummatkin joukkueet jäivät todella niukasti ulos suorasta noususta, ja nyt toisella joukkueella on mahdollisuus pelata ensi kaudella 4.divisioonaa. <br> <br> Toijalan joukkue pelasi vielä viime kaudella 3.divarissa. Sieltä TFT putosi ja menetti pari kovaa pelimiestä ylempiin divareihin, mutta joukkueen eräänlainen runko on silti pysynyt monta vuotta kasassa ja joukkue on todella tasokas 5.divariin. <br> <br> KooVee 2:llakin on joukkueen runko ollut kasassa myöskin jo monta kautta, eikä suurempia menetyksiä ole tullut vaan tilalle on tullut uusia vahvistuksia. Kakkosjoukkueen pelaajatilanne lauantaiksi on hyvä, koska joukkue saa otteluun mukaan kaikki pelaajaansa. <br> <br> Nousukarsintapelistä on todennäköisesti tulossa vauhdikas ja tekninen peli, jossa maaleja nähdään, koska ovathan kummatkin joukkueet tehneet ylemmissä loppusarjoissa 112 maalia per joukkue.  <br> <br> (Aikaisemmat keskinäiset ottelut: 9.4.2004 Suomen Cup: TFT - KooVee 2  6-2.)
1115	2006-04-24	Jussi Innanen	Antti Paukkio joukkueen tsemppipelaaja	KooVeen koko seuran päättäjäisissä Pyynikin palloiluhallissa salibandyjaosto palkitsi kauden 2005-06 miesten kakkosjoukkueen tsemppipelaajana maalivahti Antti Paukkion. <br> <br> Maalivahti Paukkio oli joukkueen tärkeimpiä avainpelaajia nousussa sarjaporrasta ylemmäksi ensi kaudeksi. Paukkio pelasti monet tärkeät sarjapisteet joukkueelle sekä päästi vain 75 maalia 21 pelaamassaan ottelussa, keskiarvon ollessa n.3,5 maalia/per ottelu (21 ott. 17 voittoa, 2 tasuria ja 2 tappiota).
1114	2006-04-22	Jussi Innanen	Kakkosjoukkueen  4.div-nousujuhlat	Kakkosjoukkueen 4.divari nousujuhlat aloitetaan 22.4 lauantaina klo 18.00 jälkeen Hervannassa Vaajakadulla, jossa sauna on kuumana. Hervannasta matka jatkuu perinteisesti kaupungille. Joukkuelaisille lisätietoa löytyy sisäisestä foorumista.
1113	2006-04-22	Jussi Innanen	KooVee 2  nousi  4.divisioonaan	Kaukajärven Spiral-salien 1-kentällä KooVee 2 voitti tiukassa ja hyvätasoisessa nousukarsintapelissä Toijalan TFT:n maalein 4-3 ja näin nousi ensi kaudeksi 4.divisioonaan. <br> <br> Kakkosjoukkue lähti otteluun tasan kahdella kentällisellä ja vastustaja TFT:llä oli mukana kolmisen ketjua plus valmentajat vaihtoaitiossa. <br> <br> Ottelu oli alusta lähtien todella tarkkaa peliä, mutta jo ajassa 1.59 Kooveen pelaajan heikosta avaussyötöstä pääsi ennakkosuosikki TFT rokottamaan. 0-1 maalin puolittaisen läpiajon pääteeksi viimeisteli Aleksi Hänninen. Sen jälkeen oli Kakkosjoukkueen vuoro kun joukkueen kapteeni Jukka Kaartinen väänsi tasoituksen maalinkulmalta 1-1 ajassa 6.05, syöttäjänä toimi Jaakko Ailio. Tasainen ja kovavauhtinen vääntö jatkui välillä kummankin painostaessa, mutta 2-1 johtomaalin KooVeelle viimeisteli maalinedusta hässäkästä Jani Myllynen ajassa 7.16 lyömällä junnu Samu Löövin reboudin sisään. TFT sai kuitenkin vielä 1.erän loppuun 2-2 tasoitusmaalinsa hieman tuurilla, kun Mika Hakalan veto otti kimmokkeen Koovee-puolustajasta ja kimposi loisto-ottelun pelanneen maalivahti Antti Paukkion taakse. <br> <br> 2.erässä KooVee oli hallitsevampi osapuoli, mutta silti huolimattomasta hyökkäyspään vapaalyönnistä pääsi TFT:n hyökkääjä läpi ja Kakkosjoukkueen pelaaja joutui rikkomaan takaa-päin josta seurauksena rankkari Toijalaisille. TFT:n Juha Mönttinen sivalsi taitavasti rankkarin sisään ajassa 19.48 ja peli oli jälleen TFT:lle 2-3. KooVeen odotus palkittiin ajassa 24.01 kun Lauri Oksanen syötti Jani Myllyselle, jonka veto päätyi lopulta TFT-maaliin melkoisen sumpun päätteeksi ja peli oli jälleen tasan 3-3. <br> <br> Ratkaiseva kolmas erä alkoi todella vauhdilla, kummallakin oli paikkansa, mutta pallo ei mennyt maaliin saakka.  KooVee 2 sai rankkarin kun Jani Myllystä rikottiin vetotilanteessa ja ajassa 34.35 pääsi Myllynen yrittämään ratkaisua rankkarista, mutta TFT-vahti Jukka Aalto peitti hyvin ja peli pysyi edelleen tasalukemissa 3-3. Kummallekkin joukkueelle vihellettiin kaksi jäähyäkin 3.erässä, mutta ratkaisua ei syntynyt vieläkään. Tasaisen pelin ratkaisu tuli ajassa 41.27 KooVee Kakkosen hyväksi kun C-junnujen vieraileva tähti Samu Löövi syötti laidasta keskelle Jussi Innaselle, joka ampui pallon ylä-kulmaan: 4-3. Tästä TFT ei enää pystynyt nousemaan tasoihin kovasta pyörityksestä huolimatta ja näin kun tuomarin pillinvihellys kuului ajassa 45.00 alkoivat Kakkosen ainakin vielä kohtuullisen hillityt nousujuhlat (illalla sitten vasta JUHLITAAN kunnolla !). <br> <br> KooVee 2:n hieno kausi siis päättyi 4.divisioona nousuun, joka oli koko joukkueen sekä seurankin tavoite. Kakkosjoukkue kiittää sponsoria eli Skanskaa sekä koko KooVee-salibandyjaostoa. NOUSUJUHLAT ALKAKOON !!!!
1176	2006-11-05	Jussi Innanen	Päivitetty 4.div-sarjataulukko 5.11.06	4.divisioonan päivitetty (5.11.06) sarjataulukko ja ottelutulokset löytyy klikkaamalla vasemmalta kohtaa "sarjat"
1129	2006-07-26	Jussi Innanen	Juha Kaartinen vaihtoon Meksikoon	KooVee 2:n pitkäaikainen "alakerran päällikkö" puolustaja Juha "Lämmi" Kaartinen on pois Kakkosjoukkueen kauden 06-07 vahvuudesta. Juha lähtee tulevan kauden ajaksi vaihto-opiskelijaksi Meksikoon. <br> <br> KooVee 2 toivottaa Juhalle viihtyisää sekä hyvin "kosteaa" Meksikon reissua.
1117	2006-04-28	Jussi Innanen	Koko kauden sisäinen pistepörssi	KooVee 2:n koko kauden sisäisen pistepörssin (runkosarja+yls) ykkönen oli täksi kaudeksi VaLusta KooVeeseen siirtynyt Jani Myllynen, joka teki tehot 38+17=55. <br> <br> Toiseksi sijoittui KooVee 3:sta tullut Juuso Koivisto tehoilla 40+13=53 ja kolmanneksi myöskin VaLusta siirtynyt Jussi Innanen 19+34=53. <br> <br> KooVee 2:n kaikkien aikojen pistepörssin kärkipaikkaa pitää joukkueen kapteeni Jukka Kaartinen, jolla on 58 pelistä tehot 38+27=66.
1120	2006-05-13	Jussi Innanen	KooVee 2  etsii muutamaa pelimiestä	Ensi kaudeksi 2006-07 KooVeen kakkosjoukkue (4.div) etsii riveihinsä muutamaa pelimiestä. <br> <br> Jos kiinnostaa niin ota yhteyttä joukkueenjohtoon: <br> <br> Jukka Kaartinen 040-5419552  jukka.kaartinen@tut.fi <br> <br>  Jussi Innanen 040-8390388  jute07@hotmail.com
1119	2006-05-10	Jukka Kaartinen	Kotisivun osoite vaihtuu!	Uusi osoite on <a href="http://d114.kkaari.tontut.fi/~koovee2">http://d114.kkaari.tontut.fi/~koovee2</a>.<br />\r\nVanha osoite toimii vielä jonkin aikaa.<br />Uusi osoite toimii jo.
1121	2006-06-02	Jussi Innanen	Edustusjoukkueen kesäharjoittelu	KooVeen edustusjoukkueen kanssa on sovittu niin että kaikki halukkaat kakkosjoukkuelaiset pääsevät mukaan edustuksen kesätreeneihin, jos haluavat. <br> <br> Edustusjoukkueen kesäharjoittelu-palaveri pidetään tänään perjantaina 2.6 klo 17.30 Kaukajärven Spiral-saleilla. Treenit alkavat ensi viikon maanantaina.
1126	2006-06-19	Jussi Innanen	KooVee 2:n tulevan kauden sarjat 06-07	KooVee 2 pelaa tulevalla kaudella 2006-07 kahdessa liiton sarjassa: SSBL:n miesten 4.divisioonassa sekä Tamperesarjassa. <br> <br> 4.divari-lohko on jo valmiina ja puolestaan Tamperesarjaan ilmoittautuneet joukkueet jaetaan myöhemmin.
1127	2006-06-21	Jussi Innanen	Sami Peiponen  Kakkosjoukkueeseen	Sami Peiponen siirtyy KooVee 2:n toiseksi maalivahdiksi tulevaksi kaudeksi 06-07. Ykkösmaalivahti Antti Paukkio saa tuuraajakseen Sami Peiposen, joka tulee pelamaan ennen kaikkea Tamperesarjan ottelut sekä mahdolliset 4.div-ottelut joihin ei Paukkio pääse. <br> <br> Peiponen on pelannut aikaisemmin Ilves 2:ssa (4.div), Classic 2:ssa (3.div) sekä SB Ontossa (2.div), mutta piti viime kauden taukoa salibandymaalivahdin hommista.
1122	2006-06-09	Jussi Innanen	Kakkosjoukkueen ensimmäiset kesätreenit	KooVeen kakkosjoukkueen kesäharjoittelu alkaa ensi viikon maanantaina 12.6. Kesätreenien ajat ja paikat löytyvät joukkuelaisille sisäisestä foorumista.
1123	2006-07-05	Jussi Innanen	KooVee 2:n  pelaajatilanne 2006-07	KooVee 2:n viime kauden joukkueesta puolustaja Johannes Järvinen, hyökkääjät Jani Singh, Jarno Mustonen, Lauri Yli-Huhtala, Jussi Innanen, Jani Myllynen, Lauri Oksanen, Jaakko Ailio sekä kapteeni Jukka Kaartinen jatkavat tulevalla kaudella 2006-07 KooVee 2:ssa 4.divisioonan merkeissä. Myös maalivahti Antti Paukkio jatkaa maalinsuulla ja kakkosveskariksi tuli uusi mies Sami Peiponen. Muiden vanhojen pelaajien sekä uusien tulokkaiden tilanne ratkennee myöskin lähiviikkoina.
1125	2006-06-15	Jussi Innanen	4.divari-lohkot jaettuna kaudelle 06-07	SSBL:n Sarjavaliokunta on jakanut tulevalle kaudelle 2006-07 Miesten 4.divisioona-lohkot Sisä-Suomen alueella. Lohkoja on neljä kappaletta ja KooVee 2 on sijoitettu 3.lohkoon, joka on kovatasoisin näistä Sisä-Suomen neljästä lohkosta. <br> <br> 3.Lohkossa pelaa KooVee 2:n lisäksi yhdeksän joukkuetta: B (Tre), D-Kone (Tre), Ilves 3 (Tre), FiBa (Tre), KoKo (Tre), TAMKO (Tre), Soolo (Tre), Punakone (Tre) ja SBT PaPo (Parkano). Sarjapelit alkavat Syys-Lokakuussa.
1128	2006-07-02	Jussi Innanen	4.divisioonan otteluohjelma selvillä	KooVee 2:n tulevan kauden 4.divisioonan 3.lohkon otteluohjelma on selvillä. KooVee 2 kohtaa ensimmäisessä 4.div-pelissään nousijajoukkue TAMKO SB:n Kaukajärvellä lauantaina 23.9.2006 klo 11.00. Kaikki ottelut löytyvät joukkuelaisille sisäisestä foorumista.
1136	2006-08-08	Jussi Innanen	Jarno Jokinen  Kakkosjoukkueeseen	KooVee 2 vahvistaa tulevan kauden puolustuslinjaa oman seuran miehellä Jarno Jokisella. Jokinen on pelannut mm. KooVeen edustusjoukkueessa 2.divisioonaa ja nykyään toimii edustuksessa joukkueenjohtajan tehtävissä.
1134	2006-08-03	Jussi Innanen	Harjoitusvuorot kaudella 06-07	Kakkosjoukkueen harjoitusvuorot tulevalla kaudella 06-07 ovat seuraavat: <br> <br> Tiistai 21-22 Pirkkahalli-2  (Alkaen 24.10.06) <br> <br> Torstai 18-19 Kaukajärvi-2
1133	2006-08-02	Jussi Innanen	KooVee 2 osallistuu Punakone-turnaukseen	KooVee 2 on ilmoitettu lauantaina 2.9.2006 pelattavaan Punakoneen 10v.Juhlaturnaukseen, joka pelataan Kaukajärvellä. <br> <br> Lisätietoa turnauksesta tulee myöhemmin.
1131	2006-07-28	Jussi Innanen	KooVee-salibandy kaudella 2006-07	KooVee-salibandylla on tulevaksi kaudeksi 2006-07 liiton eri sarjoihin yli kaksikymmentä joukkuetta. KooVeen miesten joukkueet SSBL:n sarjoissa: <br> <br> Edustus (1.div) <br> <br> Kakkonen (4.div) <br> <br> Kolmonen (5.div) <br> <br> Nelonen (6.div)
1132	2006-08-02	Jussi Innanen	Tamperesarjan otteluohjelma valmis	Tamperesarjan 2.divisioonan otteluohjelma on saatu valmiiksi. KooVee 2 kohtaa ensimmäisessä Tamperesarjan ottelussa Ylöjärven AWEn Raholassa 13.9.2006 klo 20.00. <br> <br> Tamperesarja kakkosessa pelaa KooVee 2:n lisäksi AWE, Nokian KRP, Classic XL, WMP, KoKo, SB Luuppi sekä SB NMP. Sarja pelataan kaksinkertaisena ja kaksi parasta joukkuetta nousee Tamperesarja ykköseen.
1135	2006-08-04	Jussi Innanen	Punakone-turnauksen joukkueet	Lauantaina 2.9.06 pelattavaan Punakoneen 10-vuotis juhlaturnaukseen on ilmoittautuminen käynnissä parhaillaan. Turnaukseen ovat osallistuneet tähän mennessä seuraavat joukkueet: <br> <br> Punakone (4.div) <br> <br> KooVee 2 (4.div) <br> <br> NOPS Äijät (4.div) <br> <br> SCL (5.div) <br> <br> Classic 3 (3.div) <br> <br> Sottiisi Fun Club (5.div) <br> <br> SB Luja (5.div) <br> <br> SIPS (5.div) <br> <br> IRA (6.div) <br> <br> FBT Patapallo (Pori) (5.div) <br> <br> Turnaukseen otetaan mukaan 12 joukkuetta eli kahdelle paikka on vielä vapaana.
1138	2006-08-23	Jussi Innanen	Heikki Korhonen siirtyy KooVee 2:een	KooVee 2:n hyökkäyskalusto saa lisää syvyyttä kun Heikki Korhonen siirtyy joukkueeseen Hämeenlinnalaisesta SB Kisasta. <br> <br> Korhonen pelasi viime kauden SB Kisan joukkueessa 3.divisioonaa, mutta joukkue putosi sarjatasoa alemmaksi ja näin "Kosti" valitsi KooVee 2:n Tampereella opiskelun vuoksi.
1137	2006-08-25	Jussi Innanen	Joukkuekuvaus Kaukajärvellä  2.9	KooVee-salibandyjaoston joukkueiden valokuvaukset pidetään Kaukajärven Spiral-saleilla lauantaina 2.9.2006. Miesten Kakkosjoukkueen kuvausaika on klo 15.10. Foorumista löytyy joukkuelaisille lisätietoa.
1141	2006-08-30	Jussi Innanen	Ensimmäinen saunailta	Kakkosjoukkueen kauden ensimmäinen saunailta pidetään Punakone-turnauksen jälkeen lauantaina 2.9.06 Hervannassa klo 17 alkaen. Lisätietoja löytyy joukkuelaisille sisäisestä foorumista.
1130	2006-08-31	Jussi Innanen	KooVee 2:n  kokoonpano  06-07	KooVee 2:n kauden 06-07 kokoonpano 4.divisioonan sekä Tre-sarjan otteluihin: <br> <br> Maalivahdit: 30 Antti Paukkio, 1 Sami Peiponen <br> <br> Puolustajat: 5 Teemu Siitarinen, 15 Johannes Järvinen, 14 Lauri Oksanen, 7 Jarno Jokinen (uusi) <br> <br> Hyökkääjät: 80 Jukka Kaartinen, 16 Jani Myllynen, 8 Jani Singh, 79 Jussi Innanen, 10 Juuso Koivisto, 12 Jaakko Ailio, 6 Jarno Mustonen, 4 Lauri Yli-Huhtala, 13 Heikki Korhonen (uusi).
1139	2006-08-28	Jussi Innanen	Punakoneen 10-vuotis juhlaturnaus	Lauantaina 2.9.06 pelattavaan Punakone-turnaukseen lopulta otettiin vain 10 joukkuetta eikä siis 12 joukkuetta. Turnausjärjestelmä on seuraava: Kaksi viiden joukkueen lohkoa, joista lohkovoittajat finaaliin ja kakkoset pronssipeliin eli pelejä tulee kaikille joukkueille vähintään neljä kappaletta. Kakkosjoukkueen otteluohjelma: <br> <br> 10.00 Punakone-KooVee 2, 11.30 KooVee 2-SB Luja, 13.45 KooVee 2-SFC ja 15.15 KooVee 2-IRA. Finaali ja Pronssipeli pelataan klo 16.15.
1142	2006-09-03	Jussi Innanen	Vaisu Punakone-turnaus	Kakkosjoukkueen pelit Punakoneen 10-vuotis Juhlaturnauksessa 2.9 lauantaina Kaukajärvellä menivät penkin alle varsinkin pelillisesti ja hieman myös tuloksellisesti. Tasan kahdella kentällisellä ja yhdellä veskarilla turnaukseen lähdettiin mutta missään vaiheessa peli ei kulkenut tarvittavalla tavalla. <br> <br> KooVee 2:n pelien tulokset (2 voittoa ja 2 tappiota): <br> <br> Punakone-KooVee 2 3-2. Maalit: Myllynen, Yli-Huhtala <br> <br> KooVee 2-SB Luja 2-3. Maalit: Jokinen, Innanen <br> <br> SFC-KooVee 2 0-2. Maalit: Yli-Huhtala, Siitarinen <br> <br> KooVee 2-IRA 3-1. Maalit: Koivisto 3 <br> <br> Turnauksen voitti lopulta isäntä-joukkue Punakone, joka kaatoi finaalissa NOPS Äijät. Lisää turnauksesta löytyy sivulta www.punakone.net/turnaus/
1140	2006-09-02	Jussi Innanen	Ennakko Punakone-turnauksesta	KooVee 2 lähtee kauden 06-07 avauspeleihin harjoitusturnauksen merkeissä ja kyseessä on siis Punakoneen 10-vuotis Juhlaturnaus 2.9.06 Kaukajärvellä. <br> <br> Pelit turnauksessa ovat lyhyitä (2x15 min), joten Kakkosjoukkueella ei ole mukana kuin kaksi kentällistä pelaajia sekä yksi maalivahti. Turnauksen joukkueita katsoessa voi sanoa ennakkosuosikiksi huomattavasti vahvistuneen Classic 3:n, joka pelaa ainoana 3.divisioonaa. Loput turnauksen joukkueista pelaa 4-6 divareita, mutta aina yllätyksiä tapahtuu. Kakkosjoukkueen pelillinen tavoite on saada joukkuepeli kelpo kuosiin ennen sarja-avauksia (4.div ja Tre-sarja) ja muutenkin päästä turnauksessa mahdollisimman pitkälle. <br> <br> Koovee 2:n pelaajat turnauksessa alustavasti: <br> <br> Maalivahdit: Antti Paukkio <br> <br> Puolustajat: Johannes Järvinen, Jarno Jokinen, Lauri Oksanen, Teemu Siitarinen <br> <br> Hyökkääjät: Jani Myllynen, Jukka Kaartinen C, Jussi Innanen, Jani Singh, Lauri Yli-Huhtala, Juuso Koivisto
1144	2006-09-05	Jussi Innanen	Tamperesarjan joukkue muutos	Tamperesarja-2:n WMP perui osallistumisensa viime hetkellä ja näin Team Showtime ottaa WMP:n paikan. <br> <br> KooVee 2 kohtaa Showtimen kahdesti: ensin 25.10.06 ja toisen kerran 7.2.07 Raholassa, kummatkin pelit pelataan klo 20.00.
1143	2006-09-04	Jussi Innanen	Harjoituspeli KooVeen B-jun. vastaan	Kakkosjoukkue pelaa harjoitusottelun torstaina 7.9.06 Kaukajärvellä omalla treenivuorollaan klo 18.00 KooVeen B-89 junioreita vastaan.
1145	2006-09-06	Jussi Innanen	Tamperesarja-joukkueiden ennakot	Ensi viikolla alkaa Liiton Tamperesarjat. Tamperesarja-2:ssa pelaa kahdeksan joukkuetta, joista kaksinkertaisen sarjan päätyttyä kaksi parasta nousee Tre-1:een. Pienet ennakkokatsaukset joukkueisiin: <br> <br> Nokian KRP (1.div): Selvä voittajasuosikki, vaikka pelannee käytännössä A-junioreilla, mutta myöskin "vanhoja liiga- ja divaritähtiä" varmaankin välillä nähdään kentällä. <br> <br> KooVee 2 (4.div): Hissiliikettä nelosen ja vitosen välillä ollut jo liikaa. Hiukkasen vahvistunut viime kaudesta ja tavoittelee paikkaa kahden nousijan sakkiin. <br> <br> KoKo (4.div): Pienirinkinen joukkue joka on kanssa pelannut nelosta ja vitosta melkein vuorotellen, omaa yhden hyvän ketjun. Myöskin varteenotettava nousija. <br> <br> SB NMP (5.div): Vitosen kärkipään joukkueita, mutta tavoitteista ei ole tietoa..keskikastia tulevallakin kaudella Tre-sarjassa. <br> <br> Team Showtime (5.div): Pitkään melkein samalla miehistöllä aladivareita tahkonut kaveriporukka pelaa ailahtelevasti, mutta välillä vaikea vastus kun ovat pelipäällä. <br> <br> SB Luuppi (6.div): Myöskin pitkän tien kulkija 5.divarissa, joka nyt putosi kutoseen tulevaksi kaudeksi. <br> <br> AWE Team (6.div): Fyysinen joukkue jossa muutama hyvä yksilö, yllättää silloin tällöin. <br> <br> Classic XL (6.div): Pääosin koostuu Classicin viime kauden 4- ja 5 joukkueiden pelaajista, jotka putosivat kutoseen. <br> <br> KooVee 2 kohtaa ensimmäisessään Tre-sarjan pelissään keskiviikkona 13.9.06 Raholan Liikuntakeskuksessa klo 20.00 viime kauden 5.divarista tutun AWE-Teamin.
1147	2006-09-07	Jussi Innanen	Jukka Kaartinen jatkaa kapteenina	Kakkosjoukkueen kapteenina jatkaa tulevallakin kaudella 06-07 Jukka Kaartinen. Varakapteeneina toimivat Jussi Innanen ja Jarno Jokinen.
1150	2006-09-14	Jussi Innanen	Nolo tappio Tre-sarjan avauksessa	Tamperesarja-2 alkoi heikosti Kakkosjoukkueen osalta häviten Ylöjärven AWE-Teamille nolosti 3-2 Raholan Liikuntakeskuksessa. <br> <br> Kauden ensimmäinen Tre-sarjan ottelu oli alusta lähtien vaikea peli KooVeelle, paikkoja oli moneenkin maalin mutta vedot olivat onnettomia ja terävyys puuttui hyökkäyksien päätöksissä. <br> <br> AWE joka putosi 6.divariin sen sijaan panosti vastahyökkäyksiin ja piti pelinsä liikkeessä sekä pystyi luomaan enemmän vaarallisia paikkoja. Ylivoimalla AWE teki voittomaalin pelin lopussa. Ilman Kakkosjoukkueen maalissa pelannutta Sami Peiposta olisi peli ratkennut jo ensimmäiseen erään, mutta Peiponen venyi muutamiin loistotorjuntoihin ja piti KooVeen mukana pelissä. Joukkue pelasi pahasti alle oman tasonsa ja todella nolo tappio oli tosiasia jo kauden ekassa pelissä. <br> <br> KooVee 2:n maalit tekivät Jussi Innanen (1-1) ja Johannes Järvinen (2-2). Jani Myllynen syötti ensimmäisen maalin. <br> <br> Seuraavassa Tre-sarjapelissa vastaan tulee aivan eri tasoinen joukkue, kyseessä on siis 1.divisioonan Nokian KRP.
1148	2006-09-08	Jussi Innanen	Kakkosjoukkue voitti B-junnut  4 - 3	KooVee 2 pelasi kokonaisuudessaan hyvän harjoituspelin saman seuran B89-junioreiden ykkösjoukkuetta vastaan ja nousi voittoon 4-3 numeroin. <br> <br> Kakkosjoukkueen maalit: <br> <br> 1-0 Siitarinen (Singh) <br> <br> 2-1 Yli-Huhtala (Innanen) <br> <br> 3-3 Innanen <br> <br> 4-3 Kaartinen (Innanen).<br> <br> KooVee 2:lla oli pelissä mukana 12 kenttäpelaajaa ja maalissa pelasi Antti Paukkio.
1146	2006-09-06	Jussi Innanen	4.div joukkue muutos	3.Divisioonassa tapahtui Sisä-Suomen alueella muutama yllättävä sarjasta luopuminen kun TSB (Tampere) ja Hogs International (Jyväskylä) lopettivat toimintansa. Sen seurauksena 4.div-lohkosta nro.3 eli Kakkosjoukkueen lohkosta D-Kone nostettiin takaisin 3.divariin ja tilalle nousi 5.divarista DTT (DownTown Tigers).
1153	2006-09-20	Jussi Innanen	Innaselta jää väliin 4.div-avauspeli	Kauden 06-07 ensimmäisestä 4.divisioonan ottelusta 23.9 lauantaina TAMKOa vastaan Kakkosjoukkueen vahvuudesta puuttuu hyökkääjä Jussi Innanen, joka on samaan aikaan Ruovedella hautajaisissa.
1152	2006-09-17	Jukka Kaartinen	Harj.peli pyynnöt sekä treenipelaajat	Jos kiinnostaa harjoituspeli KooVee 2 (4.div) vastaan, niin ota yhteyttä sähköpostitse joukkueen yhteyshenkilöihin: <br> <br> Jussi Innanen = Jussi.Innanen (at) salibandy.koovee.fi <br> <br> Jukka Kaartinen = jkaartinen (at) gmail.com   <br> <br> Myös Kakkosjoukkueessa pelkästään treenaamiseen halukkaat ottaakaa yhteyttä ed.mainittuihin henkilöihin.
1149	2006-09-11	Jussi Innanen	Ennakko: Tre2  AWE - KooVee 2   13.9.06	Keskiviikkona 13.9.06 Raholan Liikuntakeskuksessa alkaa Tamperesarja-2 Kakkosjoukkueen osalta ottelulla Ylöjärven AWE Teamia vastaan klo 20.00. <br> <br> Ennakkoon ajatellen ottelussa KooVee 2 on selkeä suosikki jo sarjatasojen suhteen (KooVee 2 4.div ja AWE 6.div) sekä aikaisempia kohtaamisia katsoessa (viime kaudelta: 5.div 6-3 ja 15-3 voitot KooVeelle). Mutta yllätyksiä tapahtunee myöskin Tamperesarjassa, koska kaikki joukkueet pelaavat  Tre-sarjan lisäksi divareita ja pelaajisto "elää" koko ajan. <br> <br> KooVee 2:n rotaatio alkaa AWE-pelissä: Eli Kakkosjoukkue kierrättää (melkein) kaikkia pelaajiaan kun pelataan kahta eri sarjaa (4.div ja Tre-2), vakiot pysynee kummassakin sarjassa mutta huilauksia tulee silti jokaiselle. Joka pelissä siis KooVeella on mukana aina tasan kaksi kentällistä ja 1-2 maalivahtia. AWE-pelin huilaa KooVee 2:lta Juuso Koivisto, Heikki Korhonen sekä maalivahti Antti Paukkio. Jaakko Ailiolta jää puolestaan enemmän pelejä väliin ollessaan Afrikassa.
1151	2006-09-17	Jussi Innanen	4.divisioona joukkueiden ennakot	Lauantaina 23.9.06 alkaa SSBL:n Sisä-Suomen 4.divisioonan lohko-3:n pelit Kaukajärven Spiral-saleilla. Kymmenen joukkueen sarjassa pelataan kaksinkertainen perussarja jonka voittaja nousee suoraan 3.divisioonaan ja kakkonen pääsee yhden pelin karsintaan toisen lohkon kakkosta vastaan. Kolme viimeistä joukkuetta putoavat suoraan 5.divisioonaan. <br> <br> Lyhyet ennakkokatsaukset lohkon joukkueisiin: <br> <br> Punakone: Joukkueella on leveä materiaali: Kolme tasaista ketjua kovakuntoisia ja fyysisiä pelaajia ja on ehdottomasti lohkon voittajasuosikki. (Aikasemmat keskinäiset pelit: Punakone-KooVee 2 3-2) <br> <br> B: Taitava kärkipään joukkue nelosessa ratkaissee suoran nousijan paikan Punakoneen kanssa. Täynnä kovia pelimiehiä aladivareihin, mutta myöskin välillä pelaajista pulaa otteluissa. <br> <br> Ilves 3: "Vanhoja divarijyriä" ja nuorempia junnuja vilisevä liikkuva joukkue. Ottanee pisteitä myöskin kärkijoukkueilta. (Aikaisemmat keskinäiset pelit: KooVee 2-Ilves 3 2-2, Ilves 3-KooVee 2 3-3) <br> <br> Soolo: Viime kaudella nelosessa neljäs, joten potentiaalinen yllättäjä joukkue myöskin tällä kaudella.  <br> <br> KooVee 2: Tavoite vähintään turvata sarjapaikka myös ensi kaudellekin nelosessa. Taso rittää neloseen, mutta välillä liika pehmeys on heikkous. Keskikastin joukkue. <br> <br> TAMKO SB: Myöskin täksi kaudeksi neloseen noussut Ammattikorkeakoulun nuori taitava joukkue voi taistella sarjapaikkansa puolesta, mutta keskitasoa lohkossa KooVeen tapaan. <br> <br> KoKo: Pienirinkinen joukkue, joka sinnittelee keskikastin jommalla kummalla puolella tasaisessa sarjassa. <br> <br> FiBa: Taistelee putoamista vastaan tasaisessa häntäpäässä, mutta voi yltää helposti myöskin kuuden sakkiin. (Aikaisemmat keskinäiset pelit: KooVee 2-FiBa 6-2) <br> <br> DTT: "Kabinetissa" neloseen noussut joukkueen ainoa tavoite säilyä nelosessa. Muutama hyvä yksilö joukkueessa. <br> <br> SBT PaPo: Parkanon nousijajoukkue voi olla joko heittopussi ja tai sitten musta hevonen ja yllättää kaikki lohkon joukkueet. <br> <br> Kaikin puolin tiedossa on todennäköisesti hyvätasoinen sekä tasainen lohko, jossa nähdään vauhdikkaita pelejä. Kaksi selvää nousijasuosikkia ja loput kahdeksan muuta joukkuetta taistelee tasapäisesti. <br> <br> KooVee 2:n kauden 06-07 ensimmäisessä 4.divari-pelissä vastaan tulee TAMKO SB.
1154	2006-09-19	Jussi Innanen	KooVee 2:n  joukkuekuva lisätty	Kakkosjoukkueen joukkuekuva on lisätty sivuille. Kuvan näkee kun ensin klikkaa vasemmalta "Joukkue" sen jälkeen kohtaa "Miesten 4.divisioona, 2006" ja lopuksi vielä klikkaa "kameraa". Kuvasta puuttuvat Jarno Mustonen, Jaakko Ailio ja Heikki Korhonen.
1157	2006-09-27	Jussi Innanen	Ennakot Tre2 ja 4.div tulevista peleistä	KooVee 2 kohtaa tällä viikolla perjantaina 29.9 Raholassa Tamperesarjassa sarjajohtaja N-KRP:n ja heti perään lauantaina 30.9 Kaukajärvellä 4.divarissa vastaan asettuu B. <br> <br> Tre-2: KRP-KooVee 2-ottelussa Kakkosjoukkue yrittää avata pistetilinsä nolon AWE-tappion jälkeen ja puolestaan Nokialaiset tulevat hakemaan toista voittoaan todennäköisesti A-junnu pitoisella joukkueellaan. Hyvällä joukkuepelillä ja taistelutahdolla kuten viikonloppuna 4.div-avauksessa KooVeella on mahdollisuus yllättää Nokian KRP. KooVeelta poissa ovat huilausvuoron vuoksi hyökkääjät Jani Myllynen ja Jussi Innanen.Myös maalivahti Sami Peiponen ei pelaa nivusrevähdyksen vuoksi. <br> <br> 4.div: B-KooVee 2-ottelu on toinen 4.div-ottelu ja todellinen tasomittari KooVeelle, koska B on suosikkijoukkue ottelussa sekä koko sarjassa. B:llä on riveissään paljon entisiä KooVeen pelaajia ja taitoa löytyy kaikilta. Tiedossa siis kärkikamppailu jossa Kakkosjoukkueella on mahdollisuudet kuitenkin ottaa B:ltä pisteitä.
1155	2006-09-21	Jussi Innanen	Ennakko: 4.div  KooVee 2 - TAMKO  23.9	Sisä-Suomen alueen 4.divisioona starttaa nyt viikonloppuna käyntiin ja avauspelissään lauantaina 23.9.06 klo 11.00 KooVee 2 kohtaa toisen nousijajoukkueen TAMKO SB:n Kaukajärven Spiral-saleilla. <br> <br> Ennakkoon ajatellen kyseessä on kaksi saman tyyppistä joukkuetta vastakkain. Ennakkosuosikkia on vaikea sanoa, koska pelistä varmaankin tulee tasainen vääntö kahden nuoren joukkueen välillä. Kummatkin pelaavat divarin lisäksi Tamperesarjoja, tosin Ammattikorkeakoulun joukkue TAMKO sarjaporrasta ylempänä. <br> <br> Kakkosjoukkueen pitää parantaa aikaisemmissa peleissä nähtyä koko joukkueen puolustustyöskentelyä, joka on ollut aika vaatimatonta muutamaa hyvää harj.peliä lukuunottamatta. KooVee 2 lähtee pelaamaan jokaista 4.div-peliä kahdella parhaalla kentällisellään ja ekan pelin kokoonpanosta puuttuvat hyökkääjät Jussi Innanen (Ruovedella hautajaissa) ja Jaakko Ailio (Afrikassa). <br> <br> Heikki Korhosen ja Jarno Jokisen KooVee 2:n 4.div-"debyytit" nähdään lauantaina.
1158	2006-09-29	Jussi Innanen	Tre2: KooVee 2 ja N-KRP tasapeliin 4 - 4	Tamperesarjan perjantai-illan ottelussa Raholassa Nokian KRP:n A-juniorijoukkue vei täysin ensimmäisen erän nimiinsä 4-0, mutta KooVee 2 ryhdistäytyi hienosti ja nousi ansaitusti tasoihin 4-4. <br> <br> Ottelun alku oli järkyttävä kooveelaisten kannalta, koska peli oli jo 4-0 nokialaisille kun vain 9 minuutia oli pelattu. Mutta KRP pyöri tehottomasti ja väsähti nopeasti, jolloin Kakkosjoukkueen komea kiri alkoi. KooVeen ylivoimapeli oli kohtalaisen tehokasta, koska kaksi maalia syntyi yv:llä. <br> <br> KooVeen tehomies oli Heikki Korhonen tehoilla 1+2, muut tehot menivät Lauri Yli-Huhtalalle 1+0, Juuso Koivistolle 1+0, Teemu Siitariselle 1+0 sekä Jani Singhille 0+1. Maalissa pelasi Antti Paukkio, Peiposen ollessa loukkaantuneena. <br> <br> KooVee 2:n kauden kolmas Tamperesarja-peli on Classic XL:ää vastaan perjantaina 13.10 Raholassa klo 19.00.
1156	2006-09-23	Jukka Kaartinen	Kauden avausvoitto!	KooVee II otti kauden avausvoiton 4. div- sisä-suomen lohkossa voittaen TAMKO:n 3-1. Voitto saavutettiin kovalla taistelulla tappavan tehokaalla viimeistelyllä. KooVee:n maalintekijät olivat Juuso Koivisto ja kaksi maali tehnyt Jani Myllynen. Debyyttinsä KooVee II:ssa tehnyt Jarno Jokinen kalasti syöttöpisteen kuten myös Lauri Oksanen ja Lauri Yli-huhtala. Pelin pöytäkirjan löydät <a href="index.php?alitoiminto=pelitilastot&peliid=1177"><b>täältä</b></a>.
1165	2006-10-12	Jussi Innanen	4.divisioonan pistepörssi	Miesten 4.divisioonan Sisä-Suomen lohkon pistepörssiä johtaa yllättäjä joukkue DTT:n Harri Vähäkuopus tehoilla 3.8+2=10. Toisena löytyy seuratoveri Tigersista Rami Rajakallio 3.3+5=8 ja puolestaan kolmantena on Soolon Janne Tikkakoski 2.5+2=7. <br> <br> KooVee 2:n parhaat pistemiehet ovat 9. Jani Myllynen 3.3+1=4 ja 11. Jussi Innanen 2.2+2=4.
1159	2006-09-30	Jussi Innanen	4.div:  B oli parempi numeroin 3 - 0	Kauden toisessa 4-divaripelissä KooVee 2:sta vastaan tuli koko sarjan nousijasuosikki B, joka ei antanut KooVeelle mahdollisuuksia yllätykseen vaan voitti selvästi 3-0. <br> <br> Ottelua B dominoi täysin ja hyödynsi Kakkosjoukkueen virheet tehokkaasti. Heti aloituksesta vain 7 sekunnin pelin jälkeen koovee-pakki pelasi löysästi ja B kiitti 1-0:een. Toisen maalinsa B teki 2.erässä hienolla kuviolla keskeltä ja peli 2-0. Vaikka KooVee pelasikin kohtuu hyvin viisikkopuolustuksensa, niin silti ottelu ratkesi vielä yhteen pahaan virheeseen keskialueella ja 3-0 oli loppuluvut. Kakkosella maalissa pelasi mainion ottelun Antti Paukkio, joka ei voinut yhdellekään maalille yhtään mitään ja pitikin numerot kooveen kannalta siedettävinä. Myös KooVeella oli ottelussa muutama hyvä hyökkäys ja maalipaikka, mutta silti maalisarakkeesta löytyy tyly nolla. <br> <br> KooVeen pitää parantaa peliä ja varsinkin karsia turhat henkilökohtaiset virheet pois ennen ensi sunnuntain Soolo-ottelua.
1160	2006-10-02	Jussi Innanen	4.divisioonan sarjatilanne	4.divisioonaa johtaa tällä hetkellä B, joka on voittanut kaksi ensimmäistä peliään ja sillä plakkarissa täydet neljä pistettä. D-Koneen paikalle 5.divarista "kabinetissa" nostettu DownTown Tigers on yllättäen kakkosena kolmella pisteellä kuten myöskin on FiBa, jolla on 3 pistettä mutta heikompi maaliero. Sen jälkeen kahdessa pistessä ovat neljä joukkuetta (Punakone, KooVee 2, Soolo, Ilves 3), joista Ilves 3 ja Soolo ovat vasta pelanneet yhdet ottelut. Peränpitäjinä on nollakerholaiset SBT PaPo, KoKo ja TAMKO SB. <br> <br> Seuraavat ottelut pelataan ensi sunnuntaina 8.10 Kaukajärvellä: 10.00 KooVee 2-Soolo, 11.00 KoKo-Punakone, 12.00 DTT-B ja 13.00 FiBa-TAMKO. Ilves 3:lla ja SBT PaPolla ei ole peliä Kaukajärvellä.
1161	2006-10-02	Jussi Innanen	Tamperesarja-2:n  sarjatilanne	Tamperesarja-kakkosessa on pelattu kaksi ottelua ja sarjaa johtaa SB Luuppi (4p.), joka on voittanut molemmat ottelunsa. Kolmessa pisteessä ovat SB NMP, AWE ja Nokian-KRP. Seuraavaksi tulevat Classic XL (2p.), KooVee 2 (1p.) ja nollassa ovat vielä KoKo ja Showtime. <br> <br> Sarjassa pelataan yhteensä 14 peliä ja kaksi parasta nousee Tampere-ykköseen.
1164	2006-10-13	Jussi Innanen	Ennakot tulevista peleistä Tre2 ja 4.div	Perjantaina 13.10 klo 19.00 Raholan Liikuntakeskuksessa Tamperesarja-2:n ottelussa KooVee 2 saa vastaansa Classic XL:n ja sunnuntaina 15.10 klo 11.00 Kaukajärvellä 4.divarissa vastaan tulee Ilves 3. <br> <br> Tre-2: Classic XL-KooVee 2 ottelussa KooVee yrittää napata ensimmäisen voittonsa Tamperesarjassa (tähän asti: 1 tasapeli ja 1 tappio) Classicin kustannuksella, joka hävisi sarjajohtaja SB Luupille mutta voitti yllättäen 4.div-joukkue KoKon. Kakkosjoukkueella oli viimeksi hyvä peli N-KRP:tä vastaan (4-4) ja nyt sama taso pitää säilyttää jotta Classic XL kaatuu eikä kärki karkaa enää kauemmas. Maalirikas ottelu hyvin todennäköisesti tiedossa. KooVeelta huilivuorossa ovat kapteeni Jukka "Jukkis" Kaartinen ja Heikki "Kosti" Korhonen. Kaartisen tilalla kapteenina pelissä toimii Jussi Innanen. <br> <br> 4.div: Ilves 3-KooVee 2 pelissä nähdään Ipan puolelta "vanhoja divarijyriä", jotka pelipäällä ollessaan ovat vaikeita pysäyttää ja lisäksi joukkueessa on omaa juniorikaartia. Ilves 3 on pelannut nelosessa vasta yhden ottelun, jossa se voitti jumbo-KoKon 6-5. KooVee kakkosen pitää pelata hyökkäyspelinsä paremmin kuin Sooloa vastaan että voitto irtoaa, koska vain neljällä tehdyllä maalilla tuskin täysiä sarjapisteitä irtoaa. KooVeelta poissa on vielä Jaakko Ailio, joka palaa ensi kuussa takaisin Suomeen. (Aikaisemmat keskinäiset kohtaamiset: Ilves 3 - KooVee 2 3-3, 2-2, 6-3, 4-8.)
1162	2006-10-05	Jussi Innanen	Ennakko: 4.div  KooVee 2 - Soolo 8.10.06	Sunnuntai-aamuna 8.10 klo 10.00 Kaukajärven Spiral-saleilla KooVee 2 haastaa Soolon 4.divari-ottelussa. <br> <br> Ennakkoon Soolo on hienoinen ennakkosuosikki pelissä: Soolo on pelannut vasta yhden ottelun, jossa se oli vakuuttava murskaten KoKon 10-4 lukemin. Joukkueen ykköshyökkääjä, Soittorasiasta tullut Janne Tikkakoski paukutti KoKo-pelissä tehot 5+1. Kun aamu peli on kyseessä niin sekin vaikuttaa, että millä "liikkeellä" joukkueet ovat matkassa. <br> <br> KooVeen kurinalainen viisikkopuolustus toimi hyvin B:tä vastaan, koska otteluhan käytännössä ratkesi muutamaan henk.kohtaisiin virheeseen. Kakkosjoukkueella on kaikki mahdollisuudet voittoon, mutta se vaatii että maalihanat pitää saada paremmin auki (tähän asti: 2 ottelua, 3 tehtyä maalia!). <br> <br> KooVeelta Soolo-pelissä puuttuu puolustaja Johannes Järvinen.
1166	2006-10-14	Jussi Innanen	Tre2:  Ensimmäinen voitto sarjassa 10-3	Tamperesarjan 2.divarissa KooVee 2 otti avausvoittonsa Classic XL:n kustannuksella perjantai-iltana Raholassa suurinumeroisesti 10-3. <br> <br> KooVee 2:lla ei ollut pelissä mitään hätää vaan dominoi peliä, joka muistutti vauhdiltaan kävelyä. Taso ei noussut juuri pelillisestikään, mutta tärkeintä oli voitto ja muutamien pelaajien onnistuminen hyökkäyspäässä hyvillä tehoilla. KooVeen tehopelaajat olivat Jani Singh 3+1 ja Lauri YliHuhtala 3+0. Kakkosella maalissa pelasi Sami Peiponen. <br> <br> Seuraavassa Tamperesarjan pelissä KooVee kohtaa sarjan viimeisenä olevan Team Showtimen.
1163	2006-10-08	Jussi Innanen	4.div:  Soolo kaatui niukasti 4 - 3	Miesten 4.divisioonassa KooVee 2 voitti niukasti Urheiluseura Soolon maalein 4-3. <br> <br> Kauden kolmannessa 4.divari-pelissä pelattiin tasainen vääntö KooVeen ja Soolon välillä, ottelua jossa Koovee hallitsi alkua ja Soolo puolestaan loppua. KooVee sai peliin lentävän lähdön kun se johti jo 6 min jälkeen 2-0, mutta sen jälkeen jonkinlainen hyvänolon tunne valtasi ja Soolo pääsi tasoittamaan 1.erän lukemat 2-2:een nopeiden vastaiskujen päätteeksi. Toinen ja kolmas erä oli Kakkosjoukkueelta heikkoa joukkuepeliä ja ennen kaikkea erittäin huolimatonta. Soolo myllytti kovaa sen jälkeen kun peli oli jälleen KooVeelle 4-2, ja Soolo tulikin heti maalin päähän 4-3 mutta kovalla puolustustaistelulla täydet kaksi sarjapistettä menivät kuitenkin Kakkosjoukkueelle. <br> <br> KooVeen tehopelaaja oli 2+2 tehot tehnyt Jussi Innanen. Muut tehot: Jani Myllynen 1+1, Juuso Koivisto 1+0 ja Jani Singh 0+1. Maalissa Antti Paukkio pelasi hyvän ottelun jälleen. <br> <br> KooVee kohtaa ensi sunnuntaina 15.10 Ilves 3:n Kaukajärvellä klo 11.00.
1170	2006-10-18	Jussi Innanen	Pirkkahallin vuoro alkaa ensi viikolla	Pirkkahallin harjoitusvuoro alkaa ensi viikon tiistaina 24.10.06 klo 21-22 pyörimään Kakkosjoukkueen käytössä. Treeni muutoksista ilmoitetaan joukkuelaisille aina foorumissa. <br> <br> Harjoitusvuorot kaudella 06-07: <br> <br> Tiistai Pirkkahalli klo 21-22 <br> <br> Torstai Kaukajärvi 18-19
1168	2006-10-15	Jussi Innanen	Harjoituspeli KooVee 2 - Classic 3	KooVee 2 pelaa harjoituspelin torstaina (omalla treenivuorolla) 19.10.06 klo 18.00 Kaukajärvellä Classic 3 (3.div) vastaan.
1167	2006-10-15	Jussi Innanen	4.div: Ilves 3 jäi jyrän alle 7 - 2	Kauden neljännessä 4.divisioona-pelissä KooVee 2 otti selvän voiton Ilves 3:sta numeroin 7-2 sunnuntai-aamuna Kaukajärven Spiral-saleilla. <br> <br> Ottelu oli alusta lähtien KooVeen heiniä ja paikkoja luotiin, mutta silti 1.erä meni Kakkosjoukkueelle vain lukemin 2-0. Ilveksellä ei ollut montaa vaihtomiestä ja peli pysyikin aika laiska vauhtisena koko 45 minuuttia. Toisen erän KooVee voitti 2-1 ja kolmannen puolestaan 3-1. KooVeen voittolukemat 7-2 kuvaavat hyvin pelin luonnetta. <br> <br> KooVeen tehomiehet olivat Jani Myllynen tehoilla 3+0, Juuso Koivisto 2+1 sekä Jukka Kaartinen 1+2. Muut tehot: Jussi Innanen 0+2, Teemu Siitarinen 1+0, Jani Singh 0+1 ja Jarno Jokinen 0+1. <br> <br> KooVee 2 kohtaa seuraavaksi KoKon, joka voitti tänään Parkanon SBT PaPon. Ottelu pelataan vasta 5.11 sunnuntaina.
1169	2006-10-17	Jussi Innanen	4.div-sarjatilanne: KooVee 2 kolmantena	4.divarissa suurinosa joukkueista on pelannut jo neljä ottelua (paitsi DTT ja Soolo 3 peliä, Ilves 2 peliä) ja tässä sarjan alkuvaiheessa kärjessä ovat B, Punakone ja KooVee 2. Kaikilla ovat kuusi pistettä (3 voittoa ja 1 tappio), mutta maalineron ja B-tappion takia KooVee on kolmantena. <br> <br> Viidessä pisteessä ovat DownTown Tigers (DTT) sekä Fireballs (FiBa), Soolo on ainoa joukkue joka on neljässä pisteessä. Ilves 3:lla ja KoKolla on kaksi pistettä ja nollakerhossa ovat edelleen TAMKO SB ja SBT PaPo Parkanosta. <br> <br> Sarjassa pelataan 18 kierrosta ja sarjan voittaja nousee suoraan 3.divariin, toiseksi tullut karsii noususta yhdessä play-off pelissä ja puolestaan kolme viimeistä joukkuetta putoavat suoraan 5.divariin. <br> <br> Seuraavat lohkon ottelut Kaukajärvellä: 21.10.06 10.00 Ilves III - Punakone ja 11:00 Soolo - DTT. KooVee 2:n seuraava peli on vasta 5.11.06 klo 13.00 KoKoa vastaan.
1171	2006-10-23	Jussi Innanen	Tre2: Ennakko Showtime-pelistä 25.10	KooVee 2 pelaa keskiviikkona 25.10.06 Raholassa klo 20.00 Tamperesarja-2:n ottelun Team Showtimeä vastaan. <br> <br> Kakkosjoukkueella on kasassa kolmen pelin jälkeen kolme pistettä ja Showtimella puolestaan kaksi pistettä. Ottelussa KooVee on selvä ennakkosuosikki, mutta kuten aikaisemminkin on nähty että mitä tahansa voi tapahtua näissä peleissä, joten "takki auki" pelaamalla voi Showtime nappasta pisteet. Normaalilla suorituksella eli leveällä pallonliikuttelu-pelillä Kakkosjoukkueen pitäisi ottaa selvä voitto. Kooveelta puuttuu ottelussa Heikki Korhonen (Ruotsissa), Jaakko Ailio (Afrikassa), Teemu Siitarinen (huilivuoro)?? ja Lauri Oksanen (huilivuoro)??.
1172	2006-10-26	Jussi Innanen	Tre2: Tasapeli Showtimeä vastaan 5-5	Tamperesarja-2:ssa KooVee 2 joutui tyytymään tasapeliin Showtimeä vastaan numeroin 5-5. Pienessä kaukalossa Raholassa KooVee ei saanut omaa peliä pyörimään ja hyvin taistellut vastustaja otti kaiken tilan pois. Tasatulos oli heikko saavutus Kakkosjoukkueelta, mutta toisaalta pitää olla tyytyväinen, koska peli olisi voitu myöskin hävitä, sen verran huonoa oli jälleen koko joukkueen liike sekä puolustaminen. Positiivista oli kolme yv-maalia kolmesta yrityksestä. <br> <br> Kooveelle kaksi maalia teki Jani Myllynen ja loput yhden maalin miehet olivat Jarno Jokinen, Jussi Innanen ja Lauri YliHuhtala. <br> <br> Seuraavassa Tre-pelissä Kakkosjoukkue kohtaa KoKon 10.11 perjantaina Raholassa klo 20.00.
1173	2006-11-03	Jussi Innanen	4.div: Ennakko KooVee 2 - KoKo 5.11.06	Sunnuntaina 5.11.2006 4.divarissa KooVee 2 pelaa Kaukajärvellä  KoKoa vastaan klo 13.00. <br> <br> Erilaisista lähtökohdista joukkueet lähtevät peliin, koska KooVee on sarjan kärkipäässä (6p.) ja KoKo puolestaan häntäpäässä (2p.). KoKolla on hyvä hyökkäyspää ja on paha vastustaja jos saa peliin tarpeeksi pelaajia, mutta monessa pelissä joukkue on väsähtänyt ja näin vastustaja on karannut välillä rumien lukemien voittoihin. KooVee 2 on voittanut kaksi ottelua putkeen ja on hyvässä vedossa. Joukkueen viisikkopuolustus on ollut tähän saakka maalivahtipelin ohella erinoimaista ja Kakkosjoukkueelle on tehty neljässä pelissä vain yhdeksän maalia. KooVeelta puuttuu KoKo-pelistä puolustajat Johannes "Jay-Jay" Järvinen sekä Lauri "Oka" Oksanen, joka on Englannissa.
1175	2006-11-05	Jussi Innanen	4.div:  KooVee 2 murjoi KoKon 10-1	Miesten 4.divarissa KooVee 2 jatkoi voittoputkeaan voittamalla KoKon murskaavasti 10-1. Kummallakin joukkueella oli ottelussa alle kymmenen pelaajaa mukana, joten pelin taso ei ollut missään vaiheessa päätä huimaavaa. Kakkosjoukkueen pallon liikuttelu leveällä toimi hyvin ja maalipaikkoja aukesi jokaiselle pelaajalle. Ottelu oli käytännössä ohi jo 1.erän (4-0) jälkeen, mutta silti Kakkosjoukkue jaksoi puolustaa hyvin omaa maaliaan loppuun saakka, eikä KoKo päässyt tekemään kuin yhden hienon kuviomaalin (kavennus 5-1) jolle hyvin maalissa pelannut Paukkio ei voinut mitään. KooVeen voittoputki on nyt kolmen ottelun mittainen. <br> <br> KooVeen tehot laajalta rintamalta: Lauri Yli-Huhtala 3+0, Jani Myllynen 2+1, Jukka Kaartinen 1+2, Jussi Innanen 1+2, Jani Singh 2+0, Jarno Jokinen 0+2, Juuso Koivisto 1+0 ja Heikki Korhonen 0+1. <br> <br> KooVee 2:n seuraava 4.div-peli on parin viikon päästä Punakonetta vastaan.
1174	2006-11-02	Jussi Innanen	Sarjataulukko lisätty sivuille	Näille sivuille on lisätty mm. Miesten 4.divarin sarjataulukko 2006-07. Taulukkoa ja kaikkia lohkon ottelutuloksia pääsee katsomaan klikkaamalla vasemmalta kohtaa "sarjat".
1179	2006-11-10	Jussi Innanen	Tre2: KoKo kaatui toistamiseen selvästi	Tamperesarja-2:ssa KooVee 2 voitti KoKon selvin lukemin 7-2 perjantai-iltana Raholan hallissa. <br> <br> Kakkosjoukkue palasi voittojen tiellä Tamperesarjassa voittamalla KoKon toistamiseen viikon sisällä kokonaisuudessa hyvällä pelillä, vaikka lopussa KoKo pääsikin maalamaan kaksi maalia kun peli oli jo ratkennut. Alussa KoKo tuli kovaa ja myllytti muttei saanut maalia hyvin pelanneen maalivahti Sami Peiposen taakse, ja näin KooVee kiitti komeilla yksilösuorituksilla sekä kuviomaaleilla ja peli oli nopeasti 5-0. <br> <br> KooVeesta pelipäällä olivat maalivahti Peiposen lisäksi Heikki Korhonen sekä Juuso Koivisto, joka teki ottelussa neljä maalia hyvillä vedoillaan. Muut KooVeen maalarit olivat Jani Singh, Jussi Innanen ja Jukka Kaartinen. <br> <bt> Seuraavassa Tre2-pelissä Kakkosjoukkue kohtaa 22.11 SB NMP:n.
1178	2006-11-08	Jussi Innanen	4.divisioonan pistepörssi	Miesten Sisä-Suomen salibandyn 4.divisioonan pistepörssiä johtaa DTT:n Harri Vähä-Kuopus, joka on tehnyt tehot 14+4=18 kuudessa pelaamassaan ottelussa. <br> <br> KooVee 2:n tehokkaimmat pelaajat lohkon pistepörssissä ovat kuudes Jani Myllynen 5.8+2=10 ja kahdeksas Jussi Innanen 4.3+6=9. <br> <br> Loput listan Kakkosjoukkuelaiset: (19.) Juuso Koivisto 5.5+1=6, (25.) Jukka Kaartinen 5.2+4=6, (34.) Lauri Yli-Huhtala 4.3+1=4, (39.) Jani Singh 4.2+2=4, (48.) Jarno Jokinen 5.0+4=4, (85.) Teemu Siitarinen 5.1+0=1 ja (104.) Heikki Korhonen 5.0+1=1.
1177	2006-11-09	Jussi Innanen	Ennakko Tre2: KoKo-KooVee 2  PE 10.11	Perjantaina 10.11.06 klo 19.00 Raholan Liikuntakeskuksessa KoKo haastaa KooVee 2:n Tamperesarja-2:n pelissä. <br> <br> Viidennessä Tresarja-pelissä KoKo (0p.) yrittää kuitata KooVeelle (4p.) viime viikonlopun nöyryyttävän (10-1) divaritappion ja ottaa samalla yllättäen vasta ensimmäiset sarjapisteet. KooVeenkin puolestaan on pakko alkaa hiljalleen voittamaan pelejä enemmän mikäli meinaa kahden nousijan joukkoon sarjan päätteksi. Vaikka Tamperesarja-2 on ollut todella tasainen ja pelit menneet ristiin niin silti ylemmän sarjatason joukkueen pitää pystyä voittamaan aina alemman tason joukkueet. KooVeelta huilivuorossa ovat Lauri YliHuhtala ja Lauri Oksanen. <br> <br> Sarjaa johtaa tällä hetkellä neljän pelin jälkeen yllättäen AWE 7 pisteellä. Perässä tulevat 5 pisteellä SB NMP ja Nokian-KP, näiden jälkeen ovat KooVee 2, SB Luuppi ja Classic XL 4 pisteessä. Häntäpäätä pitävät Showtime (3p.) ja jumbojoukkue KoKo (0p.).
1180	2006-11-12	Jussi Innanen	4.divari sarjataulukko päivitetty 11.11.	KooVee 2:lla ei ollut peliä viikonloppuna, mutta lohkon monella muulla joukkueella oli. Sarjatilanne ja tulokset ovat jälleen päivitetty 11.11.2006.
\.


--
-- Data for TOC entry 124 (OID 110271)
-- Name: kayttajat; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY kayttajat (tunnus, salasana, henkilo) FROM stdin;
kaartine	85e534ea9ea10877f7a1b9ee7cfd1a03	1027
jute	b969ac75a840dc34b8d48187284fbfa1	1065
myllynen	e7e941b1f09f266540c6780db51d5f58	1067
kaartinj	85e534ea9ea10877f7a1b9ee7cfd1a03	1026
kai	b5998634c34d397032b1ccb34a3b0260	1075
ylihuhta	05b7f3ad5d98f0652f6cf605e5a5bd92	1029
teemu	4510e5490cf48fbec9e050332fea5ffb	1014
paukkio	073c46845b01e5f2245b9c240d96efac	1068
jarnomus	b31465d5d1c69f6672748f24daa514be	1021
h4jsingh	0ca785a6677d67d0228e46c3576dabfa	1069
jukka	85e534ea9ea10877f7a1b9ee7cfd1a03	1
late	f2c67381db28fa11c59fe7a6df0f2587	1047
petteri	b3736335cb29242e228ab175cb0f3998	1071
pekka	b3736335cb29242e228ab175cb0f3998	1015
jojo	1f1021c7452494557737ed7b9488c02b	1072
ailio	5dcfd7dff3ccccd6d660d960dd41af16	1018
sami	3ec69b7a8c3d8cd25a36f4861f5f07a6	1041
johannes	e8ed6b64840122f0c0ad3968874a4e15	1024
korhonen	e453bcc34769ab7dfeb338ed04a2042f	1074
\.


--
-- Data for TOC entry 125 (OID 110279)
-- Name: yllapitooikeudet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY yllapitooikeudet (tunnus) FROM stdin;
jukka
kaartine
\.


--
-- Data for TOC entry 126 (OID 110287)
-- Name: lisaamuokkaaoikeudet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY lisaamuokkaaoikeudet (tunnus) FROM stdin;
jute
teemu
\.


--
-- Data for TOC entry 127 (OID 110295)
-- Name: joukkueenalueoikeudet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY joukkueenalueoikeudet (tunnus) FROM stdin;
jute
paukkio
johannes
jarnomus
h4jsingh
ylihuhta
myllynen
teemu
kaartinj
late
petteri
pekka
jojo
ailio
sami
korhonen
kai
\.


--
-- Data for TOC entry 128 (OID 110303)
-- Name: omattiedotoikeudet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY omattiedotoikeudet (tunnus) FROM stdin;
jute
paukkio
h4jsingh
myllynen
teemu
johannes
kaartinj
jarnomus
late
ylihuhta
petteri
pekka
jojo
ailio
sami
korhonen
kai
\.


--
-- TOC entry 73 (OID 109901)
-- Name: yhteystieto_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY yhteystieto
    ADD CONSTRAINT yhteystieto_pkey PRIMARY KEY (yhtietoid);


--
-- TOC entry 74 (OID 109911)
-- Name: henkilo_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY henkilo
    ADD CONSTRAINT henkilo_pkey PRIMARY KEY (hloid);


--
-- TOC entry 75 (OID 109920)
-- Name: pelaaja_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaaja
    ADD CONSTRAINT pelaaja_pkey PRIMARY KEY (pelaajaid);


--
-- TOC entry 76 (OID 109928)
-- Name: tyyppi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tyyppi
    ADD CONSTRAINT tyyppi_pkey PRIMARY KEY (tyyppi);


--
-- TOC entry 77 (OID 109938)
-- Name: tapahtuma_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tapahtuma
    ADD CONSTRAINT tapahtuma_pkey PRIMARY KEY (tapahtumaid);


--
-- TOC entry 78 (OID 109957)
-- Name: halli_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY halli
    ADD CONSTRAINT halli_pkey PRIMARY KEY (halliid);


--
-- TOC entry 79 (OID 109965)
-- Name: kausi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kausi
    ADD CONSTRAINT kausi_pkey PRIMARY KEY (vuosi);


--
-- TOC entry 80 (OID 109969)
-- Name: sarjatyyppi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjatyyppi
    ADD CONSTRAINT sarjatyyppi_pkey PRIMARY KEY (tyyppi);


--
-- TOC entry 81 (OID 109979)
-- Name: seura_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY seura
    ADD CONSTRAINT seura_pkey PRIMARY KEY (seuraid);


--
-- TOC entry 82 (OID 109989)
-- Name: sarja_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarja
    ADD CONSTRAINT sarja_pkey PRIMARY KEY (sarjaid);


--
-- TOC entry 83 (OID 110008)
-- Name: joukkue_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkue
    ADD CONSTRAINT joukkue_pkey PRIMARY KEY (joukkueid);


--
-- TOC entry 84 (OID 110022)
-- Name: kaudenjoukkue_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT kaudenjoukkue_pkey PRIMARY KEY (joukkueid, kausi);


--
-- TOC entry 85 (OID 110047)
-- Name: peli_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT peli_pkey PRIMARY KEY (peliid);


--
-- TOC entry 86 (OID 110114)
-- Name: tilastomerkinta_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tilastomerkinta
    ADD CONSTRAINT tilastomerkinta_pkey PRIMARY KEY (timerkintaid);


--
-- TOC entry 87 (OID 110131)
-- Name: maali_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT maali_pkey PRIMARY KEY (maaliid);


--
-- TOC entry 88 (OID 110185)
-- Name: pelaajatilasto_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT pelaajatilasto_pkey PRIMARY KEY (tilastoid);


--
-- TOC entry 89 (OID 110201)
-- Name: toimenkuva_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimenkuva
    ADD CONSTRAINT toimenkuva_pkey PRIMARY KEY (toimenkuva);


--
-- TOC entry 90 (OID 110205)
-- Name: toimi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimi
    ADD CONSTRAINT toimi_pkey PRIMARY KEY (kaudenjoukkue, henkilo, kausi);


--
-- TOC entry 91 (OID 110220)
-- Name: osallistuja_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY osallistuja
    ADD CONSTRAINT osallistuja_pkey PRIMARY KEY (tapahtumaid, osallistuja);


--
-- TOC entry 92 (OID 110235)
-- Name: pelaajat_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajat
    ADD CONSTRAINT pelaajat_pkey PRIMARY KEY (joukkue, pelaaja, kausi);


--
-- TOC entry 93 (OID 110247)
-- Name: sarjanjoukkueet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT sarjanjoukkueet_pkey PRIMARY KEY (sarjaid, joukkue, kausi);


--
-- TOC entry 94 (OID 110269)
-- Name: uutinen_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY uutinen
    ADD CONSTRAINT uutinen_pkey PRIMARY KEY (uutinenid);


--
-- TOC entry 95 (OID 110273)
-- Name: kayttajat_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kayttajat
    ADD CONSTRAINT kayttajat_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 96 (OID 110281)
-- Name: yllapitooikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY yllapitooikeudet
    ADD CONSTRAINT yllapitooikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 97 (OID 110289)
-- Name: lisaamuokkaaoikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY lisaamuokkaaoikeudet
    ADD CONSTRAINT lisaamuokkaaoikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 98 (OID 110297)
-- Name: joukkueenalueoikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkueenalueoikeudet
    ADD CONSTRAINT joukkueenalueoikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 99 (OID 110305)
-- Name: omattiedotoikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY omattiedotoikeudet
    ADD CONSTRAINT omattiedotoikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 129 (OID 109913)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY henkilo
    ADD CONSTRAINT "$1" FOREIGN KEY (yhtieto) REFERENCES yhteystieto(yhtietoid);


--
-- TOC entry 130 (OID 109922)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaaja
    ADD CONSTRAINT "$1" FOREIGN KEY (pelaajaid) REFERENCES henkilo(hloid);


--
-- TOC entry 132 (OID 109940)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tapahtuma
    ADD CONSTRAINT "$1" FOREIGN KEY (vastuuhlo) REFERENCES henkilo(hloid);


--
-- TOC entry 131 (OID 109944)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tapahtuma
    ADD CONSTRAINT "$2" FOREIGN KEY (tyyppi) REFERENCES tyyppi(tyyppi);


--
-- TOC entry 133 (OID 109959)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY halli
    ADD CONSTRAINT "$1" FOREIGN KEY (yhtietoid) REFERENCES yhteystieto(yhtietoid);


--
-- TOC entry 135 (OID 109991)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarja
    ADD CONSTRAINT "$1" FOREIGN KEY (kausi) REFERENCES kausi(vuosi);


--
-- TOC entry 134 (OID 109995)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarja
    ADD CONSTRAINT "$2" FOREIGN KEY (tyyppi) REFERENCES sarjatyyppi(tyyppi);


--
-- TOC entry 136 (OID 110010)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkue
    ADD CONSTRAINT "$1" FOREIGN KEY (seuraid) REFERENCES seura(seuraid);


--
-- TOC entry 139 (OID 110024)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT "$1" FOREIGN KEY (joukkueid) REFERENCES joukkue(joukkueid);


--
-- TOC entry 138 (OID 110028)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT "$2" FOREIGN KEY (kausi) REFERENCES kausi(vuosi);


--
-- TOC entry 137 (OID 110032)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT "$3" FOREIGN KEY (kotihalli) REFERENCES halli(halliid);


--
-- TOC entry 154 (OID 110049)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$1" FOREIGN KEY (peliid) REFERENCES tapahtuma(tapahtumaid);


--
-- TOC entry 153 (OID 110053)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$2" FOREIGN KEY (vierasjoukkue) REFERENCES joukkue(joukkueid);


--
-- TOC entry 152 (OID 110057)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$3" FOREIGN KEY (kotijoukkue) REFERENCES joukkue(joukkueid);


--
-- TOC entry 151 (OID 110061)
-- Name: $4; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$4" FOREIGN KEY (sarja) REFERENCES sarja(sarjaid);


--
-- TOC entry 150 (OID 110065)
-- Name: $5; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$5" FOREIGN KEY (atoimihenkilo1) REFERENCES henkilo(hloid);


--
-- TOC entry 149 (OID 110069)
-- Name: $6; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$6" FOREIGN KEY (atoimihenkilo2) REFERENCES henkilo(hloid);


--
-- TOC entry 148 (OID 110073)
-- Name: $7; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$7" FOREIGN KEY (atoimihenkilo3) REFERENCES henkilo(hloid);


--
-- TOC entry 147 (OID 110077)
-- Name: $8; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$8" FOREIGN KEY (atoimihenkilo4) REFERENCES henkilo(hloid);


--
-- TOC entry 146 (OID 110081)
-- Name: $9; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$9" FOREIGN KEY (atoimihenkilo5) REFERENCES henkilo(hloid);


--
-- TOC entry 145 (OID 110085)
-- Name: $10; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$10" FOREIGN KEY (btoimihenkilo1) REFERENCES henkilo(hloid);


--
-- TOC entry 144 (OID 110089)
-- Name: $11; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$11" FOREIGN KEY (btoimihenkilo2) REFERENCES henkilo(hloid);


--
-- TOC entry 143 (OID 110093)
-- Name: $12; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$12" FOREIGN KEY (btoimihenkilo3) REFERENCES henkilo(hloid);


--
-- TOC entry 142 (OID 110097)
-- Name: $13; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$13" FOREIGN KEY (btoimihenkilo4) REFERENCES henkilo(hloid);


--
-- TOC entry 141 (OID 110101)
-- Name: $14; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$14" FOREIGN KEY (btoimihenkilo5) REFERENCES henkilo(hloid);


--
-- TOC entry 140 (OID 110105)
-- Name: $15; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$15" FOREIGN KEY (pelipaikka) REFERENCES halli(halliid);


--
-- TOC entry 156 (OID 110116)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tilastomerkinta
    ADD CONSTRAINT "$1" FOREIGN KEY (peliid) REFERENCES peli(peliid);


--
-- TOC entry 155 (OID 110120)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tilastomerkinta
    ADD CONSTRAINT "$2" FOREIGN KEY (joukkueid) REFERENCES joukkue(joukkueid);


--
-- TOC entry 159 (OID 110133)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT "$1" FOREIGN KEY (maaliid) REFERENCES tilastomerkinta(timerkintaid);


--
-- TOC entry 158 (OID 110137)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT "$2" FOREIGN KEY (tekija) REFERENCES henkilo(hloid);


--
-- TOC entry 157 (OID 110141)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT "$3" FOREIGN KEY (syottaja) REFERENCES henkilo(hloid);


--
-- TOC entry 161 (OID 110154)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY epaonnisrankku
    ADD CONSTRAINT "$1" FOREIGN KEY (epaonnisrankkuid) REFERENCES tilastomerkinta(timerkintaid);


--
-- TOC entry 160 (OID 110158)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY epaonnisrankku
    ADD CONSTRAINT "$2" FOREIGN KEY (tekija) REFERENCES pelaaja(pelaajaid);


--
-- TOC entry 163 (OID 110165)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY rangaistus
    ADD CONSTRAINT "$1" FOREIGN KEY (rangaistusid) REFERENCES tilastomerkinta(timerkintaid);


--
-- TOC entry 162 (OID 110169)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY rangaistus
    ADD CONSTRAINT "$2" FOREIGN KEY (saaja) REFERENCES henkilo(hloid);


--
-- TOC entry 166 (OID 110187)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT "$1" FOREIGN KEY (peliid) REFERENCES peli(peliid);


--
-- TOC entry 165 (OID 110191)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT "$2" FOREIGN KEY (joukkue) REFERENCES joukkue(joukkueid);


--
-- TOC entry 164 (OID 110195)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT "$3" FOREIGN KEY (pelaaja) REFERENCES henkilo(hloid);


--
-- TOC entry 168 (OID 110207)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimi
    ADD CONSTRAINT "$1" FOREIGN KEY (kaudenjoukkue, kausi) REFERENCES kaudenjoukkue(joukkueid, kausi);


--
-- TOC entry 167 (OID 110211)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimi
    ADD CONSTRAINT "$2" FOREIGN KEY (henkilo) REFERENCES henkilo(hloid);


--
-- TOC entry 170 (OID 110222)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY osallistuja
    ADD CONSTRAINT "$1" FOREIGN KEY (tapahtumaid) REFERENCES tapahtuma(tapahtumaid);


--
-- TOC entry 169 (OID 110226)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY osallistuja
    ADD CONSTRAINT "$2" FOREIGN KEY (osallistuja) REFERENCES henkilo(hloid);


--
-- TOC entry 172 (OID 110237)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajat
    ADD CONSTRAINT "$1" FOREIGN KEY (joukkue, kausi) REFERENCES kaudenjoukkue(joukkueid, kausi);


--
-- TOC entry 171 (OID 110241)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajat
    ADD CONSTRAINT "$2" FOREIGN KEY (pelaaja) REFERENCES henkilo(hloid);


--
-- TOC entry 175 (OID 110249)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT "$1" FOREIGN KEY (sarjaid) REFERENCES sarja(sarjaid);


--
-- TOC entry 174 (OID 110253)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT "$2" FOREIGN KEY (joukkue, kausi) REFERENCES kaudenjoukkue(joukkueid, kausi);


--
-- TOC entry 173 (OID 110257)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT "$3" FOREIGN KEY (kausi) REFERENCES kausi(vuosi);


--
-- TOC entry 176 (OID 110275)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kayttajat
    ADD CONSTRAINT "$1" FOREIGN KEY (henkilo) REFERENCES henkilo(hloid);


--
-- TOC entry 177 (OID 110283)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY yllapitooikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 178 (OID 110291)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY lisaamuokkaaoikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 179 (OID 110299)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkueenalueoikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 180 (OID 110307)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY omattiedotoikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 61 (OID 109894)
-- Name: yhteystieto_yhtietoid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('yhteystieto_yhtietoid_seq', 1038, true);


--
-- TOC entry 62 (OID 109903)
-- Name: henkilo_hloid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('henkilo_hloid_seq', 1075, true);


--
-- TOC entry 63 (OID 109930)
-- Name: tapahtuma_tapahtumaid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('tapahtuma_tapahtumaid_seq', 1286, true);


--
-- TOC entry 64 (OID 109948)
-- Name: halli_halliid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('halli_halliid_seq', 1020, true);


--
-- TOC entry 65 (OID 109971)
-- Name: seura_seuraid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('seura_seuraid_seq', 1044, true);


--
-- TOC entry 66 (OID 109981)
-- Name: sarja_sarjaid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('sarja_sarjaid_seq', 1006, true);


--
-- TOC entry 67 (OID 109999)
-- Name: joukkue_joukkueid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('joukkue_joukkueid_seq', 1047, true);


--
-- TOC entry 68 (OID 110014)
-- Name: kaudenjoukkue_joukkueid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('kaudenjoukkue_joukkueid_seq', 1000, true);


--
-- TOC entry 69 (OID 110036)
-- Name: peli_peliid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('peli_peliid_seq', 1003, true);


--
-- TOC entry 70 (OID 110109)
-- Name: tilastomerkinta_timerkintaid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('tilastomerkinta_timerkintaid_seq', 1614, true);


--
-- TOC entry 71 (OID 110173)
-- Name: pelaajatilasto_tilastoid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('pelaajatilasto_tilastoid_seq', 2156, true);


--
-- TOC entry 72 (OID 110261)
-- Name: uutinen_uutinenid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('uutinen_uutinenid_seq', 1180, true);


--
-- TOC entry 3 (OID 2200)
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


