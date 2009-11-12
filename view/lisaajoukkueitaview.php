<?php
/**
 * lisaajoukkueitaview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 30.03.2005
 *
*/

require_once("listaview.php");


/**
 * class LisaaJoukkueitaView
 *
 */
class LisaaJoukkueitaView extends ListaView
{
    function LisaaJoukkueitaView(&$arg) {

        $this->ListaView($arg);

        $this->headers = array(
            'lyhytnimi'=>$this->tm->getText('Lyhytnimi'),
            'pitkanimi'=>$this->tm->getText('Pitk&auml;nimi')
        );
        $this->toiminnonNimi = "lisaajoukkueita";
    }

    /**
     * Overridden from View
     */
    function drawMiddle () {
        $data = $this->toiminto->getData();
    
        print '<form action="index.php?toiminto=sarjanjoukkueet" method="post" >
                <table> <tr>';
        print '<th>'.$this->tm->getText("Lis&auml;&auml;").'</th>';
    
        foreach ($this->headers as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
            $dir = $this->toiminto->nextdirection;
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.
              '&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '</tr>';
    
        $i=0;
        foreach ($data as $rivi )    {
            print "<tr>";
            print "<td>";
            print '<input type="checkbox" name="lisaa['.$i.']" value="'.$rivi['joukkue'].'"/>';
    
            print "</td>";
    
            foreach ($this->headers as $key=>$label){
            print "<td>";
    
            if( isset($this->toiminto->links[$key]) ) {
                $this->printLink($rivi[$key], $key, $data[$i]);
            }
            else {
                print $rivi[$key];
            }
    
            print "</td>";
            }
    
            print "</tr>";
            $i++;
    
        }
        print '</table><br>';
    
        print ' <input type="submit" name="send" value="'.$this->tm->getText("Lis&auml;&auml; joukkueet").'"/>            
            </form><br>';
        
        $this->palaaTakaisin();    
        /*print '<form action="index.php?toiminto=sarjanjoukkueet" method="post" >            
            <input type="submit" name="takaisin" value="'.$this->tm->getText("Takaisin").'"/>
            </form>';
         */ 
    }

} // end of LisaaJoukkueitaView
?>
