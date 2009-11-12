<?php
/**
 * kaudenjoukkueetview.php
 * Copyright Rysty 2005:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 16.03.2005
 *
*/

require_once("listaview.php");


/**
 * class KaudenJoukkueetView
 *
 */
class KaudenJoukkueetView extends ListaView
{
    function KaudenJoukkueetView(&$arg) {

        $this->ListaView($arg);

        $this->headers = array(
            'kausi'=>$this->tm->getText('Kausi'),
            'kotipaikka'=>$this->tm->getText('Kotipaikka'),
            'kotihalli'=>$this->tm->getText('Kotihalli'),
            'kuvaus'=>$this->tm->getText('Kuvaus'),
            'kortti'=>$this->tm->getText('&nbsp;')
        );
        $this->toiminnonNimi = "kaudenjoukkueet";
    }

    function drawMiddle() {
        print '<table><tr><td class="reunat">';
        $this->toiminto->joukkuetiedot->draw(false);
        if( onkoOikeuksia('joukkueenlisays') ) {
            print '<br /><form action="index.php?toiminto=joukkueenlisays" method="post" >
                <input type="hidden" name="joukkueid" value="'.$this->toiminto->joukkueid.'"/>
                <input type="submit" name="muokkaa" value="'.$this->tm->getText("Muokkaa joukkuetta").'"/>
                </form>';
        }

        print '</td></tr></table>';

        print '<br /><br />';

        parent::drawMiddle();

        print '<br /><br />';

        if( onkoOikeuksia('kaudenjoukkueenlisays') ) {
            print '<form action="index.php?toiminto=kaudenjoukkueenlisays" method="post" >
                <input type="hidden" name="joukkueid" value="'.$this->toiminto->joukkueid.'"/>
                <input type="submit" name="uusi" value="'.$this->tm->getText("Lis&auml;&auml; kaudenjoukkue").'"/>
                </form>';
        }

    }

} // end of HenkiloView
?>


