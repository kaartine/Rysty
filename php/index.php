<?php
/**
 * translationmanager.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 11.01.2005
 *
*/
// for testing
error_reporting(E_ALL);

ini_set('include_path', '.:./inc:./view:./toiminnot:./directorylisting:./templates:./components');


// do buffering
ob_start();

// initialize sessions
ini_set("session.use_only_cookies","1");
session_start();

require_once("config.php");
require_once("controller.php");

// tätä ei pakosta tarvittais 
header ("Content-Type: text/html; charset=ISO-8859-1");

$controller = new Controller();

// template on asetettava ennen toiminnon suorittamista

$controller->setTemplate( $TEMPLATE );

$controller->processToiminto();

$controller->drawTemplate();

// end buffering
 ob_end_flush();

?>
