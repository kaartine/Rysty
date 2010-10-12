<?php
/*
 * Created on Feb 10, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
 require_once("listaview.php");
 /**
 * class UutisListaView
 *
 */
class UutisListaView extends ListaView
{
    function UutisListaView(&$arg) {

        $this->ListaView($arg);
        $this->toiminnonNimi = "uutislista";
        $_REQUEST['dir'] = 'desc';
    }
      
    /**
     * Overridden from View
     */
    function drawMiddle () {
        $data = $this->toiminto->getData();


        $i=0;
        print '<hr>';
        foreach ($data as $rivi )    {
            print '  <table>';
                print '<tr id=ID'.$rivi['uutinenid'].'><td>';
                print $rivi['pvm'];
                print '<br /><b> ';
         
                print $rivi['otsikko'];
                print '</b></td> </tr>';
                print '<tr><td><p>';
                print $rivi['uutinen'];
                print '</p></td> </tr>';
                print '<tr><td>';
                
                print $rivi['ilmoittaja'];                
                print '</td> </tr>';
                print '<tr><td>';
                if( $this->isLoggedIn() ) {
                    $this->printLink($this->tm->getText('editoi'),'uutinen', $rivi['uutinenid']);
                }
                print '</td> </tr>';
                
           		if( $i == 4 && !isset($_REQUEST['all']) ) {
                	print "</table><hr />";
                	break;
                }
                
            print "</table><hr />";
            $i++;
        }
        
        // Tulosta kaikki uutiset linkki
        if( !isset($_REQUEST['all']) ) {
        	print "<a href=\"?toiminto=".$this->toiminnonNimi."&amp;all=1\">".$this->tm->getText('kaikki')."</a>";
        }
    }
    
    function printLink($string, $key, $value) {
        $name = $this->toiminto->links[$key][0];
        print "<a href=\"?toiminto=".$this->toiminto->links[$key][1].
        "&amp;".$name."=".$value."\">".$string."</a>";
    }
        

} // end of HenkiloView
?>
