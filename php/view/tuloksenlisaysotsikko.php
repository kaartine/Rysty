<?php
/*
 * Created on Apr 23, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
 
 class TuloksenOtsikko {
    
    var $tiedot=array();
    var $tm;
    function TuloksenOtsikko ( &$data ) {
        foreach ( $data as $k => $v ) {
            if ( $k == 'aikalisaa' or $k == 'aikalisab' ) {
                $e = explode(':',$v[0]);
                if ( count($e) == 3 ) {
                    $v[0] = $e[1] .':' . $e[2]; 
                } 
            }
            $this->tiedot[$k] = $v[0];
        }
    }
    
    function draw($full = FALSE) {
        beginFrame();
        print '<table><tr>';
        print '<td align="middle">';
        isoTeksti($this->tiedot['kotijoukkuepitkanimi']);
        if ( $this->tiedot['kotijoukkuepitkanimi'] != $this->tiedot['kotijoukkuenimi'] ) {
            print ' ('.$this->tiedot['kotijoukkuenimi'].')';
        }
        print '</td><td align="middle">';
        isoTeksti(' - ');
        print '</td><td align="middle">';
        isoTeksti($this->tiedot['vierasjoukkuepitkanimi']);
        if ( $this->tiedot['vierasjoukkuepitkanimi'] != $this->tiedot['vierasjoukkuenimi'] ) {
            print ' ('.$this->tiedot['vierasjoukkuenimi'].')';
        }

        print '</td></tr><td align="middle">';
        $dmaalit = ( !empty($this->tiedot['kotimaalit']) && !empty($this->tiedot['vierasmaalit']));
        if ( $dmaalit ) isoTeksti($this->tiedot['kotimaalit']);
        print '</td><td align="middle">';
        if ( $dmaalit ) isoTeksti(' - ');
        print '</td><td align="middle">';
        if ( $dmaalit) isoTeksti($this->tiedot['vierasmaalit']);
        print '</td></tr></table>';        
        print '<table> <tr> <td>';
        print $this->tiedot['kausi'] . ', ' . $this->tiedot['sarjanimi'];
        print '</td></tr><tr><td>';
        print $this->tiedot['pvm'];
        print '</td></tr><tr><td>';
        print $this->tiedot['pelipaikka'];

        if ( $full ) {
            $this->tm = TranslationManager::instance();
            $this->drawInfo('aikalisaa');
            $this->drawInfo('aikalisab');
            $this->drawInfo('tuomari1');
            $this->drawInfo('tuomari2');
            $this->drawInfo('toimitsija1');
            $this->drawInfo('toimitsija2');
            $this->drawInfo('toimitsija3');
            if ( $this->tiedot['yleisomaara'] > 0 )
                $this->drawInfo('yleisomaara');
        }

        
        print '</td></tr>';
        print '</table>';
        endFrame();
        print '<br>';
          
    }
    function drawInfo ($value) {
    	if ( !empty( $this->tiedot[$value] ) ) {
            print '</td></tr><tr><td>';
            print $this->tm->getText($value).': '.$this->tiedot[$value];
        }
    }
 }
?>
