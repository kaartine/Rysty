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

require_once "view.php";

/**
 * class MultiListaView
 *
 */
class MultiListaView extends View
{

    function MultiListaView (&$arg) {
        $this->View($arg);

        /**
         * 'pelaajat' => array(
               'pelinumero'=>$this->tm->getText('#'),
               'etunimi'=>$this->tm->getText('Etunimi'),
               'sukunimi'=>$this->tm->getText('Sukunimi'),
               'pelipaikka'=>$this->tm->getText('Pelipaikka'),
               'kapteeni'=>$this->tm->getText('Kapteeni')),
           'toimihenkilot' => array(
               'etunimi'=>$this->tm->getText('Etunimi'),
               'sukunimi'=>$this->tm->getText('Sukunimi'),
               'tehtava'=>$this->tm->getText('Teht&auml;v&auml;'))
         */
        $this->headers = array();

        $this->toiminnonNimi = "";
    }


    /**
     * Override
     */
    function drawMiddle () {

        /*
        $this->drawList($this->toiminto->getData('pelaajat'),'pelaajat');

        $this->drawList($this->toiminto->getData('toimihenkilot'),'toimihenkilot');
*/

        /*print "<pre>";
        print_r($data);
        print_r($this->toiminto->links);
        print "</pre>";
        */
    }

    function drawList($data, $list) {

        if( count($data) == 0) {
            return;
        }

        $header = &$this->headers[$list];
        print '  <table> <tr>';

        foreach ($header as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order[$list] === $key ) {
                $dir = $this->toiminto->nextdirection[$list];
            }
            
            if( $this->toiminto->sorting == true ) {
                print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort'.$list.'='.$key.
                '&amp;dir='.$dir.'">'.$label.'</a></th>';
            }
            else {
                print '<th>'.$label.'</th>';
            }
        }
        print '</tr>';

        $i=0;
        foreach ($data as $rivi ) {

            print "<tr>";
            foreach ($header as $key=>$label){                
            print "<td>";

            /*if( isset($this->toiminto->links[$list][$key]) ) {
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
                print $rivi[$key];
            }

            print "</td>";
            }

            print "</tr>";
            $i++;
        }
        print "</table>";
    }

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

    /*function printLink($string, $key, $value, $list) {

        $name = $this->toiminto->links[$list][$key][0];
        print "<a href=\"?alitoiminto=".$this->toiminto->links[$list][$key][1].
        "&amp;".$name[0]."=".$value[strtolower($name[0])]."\">".$string."</a>";
    }*/

    /**  Aggregations: */

    /** Compositions: */

    /*** Attributes: ***/


} // end of PeliView
?>

