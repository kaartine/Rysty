<?php
/**
 * peliview.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 20.04.2005
 *
*/
  require_once("view.php");

/**
 * class PeliView
 *
 */
class PeliView extends View
{

     /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function PeliView (&$arg) {
        $this->View($arg);
        $kuvaus='';
    }

    function drawMiddle () {
        if ( $this->hasErrors) {
            D('ERROR');
            return;
        }
        $this->toiminto->otsikkoView->draw(TRUE);

        print '<br>';
        print '<br>';


            beginFrame();
            $this->trans('Kotijoukkue');
            print '<BR>';
            isoTeksti($this->toiminto->koti->nimi);
            print '<BR>';
            $this->drawMaalit($this->toiminto->koti);
            endFrame();
            print '<br>';
            beginFrame();
            $this->trans('Vierasjoukkue');
            print '<br>';
            isoTeksti($this->toiminto->vieras->nimi);
            print '<BR>';
            $this->drawMaalit($this->toiminto->vieras);
            endFrame();

        print '<br>';

    }
    function drawMaalit (&$joukkue) {
        $i = 1;
        if ( count($joukkue->pelaajat) == 0 ) {
            print '<br>';
            $this->p('Joukkueelle ei ole merkitty pelaajia kokoonpanoon.');
            print '<br>';
            return;
        }
        print '<br />';
        $this->heading( $this->trans('Maalit') );
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
                    if ( !empty($k['tekija']) and $k['tekija'] != -1 ) {
                        // kortti&amp;pelaaja=1016&amp;joukkueid=1
                        $this->drawPelaajaLink($k['tekija'], $joukkue);
                         //print '<a href="index.php?alitoiminto=pelaajakortti&amp;pelaaja=' .
//                                $k['tekija'].'&amp;joukkueid='.$joukkue->joukkueid.'">';
//                        print $joukkue->pelaajat[$k['tekija']]['numero'].' '.$joukkue->pelaajat[$k['tekija']]['nimi'];
//                        print '</a>';
                        $joukkue->lisaaPiste($joukkue->pelaajat[$k['tekija']],'maali');
                    }
                    else print '-';
                print '</td><td>';
                    if ( !empty($k['syottaja'] ) and $k['syottaja'] != -1 ) {
                        $this->drawPelaajaLink($k['syottaja'], $joukkue);
                        //print $joukkue->pelaajat[$k['syottaja']]['numero'].' '.$joukkue->pelaajat[$k['syottaja']]['nimi'];
                        $joukkue->lisaaPiste($joukkue->pelaajat[$k['syottaja']],'syotto');
                    }
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
            <br>
            <?php
        } else {
            $this->p('Ei maalimerkint&ouml;j&auml;');
        }

        $i = 1;
        print '<br><br>';
        $this->heading( $this->trans('J&auml;&auml;hyt') );
        if ( count($joukkue->jaahyt) > 0 ) {

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
                    if ( !empty($k['saaja']) and $k['saaja'] != -1 )  {
                        $this->drawPelaajaLink($k['saaja'], $joukkue);

//                        print $joukkue->pelaajat[$k['saaja']]['numero'].' '.$joukkue->pelaajat[$k['saaja']]['nimi'];
                    }
                    else print '-';
                print '</td><td align="center">';
                    print $k['minuutit'];
                print '</td><td align="center">';
                    print $k['syy'];
                print '</td><td align="center">';
                    print $k['tapahtumisaika'];
                print '</td><td align="center">';
                    print $k['paattymisaika'];

                print '</td></tr>';
                $i++;
            }
        ?>
        </table>
        <br>

