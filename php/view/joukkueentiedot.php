
<?php
/**
 * toiminto.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 17.04.2005
 *
*/

/**
 * class Joukkuetiedot
 *
 */
/******************************* Abstract Class ****************************
  Toiminto does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/
require_once("tietokanta.php");
require_once("toimintofactory.php");

class Joukkuetiedot
{
    var $tiedot;
    var $tm; // kielen k‰‰nt‰j‰

    function Joukkuetiedot() {
        unset($this->tiedot);
    }

    function haeTiedot($joukkueid,$kausi = NULL) {
        $db = new Tietokanta();
        $db->open();

        $this->tiedot = $db->doQuery("SELECT j.lyhytnimi, j.pitkanimi, j.kuvaus, j.maskotti, j.email, j.logo, " .
            "s.nimi, s.perustamispvm, s.lisatieto FROM Joukkue j, Seura s WHERE joukkueid = $joukkueid and j.seuraid = s.seuraid");

        if ( $kausi != NULL ) {
            $logotiedot = $db->doQuery("SELECT logo " .
                " FROM kaudenjoukkue WHERE kausi = $kausi " .
                    " and joukkueid = $joukkueid");
              if ( count($logotiedot) > 0 ) {
                $this->tiedot[0]['logo'] = $logotiedot[0]['logo'];
              }
        }
        $this->tiedot = $this->tiedot[0];

        $db->close();

        $this->tm = TranslationManager::instance();
    }

    /**
        Piirt‰‰ joukkueen tiedot
        @param border jos true niin piirt‰‰ reunat ymp‰rille muuten piirret‰‰n ilman reunoja
    */
    function draw($border = true) {

        if($border == true) {
            beginFrame();
        }
        print '<table><tr><td>';
        if ( !empty($this->tiedot['logo']) and is_file($this->tiedot['logo']) ){
            print '<img src="'.$this->tiedot['logo'].'" border="0" alt=""><br>';
        }
        print '</td><td>';
        print '<table><tr><td><font class="isoteksti">'.$this->tiedot['pitkanimi'].'</font> ('.$this->tiedot['lyhytnimi'].')</td></tr>
                <tr><td>'.$this->tiedot['email'].'</td></tr>
                <tr><td>'.$this->tm->getText('maskotti').': '.$this->tiedot['maskotti'].'</td></tr>
                <tr><td>&nbsp;</td></tr>
                <tr><td>'.$this->tm->getText('Seura:').' '.$this->tiedot['nimi'].'</td></tr>
                <tr><td>'.$this->tm->getText('Perustettu').': '.$this->tiedot['perustamispvm'].'</td></tr>
                <tr><td>'.$this->tiedot['lisatieto'].'</td></tr></table>';
        print '</td></tr></table>';
        if($border == true) {
            endFrame();
        }
    }
}

?>