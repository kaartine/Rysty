
<?php
/**
  * joukkuetilastotview.php
  * Copyright Rysty 2004:
  *   Teemu Lahtela
  *   Jukka Kaartinen
  *   Teemu Siitarinen
  *
  * author: Jukka
  * created: 09.03.2005
  *
  */

require_once("listaview.php");


/**
 *  * class JoukkueTilastotView
 *  *
 *  */
class JoukkueTilastotView extends ListaView
{
    function JoukkueTilastotView(&$arg) {

        $this->ListaView($arg);

        $this->headers = array(
            'sarjannimi' => $this->tm->getText('Sarja'),
            'pelit' => array($this->tm->getText('Pelit'),'center'),
            'voitot' =>array($this->tm->getText('Voitot'),'center'),
            'tasapelit' =>array($this->tm->getText('Tasapelit'),'center'),
            'tappiot' =>array($this->tm->getText('Tappiot'),'center'),
            'kotivoitot' =>array($this->tm->getText('Voitot kotona'),'center'),
            'kotitasapelit' =>array($this->tm->getText('Tasapelit kotona'),'center'),
            'kotitappiot' =>array($this->tm->getText('Tappiot kotona'),'center'),
            'vierasvoitot' =>array($this->tm->getText('Voitot vieraissa'),'center'),
            'vierastasapelit' =>array($this->tm->getText('Tasapelit vieraissa'),'center'),
            'vierastappiot' =>array($this->tm->getText('Tappiot vieraissa'),'center')

        );
        $this->toiminnonNimi = "joukkuetilastot";
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

        $this->toiminto->joukkuetiedot->draw();

        print '<br /><br /><table> <tr>';

        foreach ($this->headers as $key=>$label) {
            
            if( is_array($label) ) {
                $label = $label[0];
            }
                        
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
            $dir = $this->toiminto->nextdirection;
            }print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.
            '&amp;dir='.$dir.'">'.$label.'</a></th>';
        }
        print '<th>&nbsp;</th></tr>';

        $suodatin = "";
        $i=0;
        foreach ($data as $rivi ) {
            print "<tr>";
            foreach ($this->headers as $key=>$label) {
                
                $align = "";
                if( is_array($label) ) {                
                    $align = "align=\"$label[1]\"";
                    $label = $label[0];
                }
                
                print "<td $align>";
    
                if( isset($this->toiminto->links[$key][2]) and is_array($this->toiminto->links[$key][0]) ) {
                    $this->printLink2($this->tm->getText($key), $key, $data[$i]);
                }
                else if( isset($this->toiminto->links[$key]) and is_array($this->toiminto->links[$key][0]) ) {
                    $this->printLink2($rivi[$key], $key, $data[$i]);
                }
                else if( isset($this->toiminto->links[$key]) ) {
                    $this->printLink($rivi[$key], $key, $data[$i]);
                }
                else {
                    if($key === "ppp" )
                        if( $rivi['pelit'] > 0 )
                            print (($rivi['maalit']+$rivi['syotot'])/$rivi['pelit']);
                        else
                            print "0";
                    else if($key === "pisteet" )
                        print ($rivi['maalit']+$rivi['syotot']);
                    else
                        print $rivi[$key];
                }
    
                print "</td>";
            }

            print "</tr>";
            $i++;
        }
        print "</table>";
    }

} // end of HenkiloView
?>

