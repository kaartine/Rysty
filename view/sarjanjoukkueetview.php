<?php
/**
 * sarjanjoukkueetview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 30.03.2005
 *
*/

require_once "listaview.php";

/**
 * class SarjanJoukkueetView
 *
 */
class SarjanJoukkueetView extends ListaView
{

    function SarjanJoukkueetView (&$arg) {
        $this->ListaView($arg);

        $this->headers = array(
           'lyhytnimi'=>$this->tm->getText('Lyhytnimi'),
           'pitkanimi'=>$this->tm->getText('Pitk&auml;nimi')
        );
        $this->toiminnonNimi = "sarjanjoukkueet";
    }


    /**
     * Overridden from View
     */
    function drawMiddle () {
        
        print '<form action="index.php?toiminto=sarjanjoukkueet" method="post">';
 //       print $this->toiminto->kaudet->draw();
        print $this->toiminto->sarjat->draw();
        $label = $this->tm->getText('Valitse');        
        print '<input type="submit" name="kaudenvalinta" value="'.$label.'" /></form>';
    
        $suodatin = array('joukkue'=>"",'kausi'=>'');
        $this->drawList(&$this->toiminto->data,&$suodatin);
               
        print '<form action="index.php" method="post" >' .
            '<input type="hidden" name="palaa" value="true" />' .
            '<input type="hidden" name="toiminto" value="'.$this->toiminnonNimi.'"/>' .
            '<input type="hidden" name="seuraava" value="lisaajoukkueita"/>' .
            '<input type="hidden" name="kausisuodatin" value="'.$suodatin['kausi'].'"/> ' .
            '<input type="hidden" name="joukkuesuodatin" value="'.$suodatin['joukkue'].'"/> ' .
            '<input type="submit" name="send" value="'.$this->tm->getText("Lis&auml;&auml; joukkueita").'"/> '.
            '</form>';
      }
        
    function drawList($data, $suodatin) {
        
        $header = &$this->headers;
        print '  <table> <tr>';

        foreach ($header as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.
            '&amp;dir='.$dir.'">'.$label.'</a></th>';
        }        
        print '<th>&nbsp;</th></tr>';
               
               
        $i=0;
        foreach ($data as $rivi ) {
            
            print "<tr>";
            foreach ($header as $key=>$label){
                print "<td>";
    
                    print $rivi[$key];

                print "</td>";
            }
            
            print "<td>";
            print '<form action="index.php?toiminto=sarjanjoukkueet" method="post" >' .
                '<input type="hidden" name="joukkue" value="'.$rivi['joukkue'].'" />' .
                '<input type="hidden" name="kausi" value="'.$rivi['kausi'].'" />' .
                '<input type="hidden" name="sarjaid" value="'.$rivi['sarjaid'].'" />' .
                '<input type="hidden" name="poista" value="1" />' .
                '<input type="hidden" name="samarefresh" value="1" />' .
                '<input type="submit" name="send" value="'.$this->tm->getText("Poista").'"/>' .
                '</form>';
            print "</td>";
            
            print "</tr>";
            $i++;
            
            $suodatin['joukkue'] .= "$rivi[joukkue],";
            $suodatin['kausi'] .= "$rivi[kausi],";
        }
        print "</table>";
        
        // Poistaa viimeisen pilkun
        $suodatin['joukkue'] = substr($suodatin['joukkue'],0,-1);
        $suodatin['kausi'] = substr($suodatin['kausi'],0,-1);
    }

    /**  Aggregations: */

    /** Compositions: */

    /*** Attributes: ***/


} // end of PeliView
?>

