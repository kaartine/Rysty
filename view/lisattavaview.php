<?php
/*
 * Created on Jan 22, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 */

require_once("view.php");

/**
 * class LisattavaView
 * TODO:
    Alitilat Toimintoon?
    -muokkaus, refresh juttu
    Form elementit on luotu

 *
 */
class LisattavaView extends View
{
    var $formStart;

    /**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan.
     */
    function LisattavaView (&$arg) {
        $this->View($arg);
        $this->formStart = '<form action="index.php" method="post">';

    }

    /**
     * Overridden from View
     */
    function drawMiddle () {

        if ( $this->toiminto->drawForm ) {
            $this->drawForm();
            
            $this->palaaTakaisin();
        }
        else {
            print "SUCCESS?";
        }
    }
    
    function drawEiOikeuksiaForm(){
        print '<table> <tr>';
        foreach ( $this->toiminto->tiedot as $key => $value ) {

            if ( $value[0] === NULL and $value[2] === 'HIDDEN')
            {
                continue; // tällaista ei tulosteta
            }

            print '</td><td>';

            // onko lomakeelementti ensimmäinen alkio
            if ( !is_a( $value[0], 'LomakeElementti' ) ) { // joe ei niin luodaan semmonen
                $value[0] = $this->toiminto->luoLomakeElementti($key,$value);
            }
            // case insensitive compare
            if ( strcasecmp($value[0]->TYPE,'hidden') != 0 ) { // no label for hidden komponent
                print $this->tm->getText($key);
                // onko pakollinen tieto
            }
           print '</td><td>';
           $value[0]->draw();

            print '</td></tr>';
        }
        print '</table>';
    }

    function drawForm(){
            if ( !$_SESSION['onkooikeuksia']) {
                $this->drawEiOikeuksiaForm();
                return;
            }

        /*if ( array_key_exists('send',$_REQUEST) and !empty($_REQUEST['send']) ) {
            if ( isset($this->toiminto->notset ) ) {
                if ( count($this->toiminto->notset[0]) > 0) {
                    print "T&auml;yt&auml; ainakin t&auml;hdell&auml; (*) merkityt kent&auml;t!";
                    print_r($this->toiminto->notset[0]);
                }
                if (count($this->toiminto->notset[1]) > 0) {
                    print "Laiton pituus jossain: KORJAAAAAAA";
                }
                if (count($this->toiminto->notset[2]) > 0) {
                    print "Laiton arvo kent&auml;ss&auml;: <br>";
                    print_r($this->toiminto->notset[2]);
                }
            }
        }*/

        print $this->formStart;
        print  ' <table> <tr>';

        //$this->toiminto->asetaTiedot($this->toiminto->tiedot);

        foreach ( $this->toiminto->tiedot as $key => $value ) {

            if ( $value[0] === NULL and $value[2] === 'HIDDEN')
            {
                continue; // tällaista ei tulosteta
            }

            print '</td><td>';

            // onko lomakeelementti ensimmäinen alkio
            if ( !is_a( $value[0], 'LomakeElementti' ) ) { // joe ei niin luodaan semmonen
                $value[0] = $this->toiminto->luoLomakeElementti($key,$value);
            }
            // case insensitive compare
            if ( strcasecmp($value[0]->TYPE,'hidden') != 0 ) { // no label for hidden komponent
                print $this->tm->getText($key);
                // onko pakollinen tieto
                if ( $value[1] ) {
                    print ' *';
                }
            }
           print '</td><td>';
           $value[0]->draw();

            print '</td></tr>';

        }
        print '<tr><td><input type="hidden" name="toiminto" value="'.$this->toiminto->nykyinenTila().'"/>';
          /*
          if() {

          }*/

        print '<input type="submit" name="send" value="'.$this->tm->getText("L&auml;het&auml;").'"/></td>';
        print '<td><input type="submit" name="remove" value="'.$this->tm->getText("Poista").'"/></td></tr>';

        print "</table></form>";
    }
}
?>
