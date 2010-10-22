--
-- PostgreSQL database dump
--

SET client_encoding = 'SQL_ASCII';
SET check_function_bodies = false;

--
-- TOC entry 2 (OID 0)
-- Name: koovee; Type: DATABASE; Schema: -; Owner: rysty
--

CREATE DATABASE koovee WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII';


\connect koovee rysty

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
-- TOC entry 5 (OID 24038)
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
-- TOC entry 6 (OID 24038)
-- Name: yhteystieto; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE yhteystieto FROM PUBLIC;
GRANT ALL ON TABLE yhteystieto TO rysty;


--
-- TOC entry 7 (OID 24045)
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
-- TOC entry 8 (OID 24045)
-- Name: henkilo; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE henkilo FROM PUBLIC;
GRANT ALL ON TABLE henkilo TO rysty;


--
-- TOC entry 9 (OID 24051)
-- Name: pelaaja; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE pelaaja (
    pelaajaid integer NOT NULL,
    katisyys character(1) DEFAULT 'L'::bpchar NOT NULL,
    maila character varying(40)
);


--
-- TOC entry 10 (OID 24051)
-- Name: pelaaja; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE pelaaja FROM PUBLIC;
GRANT ALL ON TABLE pelaaja TO rysty;


--
-- TOC entry 11 (OID 24054)
-- Name: tyyppi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE tyyppi (
    tyyppi character varying(20) NOT NULL
);


--
-- TOC entry 12 (OID 24054)
-- Name: tyyppi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE tyyppi FROM PUBLIC;
GRANT ALL ON TABLE tyyppi TO rysty;


--
-- TOC entry 13 (OID 24058)
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
-- TOC entry 14 (OID 24058)
-- Name: tapahtuma; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE tapahtuma FROM PUBLIC;
GRANT ALL ON TABLE tapahtuma TO rysty;


--
-- TOC entry 15 (OID 24066)
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
-- TOC entry 16 (OID 24066)
-- Name: halli; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE halli FROM PUBLIC;
GRANT ALL ON TABLE halli TO rysty;


--
-- TOC entry 17 (OID 24073)
-- Name: kausi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE kausi (
    vuosi integer NOT NULL
);


--
-- TOC entry 18 (OID 24073)
-- Name: kausi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE kausi FROM PUBLIC;
GRANT ALL ON TABLE kausi TO rysty;


--
-- TOC entry 19 (OID 24075)
-- Name: sarjatyyppi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE sarjatyyppi (
    tyyppi character varying(25) NOT NULL
);


--
-- TOC entry 20 (OID 24075)
-- Name: sarjatyyppi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE sarjatyyppi FROM PUBLIC;
GRANT ALL ON TABLE sarjatyyppi TO rysty;


--
-- TOC entry 21 (OID 24079)
-- Name: seura; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE seura (
    seuraid serial NOT NULL,
    nimi character varying(40) NOT NULL,
    perustamispvm date NOT NULL,
    lisatieto text
);


--
-- TOC entry 22 (OID 24079)
-- Name: seura; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE seura FROM PUBLIC;
GRANT ALL ON TABLE seura TO rysty;


--
-- TOC entry 23 (OID 24087)
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
-- TOC entry 24 (OID 24087)
-- Name: sarja; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE sarja FROM PUBLIC;
GRANT ALL ON TABLE sarja TO rysty;


--
-- TOC entry 25 (OID 24095)
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
-- TOC entry 26 (OID 24095)
-- Name: joukkue; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE joukkue FROM PUBLIC;
GRANT ALL ON TABLE joukkue TO rysty;


--
-- TOC entry 27 (OID 24104)
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
-- TOC entry 28 (OID 24104)
-- Name: kaudenjoukkue; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE kaudenjoukkue FROM PUBLIC;
GRANT ALL ON TABLE kaudenjoukkue TO rysty;


--
-- TOC entry 29 (OID 24112)
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
-- TOC entry 30 (OID 24112)
-- Name: peli; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE peli FROM PUBLIC;
GRANT ALL ON TABLE peli TO rysty;


--
-- TOC entry 31 (OID 24123)
-- Name: tilastomerkinta; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE tilastomerkinta (
    timerkintaid serial NOT NULL,
    peliid integer NOT NULL,
    joukkueid integer NOT NULL,
    tapahtumisaika time without time zone
);


--
-- TOC entry 32 (OID 24126)
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
-- TOC entry 33 (OID 24126)
-- Name: maali; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE maali FROM PUBLIC;
GRANT ALL ON TABLE maali TO rysty;


--
-- TOC entry 34 (OID 24133)
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
-- TOC entry 35 (OID 24142)
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
-- TOC entry 36 (OID 24142)
-- Name: rangaistus; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE rangaistus FROM PUBLIC;
GRANT ALL ON TABLE rangaistus TO rysty;


--
-- TOC entry 37 (OID 24147)
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
-- TOC entry 38 (OID 24147)
-- Name: pelaajatilasto; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE pelaajatilasto FROM PUBLIC;
GRANT ALL ON TABLE pelaajatilasto TO rysty;


--
-- TOC entry 39 (OID 24157)
-- Name: toimenkuva; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE toimenkuva (
    toimenkuva character varying(20) NOT NULL
);


--
-- TOC entry 40 (OID 24159)
-- Name: toimi; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE toimi (
    tehtava character varying(20),
    kaudenjoukkue integer NOT NULL,
    kausi integer NOT NULL,
    henkilo integer NOT NULL
);


--
-- TOC entry 41 (OID 24159)
-- Name: toimi; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE toimi FROM PUBLIC;
GRANT ALL ON TABLE toimi TO rysty;


--
-- TOC entry 42 (OID 24161)
-- Name: osallistuja; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE osallistuja (
    tapahtumaid integer NOT NULL,
    osallistuja integer NOT NULL,
    paasee boolean NOT NULL,
    selite text
);


--
-- TOC entry 43 (OID 24161)
-- Name: osallistuja; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE osallistuja FROM PUBLIC;
GRANT ALL ON TABLE osallistuja TO rysty;


--
-- TOC entry 44 (OID 24166)
-- Name: pelaajat; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE pelaajat (
    joukkue integer NOT NULL,
    kausi integer NOT NULL,
    pelaaja integer NOT NULL,
    pelinumero integer,
    pelipaikka character varying(2),
    kapteeni boolean DEFAULT false,
    CONSTRAINT pelaajat_pelipaikka CHECK ((((((((pelipaikka)::text = 'VL'::text) OR ((pelipaikka)::text = 'OL'::text)) OR ((pelipaikka)::text = 'KE'::text)) OR ((pelipaikka)::text = 'PU'::text)) OR ((pelipaikka)::text = 'MV'::text)) OR ((pelipaikka)::text = NULL::text)))
);


--
-- TOC entry 45 (OID 24166)
-- Name: pelaajat; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE pelaajat FROM PUBLIC;
GRANT ALL ON TABLE pelaajat TO rysty;


--
-- TOC entry 46 (OID 24170)
-- Name: sarjanjoukkueet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE sarjanjoukkueet (
    sarjaid integer NOT NULL,
    joukkue integer NOT NULL,
    kausi integer NOT NULL
);


--
-- TOC entry 47 (OID 24170)
-- Name: sarjanjoukkueet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE sarjanjoukkueet FROM PUBLIC;
GRANT ALL ON TABLE sarjanjoukkueet TO rysty;


--
-- TOC entry 48 (OID 24174)
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
-- TOC entry 49 (OID 24174)
-- Name: uutinen; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE uutinen FROM PUBLIC;
GRANT ALL ON TABLE uutinen TO rysty;


--
-- TOC entry 50 (OID 24180)
-- Name: kayttajat; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE kayttajat (
    tunnus character varying(16) NOT NULL,
    salasana character varying(255),
    henkilo integer
);


--
-- TOC entry 51 (OID 24180)
-- Name: kayttajat; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE kayttajat FROM PUBLIC;
GRANT ALL ON TABLE kayttajat TO rysty;


--
-- TOC entry 52 (OID 24182)
-- Name: yllapitooikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE yllapitooikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 53 (OID 24182)
-- Name: yllapitooikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE yllapitooikeudet FROM PUBLIC;
GRANT ALL ON TABLE yllapitooikeudet TO rysty;


--
-- TOC entry 54 (OID 24184)
-- Name: lisaamuokkaaoikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE lisaamuokkaaoikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 55 (OID 24184)
-- Name: lisaamuokkaaoikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE lisaamuokkaaoikeudet FROM PUBLIC;
GRANT ALL ON TABLE lisaamuokkaaoikeudet TO rysty;


--
-- TOC entry 56 (OID 24186)
-- Name: joukkueenalueoikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE joukkueenalueoikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 57 (OID 24186)
-- Name: joukkueenalueoikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE joukkueenalueoikeudet FROM PUBLIC;
GRANT ALL ON TABLE joukkueenalueoikeudet TO rysty;


--
-- TOC entry 58 (OID 24188)
-- Name: omattiedotoikeudet; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE omattiedotoikeudet (
    tunnus character varying(16) NOT NULL
);


--
-- TOC entry 59 (OID 24188)
-- Name: omattiedotoikeudet; Type: ACL; Schema: public; Owner: kaartine
--

REVOKE ALL ON TABLE omattiedotoikeudet FROM PUBLIC;
GRANT ALL ON TABLE omattiedotoikeudet TO rysty;


--
-- TOC entry 60 (OID 24190)
-- Name: log; Type: TABLE; Schema: public; Owner: kaartine
--

CREATE TABLE log (
    tunnus character varying(16) NOT NULL,
    pvm timestamp without time zone,
    tyyppi character varying(30)
);


--
-- Data for TOC entry 100 (OID 24038)
-- Name: yhteystieto; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY yhteystieto (yhtietoid, puhelinnumero, faxi, email, katuosoite, postinumero, postitoimipaikka, maa, selite) FROM stdin;
1008	\N	\N	pasik69@gmx.de	\N	\N	Tampere	Suomi	\N
2	03 3561 733	03 3561 734	toimisto@spiral-salit.fi	Juvankatu 16	33710	Tampere	Suomi	\N
1001	\N	\N	matti.haapaniemi@tut.fi	\N	\N	Tampere	Suomi	\N
1016	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1004	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1031	040-5424194	\N	aapo.repo@me.tamk.fi	Tahmelankatu 3	33240	tampere	Suomi	\N
1027	040-5520798	\N	\N	\N	\N	Tampere	Suomi	\N
1029	040-8210725	\N	antti.paukkio@tut.fi	\N	\N	Tampere	Suomi	\N
1014	040-5799004	\N	\N	\N	\N	Tampere	Suomi	\N
1003	040-5681890	\N	\N	\N	\N	\N	Suomi	\N
1010	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1028	040-7153624	\N	janim@saunalahti.fi	Parkanonkatu 4 E 63	33720	Tampere	Suomi	\N
1026	040-7073304	\N	jani.singh@cs.tamk.fi	Hatanp��n Valtatie 12	33100	Tampere	Suomi	\N
1012	040-7369942	\N	\N	\N	\N	Tampere	Suomi	\N
1017	\N	\N	lauri.yli-huhtala@tut.fi	\N	\N	Tampere	Suomi	\N
1024	040-0968072	\N	\N	\N	\N	Tampere	Suomi	\N
1002	040-7396316	\N	teemu.siitarinen@tut.fi	Sammonkatu 23 F 95	33540	Tampere	Suomi	\N
1015	+358 40 541 9552	\N	kaartine@cs.tut.fi	Tumppi 3 D 114	33720	Tampere	Suomi	\N
1022	\N	\N	\N	\N	\N	Vilppula	Suomi	\N
1018	(03) 542 0410	(03) 542 0415	\N	K�yv�rintie 3	37800	Tampere	Suomi	\N
1019	03 254 4100	03 3126 2511	areena@metroautoareena.fi	J��hallinraitti 3	33501	Tampere	Suomi	\N
1020	\N	\N	\N	K��j�ntie 4	\N	Orivesi	Suomi	\N
1	+358 40 5419552	\N	jukka.kaartinen@tut.fi	Tumppi 3 D 114	33720	Tampere	Suomi	Kotiosoite
1030	040-7515818	\N	lauri_oksanen@hotmail.com	\N	\N	Tampere	Suomi	\N
1023	03 3115 2797	\N	\N	Korkeakoulunkatu 12	33720	Tampere	Suomi	\N
1011	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1021	\N	\N	\N	Teerivuorenkatu	\N	Tampere	Suomi	\N
1013	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1025	040-8390388	\N	jute07@hotmail.com	Opiskelijankatu 19 B 29	33720	Tampere	Suomi	\N
1007	\N	\N	\N	\N	\N	Tampere	Suomi	\N
1009	\N	\N	jarnomus@dnainternet.net	\N	\N	Tampere	Suomi	\N
1005	040-5664972	\N	\N	\N	\N	Tampere	Suomi	\N
1006	040-7177317	\N	\N	\N	\N	Tampere	Suomi	\N
\.


