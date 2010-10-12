
<?php
/**
  * sarjatilastotview.php
  * Copyright Rysty 2006:
  *   Teemu Lahtela
  *   Jukka Kaartinen
  *   Teemu Siitarinen
  *
  * author: Jukka
  * created: 12.10.2006
  *
  */

require_once("view.php");

/**
 *  * class SarjaTilastotView
 *  *
 *  */
class SarjaTilastotView extends View
{
    function SarjaTilastotView(&$arg) {

        $this->View($arg);
        $this->toiminnonNimi = "sarjatilastot";

        
    }

    /**
     * Overridden from View
     */
    function drawMiddle () {
        print '<form action="index.php?toiminto=sarjatilastot" method="post">';
        print $this->toiminto->sarjat->draw();
        $label = $this->tm->getText('Valitse');
        print '<input type="submit" name="kaudenvalinta" value="'.$label .'" /></form>';
        
        print '<br />';
        print $this->toiminto->sarjatilastot->draw();
        print '<br />';
        print '<div>'.$this->tm->getText('legendsarjatilastot').'</div>';
        print '<br /><br />';
        print $this->toiminto->sarjanpelit->draw();
    }
    
 

} // end of HenkiloView
?>

