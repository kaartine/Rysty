<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 20.03.2005
 *
*/

require_once "multilistaview.php";

/**
 * class KokoonpanoView
 *
 */
class PelaajaKorttiView extends MultiListaView
{

    function PelaajaKorttiView (&$arg) {
        $this->MultiListaView($arg);

        $this->headers = array( 
            'tehot' => array(
               'sarjannimi'=>$this->tm->getText('Sarja'),               
               'ottelut'=>$this->tm->getText('Ottelut'),
               'maalit'=>$this->tm->getText('Maalit'),
               'syotot'=>$this->tm->getText('Sy&ouml;t&ouml;t'),
               'pisteet'=>$this->tm->getText('Pisteet'),
               'plusmiinus'=>$this->tm->getText('+/-'),
               'joukkue'=>$this->tm->getText('Joukkue'),
               'aloituspvm'=>$this->tm->getText('aloituspvm'),
               'lopetuspvm'=>$this->tm->getText('lopetuspvm')),
           'jaahyt' => array(               
               'sarjannimi'=>$this->tm->getText('Sarja'),
               'k'=>$this->tm->getText('2'),
               'v'=>$this->tm->getText('5'),
               'kym'=>$this->tm->getText('10'),
               'kk'=>$this->tm->getText('20'),
               'yht'=>$this->tm->getText('Yhteens&auml;'))               
         );
           
        $this->toiminnonNimi = "pelaajakortti";
    }


    /**
     * Overridden from View
     */
    function drawMiddle () {
     
        $pelaaja = &$this->toiminto->dataPelaaja;
        $henkilo = &$this->toiminto->dataHenkilo;
        ?>
  <table>
    <tr>
      <td>
      <?php
      
        if ( empty($henkilo['kuva']) or !is_file( $henkilo['kuva'] )) {
            $henkilo['kuva'] = 'kuvat/missing_kuva.jpg';
        }        
        print ' <img src="'.$henkilo['kuva'].'" alt="kuva" border="0" width="200" height="200" ><br><br>';
        print '</td><td>';
        print '<b>'.$this->tm->getText('Nimi').":</b> ".$henkilo['etunimi']." ".$henkilo['sukunimi']."<br>";
        print '<b>'.$this->tm->getText('Syntym&auml;aika').":</b> ".$henkilo['syntymaaika']."<br>";
        print '<b>'.$this->tm->getText('Paino').":</b> ".($henkilo['paino']>0?$henkilo['paino']/1000:'')."<br>";
        print '<b>'.$this->tm->getText('Pituus').":</b> ".$henkilo['pituus']."<br>";
        print '<b>'.$this->tm->getText('Kuvaus').":</b> ".$henkilo['kuvaus']."<br>";
        print '<b>'.$this->tm->getText('Lempinimi').":</b> ".$henkilo['lempinimi']."<br>";
        
        if( count($pelaaja) > 0) {
            print '<b>'.$this->tm->getText('Maila').":</b> ".$pelaaja['maila']."<br>";
            print '<b>'.$this->tm->getText('K&auml;tisyys').":</b> ".$pelaaja['katisyys']."<br>";
        }
      //  print $this->tm->getText('').": ".$pelaaja['']."<br>";
      ?>            
      </td>
    </tr>
  </table>
        <?php
              
        print "<br>";
        print "<br>";
        $this->heading( $this->tm->getText('Pisteet:') );
        $this->drawList($this->toiminto->getData('tehot'),'tehot');
        
        print "<br>";
        $this->heading( $this->tm->getText('J&auml;&auml;hyt:') );
        $this->drawList($this->toiminto->getData('jaahyt'),'jaahyt');

        /*D( "<pre>");
        D($data);
        D($this->toiminto->links);
        D("</pre>");
        */
        
        print '<br />';
        print '<br />';
        $this->palaaTakaisin();
    }

    function drawList($data, $list) {
        
        $header = &$this->headers[$list];
        print '  <table> <tr>';

        foreach ($header as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order[$list] === $key ) {
                $dir = $this->toiminto->nextdirection[$list];
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort'.$list.'='.$key.
            '&amp;dir='.$dir.'&amp;joukkueid='.$_REQUEST['joukkueid'].'&amp;pelaaja='.$_REQUEST['pelaaja'].'">'.$label.'</a></th>';
        }
        print '</tr>';
        
        if( $list == 'tehot') {
            $ottelut = 0;
            $pisteet = 0;
            $maalit = 0;
            $syotot = 0;
            $plusmiinus = 0;    
        }
        else {
            $k = 0;
            $v = 0;
            $kym = 0;
            $kk = 0;
            $yht = 0;
        }
        
        $i=0;
        foreach ($data as $rivi ) {
            
            print "<tr>";
            foreach ($header as $key=>$label){
                print "<td>";
    
                if( isset($this->toiminto->links[$list][$key]) ) {                
                    $this->printLink($rivi[$key], $key, $data[$i],$list);                
                }
                else {
                    if($key === "sarja" ) {
                        if( $rivi[$key] > 0 ) {
                            print $rivi['kausi'].' '.$rivi['sarja'].' '.$rivi['nimi'];
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
            print "</tr>";
            
            if( $list == 'tehot') {
                $ottelut += $rivi['ottelut'];
                $pisteet += $rivi['pisteet'];
                $maalit += $rivi['maalit'];
                $syotot += $rivi['syotot'];
                $plusmiinus += $rivi['plusmiinus'];
            }
            else {
                $k += $rivi['k'];;
                $v += $rivi['v'];;
                $kym += $rivi['kym'];
                $kk += $rivi['kk'];
                $yht += $rivi['yht'];
            }
            
            $i++;
        }
        if( $list == 'tehot') {
            print "<tr><td class=\"lastrow\">".$this->tm->getText('Yhtees&auml;')."</td><td class=\"lastrow\">$ottelut</td><td class=\"lastrow\">$maalit</td><td class=\"lastrow\">$syotot</td>" .
                "<td class=\"lastrow\">$pisteet</td><td class=\"lastrow\">$plusmiinus</td><td class=\"lastrow\">&nbsp;</td><td class=\"lastrow\">&nbsp;</td><td class=\"lastrow\">&nbsp;</td></tr>";
        }
        else {
            print "<tr><td class=\"lastrow\">".$this->tm->getText('Yhtees&auml;')."</td><td class=\"lastrow\">$k</td><td class=\"lastrow\">$v</td><td class=\"lastrow\">$kym</td>" .
                "<td class=\"lastrow\">$kk</td><td class=\"lastrow\">$yht</td></tr>";
        }
        print "</table>";
    }
    
    function printLink($string, $key, $value, $list) {
        
        $name = $this->toiminto->links[$list][$key][0];        
        print "<a href=\"?alitoiminto=".$this->toiminto->links[$list][$key][1].
        "&amp;".$name[0]."=".$value[strtolower($name[0])]."\">".$string."</a>";
    }

    /**  Aggregations: */

    /** Compositions: */

    /*** Attributes: ***/


} // end of PeliView
?>

