<?php
/*
 * Created on Jan 16, 2005
 *
 * Created by Teemu Lahtela
 * (c) L�mmi
 */

require_once("view.php");

 class IntranetView extends View
{

    function drawMiddle () {
        include("DirectoryListing.php");
    }
}
 ?>