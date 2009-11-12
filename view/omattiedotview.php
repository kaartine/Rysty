<?php
/*
 * Created on Apr 21, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
 require_once("lisattavaview.php");


 class OmatTiedotView extends LisattavaView
{

    function OmatTiedotView (&$arg) {
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
        print '<br />';
        print '<form action="https://'.$_SERVER['SERVER_NAME'].$_SERVER['PHP_SELF'].'" method="POST">' .
             '<input type="hidden" name="toiminto" value="salasananvaihto" />';
        //print '<a href="index.php?toiminto=salasananvaihto">';
        print '<input type="submit" name="vaihda" value="';
        $this->p('Vaihda salasana');
        print '" /></form>';
        //print '</a>';
    }
}
?>
