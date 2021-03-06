<?php
/**
 * config.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: L�mmi
 * created: 27.04.2005
 *
*/

// Debug moodi
$DEBUG = TRUE;

$JOUKKUEENNIMI = 'KooVee II';
$WEBADDRESS = "127.0.0.1/~kaartine/rysty";
$HOMEDIR = "/home/koovee2";

// Tietokannan salasana
$dbuser = "dbname=rysty";

$_SESSION['defaultjoukkue'] = '1';

$_SESSION['peliaika'] = 45;

$_SESSION['defaultkausi'] = '2010';
$_SESSION['defaultsarjaid'] = '1007';

// Kuinka monta tuntia pipari muistetaan
$COOKIEHOURSTOLIVE = 24*90;

$DEFAULTLANGUAGE = 'fi';

$EMAIL = 'email: jkaartinen at gmail.com';

$CSSFILE = 'tyylitiedosto.css';

function printLocalFooter()
{?>
        <a href="http://www.pokerimarketti.fi" target="_blank">
        <img vspace="5" src="kuvat/images/pokerimarketti_banneri.gif" alt="Pokerimarketti.fi" border="1" />
&nbsp;
        <a href="http://www.skanska.fi" target="_blank">
        <img vspace="0" src="kuvat/images/skanska.gif" alt="Skanska.fi" border="0" />
        </a>
<?php
}

?>

