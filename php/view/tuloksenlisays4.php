<?php
/*
 * Created on Apr 7, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */

  require_once("view.php");

 class TuloksenLisays4View extends View
{
        /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function TuloksenLisays4View (&$arg) {
        $this->View($arg);
        $kuvaus='';
    }
    function drawMiddle () {
        $this->p('Sivu 4');

        ?>
<FORM NAME="form1" ACTION="index.php" METHOD="POST">
        <?php

        $this->toiminto->otsikkoView->draw(TRUE);
        print '<br>';
        print '<br>';

        if ( $this->toiminto->tiedot['eipoytakirjaa'][4] === false){
            beginFrame();
            $this->p('Kotijoukkue');
            print '<br>';
            isoTeksti($this->toiminto->koti->nimi);            
            print '<br>';
            $this->drawMaalit($this->toiminto->koti);
            endFrame();
            print '<br>';
            beginFrame();
            $this->p('Vierasjoukkue');
            print '<br>';
            isoTeksti($this->toiminto->vieras->nimi);            
            print '<br>';
            $this->drawMaalit($this->toiminto->vieras);
            endFrame();
        }
        print '<br>';

        $this->toiminto->tiedot['toiminto'][0]->draw();
        $this->toiminto->tiedot['seuraavatila'][0]->draw();
        $this->toiminto->tiedot['peliid'][0]->draw();
        $this->toiminto->tiedot['kotijoukkue'][0]->draw();
        $this->toiminto->tiedot['vierasjoukkue'][0]->draw();
/*        $cb = new Input('kotimaalit',$this->toiminto->koti->maalienlkm,'hidden');
        $cb->draw();
        $cb = new Input('vierasmaalit',$this->toiminto->koti->maalienlkm,'hidden');
         $cb->draw();*/

        $cb = new Input('finish','now','hidden');
        $cb->draw();

        $cb = new Input('edellinen',$this->tm->getText('Edellinen'),'submit');
        $cb->draw();

        $cb = new Input('seuraava',$this->tm->getText('Tallenna'), 'submit');
        $cb->draw();

        ?>
</FORM>
        <?php
    }
    function drawMaalit (&$joukkue) {
        $i = 1;
        if ( count($joukkue->pelaajat) == 0 ) {
            print '<br>';
            $this->p('Joukkueelle ei ole merkitty pelaajia kokoonpanoon.');
            print '<br>';
            return;
        }
            print '<br>';
        
        $this->p('Maalit');
        if ( count($joukkue->maalit) > 0 ) {

?>
<br>
  <table>
    <tr>
      <th>
      <?php $this->p('nro'); ?>
      </th>

      <th>
      <?php $this->p('aika'); ?>
      </th>
      <th>
      <?php $this->p('tekij&auml;');?>
      </th>
      <th>
      <?php $this->p('sy&ouml;tt&auml;j&auml;');?>
      </th>
      <th>
      <?php $this->p('av/yv/tasa');?>
      </th>
      <th>
      <?php $this->p('Siirretyn rangaistuksen aikana');?>
      </th>

      <th>
      <?php $this->p('tyhj&auml;maali');?>
      </th>
      <th>
      <?php $this->p('rangaistuslaukaus');?>
      </th>


    </tr>
    <?php

            foreach ($joukkue->maalit as $k) {
                print '<tr><td>';
                    print $i;
                print '</td><td>';
                    print $k['tapahtumisaika'];
                print '</td><td>';
                    if ( !empty($k['tekija']) and $k['tekija'] != -1 ) print $joukkue->pelaajat[$k['tekija']]['numero'].' '.$joukkue->pelaajat[$k['tekija']]['nimi'];
                    else print '-';
                print '</td><td>';
                    if ( !empty($k['syottaja'] ) and $k['syottaja'] != -1 ) print $joukkue->pelaajat[$k['syottaja']]['numero'].' '.$joukkue->pelaajat[$k['syottaja']]['nimi'];
                    else print '-';
                print '</td><td>';
                    print $this->tm->getText($k['tyyppi']);
                print '</td><td>';
                    print $this->tm->getText($k['siirrangaikana']);
                print '</td><td>';
                    print $this->tm->getText($k['tyhjamaali']);
                print '</td><td>';
                    print $this->tm->getText($k['rangaistuslaukaus']);
                print '</td></tr>';
                $i++;
            }
            ?>
            </table>
            <?php
        } else {
            
            print '<br>';
            $this->p('Ei maalimerkint&ouml;j&auml;');
        }
        print '<br>';

        $i = 1;
        $this->p('J&auml;&auml;hyt');

        print '<br>';
        if ( count($joukkue->jaahyt) > 0 ) {

        ?>
        <br>
  <table>
    <tr>
      <th>
      <?php $this->p('nro'); ?>
      </th>

      <th>
      <?php $this->p('# Nimi'); ?>
      </th>
      <th>
      <?php $this->p('Minuutit'); ?>
      </th>

      <th>
      <?php $this->p('Syy'); ?>
      </th>

      <th>
      <?php $this->p('tapahtumisaika'); ?>
      </th>
      <th>
      <?php $this->p('P&auml;&auml;ttymisaika'); ?>
      </th>

    </tr>
        <?php
            foreach ($joukkue->jaahyt as $k) {
                print '<tr><td>';
                    print $i;
                print '</td><td>';
                    if ( !empty($k['saaja']) and $k['saaja'] != -1 ) print $joukkue->pelaajat[$k['saaja']]['numero'].' '.$joukkue->pelaajat[$k['saaja']]['nimi'];
                    else print '-';
                print '</td><td>';
                    print $k['minuutit'];
                print '</td><td>';
                    print $k['syy'];
                print '</td><td>';
                    print $k['tapahtumisaika'];
                print '</td><td>';
                    print $k['paattymisaika'];

                print '</td></tr>';
                $i++;
            }
        ?>
        </table>
        <br>

        <?php
        } else {
            $this->p('Ei j&auml;&auml;hymerkint&ouml;j&auml;');

        }
        print '<br>';
        print '<br>';
/*
        var  $epaonnisrankut = array();
        var $toiminto = array();
        var $maalivahdit = array();
        var $kapteenit = array();
        var $kapteenitiedot = array();
        var $maalivahtitiedot = array();
        */
        $this->drawEpaonnistuneet($joukkue);
        $this->drawmaalivahdit($joukkue);
        $this->drawkapteenit($joukkue);
        $this->drawJoukkeenPelaajat($joukkue);
        // piirretään toimihenkilöt
        print '<table>';
        print '<tr><td>';
        $this->p('Toimihenkil&ouml;t:');
        print '</td></tr>';
        $t = ($joukkue->tyyppi == 'koti')?'a':'b';
        $p = 1;
        for ($i = 1 ; $i < 6 ; $i++ ) {
            if ( empty($this->toiminto->tiedot[$t.'toimihenkilo'.$i][0]->VALUE) ) {
                continue;
            } 
            print '<tr><td>';            
            print " $p: ";
            print $joukkue->pelaajat[$this->toiminto->tiedot[$t.'toimihenkilo'.$i][0]->VALUE]['nimi'];
            $p++;
            print '</td></tr>';
        }
        if ( $p == 1) {
            print '<tr><td>';
            $this->p('Ei Toimihenkil&ouml;it&auml;');
            print '</td></tr>';
        }
        print '</table>';    

    }

