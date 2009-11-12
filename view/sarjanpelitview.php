
<?php
/**
  * sarjatilastotview.php
  * Copyright Rysty 2006:
  *   Teemu Lahtela
  *   Jukka Kaartinen
  *   Teemu Siitarinen
  *
  * author: Jukka
  * created: 24.10.2006
  *
  */

require_once("lisattavaview.php");

/**
 *  * class SarjanPelitView
 *  *
 *  */
class SarjanPelitView extends LisattavaView
{
    function SarjanPelitView(&$arg) {

        $this->LisattavaView($arg);
        $this->toiminnonNimi = "sarjanpelit";
    }
    
    /**
     * Overridden from View
     */
    function drawMiddle () {
        print '<form action="index.php?toiminto=sarjanpelit" method="post">';
        print $this->toiminto->sarjat->draw();
        $label = $this->tm->getText('Valitse');
        print '<input type="submit" name="kaudenvalinta" value="'.$label .'" /></form>';
        
        print '<br /><br />';
        if ( $this->toiminto->drawForm ) {            
            $this->drawForm();
            
            $this->palaaTakaisin();
        }
        else {
            print "SUCCESS?";
        }
        
        print '<br /><br />';                
        print $this->toiminto->sarjanpelit->draw();
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

        print  ' <table>';

        //$this->toiminto->asetaTiedot($this->toiminto->tiedot);

        foreach ( $this->toiminto->tiedot as $key => $value ) {

            if ( $value[0] === NULL and $value[2] === 'HIDDEN') {
                continue; // tällaista ei tulosteta
            }

            print '<tr><td>';

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

        print '<input type="submit" name="send" value="'.$this->tm->getText("L&auml;het&auml;").'"/></td></tr>';

        print "</table></form>";
    }
} // end of SarjanPelitView
?>

