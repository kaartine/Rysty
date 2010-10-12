<?php
/**
 * tapahtumatview.php
 *
 * Copyright  Rysty 2004:
 * Teemu Lahtela
 * Jukka Kaartinen
 * Teemu Siitarinen
 *
 * author: Jukka
 * created: 11.04.2005
 *
*/

require_once("listaview.php");

/**
 * class TapahtumaView
 *
 */
class TapahtumatView extends ListaView
{

    function TapahtumatView(&$arg) {

        $this->ListaView($arg);

        $this->headers = array(
            'tyyppi'=>$this->tm->getText('Tapahtuma'),
            'paiva'=>$this->tm->getText('P&auml;iv&auml;'),
            'aika'=>$this->tm->getText('Kello'),
            'paikka'=>$this->tm->getText('Paikka'),
            'vastuuhlo'=>$this->tm->getText('Vastuuhenkil&ouml;'),
            'kuvaus'=>$this->tm->getText('Kuvaus')
        );

        $this->toiminnonNimi = 'tapahtumat';
    }

    /**
     * Overridden from Lista
     */
    function drawMiddle () {
        $data = $this->toiminto->getData();

        print '  <table> <tr>';

        foreach ($this->headers as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            else if( $this->toiminto->omasort === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.'&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '<th>&nbsp;</th><th>&nbsp;</th></tr>';

        $i=0;
        foreach ($data as $rivi ) {
            print "<tr>";
            foreach ($this->headers as $key=>$label){
                print "<td>";

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
                else if( isset($this->toiminto->links[$key]) ) {
                    $this->printLink($rivi[$key], $key, $data[$i]);
                }
                else {
                    if( $key == 'paikka' and $rivi[$key] == '' ) {
                       print $rivi['pelipaikka'];
                    }
                    else if( $key == 'tyyppi' ) {
                       print $this->tm->getText($rivi['tyyppi']);
                    }
                    else {
                        print $rivi[$key];
                    }
                }

                print '</td>';
            }

            print '</td>';
            print "</tr>";
            $i++;
        }
            print "</table>";

    }


} // end of TapahtumaView
?>
