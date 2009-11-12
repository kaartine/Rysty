<?php
/**
 * config.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Lämmi
 * created: 27.04.2005
 *
*/

/*

*/

require_once("local_config.php");

// sivupohja
$TEMPLATE = 'page.php';

// k�ytetyt kielet
// 'kieli' => 'tiedoston nimi'
$LANGUAGES = array(
   'fi' => 'fi.php',
   'en' => 'en.php');

/**
 * Links Filename with classname.
 * oikeudet m��ritelty seuraavanalaisesti:
 * string jossa viisi merkki�
 * x = kyll�
 * - = ei(kaikki muut merkit)
 * ensimm�inen  ylik�ytt�j�
 * toinen omattiedotoikeudet,
 * kolmas joukkueenalueoikeudet,
 * nelj�s  lisaamuokkaaoikeudet
 * kaikkille avoin
 */
function &getToiminnot () {
    // syntaksi ensimm�inen on luokan nimi toinen tiedoston nimi
    // $TOIMINNOT['main'][0] == luokan nimi
    // $TOIMINNOT['main'][1] == tiedoston nimi
    // $TOIMINNOT['main'][2] == vaadittavat oikeudet

    $TOIMINNOT= array(
        'main'=>array('Main','main','----x'),
        'rekisteri'=>array('Rekisteri','rekisteri','----x'),
        'login'=>array('Login','login','----x'),
        'logout'=>array('Logout','logout','----x'),
        'omattiedot'=>array('OmatTiedot','omattiedot','xx---'),
        'salasananvaihto'=>array('SalasananVaihto','salasananvaihto','xx---'),
        'pelaajatilastot'=>array('PelaajaTilastot','pelaajatilastot','----x'),
        'sarjatilastot'=>array('SarjaTilastot','sarjatilastot','----x'),
        'joukkuekortti'=>array('JoukkueKortti','joukkuekortti','----x'),
        'pelaajakortti'=>array('PelaajaKortti','pelaajakortti','----x'),
        'sarjatilastot'=>array('SarjaTilastot','sarjatilastot','----x'),
        'joukkuetilastot'=>array('JoukkueTilastot','joukkuetilastot','----x'),
        'yllapito'=>array('Yllapito','yllapito','x----'),
        'sarjanjoukkueet'=>array('SarjanJoukkueet','sarjanjoukkueet','x--x-'),
        'sarjanpelit'=>array('SarjanPelit','sarjanpelit','x--x-'),
        'lisaajoukkueita'=>array('LisaaJoukkueita','lisaajoukkueita','x--x-'),
        'joukkueenlisays'=>array('JoukkueenLisays','joukkueenlisays','x--x-'),
        //'joukkueenmuokkaus'=>array('JoukkueenLisays','joukkueenlisays','x--x-'),
        'kaudenjoukkueet'=>array('KaudenJoukkueet','kaudenjoukkueet','x--x-'),
        'kaudenjoukkueenlisays'=>array('KaudenJoukkueenlisays','kaudenjoukkueenlisays','x--x-'),
        'kaudenjoukkueenmuokkaus'=>array('KaudenJoukkueenMuokkaus','kaudenjoukkueenmuokkaus','x--x-'),
        'kokoonpano'=>array('Kokoonpano','kokoonpano','----x'),
        'hallinlisays'=>array('HallinLisays','hallinlisays','x--x-'),
        'hallit'=>array('Hallit','hallit','x-xx-'),

        'seurat'=>array('Seurat','seurat','x-xx-'),
        'seuranlisays'=>array('SeuranLisays','seuranlisays','x--x-'),
        'kaudenlisays'=>array('KaudenLisays','kaudenlisays','x--x-'),
        'tyypinlisays'=>array('TyypinLisays','tyypinlisays','x--x-'),
        'sarjatyypinlisays'=>array('SarjaTyypinLisays','sarjatyypinlisays','x--x-'),
        'toimenlisays'=>array('ToimenLisays','toimenlisays','x--x-'),

        'kaudenjoukkue'=>array('Kaudenjoukkue','kaudenjoukkue','x--x-'),
        // HUOM!!!! jos haluaa antaa oikeudet muokata, lis�t� kauden pelaajia niin tarvitsee antaa oikeudet my�s
        // muokata kaudenjoukkuetta!!!!
        'muokkaakaudenpelaajia'=>array('MuokkaaKaudenpelaajia','muokkaakaudenpelaajia','x--x-'),
        'muokkaatoimihenkiloita'=>array('MuokkaaToimihenkiloita','muokkaatoimihenkiloita','x--x-'),
        'lisaapelaajia'=>array('LisaaPelaajia','lisaapelaajia','x--x-'),
        'lisaatoimihenkiloita'=>array('LisaaToimiHenkiloita','lisaatoimihenkiloita','x--x-'),

        'pelit'=>array('Pelit','pelit','----x'),
        'pelinlisays'=>array('PelinLisays','pelinlisays','x--x-'),
        'pelitilastot'=>array('PeliTilastot','pelitilastot','----x'),

        'tapahtumat'=>array('Tapahtumat','tapahtumat','x-xx-'),
	'tapahtumanlisays'=>array('TapahtumanLisays','tapahtumanlisays','x--x-'),

        'sarjat'=>array('Sarjat','sarjat','x-xx-'),
        'sarjanlisays'=>array('SarjanLisays','sarjanlisays','x--x-'),
        'sarjanmuokkaus'=>array('SarjanLisays','sarjanlisays','x--x-'),
        'henkilonlisays'=>array('HenkilonLisays','henkilonlisays','x--x-'),
        'henkilonmuokkaus'=>array('HenkilonLisays','henkilonlisays','x--x-'),
        'joukkueet'=>array('Joukkueet','joukkueet','x-xx-'),

        'kayttajat'=>array('Kayttajat','kayttajat','x----'),
        'kayttajanlisays'=>array('KayttajanLisays','kayttajanlisays','x----'),

        'henkilot'=>array('Henkilot','henkilot','x--x-'),
        'uutiset'=>array('Uutiset','uutiset','x-xx-'),
        'uutislista'=>array('UutisLista','uutislista','----x'),
        'tuloksenlisays'=>array('TuloksenLisays','tuloksenlisays','x--x-'),

        'intranet'=>array('Intranet','intranet','--xx-')
        );
    return $TOIMINNOT;
}

/**
 * Palauttaa luokan nimen perusteella ID:n. 
 */
function getID( $className ) {
    
    // Alustus
    if( !isset($_SESSION['ID']) ) {
        $_SESSION['ID'] = 1;
    }
    
    if( !isset($_SESSION[$className.'ID']) ) {
        $_SESSION[$className.'ID'] = $_SESSION['ID'];
        $_SESSION['ID'] += 1;
    }
 
    return $_SESSION[$className.'ID'];
}
?>
