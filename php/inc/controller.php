<?php
/**
 * controller.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: %date%
 *
*/


require_once("toimintofactory.php");
require_once("translationmanager.php");

/**
 * class Controller
 *
 */
class Controller
{

    /** Aggregations: */



    var $toiminto;
    var $template;

    function Controller(){

        global $DEFAULTLANGUAGE;

        // Yleinen joukkueid vaihtuu välillä
        if( !isset($_SESSION['joukkue']) ) {
            $_SESSION['joukkue'] = $_SESSION['defaultjoukkue'];
        }


        // toiminto pino
        if( !isset($_SESSION['palaa']) ) {
            $_SESSION['palaa'] = array();
            D("<br>ORJL<br>");
        }

        // yleinen kausi joka vaihtuu välilllä
        if( !isset($_SESSION['kausi']) ) {
            $_SESSION['kausi'] = $_SESSION['defaultkausi'];
        }


        // yleinen sarjaID joka vaihtuu välilllä
        if( !isset($_SESSION['sarja']) ) {
            $_SESSION['sarja'] = $_SESSION['defaultsarjaid'];            
        }
        
        if( !isset($_SESSION['kaikkisarjat']) ) {
        	$_SESSION['kaikkisarjat'] = false;
        }

        // check language
        if ( isset($_REQUEST['kieli']) ) {
            $tm = &TranslationManager::instance();
            if( $tm->setLanguage( $_REQUEST['kieli'] ) ) {
                $_SESSION['lang'] = $_REQUEST['kieli'];
            }
        }

        if ( !isset($_SESSION['lang']) )
        {
            $tm = &TranslationManager::instance();
            $tm->setLanguage( $DEFAULTLANGUAGE  );
        }
        else
        {
            $tm = &TranslationManager::instance();
            $tm->setLanguage( $_SESSION['lang'] );
        }
        unset($this->toiminto);
        unset($this->template);
    }

    function processToiminto( ) {
        /*
        luocookie-1 == sessionarvo -> commit OK
        random uudet arvot molempiin
        */

        //D('<pre>PALAA1:');
        //D($_SESSION['palaa']);
        //D('</pre>');

        $toim = &$this->getToiminto();

        $toiminto = &createToiminto( $toim );
        D("TOKA");
        D($_REQUEST);
        
        $toiminto->lataaTiedot();
       D("KOLMAS");
        D($_REQUEST);
       	$toiminto->suorita();

        if( !isset($_SESSION['errors']) ) {
            $_SESSION['errors'] = array();
        }

        $_SESSION['errors'] = array_merge($_SESSION['errors'], $toiminto->errors);


        // Ollaanko painettu backia??
        /*$size = count($_SESSION['palaa']);
        if($size > 2 and $_SESSION['palaa'][$size-3] == $toiminto->toiminnonNimi) {
            $pois = array_pop( $_SESSION['palaa'] );
            $pois = array_pop( $_SESSION['palaa'] );
        }*/

        if ( $toiminto->autoRefresh() ) {
            
            $this->template = 'refresh.php';
            $registry = &Registry::instance();

			// Onko oma refresh linkki asetettu laitettu
            $link = $toiminto->getOmaRefreshLink();
              	
            $seuraava = $toiminto->nykyinenTila();

            if( $seuraava == $toiminto->toiminnonNimi and $toiminto->succeeded() ) {
                D( "Takaisin kytkent&auml;");
                array_pop($_SESSION['palaa']);
                $seuraava = $toiminto->nykyinenTila();
                
                unset($_SESSION['tuloslisays']);
                unset($_SESSION['tiedot']);
                unset($_SESSION['vanhaTila']);
                unset($_SESSION['seuraavatila']);
                
            } 
            
  	         if( $link === '' ) {
	        	$link .= 'index.php?autorefresh=1&';	        
            	$link .= 'alitoiminto='.$seuraava;
  	         }
  	         
            /*
            else {
                D( "Normaali siirtyminen");
                $link = 'toiminto='.$toiminto->nykyinenTila();
            }*/

            $registry->setEntry('link', $link);
        }

        // Puhdistaa tila pinoa jos on käytetty backiä
        if( isset($_SESSION['palaa']) ) {
	        $size = count($_SESSION['palaa']);
	        if ( $size > 0 and isset($_REQUEST['his']) and
	                in_array($_SESSION['palaa'][$size-1],$_SESSION['palaa'])) {
	
	            $last = $_SESSION['palaa'][$size-1];
	            $uus = $_SESSION['palaa'];
	            $_SESSION['palaa'] = array();
	            for ($i = 0 ; $i < $size ; $i++ ) {
	                array_push($_SESSION['palaa'],$uus[$i] );
	
	                if ( $last == $uus[$i] ) break;
	            }
	
	        }
	        else if( $size > 2 and $_SESSION['palaa'][$size-1] == $_SESSION['palaa'][$size-3]) {
	            $pois = array_pop( $_SESSION['palaa'] );
	            $pois = array_pop( $_SESSION['palaa'] );
	        }
        }

         D( '<pre>PALAA2:');
        D($_SESSION['palaa']);
        D( '</pre>');
    }

    /**
     * Draws the actual page from the template.
     */

    function drawTemplate(){
        require_once($this->template);
    }

    function setTemplate($template){
        $this->template = $template;
    }

    function &getToiminto(){
        /**
         * tarkistaa onko siirrytty alitilasta päämenun linkin kautta johonkin
         * tilaan ja nollaa historian.
         */
        if ( !array_key_exists('alitoiminto', $_REQUEST) ) {
            if ( array_key_exists('tilat', $_SESSION) ) {
                   unset($_SESSION['tilat']);
            }
        }
        else if( isset($_REQUEST['alitoiminto']) and $_REQUEST['alitoiminto'] != '' ){
            $_REQUEST['toiminto'] = $_REQUEST['alitoiminto'];
        }

        // painettu menu linkkiä
        if( isset($_REQUEST['menu']) ) {
            $_SESSION['palaa'] = array();
            if( isset($_SESSION['tallennus']) ) {
                unset($_SESSION['tallennus']);
            }
            if( isset($_SESSION['IDS']) ) {
            	foreach( $_SESSION['IDS'] as $id ) {
                 	unset($_SESSION['ID'.$id]);
            	}
            	unset($_SESSION['IDS']);
            }
        }

//        if( isset($_REQUEST['palaa']) ) {
//            print "palaaaaa";
//            $_REQUEST['toiminto'] = $_REQUEST['seuraava'];
//        }

        if ( !isset($_REQUEST['toiminto']) ) {
            $_REQUEST['toiminto'] = "main";
        }
        return $_REQUEST['toiminto'];
    }

} // end of Controller

/**
 * Used by page template to get access to view.
 */
function &getView(){
    $registry = &Registry::instance();
    return $registry->getEntry('view');
}

function D($s){
    global $DEBUG;
    if ( !$DEBUG ) return;
    print '<font size=1>';
    print "<pre>";
    
    if ( is_array($s)) {
        print_r($s);
    }
    else {
        print $s;
    }
    print "</pre>";
    print '</font>';
}
?>
