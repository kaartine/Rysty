<?php
/**
  * henkiloview.php
  * Copyright Rysty 2004:
  *   Teemu Lahtela
  *   Jukka Kaartinen
  *   Teemu Siitarinen
  *
  * author: Jukka
  * created: 09.03.2005
  *
  */

require_once("view.php");


/**
 *  * class HenkiloView
 *  *
 *  */
class PelaajaTilastotView extends View
{
    function PelaajaTilastotView(&$arg) {

        $this->View($arg);
/*
        $this->headers = array(

            'nimi' =>$this->tm->getText('Nimi'),
            'pelit' =>array($this->tm->getText('Pelit'),'center'),
            'maalit' =>array($this->tm->getText('Maalit'),'center'),
            'syotot' =>array($this->tm->getText('Sy&ouml;t&ouml;t'),'center'),
            'pisteet' =>array($this->tm->getText('Pisteet'),'center'),
            'jaahyt' =>array($this->tm->getText('J&auml;&auml;hyt'),'center'),
            'plusmiinus' =>array($this->tm->getText('+/-'),'center'),
            'ppp' =>array($this->tm->getText('Pisteet/Peli'),'center')
        );*/
        $this->toiminnonNimi = "pelaajatilastot";
    }

    /**
     * Overridden from View
     */
    function drawMiddle () {
        /*
        $data = $this->toiminto->getData();

        /*D( "<pre>");
        D($data);
        D($this->toiminto->links);
        D("</pre>");
        */

        print '<form action="index.php?toiminto=pelaajatilastot" method="post">';
        //print $this->toiminto->kaudet->draw();
        print $this->toiminto->sarjat->draw();
        $label = $this->tm->getText('Valitse');
        print '<input type="submit" name="kaudenvalinta" value="'.$label .'" /></form>';

        print '<br />';
        
        $this->toiminto->kenttapelaajat->draw();
        
        
        
        
/*
        print '  <table> <tr>';

        foreach ($this->headers as $key=>$label){
            
            if( is_array($label) ) {
                $label = $label[0];
            }
            
            $dir = 'asc';
            if ( $this->toiminto->order === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            else if( $this->toiminto->omasort === $key ) {
                $dir = $this->toiminto->nextdirection;
            }
            print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort='.$key.
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
                if ( isset ( $rivi[$key] ) ) {
                    if(   isset($this->toiminto->links[$key]) and is_array($this->toiminto->links[$key][0]) ) {
                        $this->printLink2($rivi[$key], $key, $data[$i]);
                    }
//                    else if( isset($this->toiminto->links[$key][2]) and is_array($this->toiminto->links[$key][0]) ) {
//                        $this->printLink2($this->tm->getText($key), $key, $data[$i]);
//                    }
                    else if( isset($this->toiminto->links[$key]) ) {
                        $this->printLink($rivi[$key], $key, $data[$i]);
                    }
                    else {
                        print $rivi[$key];
                    }
                }
                print "</td>";
            }

            print "</tr>";
            $i++;
        }
        print "</table>";
*/        
        print '<br />';
        $this->toiminto->maalivahdit->draw();
    }

} // end of HenkiloView
?>

