<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 12.04.2005
 *
*/

require_once("lisattavaview.php");

class TapahtumanLisaysView extends LisattavaView {


    function TapahtumanLisaysView(&$arg) {
        $this->LisattavaView($arg);
    }

    /**
     * Overridden from View
     */
    function drawMiddle () {
        if ( $this->toiminto->drawForm ) {
            $this->drawOsallistujat();
            print '<br /><br /><br />';
            $this->drawForm();
        }
        else {
            print "SUCCESS?";
        }
    }

    function drawOsallistujat() {
        //isoTeksti($this->tm->getText($this->toiminto->tyyppi));
        //print '<table><tr><td valign="top">';
        print '<table><tr><th>'.$this->tm->getText("P&auml;&auml;sev&auml;t").'</th></tr>';
        $yht = 0;
        foreach($this->toiminto->osallistujat['paasee'] as $hlo) {
            print "<tr><td>$hlo[nimi]</td></tr>";
            $yht++;
        }
        print '<tr><td>'.$this->tm->getText("Yhteens&auml;").': '.$yht.'</td></tr></table>' .
        '<br /> <br /> ';
//                '</td>' .
//                '<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td valign="top">';
        //print '<br />';
        print '<table><tr><th>'.$this->tm->getText("Eiv&auml;t p&auml;&auml;se").'</th><th>'.$this->tm->getText('Selite').'</th></tr>';
       $yht = 0;
        foreach($this->toiminto->osallistujat['eipaase'] as $hlo) {
            print "<tr><td>$hlo[nimi]</td><td>$hlo[selite]</td></tr>";
            $yht++;
        }
        print '<tr><td>'.$this->tm->getText("Yhteens&auml;").': '.$yht.'</td><td></td></tr></table>' .
                '';//'</td></tr></table>';
    }
}

?>