    function drawEpaonnistuneet (&$joukkue) {
        $tekijat = $joukkue->epaonnisrankut;

        if ( count($joukkue->epaonnisrankut) > 0 ) {
            $this->p('Ep&auml;onnistuneet rangaistuslaukaukset');
            print '<br>';

    ?>
    <table>
        <tr>
        <th>
        <?php $this->p('nro'); ?>
        </th>

        <th>
        <?php $this->p('aika'); ?>
        </th>
        <th>
        <?php $this->p('tekij&auml;');?>
        </th>
        <th>
        <?php $this->p('av/yv/tasa');?>
        </th>
        <th>
        <?php $this->p('Siirretyn rangaistuksen aikana'); ?>
        </th>
        <th>
        <?php $this->p('tyhj&auml;maali');?>
        </th>

        </tr>
        <?php
        $i=1;
        foreach ($tekijat as $k => $v ) {
            print '<tr> <td>';
            print ($i);
            print ' </td>  <td>';
            print $v['tapahtumisaika'];
            print ' </td>  <td>';
            if ( !empty($k['tekija']) and $v['tekija'] != -1 ) print $joukkue->pelaajat[$v['tekija']]['numero'].' '.$joukkue->pelaajat[$v['tekija']]['nimi'];
            else print '-';
            print ' </td>  <td>';
            print $v['tyyppi'];
            print ' </td>  <td>';
            print $this->tm->getText($v['siirrangaikana']);
            print ' </td>  <td>';
            print $this->tm->getText($v['tyhjamaali']);
            print '</td></tr>';
            $i++;
        }
        print '</table>';
    } else {
            $this->p('Ei ep&auml;onnistuneita rangaistuslaukauksia.');
    }

        print '<br><br>';

    }

