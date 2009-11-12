<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 22.03.2005
 *
*/

require_once "listaview.php";

/**
 * class KaudenjoukkueView
 *
 */
class MuokkaaToimihenkiloitaView extends ListaView
{

    function MuokkaaToimihenkiloitaView (&$arg) {
        $this->ListaView($arg);

        $this->headers = array(              
               'etunimi'=>$this->tm->getText('Etuimi'),
               'sukunimi'=>$this->tm->getText('Sukuimi'),
               'toimi'=>$this->tm->getText('Toimi')               
           );
        $this->toiminnonNimi = "muokkaatoimihenkiloita";
    }


    /**
     * Overridden from View
     */
    function drawMiddle () {
        $data = $this->toiminto->getData();

        /*
        D( "<pre>");
        D($data);
        D($this->toiminto->links);
        D("</pre>");
        */

        print '<form action="index.php?toiminto='.$this->toiminnonNimi.'" method="post" >'.
                '<table> <tr>';

        foreach ($this->headers as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
            $dir = $this->toiminto->nextdirection;
            }print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.
            '&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '</tr>';

        $i=0;
        foreach ($data as $rivi )    {
            print "<tr>";
   
            print "<td>";
            $this->printLink($rivi['etunimi'], 'etunimi', $data[$i]);
            
            print "</td>";

            print "<td>";
            $this->printLink($rivi['sukunimi'], 'sukunimi', $data[$i]);
            print "</td>";

            print "<td>";            
            print $this->toiminto->toimenkuva[$i]->draw();
            print "</td>";
            
             $i++;
         }

        print "</table>";

        print '<br /><br /><input type="submit" name="paivita" value="'.$this->tm->getText("P&auml;ivit&auml; tiedot").'"/>
            </form>';
            
        $this->palaaTakaisin(array('joukkueid',$_SESSION['kaudenjoukkueid']) );
        /*
        print '<form action="index.php?toiminto=kaudenjoukkue" method="post" >
            <input type="hidden" name="joukkueid" value="'.$_SESSION['kaudenjoukkueid'].'"/>   
            <input type="submit" name="takaisin" value="'.$this->tm->getText("Takaisin").'"/>
            </form>';
            */                   
    }

    /**  Aggregations: */

    /** Compositions: */

    /*** Attributes: ***/


} // end of PeliView
?>

