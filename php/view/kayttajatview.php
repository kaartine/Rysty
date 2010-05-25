<?php
/**
  * henkiloview.php
  * Copyright Rysty 2004:
  *   Teemu Lahtela
  *   Jukka Kaartinen
  *   Teemu Siitarinen
  *
  * author: tepe
  * created: 09.03.2005
  *
  */

require_once("listaview.php");


/**
 *  * class HenkiloView
 *  *
 *  */
class KayttajatView extends ListaView
{
    function KayttajatView(&$arg) {
	    
	            $this->ListaView($arg);
	    
	            $this->headers = array(
					   'tunnus'=>$this->tm->getText('Tunnus'),
			   'etunimi'=>$this->tm->getText('Etunimi'),
			   'sukunimi'=>$this->tm->getText('Sukunimi')					   
					   );
	            $this->toiminnonNimi = "kayttajat";
	}
    
    function drawMiddle () {
        $data = $this->toiminto->getData();

        print '  <table> <tr>';

        foreach ($this->headers as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.'&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '</tr>';

        $i=0;
        foreach ($data as $rivi )    {
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
                    print $rivi[$key];
                }

                print "</td>";
                               
            }
            print "<td>";
            print '<form action="index.php?toiminto=kayttajat" method="post" >' .                
            '<input type="hidden" name="tunnus" value="'.$rivi['tunnus'].'" />' .
            '<input type="hidden" name="poista" value="1" />' .
            '<input type="hidden" name="samarefresh" value="1" />' .
            '<input type="submit" name="send" value="'.$this->tm->getText("Poista").'"/>' .
            '</form>';
            print "</td>";

            print "</tr>";
            $i++;
        }
            print "</table>";

    }
    
} // end of HenkiloView
?>
	
