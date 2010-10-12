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
class JoukkueKorttiView extends MultiListaView
{

    function JoukkueKorttiView (&$arg) {
        $this->MultiListaView($arg);

        $this->headers = array( 
            'pelaajat' => array(
               'pelinumero'=>$this->tm->getText('#'),
               'etunimi'=>$this->tm->getText('Etunimi'),
               'sukunimi'=>$this->tm->getText('Sukunimi'),
               'pelipaikka'=>$this->tm->getText('Pelipaikka'),
               'kapteeni'=>$this->tm->getText('Kapteeni')),
           'toimihenkilot' => array(               
               'etunimi'=>$this->tm->getText('Etunimi'),
               'sukunimi'=>$this->tm->getText('Sukunimi'),
               'tehtava'=>$this->tm->getText('Teht&auml;v&auml;'))               
         );
           
        $this->toiminnonNimi = "joukkuekortti";
    }


    /**
     * Overridden from View
     */
    function drawMiddle () {
        
        $joukkue = &$this->toiminto->dataJoukkue;
        
        beginFrame();
        print '<table><tr><td>';
        if ( !empty($joukkue['logo']) and is_file($joukkue['logo'])){
            print '<img src="'.$joukkue['logo'].'" border="0" ><br>';
        }                
        print '</td><td>';               
        print '<table border=0><tr><td><font class="isoteksti">'.$joukkue['pitkanimi'].'</font> ('.$joukkue['lyhytnimi'].')</td>' .
                '<td rowspan="6" width="100px" align="right">';
        if ( !empty($joukkue['kuva'] ) and is_file($joukkue['kuva']) ) {
                 print '<a href="'.$joukkue['kuva'].'"><img src="kuvat/camera.gif" border="0" width="40" hight="40" >' .
                 		'</a></td></tr>';
                        //$this->tm->getText('Ryhm&auml;kuva').'
                 print '';
        }
        print '<tr><td>&nbsp;</td></tr>'.                
                '<tr><td>'.$joukkue['email'].'</td></tr>' .
                '<tr><td>'.$this->tm->getText('maskotti').': '.$joukkue['maskotti'].'</td></tr>' .
                '<tr><td>'.$this->tm->getText('Kotiluola').": ".$joukkue['kotihalli'].'<br>' .
                '<tr><td>&nbsp;</td></tr>' .
                '<tr><td>'.$joukkue['kuvaus'].'</td></tr></table>';
        print '</td></tr></table>';                   
        endFrame();
               
        print "<br>";
        print "<br>";
        print $this->tm->getText('Pelaajat:');
        $this->drawList($this->toiminto->getData('pelaajat'),'pelaajat');
        
        print "<br>";
        print $this->tm->getText('Toimihenkil&ouml;t:');
        $this->drawList($this->toiminto->getData('toimihenkilot'),'toimihenkilot');

        /*D( "<pre>");
        D($data);
        D($this->toiminto->links);
        D("</pre>");
        */
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
            '&amp;dir='.$dir.'&amp;kausi='.$_REQUEST['kausi'].'&amp;joukkueid='.$_REQUEST['joukkueid'].'">'.$label.'</a></th>';
        }
        print '</tr>';
        
        $i=0;
        foreach ($data as $rivi ) {
            
            print "<tr>";
            foreach ($header as $key=>$label){
            print "<td>";

            /*
            if( isset($this->toiminto->links[$list][$key]) ) {                
                $this->printLink($rivi[$key], $key, $data[$i],$list);                
            }*/
            // monta osaa datassa
            if( isset($this->toiminto->links[$list][$key][2]) and is_array($this->toiminto->links[$list][$key][0]) ) {
                $this->printLink($this->tm->getText($key), $key, $data[$i], $list);                
            }
            else if( isset($this->toiminto->links[$list][$key]) and is_array($this->toiminto->links[$list][$key][0]) ) {
                $this->printLink($rivi[$key], $key, $data[$i],$list);                
            }
            else {
                if($key === "pelinumero" ) {
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

            print "</tr>";
            $i++;
        }
        print "</table>";
    }
    
    /*
    function printLink($string, $key, $value, $list) {
        
        $name = $this->toiminto->links[$list][$key][0];        
        print "<a href=\"?alitoiminto=".$this->toiminto->links[$list][$key][1].
        "&amp;".$name[0]."=".$value[strtolower($name[0])]."\">".$string."</a>";
    }
    */
    function printLink($string,$key, $data, $list) {
        $values = "";
        foreach( $this->toiminto->links[$list][$key][0] as $i) {
            $name = $i;
            $value = strtolower($data[strtolower($name)]);
            $values .= "&amp;".$name."=".$value;
        }
        print "<a href=\"?alitoiminto=".$this->toiminto->links[$list][$key][1].
            $values."\">".$string."</a>";
    }

    /**  Aggregations: */

    /** Compositions: */

    /*** Attributes: ***/


} // end of PeliView
?>

