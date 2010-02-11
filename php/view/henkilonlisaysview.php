<?php
/*
 * Created on Apr 21, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
 require_once("lisattavaview.php");
 
 
 class HenkilonLisaysView extends LisattavaView 
{

    function HenkilonLisaysView (&$arg) {
        $this->LisattavaView($arg);
        $this->formStart = '<form enctype="multipart/form-data" action="index.php" method="POST">' .
                '<input type="hidden" name="MAX_FILE_SIZE" value="900000" />';                	
    }
    function drawMiddle(){
        
        if (!empty($this->toiminto->kuva)) {
            ?>
            
  <p align="left">
  
            <?php
            print '<img src="'.$this->toiminto->kuva.'" alt="kuva" border="0" ><br>';
            ?>
</p>
            <?php
        }
        parent::drawMiddle();
    }
} 
?>
