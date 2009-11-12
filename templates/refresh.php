<?php
/*
 * Created on Feb 18, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
$registry = &Registry::instance();

header("Location: ".$registry->getEntry('link')); /* Redirect browser */

?>