    function drawmaalivahdit (&$joukkue) {
        $this->p('Maalivahdit');
        print '<br>';

        if ( count($joukkue->maalivahdit) > 0 ) {

            ?>
    <table>
        <tr>
        <th>
        <?php $this->p('nro'); ?>
        </th>

        <th>
        <?php $this->p('# Nimi'); ?>
        </th>

        <th>
        <?php $this->p('Tuloaika'); ?>
        </th>
        <th>
        <?php $this->p('P&auml;&auml;stetyt maalit'); ?>
        </th>

        </tr>
            <?php
                $i=1;
            foreach ($joukkue->maalivahdit as $k => $v ) {
                print '<tr> <td>';
                print ($i);
                print ' </td>  <td>';
                //print_r($v);
                print $joukkue->pelaajat[$k]['nimi'];
                print ' </td>  <td>';
                print $joukkue->pelaajat[$k]['mvtuloaika'];

                print ' </td>  <td>';
                print $joukkue->pelaajat[$k]['paastetytmaalit'];
                print '</td> </tr>';
                $i++;
            }
        print '</table>';
        }
         else {
        $this->p('Ei merkitty.');
        }
        print '<br>';
    }
    function drawkapteenit (&$joukkue) {
        $this->p('Kapteenit');
        print '<br>';
        if ( count($joukkue->kapteenit) > 0 ) {

            ?>
    <table>
        <tr>
        <th>
        <?php $this->p('nro'); ?>
        </th>

        <th>
        <?php $this->p('# Nimi'); ?>
        </th>

        <th>
        <?php $this->p('Kapteeniksi tulo aika'); ?>
        </th>
        </tr>
            <?php
                $i=1;
            foreach ($joukkue->kapteenit as $k => $v ) {
                print '<tr> <td>';
                print ($i);
                print ' </td>  <td>';
                //print_r($v);
                print $joukkue->pelaajat[$k]['nimi'];
                print ' </td>  <td>';
                print $joukkue->pelaajat[$k]['kaptuloaika'];
                print '</td> </tr>';
                $i++;

            }
            print '</table>';
        } else {
            $this->p('Ei merkitty.');
        }
        print '<br>';
    }

    function drawJoukkeenPelaajat (&$joukkue) {
    print '<br>';
            if ( !$this->hasErrors ) {
                $joukkue->sortPelaajat();
            }
            $pelaajat = $joukkue->pelaajat;
            if ( count($pelaajat) > 0 ) {
                $this->p('Peliss&auml; mukana');
        ?>
<br>
  <table>
    <tr>
      <th><?php $this->p('#'); ?></th>
      <th><?php $this->p('Nimi'); ?></th>
      <th><?php $this->p('(+/-)'); ?></th>
      <th><?php $this->p('Peliaika'); ?></th>
      <th><?php $this->p('Lis&auml;tiedot'); ?></th>
    </tr>
            <?php
            foreach ( $pelaajat as $p ) {
                if( !isset($p['kokoonpanossa']) or !$p['kokoonpanossa'] ) {
                    continue;
                }                
                $hid = $p['pelaaja'];
                print '<tr>';
                print '<td>';
                if ( $p['numero'] != 0 ) print $p['numero'];
                print '</td><td>';
                print $p['nimi'];
                print '</td><td>';
                print $p['plusmiinus'];
                print '</td><td>';
                print $p['peliaika'];
                print '</td>';
                print '<td>';
                print $p['lisatieto'];
                print '</td>';
                print '</tr>';
            }
        print '</table>';
        }
        else {
            $this->p('Ei pelaajatietoja');
        }
    print '<br>';
    print '<br>';
    }

}
?>