--
-- Data for TOC entry 101 (OID 24045)
-- Name: henkilo; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY henkilo (hloid, yhtieto, etunimi, sukunimi, syntymaaika, paino, pituus, kuva, kuvaus, lempinimi) FROM stdin;
1061	\N	Juha	Halme	\N	\N	\N	\N	\N	\N
1062	\N	Otto-Ville	Riikil�	\N	\N	\N	\N	\N	\N
1063	\N	Samu	L��vi	\N	\N	\N	\N	\N	\N
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
1011	1001	Matti	Haapaniemi	\N	\N	\N	\N	Matti on Rauhallinen ja taitava pelaaja. Ennen puolustajana pelannut pelinrakentaja pelasi kyseisell� kaudella hy�kk��j��.	Masa
1012	\N	Juha	M�h�nen	\N	\N	\N	\N	\N	\N
1013	\N	Niko	Aronen	\N	\N	\N	\N	\N	\N
1064	\N	Heikki	Mikkonen	\N	\N	\N	\N	\N	\N
1028	1016	Teemu	Lahtela	1978-04-02	80000	184	\N	\N	tepe
1016	1004	Jaakko	Hiltunen	\N	\N	\N	\N	\N	Veli-Pekka
1067	1028	Jani	Myllynen	1982-03-19	95000	184	\N	&quot;Hervannan iso vaalee Jallu Rantanen&quot; taitaa maalinteon jos vaan on sill� tuulella.	Myllyne
1068	1029	Antti	Paukkio	1981-05-11	78000	183	\N	&quot;Ei oo h�pee olla nopee&quot;	Antzas
1066	1027	Juuso	Koivisto	\N	\N	\N	\N	Armeijassa harjoittelemassa sy�tt�mist�.	Juuso
1027	1015	Jukka	Kaartinen	1980-06-18	75000	178	kuvat/henkilo/Kaartinen_Jukka_1027.jpg	Joukkueen &quot;puuha-pete&quot; laittaa pallon sis��n kun sen vaan saa.	Jukkis
1	1	Jukka	Kaartinen(WebAdmin)	1980-06-18	78000	178	\N	\N	Jukkis
1022	1010	Timo	Lautamatti	\N	\N	\N	\N	\N	Timppa
1020	1008	Pasi	Kautiala	\N	\N	\N	\N	Suoraviivainen.	\N
2	\N	Teemu	WebAdmin	\N	\N	\N	\N	\N	\N
1015	1003	Pekka	Hiltunen	\N	\N	\N	\N	\N	Pekkis
1069	1026	Jani	Singh	1982-06-23	80000	180	kuvat/henkilo/Singh_Jani_1069.jpg	Vauhdikas &quot;ulkomaan vahvistus&quot;.	Singi
1048	\N	Antti-Jussi	Kaukonen	\N	\N	\N	\N	\N	\N
1018	1006	Jaakko	Ailio	\N	\N	\N	\N	jalkapalloilija Marco Di Vaion n�k�isyytt� ja ailahtelevuutta.	\N
1026	1014	Juha	Kaartinen	\N	90000	185	\N	&quot;KooVee 2:sen 50 Cent&quot;, jos on k�sivarsiin katsomista.	L�mmi
1046	1031	Aapo	Repo	\N	\N	\N	\N	Lopetti Kooveessa.	\N
1024	1012	Johannes	J�rvinen	1979-05-14	110000	190	\N	Joukkueen iso mies Isolla I:ll� kaukalossa ja sen ulkopuolella.	Jii Jii
1030	\N	Tuomas	M�nnist�	\N	\N	\N	\N	\N	\N
1031	\N	Jarkko	Ahomaa	\N	\N	\N	\N	\N	\N
1032	\N	Sami	H�nninen	\N	\N	\N	\N	\N	\N
1033	\N	Lauri	P�rh�nen	\N	\N	\N	\N	\N	\N
1034	\N	Timo	Saros	\N	\N	\N	\N	\N	\N
1035	\N	Antti	Huuskonen	\N	\N	\N	\N	\N	\N
1036	\N	Jussi	Pietil�	\N	\N	\N	\N	\N	\N
1037	\N	Olli	Kukkam�ki	\N	\N	\N	\N	\N	\N
1038	\N	Joni	Kiiskinen	\N	\N	\N	\N	\N	\N
1039	\N	Jari-Pekka	Koljus	\N	\N	\N	\N	\N	\N
1040	\N	Kalle	Tamminen	\N	\N	\N	\N	\N	\N
1041	\N	Sami	Peiponen	\N	\N	\N	\N	\N	\N
1042	\N	Juha	Mustamo	\N	\N	\N	\N	\N	\N
1043	\N	Kari	Ahonjoki	\N	\N	\N	\N	\N	\N
1044	\N	Jan	Nigman	\N	\N	\N	\N	\N	\N
1045	\N	Niko	Suoranta	\N	\N	\N	\N	\N	\N
1029	1017	Lauri	Yli-Huhtala	\N	\N	\N	\N	Omaa kovan kudin, jos vaan p��sisi ampumaan.	Late
1065	1025	Jussi	Innanen	1982-05-06	79000	181	kuvat/henkilo/Innanen_Jussi_1065.jpg	Harvoin n�kee juoksemassa ellei ole palloa itsell��n.	Jute
1049	\N	Vill	R�nn	\N	\N	\N	\N	\N	\N
1050	\N	Tuukka	Rantanen	\N	\N	\N	\N	\N	\N
1051	\N	Mikko	Korhonen	\N	\N	\N	\N	\N	\N
1014	1002	Teemu	Siitarinen	1979-01-08	82000	192	kuvat/henkilo/Siitarinen_Teemu_1014.jpg	Pitk�n huiskea lentopalloilija...?	Teme
1052	\N	Olli	Aaltonen	\N	\N	\N	\N	\N	\N
1053	\N	Simo	Ruponen	\N	\N	\N	\N	\N	\N
1054	\N	Mika	Pyk�list�	\N	\N	\N	\N	\N	\N
1055	\N	Kimmo	Suominen	\N	\N	\N	\N	\N	\N
1056	\N	Jussi	Vainio	\N	\N	\N	\N	\N	\N
1057	\N	Jani	Kallio	\N	\N	\N	\N	\N	\N
1058	\N	Lauri	Pihlajasalo	\N	\N	\N	\N	\N	\N
1059	\N	Jan Kristian	Lahti	\N	\N	\N	\N	\N	\N
1060	\N	Aapo	Peltonen	\N	\N	\N	\N	\N	\N
1023	1011	Timo	Ruohonen	\N	\N	\N	kuvat/henkilo/Ruohonen_Timo_1023.jpg	\N	\N
1047	1030	Lauri	Oksanen	\N	\N	\N	kuvat/henkilo/Oksanen_Lauri_1047.jpg	Patentoinut jo kuuluisaksi tulleen &quot;yhden k�den sy�t�n&quot;.	\N
1025	1013	Juha	Kurki	\N	\N	\N	kuvat/henkilo/Kurki_Juha_1025.jpg	\N	\N
1070	1024	Jussi	P�ttiniemi	\N	\N	\N	\N	\N	\N
1019	1007	Ilari	Lehtinen	1979-12-09	76660	177	\N	Nysv��j�, ty�myyr�.	\N
1021	1009	Jarno	Mustonen	\N	\N	\N	kuvat/henkilo/Mustonen_Jarno_1021.jpg	N�kym�t�n mutta yll�tt�v� surffari hy�kk�ysp��ss�.	\N
1017	1005	Kari	M�kinen	\N	\N	\N	kuvat/henkilo/M_kinen_Kari_1017.jpg	&quot;Salibandyn Zinedine Zidane&quot;.	\N
\.


--
-- Data for TOC entry 102 (OID 24051)
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
1011	L	\N
1012	L	\N
1013	L	\N
1026	L	Exel Edge
1015	L	\N
1016	L	\N
1048	L	\N
1066	L	Exel
1028	L	Fat Pipe Wabor
1020	L	\N
1025	L	\N
1022	L	\N
1068	L	\N
2	L	\N
1046	L	\N
1069	L	Fat Pipe Wiz
1024	L	Fatpipe Raw
1029	L	Fat Pipe Wiz
1061	L	\N
1	L	\N
1027	L	Exel Edge 2.3
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
1041	L	\N
1042	L	\N
1043	L	\N
1044	L	\N
1045	L	Excel
1067	L	Exel Edge 2.3
1065	R	Fat Pipe Wiz
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
1063	L	\N
1064	L	\N
1023	L	\N
1019	L	Exel
1070	L	\N
1021	R	Fat Pipe
1017	L	\N
1014	L	Fat Pipe Wabor
1047	L	Fat Pipe
1018	L	\N
\.


