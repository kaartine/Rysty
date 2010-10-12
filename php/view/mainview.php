<?php
/**
 * kaudenjoukkue.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 17.04.2005
 *
*/

require_once "multilistaview.php";

 class MainView extends MultiListaView
{

    function MainView(&$arg) {
        $this->MultiListaView($arg);

        $this->headers = array(

            'seuraavat' => array(
               'tyyppi'=>$this->tm->getText('Tyyppi'),
               'paikka'=>$this->tm->getText('Paikka'),
               'pvm'=>$this->tm->getText('P&auml;iv&auml;m&auml;&auml;r&auml;')/*,
               'kuvaus'=>$this->tm->getText('Kuvaus'),
               'vastuuhlo'=>$this->tm->getText('Vastuuhenkil&ouml;')*/),
           'tulokset' => array(
               'sarjannimi'=>$this->tm->getText('Sarja'),
               'kotijoukkue'=>array($this->tm->getText('Kotijoukkue'),'right'),
               'lopputulos'=>array($this->tm->getText('Lopputulos'),'center'),
               'vierasjoukkue'=>array($this->tm->getText('Vierasjoukkue'),'left'),
               'pvm'=>$this->tm->getText('P&auml;iv&auml;m&auml;&auml;r&auml;')),
			'uutiset' => array(
				'pvm'=>$this->tm->getText('P&auml;iv&auml;m&auml;&auml;r&auml;'),
         		'otsikko'=>$this->tm->getText('Otsikko'))
         );
        $this->otsikko = '';
        $this->toiminnonNimi = "main";
    }

    /**
     * Overridden from View
     */
    function drawMiddle () {

        if( $this->isLoggedIn() == true ) {
            $this->drawSeuraavat($this->toiminto->getData('seuraavat'),'seuraavat');
            print "<br /><br />";
        }

        $this->drawTulokset($this->toiminto->getData('tulokset'),'tulokset');
        
        print "<br /><br />";
        
        $this->drawUutiset();

    }

    function drawSeuraavat($data, $list) {

        if( count($data) == 0) {
            return;
        }

        print '<font class="tulevia">'.$this->tm->getText('Tulevia tapahtumia')."<br /></font> ";
        $this->p('Muista ilmottautua');
        print '<br /><br /><br />';
        $i=0;
        foreach ($data as $rivi) {

            if( $list == 'seuraavat') {
                if( $rivi['pelipaikka'] != '' ) {
                   $halli = $rivi['pelipaikka'];
                   if( $rivi['paikka'] != '') {
                        $rivi['paikka'] = $halli.", ".$rivi['paikka'];
                   }
                   else {
                        $rivi['paikka'] = $halli;
                   }
                }
            }
            $divclass = 'tulevattapahtumat';
            if ( $rivi['paasee'] == '' ) {
                $divclass = 'eiilmottautunut';
            }
            print '<div class="'.$divclass.'"><table><tr><td rowspan="2" width="200px">';
            isoTeksti($this->printLink2($this->tm->getText($rivi['tyyppi']),
                     'pvm', $data[$i], 'seuraavat')."<br />");
            print '<br />';
            print '<b>'.$this->headers['seuraavat']['pvm']."</b>:<br />&nbsp;&nbsp;&nbsp;";
            print $this->printLink2($rivi['pvm'], 'pvm', $data[$i], 'seuraavat')."<br />";
            print '<b>'.$this->headers['seuraavat']['paikka']."</b>:<br />&nbsp;&nbsp;&nbsp;".$rivi['paikka']."</td>";



            print '<td><form action="index.php?toiminto=main" method="post" >' .
                '<input type="hidden" name="tapahtumaid" value="'.$rivi['tapahtumaid'].'" />' .
                '<input type="hidden" name="ilmoittaudu" value="'.$rivi['ilmoittaudu'].'" />' .
                '<input type="hidden" name="samarefresh" value="1" />';

            if( $rivi['paasee'] == '' ) {
                print '<input type="submit" name="tulossa" value="'.$this->tm->getText("Ilmoittaudu").'"/>';
            }
            else if( $rivi['paasee'] == 'f' ) {
                print '<input type="submit" name="tulossa" value="'.$this->tm->getText("P&auml;&auml;sen sittenkin").'"/>';
            }
            else {
                print $this->tm->getText('Olet ilmoittautunut');
            }

            print '</form></td></tr><tr><td>';
            
            print '<form action="index.php?toiminto=main" method="post" >' .
                '<input type="hidden" name="tapahtumaid" value="'.$rivi['tapahtumaid'].'" />' .
                '<input type="hidden" name="ilmoittaudu" value="'.$rivi['ilmoittaudu'].'" />' .
                '<input type="hidden" name="samarefresh" value="1" />';

            if( $rivi['paasee'] == 't' ) {
                print '<input type="submit" name="eitulossa" value="'.$this->tm->getText("En sittenk&auml;&auml;n p&auml;&auml;se").'"/>';
                print ' <br />'.$this->tm->getText('Koska:');
                print '<input type="text" size="20" maxlength="100" name="selite" value="'.$rivi['selite'].'" />';

            }
            else if( $rivi['paasee'] == 'f' ) {
                print $this->tm->getText('En p&auml;&auml;se').':<br /> '.$rivi['selite'];
            }
            else {
                print '<input type="submit" name="eitulossa" value="'.$this->tm->getText("En p&auml;&auml;se").'"/> ';
                print ' ' .$this->tm->getText('Koska:');
                print '<input type="text" size="20" maxlength="100" name="selite" value="'.$rivi['selite'].'" />';
            }

            print '</form></td></tr>';

            $i++;
            print "</table></div><br />";
        }

    }

