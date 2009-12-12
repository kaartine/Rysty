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
       'Kotiosoiteja'
);

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
        'Teemu',
        'Lahtela',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'Tepe');


-- Kayttajat(@tunnus, salasana, henkilo->HENKILO(hloID))
insert into Kayttajat values(
        'tepe',
	--md5 koodattu
	md5('tepe'),
	2
	);
				
insert into Kayttajat values(
        'jukka',
        -- md5 koodattu
        md5('jukka'),
        1
);
							
							
-- Yllapito_oikeudet(@tunnus->KAYTTAJAT)
insert into
Yllapitooikeudet values(
        'tepe'
);
	
insert into Yllapitooikeudet values(
        'jukka'
);

GRANT select ON kayttajat TO "www-data";
GRANT select ON sarja TO "www-data";
GRANT select ON sarjatyyppi TO "www-data";
GRANT select ON kausi TO "www-data";
GRANT select ON henkilo TO "www-data";
GRANT select ON yhteystieto TO "www-data";
GRANT select ON sarjanjoukkueet TO "www-data";
GRANT select ON uutinen TO "www-data";
GRANT select ON omattiedotoikeudet TO "www-data";
GRANT select ON joukkueenalueoikeudet TO "www-data";
GRANT select ON yllapitooikeudet TO "www-data";
GRANT select ON osallistuja TO "www-data";
GRANT select ON joukkue TO "www-data";
GRANT select ON kaudenjoukkue TO "www-data";
GRANT select ON seura TO "www-data";
GRANT select ON pelaajatilasto TO "www-data";
GRANT select ON toimi TO "www-data";
GRANT select ON lisaamuokkaaoikeudet TO "www-data";
GRANT select, delete ON pelaajat TO "www-data";
GRANT select ON rangaistus TO "www-data";
GRANT select ON maali TO "www-data";
GRANT select ON peli TO "www-data";
GRANT select ON sarjanjoukkueet TO "www-data";
GRANT select ON tapahtuma TO "www-data";
GRANT select ON halli TO "www-data";
GRANT select ON tyyppi TO "www-data";
GRANT select ON pelaaja TO "www-data";