--
-- Data for TOC entry 103 (OID 24054)
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
-- Data for TOC entry 104 (OID 24058)
-- Name: tapahtuma; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY tapahtuma (tapahtumaid, vastuuhlo, tyyppi, paikka, paiva, aika, kuvaus) FROM stdin;
1051	\N	harjoitus	Kaukaj�rvi	2005-05-12	18:00:00	\N
1050	1019	Saunailta	Ilarilla (Tiilikatu 13)	2005-05-14	18:30:00	Oma pullo mukaan ja joka toinen voisi ostaa jotain sy�t�v��...eli jos \r\ntulette kaverin kanssa niin on toisella oltava jotain kaikille. sill� \r\nsaunailtakassassa on t�ll�hetkell� 10 euroa + 15 euro,joita ei ole viel�k��n \r\nsaatu (VP:n suomen cup maksuja)
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
1027	\N	peli	\N	2004-02-15	14:00:00	Tiukka helmikuinen kamppailu johti kotijoukkueen niukkaan voittoon.
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
1049	\N	harjoitus	Kaukaj�rvi Spiral-halli	2005-05-05	18:00:00	Tyypilliset reenit
1011	\N	peli	\N	2004-10-03	11:00:00	\N
1052	\N	harjoitus	Kaukaj�rvi, Spiral-salit	2005-05-19	18:00:00	Normi reenit.
1021	\N	peli	\N	2004-10-16	12:00:00	\N
1053	\N	peli	\N	2004-09-04	11:00:00	\N
1054	\N	peli	Forssa	2004-09-18	12:00:00	\N
1055	\N	peli	Forssa	2004-09-18	15:00:00	\N
1056	\N	harjoitus	Kaukaj�rvi	2005-05-26	18:00:00	Normi reenit
1057	\N	harjoitus	Kaukaj�rvi (Spiral-salit)	2005-06-02	18:00:00	Reenit samaan aikaan samassa paikassa (kun ei kukaan jaksanu kysy� saisko vaihettua paremmalle(nopeammalle) kent�lle).
1058	\N	harjoitus	Kaujaj�rvi	2005-06-09	18:00:00	\N
1059	\N	harjoitus	Kaukaj�rvi, Spiral-salit	2005-06-16	18:00:00	\N
1060	\N	harjoitus	Kaukaj�rvi, Spiral-salit	2005-06-23	18:00:00	\N
1064	\N	harjoitus	Kaukaj�rvi	2005-07-21	18:00:00	\N
1061	\N	harjoitus	Kaukaj�rvi	2005-06-30	18:00:00	\N
1062	\N	harjoitus	Kaukaj�rvi	2005-07-07	18:00:00	\N
1063	\N	harjoitus	Spiral-salit kaukaj�rvi	2005-07-14	18:00:00	\N
1065	\N	harjoitus	Kaukaj�rvi	2005-07-28	18:00:00	\N
1066	\N	harjoitus	Kaukaj�rvi	2005-08-04	18:00:00	\N
1067	\N	harjoitus	Kaukaj�rvi	2005-08-11	18:00:00	\N
1068	\N	harjoitus	Kaukaj�rvi	2005-08-18	18:00:00	\N
1071	1065	harjoitus	Kaukaj�rvi	2005-09-01	18:00:00	Ylivoiman ja alivoiman harjoittelua ja viisikoittain peli�
1069	\N	peli	Kaukaj�rvi	2005-08-25	18:00:00	Harjoituspeli P�lk�neen Lukkoa vastaan.
1070	1065	harjoitus	Peltolammin koulu	2005-08-29	20:00:00	Peltolammin Koulun liikuntasalissa pienimuotoisia harjoituksia ja pienpeli�.
1072	1065	harjoitus	Peltolammin koulu	2005-09-05	20:00:00	Pienpeli� 2vs.2/ 3vs.3. Oheislajeina sis�-fudis ja koripallo
1074	\N	peli	\N	2005-09-25	12:00:00	Kauden ensimm�inen 5.div ottelu Sc Nemesist� vastaan
1083	\N	harjoitus	Peltolammin koulu	2005-10-03	20:00:00	Luvassa kovaa reeni� koville j�tkille.
1075	\N	harjoitus	Peltolammin koulu	2005-09-12	20:00:00	2vs.2/3vs.3/4vs.4 \\\\\\&quot;h�ntsy�\\\\\\&quot;. Koripallo, sis�-fudis tai k�sipallo lis�n�.
1076	\N	harjoitus	Kaukaj�rvi	2005-09-15	18:00:00	Yv-viisikoiden, avauspelin- ja karvauspelin harjoittelua.\r\n5v.5 viisikoittain peli�.
1077	\N	harjoitus	Peltolammin koulu	2005-09-19	20:00:00	Perus pienpelit ja oheislajit m��r�st� riippuen.
1081	\N	harjoitus	Peltolammin koulu	2005-09-26	20:00:00	Pienpeli-h�ntsyt 2vs.2, 3vs.3.
1084	\N	harjoitus	Kaukaj�rvi	2005-10-06	18:00:00	Harjoitukset: \r\n- alkuverryttely\r\n- 2vs.2 puolella tai koko kent�ll�\r\n- vetoharjoitteita\r\n- pienpeli� 3vs.3\r\n- ylivoima\r\n- viisikoittain 5vs.5 peli�
1073	\N	peli	Kaukaj�rvi	2005-09-08	18:00:00	Kauden toinen harjoituspeli Sc Interi�(5.div)vastaan.\r\n(Ennen ottelua pukukopissa kapteenin valinta tulevalle kaudelle)
1078	\N	peli	Kaukaj�rvi	2005-09-22	18:00:00	HARJ.PELI PERUTTU KU-68:N PUOLESTA! \r\n\r\nKooVee 2:lla normaalit/ 5.div peliin valmistavat treenit!
1082	\N	harjoitus	Kaukaj�rvi	2005-09-29	18:00:00	Lauantain (1.10) FBC Nokia-otteluun valmistavat harjoitukset (viisikkopeli: avaus, karvaus, vaparit jne.)+ yv
1079	\N	peli	Rahola	2005-10-01	10:00:00	5.divari FBC Nokia - Koovee 2
1080	\N	peli	Raholan Liikuntakeskus	2005-10-08	13:00:00	KooVee 2 vastuujoukkueena klo 10-14 (toimitsija-hommia 4 ottelua)\r\n 5.div: KooVee 2 - AWE
1085	\N	harjoitus	Peltolammin koulu	2005-10-10	20:00:00	pienpeli� ja reeni�
1086	\N	harjoitus	Kaukaj�rvi	2005-10-13	18:00:00	Lauantain 15.10 5.div: V&amp;L-peliin valmistavat harkat
1089	\N	peli	Rahola	2005-10-29	12:00:00	5.divisioonan ottelu SC L�tty� vastaan
1088	\N	peli	Rahola	2005-10-23	10:00:00	5.div-peli KoSBy� vastaan
1087	\N	peli	Rahola	2005-10-15	13:00:00	5.divari-ottelu Tottij�rven V&amp;L- vastaan
1090	\N	peli	Rahola	2005-11-06	10:00:00	\N
1094	\N	harjoitus	Peltolammin koulu	2005-10-24	20:00:00	H�ntsypelit tai jotain treeni�
1092	\N	harjoitus	Peltolammin koulu	2005-10-17	20:00:00	\\&quot;Legendaariset h�ntsyt legendaarisilla miehill�\\&quot;
1093	\N	harjoitus	Kaukaj�rvi	2005-10-20	18:00:00	Sunnuntain KoSBy-peliin valmistavat harjoitukset: \r\n-alkuverryttely: sveitsil�inen, mato jne.\r\n-2vs.2 koko- tai puolikent�ll�\r\n-keskialueen ruotsalainen (sein�sy�tt�j�ll�)\r\n-2vs.1 keskialueelta l�htev�\r\n-vaparikuviot ja sis��nly�nnit viisikoittain\r\n-yv ja av (+6)\r\n-viisikkopeli� 5vs.5
1100	\N	peli	Kaukaj�rvi	2005-11-03	18:00:00	Harjoitusottelu P�Lua(4.div) vastaan Kauksun 4-kent�ll� klo 18.00
1095	\N	harjoitus	Kaukaj�rvi	2005-10-27	18:00:00	SCL-peliin valmistavat treenit: \r\n-Alkuverryttely: sy�tt�mylly, mato, sveitsil�inen\r\n- koko- tai puolen kent�n 2vs.2/3vs.3\r\n-yv ja av\r\n-vaparikuviot\r\n-avaus- ja karvauspeli�\r\n\r\n PS. Toinen maalivahti tulee reeneihimme kokeilemaan harj.veskariksi ?!
1096	\N	harjoitus	Peltolammin koulu	2005-10-31	20:00:00	&quot;Peltsun pelit&quot;
1091	\N	muu	Rahola	2005-10-25	17:35:00	Koovee-salibandyjoukkueiden valokuvaukset Raholan liikuntakeskuksessa ja kuvaus aloitetaan klo 17.35 joten ajoissa paikalle. Tarkemmat tiedot my�hemmin.
1099	\N	peli	Kaukaj�rvi	2005-09-03	18:00:00	Harjoituspeli P�Lua vastaan klo 18.00 K-j�rvi 4
1097	\N	peli	Kaukaj�rvi	2005-09-03	18:00:00	Harj.peli P�Lua vastaan klo 18.00 Kauksun 4-kent�ll�
1101	\N	harjoitus	Peltolammin koulu	2005-11-07	20:00:00	&quot;Peltsun h�nyt&quot;
1102	\N	harjoitus	Kaukaj�rvi	2005-11-10	18:00:00	Pelitreenit
1103	\N	Saunailta	Kaupinkatu 19 asunto 15	2005-11-12	16:00:00	Koovee 2-joukkueen saunailta
1098	\N	harjoitus	Peltolammin koulu	2005-10-31	20:00:00	&quot;Peltsun pelit&quot;
\.


--
-- Data for TOC entry 105 (OID 24066)
-- Name: halli; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY halli (halliid, nimi, yhtietoid, kenttienlkm, lisatieto, alusta) FROM stdin;
2	Kaukaj�rvi Spiral-halli	2	4	\N	Muovimatto
1002	Toijalan Monitoimihalli	1018	1	\N	parketti
1004	Metroauto Areena	1019	4	\N	Muovimatto
1006	Oriveden liikuntahalli	1020	1	\N	\N
1012	Pirkkalan Liikuntatalo	\N	1	\N	Parketti
1014	Tamppi-Areena	1023	1	\N	Muovimatto
1016	Renska Areena Forssa	\N	1	\N	matto
1010	Vilppulan urheilutalo	1022	1	\N	parketti
1008	Raholan Liikuntakeskus	1021	4	\N	muovimatto
\.


--
-- Data for TOC entry 106 (OID 24073)
-- Name: kausi; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY kausi (vuosi) FROM stdin;
2003
2004
2006
2005
\.


--
-- Data for TOC entry 107 (OID 24075)
-- Name: sarjatyyppi; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY sarjatyyppi (tyyppi) FROM stdin;
M 5. Div
M 4. Div
Suomen Cup
\.


--
-- Data for TOC entry 108 (OID 24079)
-- Name: seura; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY seura (seuraid, nimi, perustamispvm, lisatieto) FROM stdin;
2	D-kone	2001-01-01	Tamperelainen seura
1001	Soittorasia	1995-01-01	\N
1002	SC Teho	1995-01-01	\N
1003	Ilves	1930-01-01	\N
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
1017	SC L�sim�ki	1995-01-01	\N
1018	SB Ontto	1993-01-01	Ontto aloitti toimintansa vuonna 1993 salibandyliiton IV-divisioonassa.
1019	Athletic Club Aulanko ry	2002-01-01	\N
1	Koo-Vee	1929-01-01	\N
1020	TFT	1900-01-01	\N
1022	SC Nemesis	2005-01-01	?
1023	AWE	2005-01-01	Mik�s helvetti t�� t�mm�nen seura on?
1021	Forssan Suupparit Ry	1993-01-14	\N
1024	Tottij�rven\r\nTottij�rven V&amp;L ry	1998-01-01	Tottij�rven vauhti ja l�m�ri ry
1025	Koskenm�en Salibandy ry	1997-01-01	\N
1026	SC L�tty	2005-01-01	\N
1027	Manse Pojat	2005-01-01	\N
\.


--
-- Data for TOC entry 109 (OID 24087)
-- Name: sarja; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY sarja (sarjaid, kausi, tyyppi, nimi, kuvaus, jarjestaja) FROM stdin;
1	2003	M 5. Div	Sis�-Suomi	Miesten 5. divisioona	Suomen Salibandyliitto
1002	2004	Suomen Cup	Lohko H	Kierrokset 1. ja 2.	Suomen Salibandyliitto
1001	2004	M 4. Div	Sis�-Suomi	Miesten 4. divisioona	Suomen Salibandyliitto
1003	2005	M 5. Div	Sis�-Suomi	Miesten 5. divisioona	Suomen Salibandyliitto
\.


--
-- Data for TOC entry 110 (OID 24095)
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
1010	1017	SC L�sim�k	SC L�sim�ki	\N	\N	\N	\N
1012	1012	KilMy	Killinkosken Myrsky	\N	\N	\N	\N
1011	1010	Vihuri	Vihuri	\N	\N	\N	\N
1013	1013	KU-68	Kangasala\r\nKU-68	\N	\N	\N	\N
1014	1014	Kurttu	Kurun Kurttu	\N	\N	\N	\N
1015	1015	JU 2	Juupajoki 2	\N	\N	\N	\N
1016	1016	Sahku	Sahku	\N	\N	\N	\N
1017	1011	Peve Bandy	Peve Bandy	\N	\N	\N	\N
1018	1018	SB Ontto	SB Ontto	\N	\N	\N	http://www.ontto.fi/
1019	1019	AC Aulanko	Athletic Club Aulanko	\N	aulanko@acaulanko.com	\N	H�meenlinnalainen jalkapallo ja salibandyseura.
1020	1020	TFT	Toijalan floorball team	\N	\N	\N	\N
1022	1021	FoSu	Forssan Suupparit	\N	\N	\N	\N
1026	1024	V&amp;L	Tottij�rven vauhti ja l�m�ri	\N	tottijarvenvauhtijalamari@kolumbus.fi	\N	Nokialta
1027	1026	SCL	SC L�tty	\N	sc.latty@luukku.com	\N	\N
1006	1006	FBC Nokia	Floor Ball Club Nokia	\N	\N	\N	\N
1023	1022	SC Nemesis	SC Nemesis	\N	info@scnemesis.com	\N	http://www.scnemesis.com
1028	1025	KoSBy	Koskenm�en salibandy	\N	toimisto@kosby.net	\N	\N
1029	1027	ManPo	Manse Pojat	\N	\N	\N	\N
1	1	Koo-Vee 2	Koo-Vee 2	\N	koovee2@beer.com	kuvat/joukkue/Koo-Vee_2/defaultlogo.gif	Vanha perinteik�s urheilun monitoimiseura
\.


--
-- Data for TOC entry 111 (OID 24104)
-- Name: kaudenjoukkue; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY kaudenjoukkue (joukkueid, kausi, kotihalli, kuva, logo, kotipaikka, kuvaus) FROM stdin;
1	2003	2	\N	\N	Tampere	Koo-Vee 2 pelasi kaudella 2003-2004 5. divisioonassa
2	2004	2	\N	\N	Tampere	\N
1019	2004	\N	\N	\N	H�meenlinna	\N
1018	2004	\N	\N	\N	Tampere	\N
1	2004	2	kuvat/joukkue/Koo-Vee_2/ryhmakuva_2004.jpg	\N	Tampere	Miehet 4 divisioona, Pirkanmaa lohko 2
1	2005	2	kuvat/joukkue/Koo-Vee_2/ryhmakuva_2005.jpg	\N	Tampere	\N
\.


