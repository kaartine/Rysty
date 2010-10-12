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

 class TuloksenLisaysView extends View
{

    /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function TuloksenLisaysView (&$arg) {
        $this->View($arg);
    }
    /**
     * Overridden from View
     */
    function drawMiddle () {
        $this->p('Sivu 1');
        $this->toiminto->otsikkoView->draw();
?>
<FORM NAME="poytakirja" ACTION="index.php" METHOD="POST">
  <table>
    <tr>
      <td width="150"><?php
        print '&nbsp;';
        print '</td><td><b>';
        $this->p('Joukkue A:');
        print '</b></td><td>';
        print '&nbsp;';
        print '</td><td><b>';
        $this->p('Joukkue B:');
        print '</b></td></tr><tr><td>';

        print '&nbsp;';
        print '</td><td>';
        print $this->toiminto->koti->nimi;
        print '</td><td>';
        print '&nbsp;';
        print '</td><td>';
        print $this->toiminto->vieras->nimi;
        print '</td></tr><tr><td>';
        print $this->tm->getText("Maalit");
        print '</td><td>';
                $this->toiminto->tiedot['kotimaalit'][0]->draw();
        print '</td><td>';
        print '-';
        print '</td><td>';
                $this->toiminto->tiedot['vierasmaalit'][0]->draw();
        print '</td><td  width="150">';
        $this->toiminto->tiedot['eipoytakirjaa'][0]->draw();
        print '</td><td>';
        print '</td></tr></table><br />';
        ?>
  <table>
    <tr>
      <td width="150"><?php
        print $this->tm->getText("Rangaistukset");
        print '</td><td>';
                $this->toiminto->tiedot['kotirangaistukset'][0]->draw();
        print '</td><td>';
        print '-';
        print '</td><td>';
                $this->toiminto->tiedot['vierasrangaistukset'][0]->draw();
        print '</td></tr><tr><td>';
        print $this->tm->getText("Ep&auml;onnistuneet rankut");
        print '</td><td>';
                $this->toiminto->tiedot['kotiepaonnstuneetrankut'][0]->draw();
        print '</td><td>';
        print '-';
        print '</td><td>';
                $this->toiminto->tiedot['vierasepaonnstuneetrankut'][0]->draw();

        print '</td></tr></table>';
        ?><br />
  <table>
    <tr>
      <td width="150"><?php
        print $this->tm->getText('Toimitsija1');
        print '</td><td>';
        $this->toiminto->tiedot['toimitsija1'][0]->draw();
        print '</td></tr><tr><td>';
        print $this->tm->getText('Toimitsija2');
        print '</td><td>';
        $this->toiminto->tiedot['toimitsija2'][0]->draw();
        print '</td></tr><tr><td>';
        print $this->tm->getText('Toimitsija3');
        print '</td><td>';
        $this->toiminto->tiedot['toimitsija3'][0]->draw();

        print '</td></tr><tr><td>';

        print '</td><td>';


        print '</td></tr></table>';
        ?><br />
  <table>
    <tr>
      <td width="150"><?php
        print $this->tm->getText('Tuomari1');
        print '</td><td>';
        $this->toiminto->tiedot['tuomari1'][0]->draw();
        print '</td></tr><tr><td>';
        print $this->tm->getText('Tuomari2');
        print '</td><td>';
        $this->toiminto->tiedot['tuomari2'][0]->draw();

        print '</td></tr></table>';
        ?><br />
  <table>
    <tr>
      <td width="150"><?php

        print $this->tm->getText("AikalisaA");
        print '</td><td>';
                $this->toiminto->tiedot['aikalisaa'][0]->draw();
        print '</td></tr><tr><td>';
        print $this->tm->getText("AikalisaB");
        print '</td><td>';
                $this->toiminto->tiedot['aikalisab'][0]->draw();
        print '</td></tr></table>';


        $this->toiminto->tiedot['toiminto'][0]->draw();
        $this->toiminto->tiedot['seuraavatila'][0]->draw();
        $this->toiminto->tiedot['peliid'][0]->draw();
        $this->toiminto->tiedot['kotijoukkue'][0]->draw();
        $this->toiminto->tiedot['vierasjoukkue'][0]->draw();
        print '<br /><INPUT TYPE="SUBMIT" NAME="seuraava" VALUE="';
        print $this->tm->getText('Seuraava');
        print '">';
        print '</FORM>';

    }

}
 ?>