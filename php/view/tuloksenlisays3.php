<?php

/*
 * Created on Jan 30, 2005
 *
 * Created by Teemu Siitarinen
 * (c) Lämmi
 * author: tepe
 * created: 20.01.2005
 */
 require_once("view.php");

 class TuloksenLisays3View extends View
{
        /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function TuloksenLisays3View (&$arg) {
        $this->View($arg);
        $kuvaus='';
    }
    function drawMiddle () {
        $this->p('Sivu 3');

/*        D( '<pre>');
        D($_REQUEST);
        D($_SESSION);

        D( '</pre>'); */

        ?>
<FORM NAME="form1" ACTION="index.php" METHOD="POST">
        <?php
        $this->toiminto->otsikkoView->draw();
        beginFrame();
        $this->tm->getText('Kotijoukkue');
        $this->drawjoukkueentiedot($this->toiminto->koti);
        endFrame();

        print '<br><hr><br>';

        beginFrame();
        $this->tm->getText('Vierasjoukkue');
        $this->drawjoukkueentiedot($this->toiminto->vieras);
        endFrame();
        print '<br>';

        $this->toiminto->tiedot['toiminto'][0]->draw();
        $this->toiminto->tiedot['seuraavatila'][0]->draw();
        $this->toiminto->tiedot['peliid'][0]->draw();
        $this->toiminto->tiedot['kotijoukkue'][0]->draw();
        $this->toiminto->tiedot['vierasjoukkue'][0]->draw();
        $cb = new Input('edellinen',$this->tm->getText('Edellinen'),'submit');
        $cb->draw();

        $cb = new Input('seuraava',$this->tm->getText('Seuraava'),'submit');
        $cb->draw();
        ?>
</FORM>
        <?php
    }
    function drawjoukkueentiedot(&$joukkue) {
        print '<br>';
        isoTeksti($joukkue->nimi);
        if ( count($joukkue->pelaajat) > 0 ) {
            $this->drawMaalintekijat($joukkue->tyyppi,$joukkue );
            $this->drawJaahyt($joukkue->tyyppi,$joukkue);

            $this->drawEpaonnistuneet($joukkue->tyyppi,$joukkue);
            $this->drawmaalivahdit($joukkue->tyyppi, $joukkue);
            $this->drawkapteenit($joukkue->tyyppi, $joukkue);
        } else {
            print '<br>';
            $this->p('Joukkueelle ei ole merkitty pelaajia kokoonpanoon.');
        }
        print '<br>';


    }