--
-- Data for TOC entry 112 (OID 24112)
-- Name: peli; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY peli (peliid, vierasjoukkue, kotijoukkue, sarja, atoimihenkilo1, atoimihenkilo2, atoimihenkilo3, atoimihenkilo4, atoimihenkilo5, btoimihenkilo1, btoimihenkilo2, btoimihenkilo3, btoimihenkilo4, btoimihenkilo5, pelipaikka, kotimaalit, vierasmaalit, tuomari1, tuomari2, toimitsija1, toimitsija2, toimitsija3, huomio, aikalisaa, aikalisab, yleisomaara) FROM stdin;
1045	1015	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1006	6	6	Michael Hokkanen	Kari Karjalainen	Hilma Honkala	Jonna K��ri�inen	Henni K��ri�inen	\N	\N	\N	-1
1044	1	1017	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	4	12	Jussi Rajanti	Juhani Lepp�nen	\N	\N	\N	\N	\N	\N	-1
1030	1	1019	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1002	1	3	Jussi Panula	Toni Joronen	Joona Laukkanen	Toni Joronen	\N	\N	\N	\N	-1
1017	1	1004	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	7	2	Niskanen Sisu	Lepp�nen Juhani	Hiltunen Jaakko	Hiltunen Asko	\N	\N	\N	\N	-1
1027	1014	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	7	3	Seppo Lattu	Lasse Lepola	Jari Lampinen	Eemeli Ilkonen	Aki Jukoukkala	\N	\N	\N	\N
1028	1	1013	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	1	6	Pekka Kes�l�inen	\N	Aki Jukkola	Otso Suokas	\N	\N	00:11:45	\N	\N
1074	1023	1	1003	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	6	1	Janne Koskinen	Lauri Moberg	Vesa Koivu	Susanna Savolainen	\N	\N	\N	00:20:15	\N
1039	1003	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	2	2	Koskinen Janne	Hokkanen Michael	Pekka S�yn�joki	Marko P��kk�nen	Ville Lehtisaari	\N	\N	00:42:37	\N
1041	1	1015	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	1	3	Kuusinen Jussi	\N	V�is�nen Petri	Moisio Mika	\N	\N	00:44:18	\N	\N
1021	1006	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	4	5	Seppo Markkanen	Jani Hautakorpi	Teemu Vartimo	Matti Hietala (aika)	\N	\N	00:42:56	\N	\N
1037	1012	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	6	1	Alaruka Jeke	Martansaari Marko	Kari J�rvinen	Petteri Rintam�ki	\N	\N	\N	\N	\N
1025	1	1003	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1012	6	3	Saarinen Katriina	Simonen Minna	Jussi Janhunen	Juha Aaltonen	Petri Kimpanp��	\N	\N	\N	-1
1038	1013	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1010	5	3	Olli Nuutinen	Markku Summelvall	Jani K�pyl�	Jaakko Orpana	\N	\N	\N	\N	\N
1022	1	2	1001	\N	\N	\N	\N	\N	1015	\N	\N	\N	\N	2	5	4	Riku Henrikson	Juha-Matti Henrikson	Matti Mikkonen	Markus Lahdensuo	\N	\N	\N	00:38:24	\N
1048	2	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	3	8	Panula	Yl�nen	Silvo	Puronurmi	Vode	\N	\N	\N	\N
1020	1003	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1012	8	4	Jukka Innanen	Seppo Auvinen	Jukka Kunnas (aika)	Jarkko Koskela (kirjuri)	Harri Iatja (kello)	\N	\N	\N	\N
1034	1	1012	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	2	7	Ari L�hteenm�ki	Petri Heikkil�	Pirttikoski Timo	Innala Miikka	Pirttikoski Hannu	\N	\N	\N	\N
1042	1016	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1006	6	4	Pekka Arola	Raimo Sompa	Mari Humalajoki	Niina Viljamaa	Katja Viljamaa	\N	\N	\N	-1
1029	1001	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	1	6	Riku Henrikson	Juha-Matti Henrikson	Joni Niskanen	Henry Nieminen (aika)	\N	\N	00:40:43	\N	\N
1035	1010	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1010	5	5	Tom Saarela	Olli Nuuttinen	Jaakko Orpana	Jani K�pyl�	\N	\N	\N	\N	\N
1036	1	1011	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	4	4	Laakso Jussi	Simonen Minna	\N	\N	\N	\N	\N	\N	\N
1040	1	1014	1	\N	\N	\N	\N	\N	1017	\N	\N	\N	\N	1004	2	5	Katriina Saarinen	Minna Simonen	Heikki Set�l�	Mika Sappinen	\N	\N	\N	\N	\N
1053	1	1020	1002	\N	\N	\N	\N	\N	1015	\N	\N	\N	\N	2	6	2	Jussi Panula	Jani Hautakorpi	Laura Saarela (aika)	Anne-Mari Vintola	\N	\N	\N	\N	\N
1079	1	1006	1003	\N	\N	\N	\N	\N	1026	1065	\N	\N	\N	1008	7	3	Pekka Kes�l�inen	Marko Sandelin	Marko Kujansivu	Toni Kivel�	\N	\N	\N	00:40:24	\N
1054	1021	1	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1016	1	12	Siitonen Pertti	Kuussaari Karo	Erkko Kikka (aika)	L�hteenkorva Perttu	\N	\N	00:42:19	\N	\N
1055	1	1022	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1016	13	1	Kuussaari Karo	Riihenper� Petri	Erkko Kikka	Vellamo Tomi (aika)	\N	\N	\N	\N	\N
1088	1028	1	1003	1027	1065	\N	\N	\N	\N	\N	\N	\N	\N	1008	7	3	Hannu Santanen	Jussi Panula	Jari Ansamaa	Allan Martimo	Markus Tapola	\N	\N	\N	\N
1080	1025	1	1003	1065	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	6	3	Jere Alaruka	Dimitri Galeh	Jukka Kaartinen	\N	\N	\N	00:41:37	\N	\N
1089	1	1027	1003	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	3	6	Sisu Niskanen	Jani Hautakorpi	Janne Myllykallio	Mika Leino	\N	\N	00:34:00	\N	\N
1087	1	1026	1003	\N	\N	\N	\N	\N	1027	1065	\N	\N	\N	1008	2	6	Petri V�is�nen	Kari Mikkonen	Pinja Lamminpohja	\N	\N	\N	\N	\N	\N
1043	1	1016	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	9	4	Marko Martamaa	Pasi Summanen	Heikki Set�l�	Johanna Aromaa	\N	\N	\N	\N	-1
1046	1	1010	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	0	5	Seppo	\N	Toni Helperi	Mikko Pekkonen	Sonja Hurtamo	\N	\N	\N	-1
1023	1004	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	7	Timo Karinki	Sami Tunturi	Mikko Immonen (aika)	Kimmo Kiprionoff	\N	\N	00:40:23	\N	-1
1047	1018	1	1002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1002	5	13	Jussi Panula	Jani Hautakorpi	Joona Laukkanen	Toni Joronen	\N	\N	\N	\N	-1
1026	1	1002	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	2	Marko Salminen	Petri Heikkil�	Tanja J��skel�inen	Pekka Hiltunen	\N	\N	\N	\N	-1
1010	1008	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	4	Roselund Mika	Ruokosalo Jukka	J�rvinen Antti	Alvinen Petri	Martimo Allan	\N	\N	00:44:06	\N
1016	1	1008	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	3	Mika Vallin	Jukka Innanen	Teemu Turunen	Ari Ruoholahti	\N	\N	\N	\N	\N
1015	1002	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	5	3	L�hteenm�ki Ari	Makkaranen Seppo	Kortemaa Mauri (aika)	Makkonen Teijo	\N	\N	\N	00:42:55	\N
1018	1	1001	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	5	4	Ari Kuusisto	J. Innonen	Jussi Yl�nen	Ari Vasarainen	\N	\N	00:40:49	\N	\N
1090	1	1029	1003	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1
1011	1	1009	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1014	5	1	Marko Salminen	Petri Heikkil�	Janne Tikkakoski	Aki H�nninen (aika)	\N	\N	\N	00:23:18	\N
1019	1007	1	1001	1015	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	6	2	Laakso Jussi	Leponen Joonas	Sari Ilola	Markus Lintula	Mikko Koskinen	\N	\N	\N	\N
1012	1009	1	1001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	2	5	Jukka Suominen	Aapo J�rvinen	Tino Silfver	Matti Partanen	\N	\N	00:39:42	\N	\N
1031	1011	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	7	5	Jussi Innanen	Seppo Lehtonen	Timo M�kinen	Marjaana Martikainen	\N	\N	\N	\N	\N
1032	1	1003	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1014	3	3	Juhani Lepp�nen	Lasse Lepola	Juha Kauppinen	Karri Saarinen	\N	\N	00:44:46	00:41:14	\N
1033	1017	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1004	9	1	Antti Tomminen	Tero Yl�nen	V�is�nen Petri	Lahtinen Perttu (aika)	Kansula Joonas	\N	00:36:24	\N	\N
\.


--
-- Data for TOC entry 113 (OID 24123)
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
\.


--
-- Data for TOC entry 114 (OID 24126)
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
\.


--
-- Data for TOC entry 115 (OID 24133)
-- Name: epaonnisrankku; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY epaonnisrankku (epaonnisrankkuid, tekija, tyyppi, tyhjamaali, siirrangaikana) FROM stdin;
1055	1019	no	f	f
1355	1066	no	f	f
\.


--
-- Data for TOC entry 116 (OID 24142)
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
\.


--
-- Data for TOC entry 117 (OID 24147)
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
\.


--
-- Data for TOC entry 118 (OID 24157)
-- Name: toimenkuva; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY toimenkuva (toimenkuva) FROM stdin;
huoltaja
Joukkueenjohtaja
\.


--
-- Data for TOC entry 119 (OID 24159)
-- Name: toimi; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY toimi (tehtava, kaudenjoukkue, kausi, henkilo) FROM stdin;
\N	1018	2004	1042
\N	1018	2004	1043
\N	1018	2004	1044
Joukkueenjohtaja	1	2005	1027
\.


--
-- Data for TOC entry 120 (OID 24161)
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
1051	1020	f	t�iss�
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
1056	1024	f	t�iss�
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
1057	1029	f	ty�kiireit� ilmaantui
1058	1024	f	Slayer
1058	1020	t	\N
1059	1026	t	\N
1058	1028	f	meen m�kille
1058	1029	f	sairaslomalla juhannukseen
1059	1027	t	\N
1059	1024	t	\N
1059	1029	t	\N
1059	1021	t	\N
1059	1028	f	ty�este
1061	1027	t	\N
1060	1024	f	Juhannus
1060	1026	f	Himoksella
1060	1021	f	Himos
1061	1029	t	\N
1060	1027	f	Viett�m�ss� juhannusta my�skin himoksella
1061	1021	t	\N
1061	1026	f	flunssa
1061	1024	t	\N
1062	1026	t	\N
1062	1027	t	\N
1062	1021	t	\N
1062	1029	t	\N
1063	1029	f	ty�este
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
1065	1029	f	alaselk� reistaa
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
1083	1069	f	kouluhommat painavat p��lle
1079	1021	t	\N
1082	1069	t	\N
1079	1069	t	\N
1080	1069	t	\N
1082	1024	f	Helsingiss�
1079	1024	t	\N
1082	1068	t	\N
1082	1021	f	Ty�t
1079	1068	t	\N
1079	1026	t	\N
1083	1065	f	vanhan paikat ei oo palautunu vi� lauantaista
1080	1065	t	\N
1084	1065	t	\N
1083	1027	f	J��n kotiin toipumaan nivus rev�hdyksest�, joka sattui la peliss�
1084	1027	t	\N
1084	1069	t	\N
1083	1021	f	Eih�n si�ll� sitte en�� ket�� ole
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
1086	1046	f	h�meenkadun appro
1087	1046	t	\N
1086	1069	t	\N
1085	1027	f	Tuli ty� kiireit� enk� p��se tulemaan
1086	1027	t	\N
1087	1027	t	\N
1087	1026	t	\N
1086	1026	t	\N
1087	1069	t	\N
1086	1029	f	tentti
1087	1029	f	m�kkireissu ruovedell�
1086	1024	t	\N
1087	1024	t	\N
1091	1027	t	\N
1091	1024	f	koulu & l�tk�matsi
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
1093	1024	f	k�sivamma
1088	1024	f	k�sivamma
1092	1024	f	k�sivamma
1094	1024	f	k�sivamma
1093	1027	t	\N
1088	1027	t	\N
1093	1067	t	\N
1088	1067	t	\N
1092	1067	f	menkat..sattuu mahaan..ai ai
1092	1027	t	\N
1091	1067	t	\N
1088	1047	f	Tulva, hein�sirkat sy�nyt autosta renkaat, vatsatauti, p�lynimuri temppuilee, onneksi on If
1094	1027	t	\N
1088	1029	t	\N
1093	1068	f	P�rkeleen koulu
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
1096	1027	f	jonkin sortin tauti on iskenyt kyntens�
1100	1027	f	En pysty pelaamaan mutta tuun paikanp��lle.
1100	1065	f	keuhkoihin pist�� ja vituttaa
1100	1029	t	\N
1090	1029	t	\N
1090	1027	t	\N
1103	1027	t	\N
\.


