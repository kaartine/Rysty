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
 * class HenkiloView
 *
 */
class PelaajanLisaysView extends ListaView
{
    function PelaajanLisaysView(&$arg) {

        $this->ListaView($arg);

        $this->headers = array(
            'etunimi'=>$this->tm->getText('Etunimi'),
            'sukunimi'=>$this->tm->getText('Sukunimi'),
            'joukkue'=>$this->tm->getText('Viimeisin joukkue')
        );
        $this->toiminnonNimi = "lisaapelaajia";
    }

    /**
     * Overridden from View
     */
    function drawMiddle () {
        $data = $this->toiminto->getData();
    
      /*  D( "<pre>");
         D($data);
         D($this->toiminto->links);
         D("</pre>");
    */
    
        print '<form action="index.php?toiminto=kaudenjoukkue" method="post" >
                <table> <tr>';
        print '<th>'.$this->tm->getText("Lis&auml;&auml;").'</th>';
    
        foreach ($this->headers as $key=>$label){
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
            $dir = $this->toiminto->nextdirection;
            }print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.
              '&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '</tr>';
    
        $i=0;
        foreach ($data as $rivi )    {
            print "<tr>";
            print "<td>";
            print '<input type="checkbox" name="lisaa['.$i.']" value="'.$rivi['hloid'].'"/>';
    
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
        print "</table>";
    
        print ' <input type="submit" name="send" value="'.$this->tm->getText("Lis&auml;&auml; pelaajat").'"/>            
            </form>';
            
        $this->palaaTakaisin(array('joukkueid',$_SESSION['kaudenjoukkueid']) );
        /*
        print '<form action="index.php?toiminto=kaudenjoukkue" method="post" >            
            <input type="hidden" name="joukkueid" value="'.$_SESSION['kaudenjoukkueid'].'"/>   
            <input type="submit" name="takaisin" value="'.$this->tm->getText("Takaisin").'"/>
            </form>';
        */ 
    }

} // end of HenkiloView
?>
