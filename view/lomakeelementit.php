<?php
/*
 * Created on Jan 20, 2005
 *
 * Created by Teemu Lahtela
 * (c) L‰mmi
 */
 class LomakeElementti{
    var $DATA;
    var $LENGTH;
    var $TYPE;
    // k‰‰nt‰j‰
    var  $TM;
    var  $onkoMuokkausOikeuksia;
    function LomakeElementti() {
        // Nopeutetaan niiden lomakeelementtien piirt‰mist‰ mitk‰ eiv‰t tarvitse k‰‰nt‰j‰‰
        // sill‰ parentin rakentajaa ei kutsuta automaattisesti
        require_once 'toimintofactory.php';

        $this->TM = TranslationManager::instance();

        if( isset($_SESSION['onkooikeuksia']) ) {
            $this->onkoMuokkausOikeuksia = $_SESSION['onkooikeuksia'];
        }
    }

    function draw(){
    }
 }

 class Select extends LomakeElementti{
    var $SELECTED;
    var $NAME;
    var $OIKEUDET;
    /**
    * $data = array( array(id,text) )
    */
    function Select($data, $name, $selected=NULL, $oikeudet=NULL ){
        $this->LomakeElementti();
        $this->SELECTED = $selected;
        $this->DATA = &$data;
        $this->NAME = &$name;
        $this->OIKEUDET = &$oikeudet;

        $this->TYPE = 'select';
    }

    function draw(){
        if ( $this->onkoMuokkausOikeuksia or $this->OIKEUDET) {
            $this->drawOikeuksilla();
        }
        else {
            if ( $this->SELECTED != NULL ){
                foreach ($this->DATA as $k=>$rivi) {

                    $id = current($rivi);
                    $value = next($rivi);
                    if ($this->SELECTED == $id ) {
                        print $value;
                        break;
                    }
                }

            }
        }
    }
    function drawOikeuksilla() {
        print '<select name="'.$this->NAME.'" >';
        foreach ($this->DATA as $k=>$rivi) {

            $id = current($rivi);
            $value = next($rivi);

            if ($this->SELECTED == $id ) {
               print '<option value="'.$id.'" selected>'.$value.'</option>';
            }
            else {
               print '<option value="'.$id.'">'.$value.'</option>';
            }
        }
        print "</select> ";
    }
 }

 class SelectLisaa extends LomakeElementti{
    var $SELECTED;
    var $NAME;
    var $BUTTON;

    function SelectLisaa($name, $data, $button, $selected=NULL ){
        $this->LomakeElementti();
        $this->SELECTED = &$selected;
        $this->DATA = &$data;
        $this->NAME = &$name;
        $this->BUTTON = &$button;

        $this->TYPE = 'select';
    }

    function draw(){
        if ( $this->onkoMuokkausOikeuksia ) {
            $this->drawOikeuksilla();
        }
        else {
            if ( $this->SELECTED != NULL ){
                foreach ($this->DATA as $k=>$rivi) {

                    $id = current($rivi);
                    $value = next($rivi);
                    if ($this->SELECTED == $id ) {
                        print $value;
                        break;
                    }
                }

            }
        }
    }
    function drawOikeuksilla() {
        print '<select name="'.$this->NAME.'" >';
        foreach ($this->DATA as $k=>$rivi) {

            $id = current($rivi);
            $value = next($rivi);

            if ($this->SELECTED === $id ) {
               print '<option value="'.$id.'" selected>'.$value.'</option>';
            }
            else {
               print '<option value="'.$id.'">'.$value.'</option>';
            }
        }
    print "</select> ";
    $this->BUTTON->draw();
    }

 }

  class Checkbox extends LomakeElementti{
    var $SELECTED;
    var $NAME;
    var $LABEL;
    /**
     * Ensimm‰inen parametri on Elementin nimi(name), toinen arvo (value) ja
     * kolmas teksi (label), t‰m‰ tullaan k‰‰nt‰m‰‰n translationmanagerin kautta.
     * nelj‰s on boolean onko valittu ( true | false )
     */
    function Checkbox($name,$value,$label, $checked=FALSE ){
        $this->LomakeElementti();
        if ( $checked ) {
            $this->SELECTED = 'checked';
        } else {
            $this->SELECTED = '';
        }
        $this->DATA = $value;
        $this->NAME = $name;
        $this->LABEL = $label;
        $this->TYPE = 'checkbox';
    }

    function draw(){
        if ( !$this->onkoMuokkausOikeuksia ) {
            if ( $this->SELECTED == 'checked' ) print $this->DATA;
        }
        else {
            print '<input type="checkbox" name="'.$this->NAME.'" value="'.
                            $this->DATA.'" '.$this->SELECTED.' />'.$this->TM->getText($this->LABEL);
        }
    }
 }