--
-- Data for TOC entry 121 (OID 24166)
-- Name: pelaajat; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY pelaajat (joukkue, kausi, pelaaja, pelinumero, pelipaikka, kapteeni) FROM stdin;
1	2005	1046	3	PU	f
1	2005	1029	4	OL	f
1	2005	1014	5	PU	f
1	2005	1021	6	VL	f
1	2003	1011	3	KE	f
1	2003	1014	5	PU	f
1	2003	1015	8	OL	t
1	2003	1016	9	PU	f
1	2003	1017	10	KE	f
1	2003	1018	12	VL	f
1	2003	1019	14	KE	f
1	2003	1020	16	OL	f
1	2003	1021	19	VL	f
1	2003	1022	25	OL	f
1	2003	1023	27	VL	f
1	2003	1024	42	PU	f
1	2003	1025	73	MV	f
1	2003	1026	77	PU	f
1	2003	1027	80	VL	f
1	2003	1028	87	VL	f
1	2003	1029	17	OL	f
2	2004	1001	\N	\N	f
2	2004	1002	\N	\N	f
2	2004	1003	\N	\N	f
2	2004	1004	\N	\N	f
2	2004	1005	\N	\N	f
2	2004	1006	\N	\N	f
2	2004	1007	\N	\N	f
2	2004	1008	\N	\N	f
2	2004	1009	\N	\N	f
2	2004	1010	\N	\N	f
2	2004	1012	\N	\N	f
2	2004	1013	\N	\N	f
1018	2004	1030	3	VL	f
1018	2004	1031	6	VL	f
1018	2004	1032	7	VL	f
1018	2004	1033	9	VL	f
1018	2004	1034	11	VL	t
1018	2004	1035	12	VL	f
1018	2004	1036	13	VL	f
1018	2004	1037	17	VL	f
1018	2004	1038	18	VL	f
1018	2004	1039	20	VL	f
1018	2004	1040	39	MV	f
1018	2004	1041	1	MV	f
1	2005	1026	7	PU	f
1	2005	1066	10	KE	f
1	2005	1018	12	KE	f
1	2005	1047	14	OL	f
1	2005	1024	15	PU	f
1	2005	1067	16	OL	f
1	2005	1068	30	MV	f
1	2005	1069	73	VL	f
1019	2004	1049	-1	\N	f
1019	2004	1050	-1	\N	f
1019	2004	1052	-1	\N	f
1019	2004	1053	-1	\N	f
1019	2004	1054	-1	\N	f
1019	2004	1055	-1	\N	f
1019	2004	1056	-1	\N	f
1019	2004	1057	-1	\N	f
1019	2004	1059	-1	\N	f
1019	2004	1060	-1	\N	f
1019	2004	1058	-1	\N	f
1	2005	1065	79	KE	f
1	2005	1027	80	VL	t
1018	2004	1042	\N	\N	f
1018	2004	1043	\N	\N	f
1018	2004	1044	\N	\N	f
1	2004	1048	1	MV	f
1	2004	1046	3	PU	f
1	2004	1014	5	PU	f
1	2004	1015	8	OL	f
1	2004	1016	9	PU	f
1	2004	1017	10	KE	t
1	2004	1018	12	VL	f
1	2004	1019	14	VL	f
1	2004	1020	16	VL	f
1	2004	1029	17	OL	f
1	2004	1021	19	VL	f
1	2004	1045	25	KE	f
1	2004	1023	27	OL	f
1	2004	1024	42	PU	f
1	2004	1025	73	MV	f
1	2004	1026	77	PU	f
1	2004	1027	80	VL	f
1	2004	1028	87	OL	f
1	2004	1047	88	PU	f
1	2004	1061	-1	\N	f
1	2004	1063	-1	\N	f
1	2004	1064	-1	\N	f
1	2004	1062	-1	\N	f
1019	2004	1051	-1	\N	f
\.


--
-- Data for TOC entry 122 (OID 24170)
-- Name: sarjanjoukkueet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY sarjanjoukkueet (sarjaid, joukkue, kausi) FROM stdin;
1002	1019	2004
1002	1	2004
1002	1018	2004
1001	1	2004
1	1	2004
1003	1	2005
\.


