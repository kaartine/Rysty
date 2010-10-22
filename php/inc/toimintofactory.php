<?php
/**
 * toimintofactory.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * @author: Teemu Lahtela
 * created: 13.01.2005
 *
*/

/**
 * Creates and returns a reference to a subclass of toiminto.
 * @param toiminto String
 * @return A subclass of Toiminto
 */
function &createToiminto( $toiminto ) {

    $action = 0;
    $TOIMINNOT = &getToiminnot();
    $_SESSION['onkooikeuksia'] = false; // saa katsoa mutta ei muuttaa

    // Haetaan taulukosta luokan nimi ja tiedoston nimi
    // ja luodaan uusi luokka luokan nimellä.

    if ( array_key_exists($toiminto, $TOIMINNOT ) ) {
        require_once($TOIMINNOT[$toiminto][1].'.php');
        $className = $TOIMINNOT[$toiminto][0];
        $action = new $className();
        $action->asetaNykyinenTila($toiminto);
        // jos ei oikeudet riitä niin palataan pääsivulle
        $onkoOikeuksia = checkRights($action, $TOIMINNOT[$toiminto][2]);

        if( $action->LOGGED_IN == true ) {
            if( !$onkoOikeuksia ) {
                D("KATSOMIS oikeudeyt");
                $_SESSION['onkooikeuksia'] = false; // saa katsoa mutta ei muuttaa
                $onkoOikeuksia = true;
            }
            else {
                $_SESSION['onkooikeuksia'] = true; // saa myös muuttaa
            }
        }

        if ( !$onkoOikeuksia ) {
            $action = mainPage();
            if ( array_key_exists('nimi',$_SESSION)  ) {
                $action->addError('Sulla ei oo oikeuksia kuules!!');
            }
            else {
                $action->addError('Loggaa sis&auml;lle!!');
            }
        }
    }
    else {
        // jos tulee virheellinen tilanne
        $action = mainPage();
    }

    $action->toiminnot = &array_keys($TOIMINNOT);
    return $action;
}


function &mainPage() {
        require_once('main.php');
        $action = new Main('main');
        $_SESSION['palaa'] = array('main');
        return $action;
}
/**
 * Checks if enough rights.
 */
function checkRights(&$action, $oikeudet) {
    // Jos julkista haetaan niin kaikilla on oikeudet

    if ( $oikeudet{4} === 'x' and (isset($_SESSION['oikeudet']) and $_SESSION['oikeudet'] != '') ) {
/*        print '<pre>';
        print($oikeudet);
        print '</pre>';
*/
        return TRUE;
    }

    if ( $action->LOGGED_IN or !isset($_SESSION['oikeudet']) or $_SESSION['oikeudet'] = '')
    {
        $vaaditutOikeudet = parsiOikeudet($oikeudet);
        $taulut = array('yllapitooikeudet','omattiedotoikeudet',
            'joukkueenalueoikeudet','lisaamuokkaaoikeudet');
        $tunnus = &$_SESSION['nimi'];
        $q1 = "select tunnus from yllapitooikeudet where tunnus = '$tunnus'";

        require_once('tietokanta.php');
        $kayttajanOikeudet = '-----';
        $_SESSION['oikeudet'] = '-----';
        $db = new Tietokanta();
        $db->open();
        $i=0;
        foreach ($taulut as $k ) {
            $q = "select tunnus from $k where tunnus = '$tunnus'";
            $kayttajanOikeudet[$i] = haeOikeustieto($db->doQuery($q));
            $_SESSION['oikeudet'][$i] = $kayttajanOikeudet[$i];
            $i++;
        }

        //print $_SESSION['oikeudet'];

        $db->commit();
        $db->close();

        D ('<pre>');
        D($kayttajanOikeudet).":";
        D($oikeudet);
        D('</pre>');

        // ylikäyttäjä
        if ( $kayttajanOikeudet{0} === 'x' ) {
            return TRUE;
        }

        for ($i = 0; $i < 5 ; $i++) {
            if ( $kayttajanOikeudet{$i} === 'x' and $oikeudet{$i} === 'x' ) {
                return TRUE;
            }
        }
    }

    // public sivu
    if ( $oikeudet{4} === 'x' ) {
        return TRUE;
    }

    return FALSE;
}
function haeOikeustieto (&$result) {
        if ( count($result) == 1 ) {
            if ( array_key_exists('tunnus',$result[0]) ) {
                return 'x';
            }
        }
        return '-';
}
function &parsiOikeudet(&$oikeudet) {
    $out = array();
    for ($i = 0; $i < 5 ; $i++) {
        if ( 'x' === $oikeudet{$i} ) {
            array_push($out, $i);
        }
    }
    return $out;
}

function onkoOikeuksia($toiminto) {
    $TOIMINNOT = &getToiminnot();
    $oikeudet = $TOIMINNOT[$toiminto][2];

    // public oikeudet
    if( $oikeudet{4} === 'x' ) {
        return true;
    }

    if ( isset($_SESSION['oikeudet']) and $_SESSION['oikeudet'] != '' and array_key_exists($toiminto, $TOIMINNOT ) ) {

        for ($i = 0; $i < 5 ; $i++) {
            if ( $_SESSION['oikeudet']{$i} === 'x' and $oikeudet{$i} === 'x' ) {
                return true;
            }
        }
        if( $_SESSION['oikeudet']{0} === 'x' ) {
            return true;
        }
    }
    return false;
}

function kuvaKansio ($kansio) {

    $strPath = 'kuvat/'.$kansio.'/';
    if ( makeDirs($strPath) ){
        return $strPath;
    }
    return FALSE;
}

/**
 * Luo rekursiivisesti hakmistorakenteen
 */
function makeDirs($strPath, $mode = 0775) //creates directory tree recursively
{
   return is_dir($strPath) or ( makeDirs(dirname($strPath), $mode) and mkdir($strPath, $mode) );
}
function muunnaNimi ($val) {
    return preg_replace('/[^a-z0-9_\-\.]/i', '_',$val);
}

/**
 * Generates unique id
 */
function createID() {
	if( !isset($_SESSION['IDGENERATOR']) ) {
		$_SESSION['IDGENERATOR'] = 0;
	}
	
	$id = $_SESSION['IDGENERATOR'] += 1; 
	return $id;	
}
?>
