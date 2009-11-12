<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 22.02.2005
 *
*/

require_once "listaview.php";

/**
 * class KaudenjoukkueView
 *
 */
class MuokkaaKaudenpelaajiaView extends ListaView
{

    function MuokkaaKaudenpelaajiaView (&$arg) {
        $this->ListaView($arg);

        $this->headers = array(
               'pelinumero'=>$this->tm->getText('#'),
               'etunimi'=>$this->tm->getText('Etunimi'),
               'sukunimi'=>$this->tm->getText('Sukunimi'),
               'katisyys'=>$this->tm->getText('K&auml;tisyys'),
               'maila'=>$this->tm->getText('Maila'),
               'pelipaikka'=>$this->tm->getText('Pelipaikka'),
               'kapteeni'=>$this->tm->getText('Kapteeni'),
               'syntymaaika'=>$this->tm->getText('Syntym&auml;aika'),
               'aloituspvm'=>$this->tm->getText('aloituspvm'),
               'lopetuspvm'=>$this->tm->getText('lopetuspvm')
           );
        $this->toiminnonNimi = "muokkaakaudenpelaajia";
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
            if( $rivi['pelinumero'] <= 0)
                $pelinumero = "";
            else
                $pelinumero = $rivi['pelinumero'];
            print '<input type="text" name="pelaaja['.$rivi['pelaaja'].'][pelinumero]" value="'.$pelinumero.'" size="2" maxlength="2"/>';
            print "</td>";

            print "<td>";
            $this->printLink($rivi['etunimi'], 'etunimi', $data[$i]);
            print "</td>";

            print "<td>";
            $this->printLink($rivi['sukunimi'], 'sukunimi', $data[$i]);
            print "</td>";

            print "<td>";
            print $rivi['katisyys'];            
            print "</td>";

            print "<td>";
            print $rivi['maila'];
            print "</td>";

            print "<td>";
            print $this->toiminto->pelipaikka[$i]->draw();
            print "</td>";

            print "<td>";
            print '<input type="checkbox" name="pelaaja['.$rivi['pelaaja'].'][kapteeni]" value="'.$rivi['kapteeni'].'" '. (($rivi['kapteeni'] == "t") ? "checked" : "").' >';
            print "</td>";

            print "<td>";
            print $rivi['syntymaaika'];
            print "</td>";
            
            print "<td>";
            if( $rivi['aloituspvm'] == NULL)
                $aloituspvm = "";
            else
                $aloituspvm = $rivi['aloituspvm'];
            print '<input type="text" name="pelaaja['.$rivi['pelaaja'].'][aloituspvm]" value="'.$aloituspvm.'" size="10" maxlength="10"/>';
            print "</td>";            
            
            print "<td>";
            if( $rivi['lopetuspvm'] == NULL)
                $lopetuspvm = "";
            else
                $lopetuspvm = $rivi['lopetuspvm'];
            print '<input type="text" name="pelaaja['.$rivi['pelaaja'].'][lopetuspvm]" value="'.$lopetuspvm.'" size="10" maxlength="10"/>';
            print "</td></tr>";
            
            $i++;
         }

        print "</table>";

		print '<br />'.$this->tm->getText("Yhteens&auml;: ").''.$i.'<br />';
		
        print '<br /><input type="submit" name="paivita" value="'.$this->tm->getText("P&auml;ivit&auml; tiedot").'"/>
            </form>';
            
        $this->palaaTakaisin(array('joukkueid',$_SESSION['kaudenjoukkueid']) );
        /*print '<form action="index.php?toiminto=kaudenjoukkue" method="post" >
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