--
-- Data for TOC entry 123 (OID 24174)
-- Name: uutinen; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY uutinen (uutinenid, pvm, ilmoittaja, otsikko, uutinen) FROM stdin;
1009	2005-08-25	Jussi Innanen	Koovee 2 ja P�Lu harj.peliss� tasavahvat	Kauden ensimm�inen harjoitusottelu 4.divarin P�lk�neen Lukkoa vastaan p��ttyi tasan 4-4. Ottelu sujui suurimman osan ajasta P�lk�neen hallitessa, mutta Koovee-vahtimme Antti Paukkio oli hyv�ss� vedossa tolppien v�liss�. \r\n\r\nP�Lu rokotti kylm�sti karkeista keskialueen virheist�mme miltei kaikki nelj� maaliaan. Joukkueemme peliss� positiivista oli maalivahtipelin lis�ksi miltei maksimaalinen maalipaikkojen hy�dynt�minen.\r\n\r\nMaaleistamme vastasivat Lauri Oksanen (1-2 kavennus), Jani Singh (2-2 tasoitus), Jussi Innanen (3-2 johto) sek� Jani Myllynen, joka tasoitti 4-4:een parikymment� sekuntia ennen loppua ylivoimalla.
1004	2005-07-08	Jukka Kaartinen	Joukkue kaudella 2005-2006	Kauden 2005-2006 kokoonpano on julkaistu.
1003	2005-10-12	Jussi Innanen	KooVeen joukkueiden valokuvaukset	Koovee-salibandyjoukkueiden valokuvaukset suoritetaan ammattilaisten toimesta tiistaina 25.10 klo 19 alkaen Raholan Liikuntakeskuksessa. Joukkueille ilmoitetaan tarkka ajankohta my�hemmin.
1033	2005-10-19	Jussi Innanen	Kaksi pakkia pois KoSBy-pelist� (23.10)	Puolustajat Johannes "Jay-Jay" J�rvinen ja Lauri Oksanen ovat sivussa ensi sunnuntain 23.10 5.div-ottelusta Koovee 2-KoSBy. J�rvinen on sivussa k�sivamman vuoksi ja Oksasella on "bisneksi�".
1007	2005-08-16	Jussi Innanen	Ensimm�inen harjoitusottelu	Kauden 2005-06 ensimm�inen harjoitusottelu on torstaina 25.8.05 klo 18-19.00 Kaukaj�rven 2-kent�ll� P�lk�neen Lukkoa (4.div) vastaan.
1006	2005-08-12	Jussi Innanen	Uusi harjoitusvuoro viikolle	Toinen harjoitusvuoro viikolle alkaa viikolla 35. Treenip�iv� on maanantai ja paikkana toimii Peltolammin uuden koulun liikuntasali klo 20.00-21.30. Peltolammin uuden koulun osoite on S��st�j�nkatu 16. Vuoro on varattu joukkueellemme 29.8.05-2.1.06.
1005	2005-07-25	Jussi Innanen	Tuleva kausi 2005-06	<p>KooVee 2-joukkue alkaa olla hiomista varten valmis tulevaan 5.div.kauteen, josta tavoite on nousta takaisin 4.divisioonaan ja lopettaa ns."hissiliike" n�iden kahden divarin v�lill�. Elokuussa joukkue alkaa hieman treenata pelillisi� asioita, esim. viisikkopeli�, ylivoimaa, alivoimaa ja muutamia pieni� t�rkeit� harjoitteita. My�s harjoitusotteluja pelataan Elokuusta eteenp�in.</p>\r\n\r\n<p> T�ll� hetkell� joukkueessa on 13 sitoutunutta pelaajaa, suurinosa vanhoja pelaajia viime kauden joukkueesta, sek� viisi uutta pelaajaa. Joukkuetta todenn�k�isesti t�ydennet��n viel� yhdell� pelimiehell�, jos on tarvetta.</p>\r\n\r\n<p>Harjoitukset jatkuu normaalisti Torstaisin Kaukaj�rven Spiral-salien 2-kent�ll� klo 18-19.00, sek� on mahdollista ett� tulee viikolle viel� toinenkin harjoitusvuoro.</p>
1008	2005-08-20	Jussi Innanen	Pelaajakortteja p�ivitetty	Tulevan kauden joukkueen pelaajakortit alkavat olla pikku hiljaa kuosissaan, joten kannattaa k�yd� katsastamassa paremman puutteessa.
1016	2005-09-08	Jussi Innanen	Jukka Kaartinen nimetty kapteeniksi	Ennen harjoitusottelua oli edess� joukkueen uuden kapteenin valinta. ��nestyksen voitti niukasti vasen laituri ja joukkueen "puuha-pete" Jukka Kaartinen, joten Jukkis aloitti kapteeni-kautensa jo samana p�iv�n� harj.peliss� Sc Interi� vastaan.
1001	2005-09-02	Jussi Innanen	Miesten 5.div. sarjaj�rjestelm�	Tulevalla kaudella 2005-06 Miesten 5.divisioonassa Sis�-Suomen alueella pelataan 8 lohkossa ja jokaisessa lohkossa on 7-8 joukkuetta. Pelataan kaksinkertainen sarja, josta kustakin lohkosta 4 parasta p��see Ylemp��n loppusarjaan ja loput jatkosarjaan. Kumpiakin sarjan lohkoja tulee nelj�. Niiss� kummassakin my�s kaksinkertainen sarja, mutta aikasemmin kohdattuja joukkueita vastaan ei en�� pelata, vaan alkusarjan keskin�isten ottelujen pisteet j��v�t voimaan. Ylempien jatkosarjojen voittajat nousevat suoraan 4.divariin ja kakkoseksi sijoittuneet pelaavat toisen lohkon kakkosta vastaan yhden ottelun noususta.
1010	2005-08-25	Jussi Innanen	Harjoitusvuoroista muistutus	Ensi viikosta eteenp�in torstain harjoitusvuoron lis�ksi tulee siis toinen vuoro maanantaille, eli kaksi harjoitusta viikossa:\r\n\r\n\r\n\r\nMaanantai 20.00-21.30 Peltolammin koulu,\r\nTorstai 18.00-19.00 Kaukaj�rven Spiral-salit 2
1011	2005-08-29	Jussi Innanen	Kari M�kinen j�tt�� joukkueen	Joukkueemme "El Capitano" Kari M�kinen on p��tt�nyt j�tt�� Koovee-kakkosen juuri tulevan kauden alla ja siirtynee vahvistamaan Spiral-liigajoukkue SB Postia. M�kisen l�hd�n syyn� on ett� pelej� tulisi kahdessa joukkueessa liikaa sek� mahdolliset p��llekk�isyydet. Koovee 2 kiitt�� Karia joukkueessa vietetyist� kausista ja toivottaa onnea Spiral-peleihin.
1013	2005-09-02	Jussi Innanen	5.divisioona lohkot valmiina	SSBL:n Sis�-Suomen 5.divisioonan Pirkanmaan lohko 5:ssa pelaavat kaudella 05-06 seuraavat joukkueet: KOOVEE 2(Tre), AWE(Yl�j�rvi), SC L�tty(Tre), SC Nemesis(Tre), ManPo(Tre), V&L(Nokia), KoSBy(Nokia) ja FBC Nokia. Ensimm�inen ottelu on SC Nemesist� vastaan 25.9 sunnuntaina Raholan Liikuntakeskuksessa klo 12.00.
1012	2005-09-02	Jussi Innanen	Tulevat harjoitusottelut	Harjoitusottelut jatkuvat viel� kahdella pelill� ennen kuin 5.div.kausi alkaa. Viimeiset harkkapelit ovat 8.9 SC Inter(5.div) ja 22.9 KU-68(4.div). Kummatkin ottelut pelataan joukkueemme torstain harkkavuorolla klo 18.00 Kaukaj�rven 2-kent�ll�.
1015	2005-09-07	Jussi Innanen	Keskustelu-foorumi aukeaa ensi viikolla	Koovee 2-joukkueen kotisivuilla avataan ensi viikon alussa keskustelu-foorumi, josta enemm�n informaatiota my�hemmin.
1014	2005-09-02	Jussi Innanen	Joukkueen kapteenin valinta	Uusi "El Capitano" joukkueelle valitaan 8.9 torstaina ennen harjoituspeli� Sc Interi� vastaan. Kaikki peliin tulevat ��nest�v�t ja kapun nauha luovutetaan eniten ��ni� saaneelle henkil�lle.
1019	2005-09-15	Jussi Innanen	KooVee 2:n kauden 2005-06 pelipaidat	Joukkueen tulevan 5.divari kauden ykk�s-pelipaita tulee olemaan puna-musta Edustuksen vanha paita, jossa siis on KooVeen logo ja mainoksia mm. LJH Computers sek� Lammi Kivitalot. Kakkos eli varapaitana on edelleen Karhun keltainen paita, jota k�ytet��n vain silloin kun vastustajalla on saman v�rinen pelipaita (puna-musta) ja olemme vierasjoukkueena velvollinen vaihtamaan pelipaitaa.
1018	2005-09-14	Jussi Innanen	Joukkueen sis�inen foorumi valmiina	T�ll� viikolla avattiin KooVee 2-joukkueen oma sis�inen keskustelufoorumi n�ill� kotisivuilla. Foorumiin p��see ensin kirjautumalla sis��n KooVee 2-sivuille eli kaikki pelaajat, joille on annettu tunnukset. Alakulmassa on linkki, josta p��see keskusteluun, kun on ensin rekister�inyt tietonsa.
1017	2005-09-11	Jussi Innanen	J�lleen tasapeli harjoituspeliss�	Harjoituspeli Sc Interi�(5.div) ei tarjonnut kuin er�n verran hyv�� viisikkopeli� joukkueeltamme. J�lleen turhia virheit� pelin rakentelussa ja huono liike veiv�t voiton, tosin tasatulos 4-4 mairittelee enemm�n vastustajaa, joilla oli yksi hyv� kent�llinen. Tason pit�� parantua huomattavasti viimeiseen harj.otteluun (22.9 KU-68) ja sit� mukaan tuleviin 5.div.sarjapeleihin. Joukkueemme maalit tekiv�t Johannes J�rvinen, Aapo Repo, Jani Myllynen ja Juha Kaartinen.
1020	2005-09-18	Jussi Innanen	Juha Kaartinen poissa 5.div-avauksesta	Luottopuolustaja ja raudanlujan vedon omaava Juha Kaartinen l�htee reissuun Saksaan, joten L�mmi ei ole k�ytett�viss� tulevan viikon viimeisess� torstain harj.peliss� KU-68 vastaan eik� my�sk��n p��se "kauan odotettuun" 5.div. avaukseen Sc Nemesist� vastaan sunnuntaina.
1021	2005-09-21	Jussi Innanen	KU-68 perui huomisen harjoituspelin	Harjoitusottelu (22.9)Koovee 2- KU-68 on peruttu n�in viime hetkell� eli p�iv�� ennen. Syyn� on ett� KU ei saa kent�llist� enemp�� pelaajia otteluun. Joten kyseinen harj.peli pelataan joskus tulevaisuudessa.\r\n\r\nHuomisen harj.pelin vuorolla siis normaalit/ 5.div peliin valmistavat harjoitukset.
1022	2005-09-22	Jussi Innanen	Koovee 2 valmiina SC Nemesis-otteluun	Kuten jo aiemminkin on todettu 5.divari alkaa joukkueemme osalta nyt tulevana sunnuntaina 25.9 klo 12.00 SC Nemesist� vastaan Raholan Liikuntakeskuksessa. Joukkueemme on hionut hieman viisikkopeli� sek� ylivoimaa ja v�lill� homma on sujunut niinkuin on pit�nytkin, mutta parannettavaa on viel� paljon joka osa-alueella. Kauden ensimm�isest� 5.div vastustuksesta SC Nemesiksest� ei ole paljon tietoa, muuta kuin ett� joukkue vasta perustettiin ja se osallistuu ensimm�ist� kertaa liiton sarjaan. Todenn�k�isesti sunnuntaina vastaan tulee nuori ja innokas ryhm� kovalla sykkeell�. Joten varuilla pit�� olla!
1024	2005-09-26	Jussi Innanen	Myllynen ei p��se FBC Nokia-peliin	Koovee 2:n laituri Jani Myllynen ei ole mukana lauantain (1.10) 5.div peliss� FBC Nokiaa vastaan. Joukkueen hy�kk�ys"vahvistus" joka saapui Kooveeseen VaLusta l�htee ty�paikan "nestepitoiselle reissulle" ja on n�in poissa kakkosjoukkueen vahvuudesta.
1023	2005-09-25	Jussi Innanen	5.div-kausi k�yntiin selv�ll� voitolla	Koovee 2 aloitti 5.divarin vakuuttavasti 6-1 voitolla SC Nemesiksest�. Ottelun kulku oli selv�, vaikka vastustaja meni yll�tt�en johtoon jo ekalla minuutilla. Sen j�lkeen joukkueemme ryhdist�ytyi ja meni menojaan. Ainoa miinus ottelussa oli joukkueeltamme lukuisat turhat j��hyt, mutta toisaalta tehtiin kaksi alivoima-maalia ja peli oli koko ajan hallussamme. Joukkueemme tehot iskiv�t Juuso Koivisto 2+0, Jussi Innanen 0+2, Teemu Siitarinen 1+0, Jani Singh 1+0, Jukka Kaartinen 1+0, Aapo Repo 1+0, Jarno Mustonen 0+1, Jaakko Ailio 0+1. 5.divari jatkuu ensi lauantaina FBC Nokiaa vastaan.
1025	2005-09-29	Jussi Innanen	Koovee 2 haastaa FBC Nokian lauantaina	Ensimm�isten 5.divari-otteluiden j�lkeen on luvassa lauantaina 2.kierros ja Koovee 2 kohtaa my�skin ekan pelins� voittaneen(8-2 KosBy) FBC Nokian lohkon k�rkipeliss� klo 10.00 Raholassa. FBC Nokia putosi viime kauden p��tteeksi 4.divarista kuten Kooveekin, joten varmaankin tasokas ja tasainen ottelu luvassa, jossa nokialaiset ovat kuitenkin ennakkosuosikin asemassa.
1027	2005-10-06	Jussi Innanen	Lauantaina Koovee 2:n vastuu-turnaus	Nyt tulevana lauantaina 8.10 5.divarin Pirkanmaan 3A-lohkon 3.kierros Raholan Liikuntakeskuksessa klo 10-14.00. KooVee 2 vastuu-joukkueena hoitaa toimitsija-hommat eli 4 ottelua: 10.00 KoSBy-V&L, 11.00 ManPo-SC Nemesis, 12.00 SC L�tty-FBC Nokia, 13.00 KooVee 2-AWE. (Foorumista l�ytyy toimitsijoiden nimet!)
1026	2005-10-01	Jussi Innanen	FBC Nokia jyr�si 3.er�ss� voittoon	Ottelu alkoi hyvin ja yll�tt�v� 3-0 johto meille jo 13 minuutin j�lkeen toi joukkueelle jonkinlaisen "hyv�nolon tunteen", koska oma pelimme j�ikin sitten siihen ja vastustaja pelasi j�rkev�sti iskien pallon nopeata tekopaikoille ja ansaitsi voittonsa lopulta nousten 3-0 tappio-asemasta 7-3 voittoon. 2.er�n j�lkeen johdettiinkin viel� 3-2, mutta 3.er� oli surkea ja nokialaiset laittoi pallon viidesti maaliin ja takaa-ajomme tyss�si j�lleen kerran tyhmiin j��hyihin. Koovee 2:n maalit tekiv�t Jarno Mustonen, Jussi Innanen ja Lauri Yli-Huhtala. Pelin on parannuttava ja turhien j��hyjen loputtava jatkossa jos joukkue haluaa tavoitella nousua 4.divariin. Seuraavassa peliss� ja KooVee 2:n vastuu-turnauksessa vastaan asettuu AWE Yl�j�rvelt�.
1031	2005-10-15	Jussi Innanen	Myllynen upotti V&L:n	Koovee 2 jatkoi voitokkaita esityksi��n nyt Tottij�rven V&L:n kustannuksella lukemin 6-2. Kooveen paras pelimies oli oikea laitahy�kk��j� Jani Myllynen, jonka ruuti oli kuivaa. Myllynen iski 4 maalia yl�-kulma vedoillaan. Peli ei ollut vauhdiltaan p��t� huimaava, mutta Kooveen hallinnassa mentiin, vaikka V&L:ll� olikin pahoja vastahy�kk�yksi�. Koovee 2:n tehopisteet: Jani Myllynen 4+0, Lauri Oksanen 1+1, Jussi Innanen 0+2, Jani Singh 1+0, Jaakko Ailio 0+1, Aapo Repo 0+1, Juha Kaartinen 0+1. Koovee 2:n seuraava ottelu on ensi sunnuntaina ja vastassa on KoSBy Nokialta.
1029	2005-10-12	Jussi Innanen	Kolme laituria poissa V&L-pelist�	Laitahy�kk��j�t Lauri Yli-Huhtala, Juuso Koivisto ja Jarno Mustonen puuttuvat lauantaina 15.10 V&L-pelist�. Koivisto on armeijassa "gineksess�", Mustonen kertausharjoituksissa ja Yli-Huhtala on Ruovedella.
1028	2005-10-11	Jussi Innanen	Koovee 2 voitti AWEn kuumassa peliss�	5.divarin Koovee 2:n omassa vastuu-turnauksessa kohdattiin AWE Yl�j�rvelt�. Joukkueestamme puuttui Mustonen, Koivisto, Repo ja Jukka Kaartinen eli pelaajia oli yhdeks�n ja maalivahti Paukkio, joka oli t�n��nkin mies paikallaan Koovee 2:n 6-3 voittoon p��ttyneess� ottelussa. Kohtalaisen tasainen v��nt�, mutta tunteet eiv�t pysyneet kurissa kummallakaan joukkueella. Vastustaja AWE pelasi vauhdikkaasti mutta todella rumaa ja ei kaukana ollut viisi minuuttia ennen loppua tappelukaan AWEn kapteenin toimesta. Onneksi silt� s��styttiin ja t�rke�t kaksi pistett� Kooveelle eik� tullut loukkaantumisia. Koovee 2:n tehopelaajat olivat Jani Myllynen 2+1, Jussi Innanen 1+1 ja Jaakko Ailio 0+2. Ensi lauantaina Koovee 2 kohtaa Raholassa klo 13.00 Tottij�rven V&L:n, joka voitti t�n��n KoSByn 8-6.
1002	2005-10-12	Jussi Innanen	5.div-lohkon sarjataulukon tilanne	5.divisioonan Pirkanmaan 3A-lohkon k�rjess� puhtaalla pelill� 3.kierroksen j�lkeen jatkaa FBC Nokia 6 pisteell�, toisena on SC L�tty 4 pisteell� ja kolmantena huonommalla maalierolla KooVee 2 my�skin 4 pisteell�. Lohkossa nelj�nten� eli viimeisen ylemp��n jatkosarjaan oikeuttavalla paikalla on V&L 3 pisteell� ja sen j�lkeen KoSBy (2p.), SC Nemesis (2p.), ManPo (2p.) ja AWE pit�� per�p��t� yhdell� pisteell�. Tarkempi sarjataulukko l�ytyy Liiton sivuilta osoitteesta www.salibandy.net.
1030	2005-10-14	Jussi Innanen	Ennakko: V&L - Koovee 2, LA 15.10	Huomena lauantaina Raholassa klo 13.00 Koovee 2 kohtaa Tottij�rven Vauhti&L�m�rin eli V&L:n, joka on sarjataulukossa pisteen j�ljess� Kooveeta eli nelj�nten�. Koovee 2 on selv� ennakkosuosikki kyseisess� peliss�, mutta V&L voi yll�tt�� viel� monet joukkueet t�ss� 5.div-lohkossa. Kamppailu tulee ratkeamaan todenn�k�isesti Kooveen tasaisuuteen vaikka kahdella ketjulla pelataankin, saa my�skin n�hd� paljon tottij�rvil�isill� on pelaajia matkassa. V&L hy�kk�� yleens� vauhdikkaasti, mutta unohtuuko omaan p��n peli. Huomena n�hd��n miten k�y...
1032	2005-10-15	Jussi Innanen	Toinen P�Lu-harjoituspeli suunnitteilla	Koovee 2 pelasi 4.divarin P�Lua vastaan (4-4) Elokuun 25.p�iv� harjoituspelin Kooveen harjoitusvuorolla joten nyt olisi l�hiviikkoina suunnitteilla sovittu toinen ottelu P�lk�neen Lukon vuorolla. Asiasta informoidaan my�hemmin.
1037	2005-10-20	Jussi Innanen	Harj.peli P�Lua vastaan torstaina 3.11.	Kahden viikon p��st� torstaina 3.11 pelataan toinen harjoitusottelu P�Lua(4.div) vastaan niiden treenivuorolla Kaukaj�rven 4-kent�ll� klo 18.00.
1034	2005-10-18	Jussi Innanen	25.10 TI valokuvaus klo 17.35 Raholassa	Koovee-salibandyjoukkueiden valokuvaus ajat ovat varmistuneet ensi viikon tiistaiksi 25.10 Raholassa. Valokuvaukset alkavat klo 17.35, joten silloin jokainen paikalle punamusta-pelipaita ja muu varustus mukana.
1036	2005-10-19	Jussi Innanen	Koovee 2:n saunailta	Koovee 2:n t�m�n kauden ensimm�inen saunailta pidet��n 12.11 lauantaina. Aika, paikka ja muut tiedot l�ytyy my�hemmin sis�isest� foorumista.
1038	2005-10-23	Jussi Innanen	Voitto KoSByst� vaisulla pelill�	Kauden viidenness� 5.div-peliss� KooVee 2 voitti KoSByn lopulta 7-3 huonollakin pelill�. Lohkon jumbojoukkue KoSBylla oli vain 7 pelaajaa ja maalivahti matkassa ja taas meill� puolestaan 11 kentt�pelaajaa, mutta silti tehtiin vaikea ottelua huonon asenteen vuoksi. Onneksi kuitenkin tarvittavat maalit tehtiin ja h�t�� ei ollut, vaikka KoSBy piti pelin tasoissa aina 2.er�n puoleen v�liin asti. Kakkosjoukkueen tehopelaajat olivat Jukka Kaartinen 2+0, Jussi Innanen 2+0, Juha Kaartinen 1+1, Jaakko Ailio 1+1, Juuso Koivisto 1+1 ja Jani Myllynen 0+2. Ensi lauantaina asenteen on oltava eri luokkaa kun vastaan tulee lohkon kolmonen SCL (SC L�tty).
1043	2005-11-01	Jussi Innanen	Muistutus torstain harjoitusottelusta	Muistutukseksi viel�, eli nyt torstaina 3.11 pelataan harjoituspeli P�Lu-KooVee 2 Kaukaj�rven 4-kent�ll� klo 18-19.00. Foorumissa lis�� tietoa tulevasta pelist�.
1035	2005-10-21	Jussi Innanen	Ennakko: Koovee 2 - KoSBy, SU 23.10	Sunnuntaina 23.10 5.divarin aamupelissa Raholassa klo 10.00 vastakkain ovat Koovee 2 - KoSBy. Koovee 2 ylivoimaisena suosikkina voi kaatua ainoastaan "takki auki-pelailuun". Lohkon jumbo-joukkue Koskenm�en Salibandy (KoSBy) tunnetusti "kuumana" joukkueena, yritt�� minimoida j��hyns�, jos aikoo voittaa. Jos ja kun kaikki menee niin kuin pit��kin eli Koovee pelaa omalla tasollaan, ei voittajasta tule olemaan ep�selvyytt�.
1039	2005-10-25	Jussi Innanen	Aapo Repo lopettaa kakkosjoukkueessa	Puolustaja Aapo Repo lopettaa Kooveen kakkosjoukkueessa. Repo ilmoitti salibandyn lopettamis p��t�ksens� maanantaina joukkueen "puuha-miehelle" Jukka Kaartiselle. Koovee 2 jatkaa kauttaan 12 kentt�pelaajalla ja yhdell� maalivahdilla.
1041	2005-10-27	Jussi Innanen	Ennakko: KooVee 2 - SCL 29.10 LA	5.divarin Pirkanmaa 3A-lohkon kakkonen(KooVee 2) kohtaa lauantaina 29.10 klo 12 Raholassa lohko-kolmosen(SCL). Vaikka Koovee 2 onkin niukasti ylemp�n� taulukossa niin silti SC L�tty on suosikki t�ss� peliss�. Peli on t�rke� kummallekin tulevan Ylemm�n loppusarjan takia, koska keskin�isist� peleist� saavutetut pisteet j��v�t voimaan l�ht�pistein�. Mik�li tietenkin ett� sinne ensin p��see. SCL vahvistui hiukkasen viime kaudesta muutamalla pelaajalla ja pelaakin parhaillaan kontrolloivaa ja taitavaa koko viisikon salibandy�. KooVee 2:n saumat on vastaiskuissa ja kurinalaisessa puolustamisessa. Tuskin kumpikaan joukkue peli� murskaten voittaa.
1044	2005-11-02	Jussi Innanen	KooVee-joukkueiden kuvat netiss�	Kaikkien jotka olivat 25.10.05 KooVee-salibandyjoukkueiden kuvauksessa mukana Raholassa, kuvat n�kyvill� netiss� osoitteessa www.youngace.com. Paikan p��ll� valokuvaajalta saadulla kuvaustunnuksella p��see katselemaan kuvia.
1042	2005-10-30	Jussi Innanen	KooVee 2:lle t�rke� voitto SCL:st�	KooVee 2 voitti 6-3 SC L�tyn Miesten 5.divarissa hyv�ll� esityksill�. SCL piti tyylilleen uskollisena palloa suurimman osan ja py�ritti leve�ll� peli�, mutta KooVee 2 puolusti kurinalaisesti ja iski vastaiskuista hienoilla maaleilla. Oman p��n peli oli kauden parasta t�h�n saakka, eik� SCL p��ssyt kunnon tekopaikoille oikeastaan miss��n vaiheessa ottelua. T�rke� ja hieno voitto Ylemp�� jatkosarjaa ajatellen. KooVee 2:n tehomiehet olivat Juuso Koivisto 2+1, Jani Myllynen 2+0, Lauri Oksanen 2+0, Jukka Kaartinen 0+2 sek� Jaakko Ailio 0+2. Ensi viikon sunnuntaina vastaan Raholassa tulee Manse Pojat(ManPo).
1040	2005-10-30	Jussi Innanen	Singh ja Innanen poissa SCL-pelist�	T�ll� kaudella salibandyn joukkueessa aloittanut laitahy�kk��j� Jani Singh ei p��se lauantaina 29.10 5.div-peliin SC L�tty� vastaan hiusmallikeikan takia. Poissa on my�s sentteri Jussi Innanen, jolla on keuhkoputken tulehdus ja kuumetta.
\.


