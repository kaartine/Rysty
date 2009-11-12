<?php
/**
 * henkiloview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: %date%
 *
*/

require_once("listaview.php");


/**
 * class PelitView
 *
 */
class PelitView extends ListaView
{
    function PelitView(&$arg) {

        $this->ListaView($arg);

        $this->headers = array(
            'kotijoukkue'=>array($this->tm->getText('Kotijoukkue'),'right'),
            'lopputulos'=>array($this->tm->getText('Lopputulos'),'center'),
            'vierasjoukkue'=>array($this->tm->getText('Vierasjoukkue'),'left'),
            'pvm'=>array($this->tm->getText('Pvm'), 'center',170),
            'halli'=>$this->tm->getText('Halli'),
            'sarja'=>$this->tm->getText('Sarja')
            
        );

        if( onkoOikeuksia('tuloksenlisays') ) {
            $this->headers['lisaa'] = '';
        }

        $this->toiminnonNimi = "pelit";
    }
    function drawPage() {
        $this->link('menneetpelit');
        print ' | ';
        $this->link('tulevatpelit');
        print ' | ';
        $this->link('kaikkipelit');
        print ' <br><br> ';
        parent::drawPage();
    }

    /**
     * Overridden from Lista
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
                else {
                    if( $key == 'lisaa' ) {
                        $name = '';
                        if( $rivi['lopputulos'] != '' ) {
                            $name = 'muokkaa';
                        }
                        else {
                            $name = 'lisaa';
                        }
                        $this->printLink($this->tm->getText($name), $key,$data[$i]);
                    }
                }

                print "</td>";
            }
            print "</tr>";
            $i++;
        }
        print "</table>";
    }

    function link($target){

    print '<a href="index.php?toiminto='.$this->toiminnonNimi .
         '&amp;alitila='.$target.'">'.$this->tm->getText($target).'</a>';

    }
} // end of HenkiloView
?>