class Radiobutton extends LomakeElementti{
    var $SELECTED;
    var $NAME;
    var $LINEBREAK;
    /**
     * Ensimm‰inen parametri on talukko vaihtoehdoista(esim. array("L","R"))
     * Toinen on nimi ja kolmas valitun vaihtoehdon nimi.
     */
    function Radiobutton($data, $name, $selected=NULL ){
        $this->LomakeElementti();
        $this->SELECTED = &$selected;
        $this->DATA = &$data;
        $this->NAME = &$name;
        $this->TYPE = "radio";
        $this->LINEBREAK = '';
    }

    function draw(){

        if ( !$this->onkoMuokkausOikeuksia ) {
            foreach ($this->DATA as $k => $rivi) {
                if ($this->SELECTED === $k ) {
                    print $rivi;
                }
            }
        }
        else {

            foreach ($this->DATA as $k => $rivi) {
                if ($this->SELECTED === $k ) {
                    print '<input type="radio" name="'.$this->NAME.'" value="'.$k.'" checked />'.$rivi;
                }
                else {
                    print '<input type="radio" name="'.$this->NAME.'" value="'.$k.'" />'.$rivi;
                }
                print $this->LINEBREAK;
            }
        }
    }
 }

class Input extends LomakeElementti{

    var $NAME;
    var $VALUE;
    /**
     * Ensimm‰inen parametri on talukko vaihtoehdoista(esim. array("L","R"))
     * Toinen on nimi ja kolmas valitun vaihtoehdon nimi.
     */
    function Input($name, $value = "", $type="text", $koko = 40){
        $this->LomakeElementti();
        $this->NAME = &$name;
        $this->TYPE = &$type;
        $this->VALUE = &$value;
        $this->LENGTH = &$koko;
    }

    function draw(){
        if ( !$this->onkoMuokkausOikeuksia ) {
            if ( strcasecmp($this->TYPE,'HIDDEN') != 0 )print $this->VALUE;

        }
        else {

            $koko = $this->LENGTH > 40?40:$this->LENGTH;
            print '<input type="'.$this->TYPE.'" name="'.$this->NAME.'" value="'.$this->VALUE.'" size="'.$koko.'" maxlength="'.$this->LENGTH.'" />';
        }
    }
 }

class FileInput extends LomakeElementti{

    var $NAME;
    var $VALUE;
    /**
     * Ensimm‰inen parametri on talukko vaihtoehdoista(esim. array("L","R"))
     * Toinen on nimi ja kolmas valitun vaihtoehdon nimi.
     */
    function FileInput($name){
        $this->LomakeElementti();
        $this->NAME = $name;
        $this->TYPE = 'FILE';
        $this->VALUE = '';
        $this->LENGTH = 0;
    }

    function draw(){
        if ( !$this->onkoMuokkausOikeuksia ) {
            // piirret‰‰nk‰ t‰h‰n se kuva?
        }
        else {

            print '<input type="file" name="'.$this->NAME.'" />';
        }
    }
 }
class TextArea extends LomakeElementti{

    var $NAME;
    var $VALUE;
    var $COLS;
    var $ROWS;
    /**
     * Ensimm‰inen parametri on talukko vaihtoehdoista(esim. array("L","R"))
     * Toinen on nimi ja kolmas valitun vaihtoehdon nimi.
     */
    function TextArea($name, $value = '', $cols='90', $rows= '10'){
        $this->LomakeElementti();
        $this->NAME = &$name;
        $this->TYPE = 'textarea';
        $this->VALUE = &$value;
        $this->COLS = &$cols;
        $this->ROWS = &$rows;

    }

