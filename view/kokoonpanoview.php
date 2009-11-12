<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 18.03.2005
 *
*/

require_once "listaview.php";

/**
 * class KokoonpanoView
 *
 */
class KokoonpanoView extends ListaView
{

    function KokoonpanoView (&$arg) {
        $this->ListaView($arg);

        $this->headers = array(
            'pelinumero'=>$this->tm->getText('#'),
            'sukunimi'=>$this->tm->getText('Sukunimi'),
            'etunimi'=>$this->tm->getText('Etunimi'),
            'pelipaikka'=>$this->tm->getText('Pelipaikka'),
            'kapteeni'=>$this->tm->getText('Kapteeni')
        );
        $this->toiminnonNimi = "kokoonpano";
    }


    /**
     * Overridden from View
     */
    function drawMiddle () {
        $data = $this->toiminto->getData();

        /*D( "<pre>");
        D($data);
        D($this->toiminto->links);
        D("</pre>");
        */

        print '  <table> <tr>';

        foreach ($this->headers as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
            $dir = $this->toiminto->nextdirection;
            }print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.
            '&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '</tr>';
        
        $i=0;
        foreach ($data as $rivi ) {
            print "<tr>";
            foreach ($this->headers as $key=>$label){
            print "<td>";

            if( isset($this->toiminto->links[$key]) ) {
                $this->printLink($rivi[$key], $key, $data[$i]);
            }
            else {
                if($key === "pelinumero" )
                    if( $rivi[$key] > 0 )
                        print $rivi[$key];
                    else
                        print "";
                else
                    print $rivi[$key];
            }

            print "</td>";
            }

            print "</tr>";
            $i++;
        }
	print '</table>';
        print '<p>'.$this->tm->getText("Yhteens&auml;").': '.$i.'</p>';
    }

    /**  Aggregations: */

    /** Compositions: */

    /*** Attributes: ***/


} // end of PeliView
?>