--
-- Data for TOC entry 124 (OID 24180)
-- Name: kayttajat; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY kayttajat (tunnus, salasana, henkilo) FROM stdin;
kaartine	85e534ea9ea10877f7a1b9ee7cfd1a03	1027
jute	b969ac75a840dc34b8d48187284fbfa1	1065
myllynen	e7e941b1f09f266540c6780db51d5f58	1067
kaartinj	85e534ea9ea10877f7a1b9ee7cfd1a03	1026
johannes	ed7efa35019db3ecd35965ddd89ee067	1024
ylihuhta	05b7f3ad5d98f0652f6cf605e5a5bd92	1029
teemu	a4a1d9d194d722987499dec4222addfd	1014
paukkio	073c46845b01e5f2245b9c240d96efac	1068
jarnomus	b31465d5d1c69f6672748f24daa514be	1021
h4jsingh	0ca785a6677d67d0228e46c3576dabfa	1069
jukka	85e534ea9ea10877f7a1b9ee7cfd1a03	1
late	f2c67381db28fa11c59fe7a6df0f2587	1047
tepe	8d27f92405ac48b02ade21689c4eafcb	2
\.


--
-- Data for TOC entry 125 (OID 24182)
-- Name: yllapitooikeudet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY yllapitooikeudet (tunnus) FROM stdin;
jukka
kaartine
tepe
\.


--
-- Data for TOC entry 126 (OID 24184)
-- Name: lisaamuokkaaoikeudet; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY lisaamuokkaaoikeudet (tunnus) FROM stdin;
jute
teemu
\.


--
-- Data for TOC entry 127 (OID 24186)
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
\.


--
-- Data for TOC entry 128 (OID 24188)
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
\.


--
-- Data for TOC entry 129 (OID 24190)
-- Name: log; Type: TABLE DATA; Schema: public; Owner: kaartine
--

COPY log (tunnus, pvm, tyyppi) FROM stdin;
\.


--
-- TOC entry 73 (OID 26285)
-- Name: yhteystieto_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY yhteystieto
    ADD CONSTRAINT yhteystieto_pkey PRIMARY KEY (yhtietoid);


--
-- TOC entry 74 (OID 26287)
-- Name: henkilo_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY henkilo
    ADD CONSTRAINT henkilo_pkey PRIMARY KEY (hloid);


--
-- TOC entry 75 (OID 26289)
-- Name: pelaaja_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaaja
    ADD CONSTRAINT pelaaja_pkey PRIMARY KEY (pelaajaid);


--
-- TOC entry 76 (OID 26291)
-- Name: tyyppi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tyyppi
    ADD CONSTRAINT tyyppi_pkey PRIMARY KEY (tyyppi);


--
-- TOC entry 77 (OID 26293)
-- Name: tapahtuma_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tapahtuma
    ADD CONSTRAINT tapahtuma_pkey PRIMARY KEY (tapahtumaid);


--
-- TOC entry 78 (OID 26295)
-- Name: halli_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY halli
    ADD CONSTRAINT halli_pkey PRIMARY KEY (halliid);


--
-- TOC entry 79 (OID 26297)
-- Name: kausi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kausi
    ADD CONSTRAINT kausi_pkey PRIMARY KEY (vuosi);


--
-- TOC entry 80 (OID 26299)
-- Name: sarjatyyppi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjatyyppi
    ADD CONSTRAINT sarjatyyppi_pkey PRIMARY KEY (tyyppi);


--
-- TOC entry 81 (OID 26301)
-- Name: seura_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY seura
    ADD CONSTRAINT seura_pkey PRIMARY KEY (seuraid);


--
-- TOC entry 82 (OID 26303)
-- Name: sarja_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarja
    ADD CONSTRAINT sarja_pkey PRIMARY KEY (sarjaid);


--
-- TOC entry 83 (OID 26305)
-- Name: joukkue_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkue
    ADD CONSTRAINT joukkue_pkey PRIMARY KEY (joukkueid);


--
-- TOC entry 84 (OID 26307)
-- Name: kaudenjoukkue_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT kaudenjoukkue_pkey PRIMARY KEY (joukkueid, kausi);


--
-- TOC entry 85 (OID 26309)
-- Name: peli_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT peli_pkey PRIMARY KEY (peliid);


--
-- TOC entry 86 (OID 26311)
-- Name: tilastomerkinta_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tilastomerkinta
    ADD CONSTRAINT tilastomerkinta_pkey PRIMARY KEY (timerkintaid);


--
-- TOC entry 87 (OID 26313)
-- Name: maali_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT maali_pkey PRIMARY KEY (maaliid);


--
-- TOC entry 88 (OID 26315)
-- Name: pelaajatilasto_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT pelaajatilasto_pkey PRIMARY KEY (tilastoid);


--
-- TOC entry 89 (OID 26317)
-- Name: toimenkuva_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimenkuva
    ADD CONSTRAINT toimenkuva_pkey PRIMARY KEY (toimenkuva);


--
-- TOC entry 90 (OID 26319)
-- Name: toimi_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimi
    ADD CONSTRAINT toimi_pkey PRIMARY KEY (kaudenjoukkue, henkilo, kausi);


