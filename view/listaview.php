<?php
/**
 * listaview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 26.01.2005
 *
*/


require_once("view.php");
/**
 * class JoukkueView
 *
 */
class ListaView extends View
{
    var $headers;
    var $toiminnonNimi;
    var $tyhjat; // piirretäänkä tyhjät listat

    function ListaView(&$arg){
        $this->View($arg);
        unset($this->headers);
        unset($this->toiminnonNimi);

        $this->piirratyhjat = false;
        $this->tyhjat = false;
    }

    /**
     * Overridden from View
     */
    function drawMiddle () {
        $data = $this->toiminto->getData();
        $align = "";

        if( count($data) == 0 and !$this->tyhjat ) {
            return;
        }

        print '  <table> <tr>';

        foreach ($this->headers as $key=>$label){
            $dir = 'asc';

            if( is_array($label) ) {
                $label = $label[0];
            }

            if ( $this->toiminto->order === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            else if( $this->toiminto->omasort === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.'&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        //print '<th>&nbsp;</th></tr>';

        $i=0;
        foreach ($data as $rivi )    {
            print "<tr>";
            foreach ($this->headers as $key=>$label){
                $width = '';
                if( is_array($label) ) {
                    if( isset($label[1]) ) {
                        $align = "align=\"$label[1]\"";
                    }
                    if( isset($label[2]) ) {
                        $width = "width=\"$label[2]\"";
                    }
                    $label = $label[0];
                }

                print "<td $align $width>";

                // monta osaa datassa
                if( isset($this->toiminto->links[$key][2]) and is_array($this->toiminto->links[$key][0]) ) {
                    $this->printLink2($this->tm->getText($key), $key, $data[$i]);
                }
                else if( isset($this->toiminto->links[$key]) and is_array($this->toiminto->links[$key][0]) ) {
                    $this->printLink2($rivi[$key], $key, $data[$i]);
                }
                else if( isset($this->toiminto->links[$key][2]) ) {
                    $this->printLink($this->tm->getText($key), $key, $data[$i]);
                }
                else if( isset($this->toiminto->links[$key]) and isset($rivi[$key]) ) {
                    $this->printLink($rivi[$key], $key, $data[$i]);
                }
                else if( isset($rivi[$key]) ) {
                    print $rivi[$key];
                }

                print "</td>";
            }
            print "</tr>";
            $i++;
        }
            print "</table>";

    }

    function printLink2($string,$key, $data) {
        $values = "";
        foreach( $this->toiminto->links[$key][0] as $i) {
            $name = $i;
            $value = strtolower($data[strtolower($name)]);
            $values .= "&amp;".$name."=".$value;
        }
        print "<a href=\"?toiminto=".$this->toiminto->links[$key][1].
            $values."\">".$string."</a>";
    }

    function printLink($string, $key, $value) {
        $name = $this->toiminto->links[$key][0];
        print "<a href=\"?toiminto=".$this->toiminto->links[$key][1].
        "&amp;".$name."=".$value[strtolower($name)]."\">".$string."</a>";
    }

    function piirraTyhjat() {
        $this->tyhjat = true;
    }

} // end of JoukkueView
?>