    function drawmaalivahdit ($tyyppi, &$joukkue) {
        print '<br>';

        $this->p('Maalivahdit');
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
                print $v;
                print ' </td>  <td>';
                $cb = new Input($tyyppi."maalivahtihlo$i", $k,'hidden');
                $cb->draw();
                $cb = new Input($tyyppi."mvtuloaika$i", $joukkue->pelaajat[$k]['mvtuloaika'],'text',5);
                $cb->draw();


                print ' </td>  <td>';
                $cb = new Input($tyyppi."paastetytmaalit$i", $joukkue->pelaajat[$k]['paastetytmaalit'],'text',4);
                $cb->draw();
                print '</td> </tr>';
                $i++;
            }
            print '</table>';
        } else {
            print '<br>';
            $this->p('Ei merkitty.');
        }
    }
    function drawkapteenit ($tyyppi,&$joukkue) {
        print '<br>';

        $this->p('Kapteenit');
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
                print $v;
                print ' </td>  <td>';
                $cb = new Input($tyyppi."kapteenihlo$i", $k,'hidden');
                $cb->draw();

                $cb = new Input($tyyppi."kaptuloaika$i",$joukkue->pelaajat[$k]['kaptuloaika'],'text',5);
                $cb->draw();
                print '</td> </tr>';
                $i++;

            }
            print '</table>';
        } else {
            print '<br>';
            $this->p('Ei merkitty.');

        }
        print '<br>';

    }

    function drawMaalintekijat ($tyyppi,&$joukkue) {
        print '<br>';
        print '<br>';
        $this->p('Maalit');
        if ( count($joukkue->maalit) > 0 ) {
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
      <?php $this->p('sy&ouml;tt&auml;j&auml;');?>
      </th>
      <th>
      <?php $this->p('av/yv/tasa');?>
      </th>
      <th>
      <?php $this->p('Siirretyn rangaistuksen aikana');?>
      <br>
      <?php $this->p('tyhj&auml;maali');?>
      <br>
      <?php $this->p('rangaistuslaukaus');?>
      </th>


    </tr>
    <?php
    $tyypit = array('no' => $this->tm->getText('Normaali'),'yv'=>$this->tm->getText('Ylivoima'),
                'av' => $this->tm->getText('Alivoima'));

    $i=1;
    foreach ($joukkue->maalit as $k => $v ) {
        print '<tr> <td>';
        print ($i);
        print ' </td>  <td>';
        $cb  = new Input($tyyppi.'tapahtumisaika'.$i,$v['tapahtumisaika'],'text',5);
        $cb->draw();
        print ' </td>  <td>';
        $kotim = $this->toiminto->tiedot['kotimaalit'];
        $cs = new Select($joukkue->select,$tyyppi.'tekija'.$i,$v['tekija']);
        $cs->draw();
?>
      </td>
      <td>
<?php
        $kotim = $this->toiminto->tiedot['kotimaalit'];
        $cs = new Select($joukkue->select,$tyyppi.'syottaja'.$i,$v['syottaja']);
        $cs->draw();
?>

      </td>
      <td>
<?php
        $cs = new Radiobutton($tyypit,$tyyppi."tyyppi$i",$v['tyyppi']);
        //$cs = new Input('tyyppi'.$i,$v['tyyppi'],'text',8);
        $cs->LINEBREAK = '<br>';
        $cs->draw();
?>
      </td>

      <td>
<?php
        $s = (isset($v['tyhjamaali']) and  $v['tyhjamaali'] == 't');

        $cs = new Checkbox($tyyppi."tyhjamaali$i",'t','Tyhj&auml; maali',$s);
        $cs->draw();
?>
<br>
<?php
        $s = ( isset($v['siirrangaikana']) and $v['siirrangaikana'] == 't' );

        $cs = new Checkbox($tyyppi."siirrangaikana$i",'t','siirretyn rangaistuksen aikana',$s);
        $cs->draw();

?>
<br>
<?php
        if ( $v['rangaistuslaukaus'] == 't' ) {
            $s = $this->tm->getText('rangaistuslaukaus');
        }

        $cs = new Checkbox($tyyppi."rangaistuslaukaus$i",'t','rangaistuslaukaus',$s);
        $cs->draw();


      ?>
      </td>
      </tr>
<?php
        $i++;
    }
    print '</table>';
        } else {
            print '<br>';
            $this->p('Ei maaleja.');
        }
        print '<br>';

    }

    function drawEpaonnistuneet ($tyyppi, &$joukkue) {
        $tekijat = &$joukkue->epaonnisrankut;
        $this->p('Ep&auml;onnistuneet rangaistuslaukaukset');
        if ( count($tekijat ) > 0 ) {

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
      <?php $this->p('Siirretyn rangaistuksen aikana');?>
      <br>
      <?php $this->p('tyhj&auml;maali');?>
      </th>

    </tr>
    <?php
    $tyypit = array('no' => $this->tm->getText('Normaali'),'yv'=>$this->tm->getText('Ylivoima'),
                'av' => $this->tm->getText('Alivoima'));

    $i=1;
    foreach ($tekijat as $k => $v ) {
        print '<tr> <td>';
        print ($i);
        print ' </td>  <td>';
        $cb  = new Input($tyyppi.'ertapahtumisaika'.$i,$v['tapahtumisaika'],'text',5);
        $cb->draw();
        print ' </td>  <td>';
        $kotim = $this->toiminto->tiedot['kotimaalit'];
        $cs = new Select($joukkue->select,$tyyppi.'ertekija'.$i,$v['tekija']);
        $cs->draw();
?>
      </td>
      <td>
<?php
        $cs = new Radiobutton($tyypit, $tyyppi.'ertyyppi'.$i, $v['tyyppi']);
        //$cs = new Input('tyyppi'.$i,$v['tyyppi'],'text',8);
        $cs->LINEBREAK = '<br>';
        $cs->draw();
?>
      </td>

      <td>
<?php
        $s = (isset($v['tyhjamaali']) and  $v['tyhjamaali'] == 't');

        $cs = new Checkbox($tyyppi."tyhjamaali$i",'t','Tyhj&auml; maali',$s);
        $cs->draw();
?>
<br>
<?php
        $s = ( isset($v['siirrangaikana']) and $v['siirrangaikana'] == 't' );

        $cs = new Checkbox($tyyppi."siirrangaikana$i",'t','siirretyn rangaistuksen aikana',$s);
        $cs->draw();

      ?>
      </td>
      </tr>
<?php
        $i++;
    }
    print '</table>';

        } else {
            print '<br>';
            $this->p('Ei merkint&ouml;j&auml;.');
        }
        print '<br>';

    }
    function drawJaahyt ($tyyppi, &$joukkue) {
        $this->p('J&auml;&auml;hyt');
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
            $i=1;
        foreach ($joukkue->jaahyt as $k => $v ) {
            print '<tr> <td>';
            print ($i);
            print ' </td>  <td>';
            $cs = new Select($joukkue->select, $tyyppi.'jhsaaja'.$i,$v['saaja']);
            $cs->draw();
            print ' </td>  <td>';
            $cb = new Input($tyyppi."jhminuutit$i", $v['minuutit'], 'text',5);
            $cb->draw();
            print ' </td>  <td>';
            $cb = new Input($tyyppi."jhsyy$i", $v['syy'], 'text',5);
            $cb->draw();

            print ' </td>  <td>';
            $cb = new Input($tyyppi."jhtapahtumisaika$i",$v['tapahtumisaika'],'text',5);
            $cb->draw();
            print ' </td>  <td>';
            $cb = new Input($tyyppi."jhpaattymisaika$i",$v['paattymisaika'],'text',5);
            $cb->draw();

            print '</td> </tr>';
            $i++;

        }
        print '</table>';
        } else {
            print '<br>';
            $this->p('Ei merkint&ouml;j&auml;.');
        }
        print '<br>';

    }
}
?>