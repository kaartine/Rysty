<?php
/*
 * rekisteriview.php  
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * Created on Apr 20, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */
  require_once("view.php");

/**
 * class RekisteriView
 * 
 */
class RekisteriView extends View
{

     /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function RekisteriView (&$arg) {
        $this->View($arg);
        $kuvaus='';
    }
    function drawMiddle () {
    
    GLOBAL $JOUKKUEENNIMI;
    GLOBAL $EMAIL;
?>

<div>
    <h4 style="margin-top: 5px;">1. - 2. Rekisterin pit&auml;j&auml; ja rekisteriasioista 
    vastaava</h4>
    <p><?php print "$JOUKKUEENNIMI, $EMAIL"; ?></p>
    <h4>3. Rekisterin nimi</h4>
    <p><?php print "$JOUKKUEENNIMI"; ?> salibandy joukkueen pelaaja-/k&auml;ytt&auml;j&auml;rekisteri.</p>
    <h4>4. Rekisterin k&auml;ytt&ouml;tarkoitus</h4>
    <p>Rekisterin k&auml;ytt&ouml;tarkoitus on tarjota tilastotietoa pelaajien ja 
    joukkueiden salibandyotteluista. Rekister&ouml;ityminen tapahtuu yll&auml;pit&auml;j&auml;n 
    toimesta.</p>
    <h4>5. Rekisterin tietosis&auml;lt&ouml;</h4>
    <p>&nbsp;&nbsp;&nbsp; Pelaajasta tallennetaan SSBL:n
    <a class="linkki" href="http://www.salibandy.net/liitto/default.asp?sivu=39&amp;alasivu=105&amp;kieli=246">
    p&ouml;yt&auml;kirjan</a> sis&auml;lt&auml;m&auml;t tiedot.</p>
    <p>&nbsp;&nbsp;&nbsp; Henkil&ouml;st&auml; tallennetaan nimi, pelinumero sek&auml; 
    pelitilastot.</p>
    &nbsp;&nbsp;&nbsp; Rekister&ouml;ityneen k&auml;ytt&auml;j&auml;n on mahdollista tallentaa:
    <ul class="rekisteri">
      <li>etunimi</li>
      <li>sukunimi </li>
      <li>syntym&auml;aika </li>
      <li>lempinimi </li>
      <li>paino </li>
      <li>pituus </li>
      <li>kuva </li>
      <li>kuvaus </li>
      <li>k&auml;tisyys </li>
      <li>mailan merkki</li>
      <li>puhelinnumero </li>
      <li>faxinumero</li>
      <li>s&auml;hk&ouml;postiosoite </li>
      <li>katuosoite</li>
      <li>postinumero</li>
      <li>postitoimipaikka</li>
      <li>maa</li>
      <li>selite</li>
    </ul>
    <h4>6. S&auml;&auml;nn&ouml;nmukaiset tietol&auml;hteet</h4>
    <p>Rekister&ouml;idyt ovat luovuttaneet tiedot itse omalla suostumuksellaan.</p>
    <h4>7. S&auml;&auml;nn&ouml;nmukaiset tietojen luovutukset ja tietojen siirto EU:n tai 
    Euroopan talousalueen ulkopuolelle</h4>
    <p>Rekisteriin annetut tiedot n&auml;kyv&auml;t sivustolla osoitetietoja lukuun 
    ottamatta sivuston luonteen vuoksi. Luovuttaessaan tiedot rekister&ouml;ity 
    suostuu siihen, ett&auml; kyseiset tiedot n&auml;kyv&auml;t muille sivuston k&auml;ytt&auml;jille. 
    Rekister&ouml;idyill&auml; on mahdollisuus muuttaa ja poistaa omia luovuttamiaan 
    tietoja halutessaan. Rekister&ouml;ityneiden k&auml;ytt&auml;jien osoitetiedot n&auml;kyv&auml;t vain 
    muille saman joukkueen rekister&ouml;ityneille k&auml;ytt&auml;jille.&nbsp; </p>
    <p>Salaisia tietoja ei luovuteta kolmansille osapuolille EU:n ja ETA:n 
    sis&auml;ll&auml; eik&auml; ulkopuolella.</p>
    <h4>8. Rekisterin suojauksen periaatteet</h4>
    <p>Jokaisella rekister&ouml;ityneell&auml; on k&auml;ytt&ouml;oikeus rekisteriin h&auml;nelle 
    my&ouml;nnetyll&auml; k&auml;ytt&auml;j&auml;tunnuksella. K&auml;ytt&auml;j&auml;tunnuksella ei kuitenkaan p&auml;&auml;se 
    muuttamaan muita salaisia tietoja kuin rekister&ouml;idyn itsens&auml; tietoja.
</div>
			
<?php	
    }    
}
?>
