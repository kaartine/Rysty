<?php
/*
 * Created on Jan 16, 2005
 *
 * Created by Teemu Lahtela
 * (c) L�mmi
 */
  require_once("intranetview.php");
  require_once("toiminto.php");
  
 class Intranet extends Toiminto {
    
    function Intranet() {
        $this->Toiminto('intranet');
    }
    
    function suorita( )
    {
        $this->createView("IntranetView");
        
    }    
 }
?>