    function draw(){
        if ( !$this->onkoMuokkausOikeuksia ) {
            print $this->VALUE;
        }
        else {
            print '<textarea name="'.$this->NAME.'" cols="'.$this->COLS.'" rows="'.$this->ROWS.'">'.$this->VALUE.'</textarea>';
          }
    }
 }

  class Link extends LomakeElementti {

    var $NAME;
    var $LABEL;
    var $ACTION;
    var $ALONE;
    var $HIDDENS;

    /**
     * Ensimm‰inen parametri on napin nimi, toinen kertoo lablelin
     * kolmas actionin mik‰ k‰sittelee seuraavan tapahtuman, nelj‰s kertoo onko
     * nappi oma forminsa ja viides on taulukko piilotetuista arvoista jos nappi
     * on oma forminsa $hidden = array ('pelaaja'=>1,'kausi'=>2);
     */
    function Link($name, $label, $action, $alone = false, $hiddens = NULL) {

        $this->LomakeElementti();

        $this->NAME = &$name;
        $this->LABEL = &$this->TM->getText($label);
        $this->ACTION = &$action;
        $this->ALONE = &$alone;
        $this->HIDDENS = &$hiddens;
    }

    function draw(){
        $tmp = "";
        if( $this->ALONE === true ) {
            if( $this->HIDDENS != NULL ) {
                foreach( $this->HIDDENS as $key => $value ) {
                    $tmp .= "&$key='$value'";
                }
            }
        }
        print "<a href='index.php?palaa=true&amp;toiminto=".$this->NAME."&amp;seuraava=".$this->ACTION."".$tmp."'>".$this->LABEL."</a>";
    }
 }


 class Button extends LomakeElementti {

    var $NAME;
    var $LABEL;
    var $ACTION;
    var $ALONE;
    var $HIDDENS;
    var $INDEX;

    /**
     * Ensimm‰inen parametri on napin nimi,
     * toinen kertoo lablelin HUOM label k‰‰nnet‰‰n jo t‰‰ll‰!
     * kolmas actionin mik‰ k‰sittelee seuraavan tapahtuman,
     * nelj‰s kertoo onko nappi oma forminsa ja
     * viides on taulukko piilotetuista arvoista jos nappi on oma forminsa
     * $hidden = array ('pelaaja'=>1,'kausi'=>2);
     */
    function Button($name, $label, $action, $alone = false, $hiddens = NULL) {

        $this->LomakeElementti();

        $this->NAME = &$name;
        $this->LABEL = &$this->TM->getText($label);
        $this->ACTION = &$action;
        $this->ALONE = &$alone;
        $this->HIDDENS = &$hiddens;

        if ( !isset ($_SESSION['buttonIndex'] ) ) {
             $_SESSION['buttonIndex'] = 0;
        }
        $this->INDEX = ++$_SESSION['buttonIndex']; 
    D(array('INDEX'=>$this->INDEX));

    }

    function draw(){
        if ( !$this->onkoMuokkausOikeuksia ) {
            return;
        }

        // Kokonaan oma
        if( $this->ALONE === true ) {
            print "<form action='index.php' method='post' >";
        }

        //print '<input type="hidden" name="palaa" value="true" />';
        print '<input type="hidden" name="alitoiminto'.$this->INDEX.'" value="'.$this->NAME.'"/>';
        print '<input type="hidden" name="seuraava'.$this->INDEX.'" value="'.$this->ACTION.'"/>';
        print '<input type="submit" name="palaa'.$this->INDEX.'" value="'.$this->LABEL.'" />';

        if( $this->ALONE === true ) {
            if( $this->HIDDENS != NULL ) {
                foreach( $this->HIDDENS as $key => $value ) {
                    print "<input type='hidden' name='$key' value='$value' />";
                }
            }
            print "</form>";
        }
    }
 }

 class Label extends LomakeElementti{
    /**
        Tulostaa teksti‰
     */
    function Label($value) {
        $this->LomakeElementti();
        $this->DATA = &$value;
    }

    function draw(){
        print $this->DATA;
    }
 }

?>