        <?php
        } else {
            print '<br>';
            $this->p('Ei j&auml;&auml;hymerkint&ouml;j&auml;');

        }
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
        print '<table>';
        print '<tr><td>';
        $this->heading( $this->trans('Toimihenkil&ouml;t:') );
        print '</td></tr>';
        $t = ($joukkue->tyyppi == 'koti')?'a':'b';
        $p = 1;
        for ($i = 1 ; $i < 6 ; $i++ ) {
            if ( empty($this->toiminto->tiedot[$t.'toimihenkilo'.$i][0]) ) {
                continue;
            }
            print '<tr><td>';
            print " $p: ";
            print $joukkue->kaikkiPelaajat[$this->toiminto->tiedot[$t.'toimihenkilo'.$i][0]]['nimi'];
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
                print '</td><td align="center">';
            print $v['tapahtumisaika'];
            print ' </td>  <td>';
            if ( !empty($k['tekija']) and $v['tekija'] != -1 ) {
                  $this->drawPelaajaLink($k['tekija'], $joukkue);
//                print $joukkue->pelaajat[$v['tekija']]['numero'].' '.$joukkue->pelaajat[$v['tekija']]['nimi'];
            }
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
        print '</table><br>';
    } else {
            //$this->p('Ei ep&auml;onnistuneita rangaistuslaukauksia.');
    }
        print '<br>';

    }

    function drawmaalivahdit (&$joukkue) {
        $this->heading( $this->trans('Maalivahdit') );
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
                $this->drawPelaajaLink($k, $joukkue);

                //print $joukkue->pelaajat[$k]['nimi'];
                print '</td><td align="center">';
                print $joukkue->pelaajat[$k]['mvtuloaika'];

                print '</td><td align="center">';
                print $joukkue->pelaajat[$k]['paastetytmaalit'];
                print '</td> </tr>';
                $i++;
            }
        print '</table>';
        }
         else {
            $this->p('Ei merkitty.');
            print '<br>';
        }
        print '<br>';
    }
    function drawkapteenit (&$joukkue) {
        $this->heading( $this->trans('Kapteenit') );
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
                $this->drawPelaajaLink($k, $joukkue);

//                print $joukkue->pelaajat[$k]['nimi'];
                print '</td><td align="center">';
                print $joukkue->pelaajat[$k]['kaptuloaika'];
                print '</td> </tr>';
                $i++;

            }
            print '</table>';
        } else {
            $this->p('Ei merkitty.');
        }
        print '<br>';
        $this->drawJoukkeenPelaajat($joukkue);
    }


    function drawJoukkeenPelaajat (&$joukkue) {
    print '<br>';
            if ( !$this->hasErrors ) {
                $joukkue->sortPelaajat();
            }
            $pelaajat = $joukkue->pelaajat;
            if ( count($pelaajat) > 0 ) {
                $this->heading( $this->trans('Peliss&auml; mukana') );
        ?>
<br>
  <table>
    <tr>
      <th><?php $this->p('#'); ?></th>
      <th><?php $this->p('Nimi'); ?></th>
      <th><?php $this->p('Pisteet'); ?></th>
      <th><?php $this->p('(+/-)'); ?></th>
      <th><?php $this->p('Peliaika'); ?></th>
      <th><?php $this->p('Lis&auml;tiedot'); ?></th>
    </tr>
            <?php
            foreach ( $pelaajat as $p ) {
                $hid = $p['pelaaja'];
                print '<tr>';
                print '<td>';
                if ( $p['numero'] != 0 ) print $p['numero'];
                print '</td><td>';
                //print $p['nimi'];
         //      $this->drawPelaajaLink($hid, $joukkue);
         print '<a href="index.php?alitoiminto=pelaajakortti&amp;pelaaja=' .
                $hid.'&amp;joukkueid='.$joukkue->joukkueid.'">';
        print $p['nimi'];
        print '</a>';

                print '</td><td align="center">';
                if ( isset($p['maali']) or isset($p['syotto']) ) {
                    if ( !isset($p['maali']) ) $p['maali'] = 0;
                    if ( !isset($p['syotto']) ) $p['syotto'] = 0;
                    print $p['maali'] . '+'. $p['syotto'];
                }
                else {
                    print '&nbsp;';
                }
                print '</td><td align="center">';
                print $p['plusmiinus'];
                print '</td><td align="center">';
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
    function drawPelaajaLink ($id, &$joukkue) {
         print '<a href="index.php?alitoiminto=pelaajakortti&amp;pelaaja=' .
                $id.'&amp;joukkueid='.$joukkue->joukkueid.'">';
        print $joukkue->pelaajat[$id]['numero'].' '.$joukkue->pelaajat[$id]['nimi'];
        print '</a>';

    }

}
?>
