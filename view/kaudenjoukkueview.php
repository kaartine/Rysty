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

require_once "multilistaview.php";

/**
 * class KaudenjoukkueView
 *
 */
class KaudenjoukkueView extends MultiListaView
{

    function KaudenjoukkueView (&$arg) {
        $this->MultiListaView($arg);

        $this->headers = array(
            'pelaajat'=>array(
               'pelinumero'=>$this->tm->getText('#'),
               'etunimi'=>$this->tm->getText('Etunimi'),
               'sukunimi'=>$this->tm->getText('Sukunimi'),
               'katisyys'=>$this->tm->getText('K&auml;tisyys'),
               'maila'=>$this->tm->getText('Maila'),
               'pelipaikka'=>$this->tm->getText('Pelipaikka'),
               'syntymaaika'=>$this->tm->getText('Syntym&auml;aika'),
               'kapteeni'=>$this->tm->getText('Kapteeni'),
               'aloituspvm'=>$this->tm->getText('aloituspvm'),
               'lopetuspvm'=>$this->tm->getText('lopetuspvm')),
           'toimihenkilot'=>array(
                'etunimi'=>$this->tm->getText('Etunimi'),
                'sukunimi'=>$this->tm->getText('Sukunimi'),
                'toimi'=>$this->tm->getText('Toimi'))
           );
        $this->toiminnonNimi = "kaudenjoukkue";
    }


    /**
     * Overridden from View
     */
    function drawMiddle () {
        
        beginFrame();    
        $this->drawJoukkue();
        if( onkoOikeuksia('kaudenjoukkueenmuokkaus') ) {
            print '<br /><form action="index.php?alitoiminto=kaudenjoukkueenmuokkaus" method="post" >
            <input type="hidden" name="kausi" value="'.$_SESSION['kausi'].'" />
            <input type="hidden" name="joukkueid" value="'.$_SESSION['kaudenjoukkueid'].'"
            <input type="submit" name="muokkaa" value="'.$this->tm->getText("Muokkaa kaudenjoukkuetta").'"/>
            </form>';
        }            
        endFrame();  
        
        print '<br><br><br><br>';

        $pelaajasuodatin = "";
        print $this->tm->getText('Pelaajat:');
        $this->drawList($this->toiminto->getData('pelaajat'),'pelaajat',&$pelaajasuodatin);

        $toimisuodatin = "";
        print "<br>";
        print $this->tm->getText('Toimihenkil&ouml;t:');
        $this->drawList($this->toiminto->getData('toimihenkilot'),'toimihenkilot',&$toimisuodatin);


        print '<br /><table><tr><td>';
        if( onkoOikeuksia('muokkaakaudenpelaajia') ) {
            print '<form action="index.php?alitoiminto=muokkaakaudenpelaajia" method="post" >
                <input type="submit" name="send" value="'.$this->tm->getText("Muokkaa pelaajia").'"/>
                </form>';
        }

        if( onkoOikeuksia('lisaapelaajia') ) {
            print '<form action="index.php" method="post" >' .
                '<input type="hidden" name="palaa" value="true" />' .
                '<input type="hidden" name="toiminto" value="'.$this->toiminnonNimi.'"/>' .
                '<input type="hidden" name="seuraava" value="lisaapelaajia"/>' .
                '<input type="hidden" name="suodatin" value="'.$pelaajasuodatin.'"/> ' .
                '<input type="submit" name="send" value="'.$this->tm->getText("Lis&auml;&auml; pelaajia").'"/> '.
                '</form>';
        }
        print '</td><td>';

        if( onkoOikeuksia('muokkaatoimihenkiloita') ) {
            print '<form action="index.php?alitoiminto=muokkaatoimihenkiloita" method="post" >
                <input type="submit" name="send" value="'.$this->tm->getText("Muokkaa toimihenkiloita").'"/>
                </form>';
        }
        
        if( onkoOikeuksia('lisaatoimihenkiloita') ) {
            print '<form action="index.php?toiminto=lisaatoimihenkiloita" method="post" >' .
                '<input type="hidden" name="suodatin" value="'.$toimisuodatin.'"/>' .
                '<input type="submit" name="send" value="'.$this->tm->getText("Lis&auml;&auml; toimihenkiloita").'"/> '.
                '</form>';
        }

        print '</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr>';

        print '<tr><td>';

        if( onkoOikeuksia('henkilonlisays') ) {
            print '<form action="index.php" method="post" >' .
                '<input type="hidden" name="palaa" value="true" />' .
                '<input type="hidden" name="toiminto" value="'.$this->toiminnonNimi.'"/>' .
                '<input type="hidden" name="seuraava" value="henkilonlisays"/>' .
                '<input type="submit" name="send" value="'.$this->tm->getText("Lis&auml;&auml; uusi henkil&ouml;").'"/> '.
                '</form>';
        }

        print '</td></tr></table>';
    }

