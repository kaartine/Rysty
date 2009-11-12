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

 class TuloksenLisays2View extends View
{
    /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function TuloksenLisays2View (&$arg) {
        $this->View($arg);
        $kuvaus='';
    }
    /**
     * Overridden from View
     */
    function drawMiddle () {
        $this->p('Sivu 2');
        print '<FORM NAME="poytakirja" ACTION="index.php" METHOD="POST">';
        $this->toiminto->otsikkoView->draw();
        isoTeksti($this->toiminto->koti->nimi);
        $this->drawJoukkeenPelaajat($this->toiminto->koti);

        print '<br><hr><br>';
        isoTeksti($this->toiminto->vieras->nimi);
        $this->drawJoukkeenPelaajat($this->toiminto->vieras);

        $this->toiminto->tiedot['toiminto'][0]->draw();
        $this->toiminto->tiedot['seuraavatila'][0]->draw();
        $this->toiminto->tiedot['peliid'][0]->draw();
        $this->toiminto->tiedot['kotijoukkue'][0]->draw();
        $this->toiminto->tiedot['vierasjoukkue'][0]->draw();

        $cb = new Input('edellinen',$this->tm->getText('Edellinen'),'submit');
        $cb->draw();

        $cb = new Input('seuraava',$this->tm->getText('Seuraava'),'submit');
        $cb->draw();
        print '</FORM>';
    }
    function drawJoukkeenPelaajat (&$joukkue) {
    print '<br>';
            if ( !$this->hasErrors ) {
                $joukkue->sortPelaajat();
            }
            $pelaajat = $joukkue->pelaajat;
            if ( count($pelaajat) > 0 ) {
        ?>

  <table>
    <tr>
      <th><?php $this->p('pelaaja'); ?></th>
      <th><?php $this->p('Numero'); ?></th>
      <th><?php $this->p('Nimi'); ?></th>
      <th><?php $this->p('Maalivahti'); ?></th>
      <th><?php $this->p('kapteeni'); ?></th>
      <th><?php $this->p('(+/-)'); ?></th>
      <th><?php $this->p('Peliaika'); ?></th>
      <th><?php $this->p('Lis&auml;tiedot'); ?></th>
    </tr>
    <?php
    $toimih = array();
    foreach ( $pelaajat as $p ) {
        $hid = $p['pelaaja'];
        print '<tr>';
        print '<td>';
        array_push($toimih,array($hid,$p['nimi']));
        $kp = FALSE;
        if ( isset($p['kokoonpanossa']) and $p['kokoonpanossa']) {
            $kp = TRUE;
        }
        $cb = new Checkbox($joukkue->tyyppi.'pelaaja'.$hid,'pelaaja','', $kp);
        $cb->draw();

      print '</td><td>';
      $cb = new Input($joukkue->tyyppi.'numero'.$hid,$p['numero'],'text',2);
       $cb->draw();
      print '</td>';

      print '<td>';
      print $p['nimi'];
        ?>
        </td><td>
        <?php

        $cb = new Checkbox($joukkue->tyyppi.'maalivahti'.$hid,'maalivahti','',($p['maalivahti']=='t' and $kp));
        $cb->draw();
        ?>

        </td><td>
        <?php

        $cb = new Checkbox($joukkue->tyyppi.'kapteeni'.$hid,'kapteeni','', ($p['kapteeni']=='t' and $kp));
        $cb->draw();

      print '</td>';
      print '<td>';
      $cb = new Input($joukkue->tyyppi.'plusmiinus'.$hid,$p['plusmiinus'],'text',3);
      $cb->draw();
      print '</td>';
      print '<td>';
      $cb = new Input($joukkue->tyyppi.'peliaika'.$hid,$p['peliaika'],'text',5);
      $cb->draw();
      print '</td>';
      print '<td>';
      $cb = new Input($joukkue->tyyppi.'lisatieto'.$hid,$p['lisatieto'],'text',500);
      $cb->draw();
      print '</td>';

    print '</tr>';
    }
    print '</table>';
    print '<br><br>';
    print '<table>';
    $tar = array(array('',$this->tm->getText('Valitse toimihenkil&ouml;')));
    usort($toimih,'toimihenkSort');
    $toimih = $tar + $toimih;
    $t = ($joukkue->tyyppi == 'koti')?'a':'b';
    for ($i = 1 ; $i < 6 ; $i++ ) {
        print '<tr><td>';
        $this->p('Toimihenkil&ouml;');
        print " $i";
        print '</td><td>';
        $cs = new Select($toimih,$t.'toimihenkilo'.$i,
            $this->toiminto->tiedot[$t.'toimihenkilo'.$i][0]->VALUE);
        $cs->draw();
        //print_r($this->toiminto->tiedot[$t.'toimihenkilo'.$i][0]);
        print '</td></tr>';
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
function toimihenkSort($a,$b){
    return ($a[1] > $b[1]);
}

?>