--
-- TOC entry 91 (OID 26321)
-- Name: osallistuja_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY osallistuja
    ADD CONSTRAINT osallistuja_pkey PRIMARY KEY (tapahtumaid, osallistuja);


--
-- TOC entry 92 (OID 26323)
-- Name: pelaajat_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajat
    ADD CONSTRAINT pelaajat_pkey PRIMARY KEY (joukkue, pelaaja, kausi);


--
-- TOC entry 93 (OID 26325)
-- Name: sarjanjoukkueet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT sarjanjoukkueet_pkey PRIMARY KEY (sarjaid, joukkue, kausi);


--
-- TOC entry 94 (OID 26327)
-- Name: uutinen_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY uutinen
    ADD CONSTRAINT uutinen_pkey PRIMARY KEY (uutinenid);


--
-- TOC entry 95 (OID 26329)
-- Name: kayttajat_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kayttajat
    ADD CONSTRAINT kayttajat_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 96 (OID 26331)
-- Name: yllapitooikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY yllapitooikeudet
    ADD CONSTRAINT yllapitooikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 97 (OID 26333)
-- Name: lisaamuokkaaoikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY lisaamuokkaaoikeudet
    ADD CONSTRAINT lisaamuokkaaoikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 98 (OID 26335)
-- Name: joukkueenalueoikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkueenalueoikeudet
    ADD CONSTRAINT joukkueenalueoikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 99 (OID 26337)
-- Name: omattiedotoikeudet_pkey; Type: CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY omattiedotoikeudet
    ADD CONSTRAINT omattiedotoikeudet_pkey PRIMARY KEY (tunnus);


--
-- TOC entry 130 (OID 26339)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY henkilo
    ADD CONSTRAINT "$1" FOREIGN KEY (yhtieto) REFERENCES yhteystieto(yhtietoid);


--
-- TOC entry 131 (OID 26343)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaaja
    ADD CONSTRAINT "$1" FOREIGN KEY (pelaajaid) REFERENCES henkilo(hloid);


--
-- TOC entry 132 (OID 26347)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tapahtuma
    ADD CONSTRAINT "$1" FOREIGN KEY (vastuuhlo) REFERENCES henkilo(hloid);


--
-- TOC entry 133 (OID 26351)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tapahtuma
    ADD CONSTRAINT "$2" FOREIGN KEY (tyyppi) REFERENCES tyyppi(tyyppi);


--
-- TOC entry 134 (OID 26355)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY halli
    ADD CONSTRAINT "$1" FOREIGN KEY (yhtietoid) REFERENCES yhteystieto(yhtietoid);


--
-- TOC entry 135 (OID 26359)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarja
    ADD CONSTRAINT "$1" FOREIGN KEY (kausi) REFERENCES kausi(vuosi);


--
-- TOC entry 136 (OID 26363)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarja
    ADD CONSTRAINT "$2" FOREIGN KEY (tyyppi) REFERENCES sarjatyyppi(tyyppi);


--
-- TOC entry 137 (OID 26367)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkue
    ADD CONSTRAINT "$1" FOREIGN KEY (seuraid) REFERENCES seura(seuraid);


--
-- TOC entry 138 (OID 26371)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT "$1" FOREIGN KEY (joukkueid) REFERENCES joukkue(joukkueid);


--
-- TOC entry 139 (OID 26375)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT "$2" FOREIGN KEY (kausi) REFERENCES kausi(vuosi);


--
-- TOC entry 140 (OID 26379)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kaudenjoukkue
    ADD CONSTRAINT "$3" FOREIGN KEY (kotihalli) REFERENCES halli(halliid);


--
-- TOC entry 141 (OID 26383)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$1" FOREIGN KEY (peliid) REFERENCES tapahtuma(tapahtumaid);


--
-- TOC entry 142 (OID 26387)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$2" FOREIGN KEY (vierasjoukkue) REFERENCES joukkue(joukkueid);


--
-- TOC entry 143 (OID 26391)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$3" FOREIGN KEY (kotijoukkue) REFERENCES joukkue(joukkueid);


--
-- TOC entry 144 (OID 26395)
-- Name: $4; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$4" FOREIGN KEY (sarja) REFERENCES sarja(sarjaid);


--
-- TOC entry 145 (OID 26399)
-- Name: $5; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$5" FOREIGN KEY (atoimihenkilo1) REFERENCES henkilo(hloid);


--
-- TOC entry 146 (OID 26403)
-- Name: $6; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$6" FOREIGN KEY (atoimihenkilo2) REFERENCES henkilo(hloid);


--
-- TOC entry 147 (OID 26407)
-- Name: $7; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$7" FOREIGN KEY (atoimihenkilo3) REFERENCES henkilo(hloid);


--
-- TOC entry 148 (OID 26411)
-- Name: $8; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$8" FOREIGN KEY (atoimihenkilo4) REFERENCES henkilo(hloid);


--
-- TOC entry 149 (OID 26415)
-- Name: $9; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$9" FOREIGN KEY (atoimihenkilo5) REFERENCES henkilo(hloid);


--
-- TOC entry 150 (OID 26419)
-- Name: $10; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$10" FOREIGN KEY (btoimihenkilo1) REFERENCES henkilo(hloid);


--
-- TOC entry 151 (OID 26423)
-- Name: $11; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$11" FOREIGN KEY (btoimihenkilo2) REFERENCES henkilo(hloid);


--
-- TOC entry 152 (OID 26427)
-- Name: $12; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$12" FOREIGN KEY (btoimihenkilo3) REFERENCES henkilo(hloid);


--
-- TOC entry 153 (OID 26431)
-- Name: $13; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$13" FOREIGN KEY (btoimihenkilo4) REFERENCES henkilo(hloid);


--
-- TOC entry 154 (OID 26435)
-- Name: $14; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$14" FOREIGN KEY (btoimihenkilo5) REFERENCES henkilo(hloid);


--
-- TOC entry 155 (OID 26439)
-- Name: $15; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY peli
    ADD CONSTRAINT "$15" FOREIGN KEY (pelipaikka) REFERENCES halli(halliid);


--
-- TOC entry 156 (OID 26443)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tilastomerkinta
    ADD CONSTRAINT "$1" FOREIGN KEY (peliid) REFERENCES peli(peliid);


--
-- TOC entry 157 (OID 26447)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY tilastomerkinta
    ADD CONSTRAINT "$2" FOREIGN KEY (joukkueid) REFERENCES joukkue(joukkueid);


--
-- TOC entry 158 (OID 26451)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT "$1" FOREIGN KEY (maaliid) REFERENCES tilastomerkinta(timerkintaid);


--
-- TOC entry 159 (OID 26455)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT "$2" FOREIGN KEY (tekija) REFERENCES henkilo(hloid);


--
-- TOC entry 160 (OID 26459)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY maali
    ADD CONSTRAINT "$3" FOREIGN KEY (syottaja) REFERENCES henkilo(hloid);


--
-- TOC entry 161 (OID 26463)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY epaonnisrankku
    ADD CONSTRAINT "$1" FOREIGN KEY (epaonnisrankkuid) REFERENCES tilastomerkinta(timerkintaid);


--
-- TOC entry 162 (OID 26467)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY epaonnisrankku
    ADD CONSTRAINT "$2" FOREIGN KEY (tekija) REFERENCES pelaaja(pelaajaid);


--
-- TOC entry 163 (OID 26471)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY rangaistus
    ADD CONSTRAINT "$1" FOREIGN KEY (rangaistusid) REFERENCES tilastomerkinta(timerkintaid);


--
-- TOC entry 164 (OID 26475)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY rangaistus
    ADD CONSTRAINT "$2" FOREIGN KEY (saaja) REFERENCES henkilo(hloid);


--
-- TOC entry 165 (OID 26479)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT "$1" FOREIGN KEY (peliid) REFERENCES peli(peliid);


--
-- TOC entry 166 (OID 26483)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT "$2" FOREIGN KEY (joukkue) REFERENCES joukkue(joukkueid);


--
-- TOC entry 167 (OID 26487)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajatilasto
    ADD CONSTRAINT "$3" FOREIGN KEY (pelaaja) REFERENCES henkilo(hloid);


--
-- TOC entry 168 (OID 26491)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimi
    ADD CONSTRAINT "$1" FOREIGN KEY (kaudenjoukkue, kausi) REFERENCES kaudenjoukkue(joukkueid, kausi);


--
-- TOC entry 169 (OID 26495)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY toimi
    ADD CONSTRAINT "$2" FOREIGN KEY (henkilo) REFERENCES henkilo(hloid);


--
-- TOC entry 170 (OID 26499)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY osallistuja
    ADD CONSTRAINT "$1" FOREIGN KEY (tapahtumaid) REFERENCES tapahtuma(tapahtumaid);


--
-- TOC entry 171 (OID 26503)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY osallistuja
    ADD CONSTRAINT "$2" FOREIGN KEY (osallistuja) REFERENCES henkilo(hloid);


--
-- TOC entry 172 (OID 26507)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajat
    ADD CONSTRAINT "$1" FOREIGN KEY (joukkue, kausi) REFERENCES kaudenjoukkue(joukkueid, kausi);


--
-- TOC entry 173 (OID 26511)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY pelaajat
    ADD CONSTRAINT "$2" FOREIGN KEY (pelaaja) REFERENCES henkilo(hloid);


--
-- TOC entry 174 (OID 26515)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT "$1" FOREIGN KEY (sarjaid) REFERENCES sarja(sarjaid);


--
-- TOC entry 175 (OID 26519)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT "$2" FOREIGN KEY (joukkue, kausi) REFERENCES kaudenjoukkue(joukkueid, kausi);


--
-- TOC entry 176 (OID 26523)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY sarjanjoukkueet
    ADD CONSTRAINT "$3" FOREIGN KEY (kausi) REFERENCES kausi(vuosi);


--
-- TOC entry 177 (OID 26527)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY kayttajat
    ADD CONSTRAINT "$1" FOREIGN KEY (henkilo) REFERENCES henkilo(hloid);


--
-- TOC entry 178 (OID 26531)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY yllapitooikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 179 (OID 26535)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY lisaamuokkaaoikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 180 (OID 26539)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY joukkueenalueoikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 181 (OID 26543)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: kaartine
--

ALTER TABLE ONLY omattiedotoikeudet
    ADD CONSTRAINT "$1" FOREIGN KEY (tunnus) REFERENCES kayttajat(tunnus) ON DELETE CASCADE;


--
-- TOC entry 61 (OID 24036)
-- Name: yhteystieto_yhtietoid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('yhteystieto_yhtietoid_seq', 1031, true);


--
-- TOC entry 62 (OID 24043)
-- Name: henkilo_hloid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('henkilo_hloid_seq', 1070, true);


--
-- TOC entry 63 (OID 24056)
-- Name: tapahtuma_tapahtumaid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('tapahtuma_tapahtumaid_seq', 1103, true);


--
-- TOC entry 64 (OID 24064)
-- Name: halli_halliid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('halli_halliid_seq', 1016, true);


--
-- TOC entry 65 (OID 24077)
-- Name: seura_seuraid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('seura_seuraid_seq', 1027, true);


--
-- TOC entry 66 (OID 24085)
-- Name: sarja_sarjaid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('sarja_sarjaid_seq', 1003, true);


--
-- TOC entry 67 (OID 24093)
-- Name: joukkue_joukkueid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('joukkue_joukkueid_seq', 1029, true);


--
-- TOC entry 68 (OID 24102)
-- Name: kaudenjoukkue_joukkueid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('kaudenjoukkue_joukkueid_seq', 1000, true);


--
-- TOC entry 69 (OID 24110)
-- Name: peli_peliid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('peli_peliid_seq', 1003, true);


--
-- TOC entry 70 (OID 24121)
-- Name: tilastomerkinta_timerkintaid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('tilastomerkinta_timerkintaid_seq', 1362, true);


--
-- TOC entry 71 (OID 24145)
-- Name: pelaajatilasto_tilastoid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('pelaajatilasto_tilastoid_seq', 1823, true);


--
-- TOC entry 72 (OID 24172)
-- Name: uutinen_uutinenid_seq; Type: SEQUENCE SET; Schema: public; Owner: kaartine
--

SELECT pg_catalog.setval('uutinen_uutinenid_seq', 1044, true);


--
-- TOC entry 3 (OID 2200)
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