    function drawList($data, $list, $suodatin) {
        
        if( count($data) == 0) {
            print "<br>".$this->tm->getText('Ei ole listattu.')."<br><br>";
            return;
        }

        $header = &$this->headers[$list];
        print '  <table> <tr>';

        foreach ($header as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order[$list] === $key ) {
                $dir = $this->toiminto->nextdirection[$list];
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort'.$list.'='.$key.
            '&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '<th>&nbsp;</th></tr>';

        if($list === 'pelaajat')
            $role = 'pelaaja';
        else
            $role = 'henkilo';

        $i=0;
        foreach ($data as $rivi ) {

            print "<tr>";
            foreach ($header as $key=>$label){
                print "<td>";

                if( isset($this->toiminto->links[$list][$key]) ) {
                    $this->printLink($rivi[$key], $key, $data[$i],$list);
                }
                else {
                    if($key === 'pelinumero' ) {
                        if( $rivi[$key] > 0 ) {
                            print $rivi[$key];
                        }
                        else {
                            print "";
                        }
                    }
                    else {
                        print $rivi[$key];
                    }
                }
                print "</td>";


            }

            print "<td>";
            
            if( onkoOikeuksia('kaudenjoukkue') ) {
                print '<form action="index.php?toiminto=kaudenjoukkue" method="post" >
                    <input type="hidden" name="'.$role.'" value="'.$rivi[$role].'" />
                    <input type="hidden" name="joukkue" value="'.$rivi['joukkue'].'" />
                    <input type="hidden" name="poista" value="1" />
                    <input type="hidden" name="samarefresh" value="1" />
                    <input type="submit" name="send" value="'.$this->tm->getText("Poista").'"/>
                    </form>';
            }
            
            print "</td>";

            print "</tr>";
            $i++;

            $suodatin .= "$rivi[pelaaja],";
        }
        print "</table>";

        // Poistaa viimeisen pilkun
        $suodatin = substr($suodatin,0,-1);
    }
    
    function drawJoukkue() {
       
        $tiedot = &$this->toiminto->kjoukkue;      
        print '<table><tr><td>';
        if ( !empty($tiedot['logo']) and is_file($tiedot['logo']) ){                
            print '<img src="'.$tiedot['logo'].'" alt="logo" border="0" ><br>';
        }        
        print '</td><td>';           
        print '<table><tr><td><font class="isoteksti">'.$tiedot['pitkanimi'].'</font> ('.$tiedot['lyhytnimi'].') '.$tiedot['kausi'].'</td></tr>
                <tr><td>';
        if ( !empty($tiedot['kuva']) and is_file($tiedot['kuva']) ) {
            print  '<a href="'.$tiedot['kuva'].'">' .
                        $this->tm->getText('Ryhm&auml;kuva').'</a></td></tr>';
        }
            print'<tr><td>&nbsp;</td></tr>
                <tr><td>'.$this->tm->getText('kotipaikka').': '.$tiedot['kotipaikka'].'</td></tr>' .
                '<tr><td>'.$this->tm->getText('kotihalli').': '.$tiedot['kotihalli'].'</td></tr>
                <tr><td>'.$tiedot['kuvaus'].'</td></tr></table>';
        print '</td></tr></table>';                               
    }

    /**  Aggregations: */

    /** Compositions: */

    /*** Attributes: ***/


} // end of PeliView
?>

  
  