    function drawtulokset($data, $list) {

        if( count($data) == 0) {
            return;
        }

        print "<h2>".$this->tm->getText('Menneit&auml; pelej&auml;')."</h2>";

        $header = &$this->headers[$list];
        $align = "";
        print '  <table> <tr>';

        foreach ($header as $key=>$label){

            $dir = 'asc';
            if ( $this->toiminto->order[$list] === $key ) {
                $dir = $this->toiminto->nextdirection[$list];
            }

            if( is_array($label) ) {
                $label = $label[0];
            }

            if( $this->toiminto->sorting == true ) {
                print '<th><a href="index.php?toiminto='.$this->toiminnonNimi.'&amp;sort'.$list.'='.$key.
                '&amp;dir='.$dir.'">'.$this->tm->getText($label).'</a></th>';
            }
            else {
                print '<th>'.$label.'</th>';
            }
        }
        print '</tr>';

        $i=0;
        foreach ($data as $rivi ) {

            if( $list == 'seuraavat') {
                if( $rivi['pelipaikka'] != '' ) {
                   $halli = $rivi['pelipaikka'];
                   if( $rivi['paikka'] != '') {
                        $rivi['paikka'] = $rivi['paikka'].", ".$halli;
                   }
                   else {
                        $rivi['paikka'] = $halli;
                   }
                }
            }

            print "<tr>";
            foreach ($header as $key=>$label){
                if( is_array($label) ) {
                    $align = "align=\"$label[1]\"";
                    $label = $label[0];
                }
                print "<td $align>";

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

            if( $list == 'seuraavat') {

                print '<td align="center">';
                print '<form action="index.php?toiminto=main" method="post" >' .
                    '<input type="hidden" name="tapahtumaid" value="'.$rivi['tapahtumaid'].'" />' .
                    '<input type="hidden" name="ilmoittaudu" value="'.$rivi['ilmoittaudu'].'" />' .
                    '<input type="hidden" name="samarefresh" value="1" />';

                if( $rivi['paasee'] == '' ) {
                    print '<input type="submit" name="tulossa" value="'.$this->tm->getText("P&auml;&auml;sen").'"/>';
                }
                else if( $rivi['paasee'] == 'f' ) {
                    print '<input type="submit" name="tulossa" value="'.$this->tm->getText("P&auml;&auml;sen sittenkin").'"/>';
                }
                else {
                    print $this->tm->getText('OK');
                }

                print '</td><td><input type="text" size="20" maxlength="100" name="selite" value="'.$rivi['selite'].'" />';

                if( $rivi['paasee'] == 't' ) {
                    print '<input type="submit" name="eitulossa" value="'.$this->tm->getText("En sittenk&auml;&auml;n p&auml;&auml;se").'"/>';
                }
                else {
                    print '<input type="submit" name="eitulossa" value="'.$this->tm->getText("En p&auml;&auml;se").'"/>';
                }

                print '</td></form>';

                print "</tr>";
            }
            $i++;
        }
        print "</table>";
    }

    function printLink2($string,$key, $data, $list) {
        $values = "";
        foreach( $this->toiminto->links[$list][$key][0] as $i) {
            $name = $i;
            $value = strtolower($data[strtolower($name)]);
            $values .= "&amp;".$name."=".$value;
        }
        return "<a href=\"?alitoiminto=".$this->toiminto->links[$list][$key][1].
            $values."\">".$string."</a>";
    }
    
    /**
     * Sivun sisäinen linkki
     */
   function printLink3($string,$key, $data, $list) {
        $values = "";
        $id = "";
        foreach( $this->toiminto->links[$list][$key][0] as $i) {
            $name = $i;
            $value = strtolower($data[strtolower($name)]);
            $values .= "&amp;".$name."=".$value;
            $id = $value;
        }
        print "<a href=\"?alitoiminto=".$this->toiminto->links[$list][$key][1].
            $values."#ID".$id."\">".$string."</a>";
    }
    
    function drawUutiset()
    {
    	if( sizeof($this->toiminto->data['uutiset']) > 0)
    	{
    		print "<h2>".$this->tm->getText('uutisia')."</h2>";
    		
    		print '<table><tr><th>'.$this->tm->getText('Otsikko').'</th>'.
					'<th>'.$this->tm->getText('j&auml;tt&ouml;').'</th></tr>';
					
    		foreach($this->toiminto->data['uutiset'] as $uutinen )
    		{
    			print '<tr><td>';
    			$this->printLink3( $uutinen['otsikko'], 'otsikko', $uutinen, 'uutiset');
    			print '</td><td>';
    			$this->printLink3( $uutinen['pvm'], 'pvm', $uutinen, 'uutiset');
    			print '</td></tr>';
    		}
    		print '</table>';
    	}
    }

} // end of MainView
?>
