<?php
/**
 * view.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * @author: Teemu Lahtela
 * created: 15.01.2005
 *
*/

require_once "toimintofactory.php";

/**
 * class View
 *
 */
class View
{
    var $toiminto;
    var $tm;
    var $title;
    var $kantaanLaitettu;
    var $ohje;
    var $otsikko;
    var $menuPublic; // menun kaikille avoin rakenne
    var $menuLoggedIn; // menun sisään kirjautuneiden rakenne


    var $hasErrors;

    function View(&$toiminto){
        $this->toiminto = &$toiminto;
        $this->tm = TranslationManager::instance();
        //unset($this->title);
        
        GLOBAL $JOUKKUEENNIMI;
        $this->title = $JOUKKUEENNIMI;
        $this->kantaanLaitettu = NULL;
        $errors = $this->toiminto->getErrors();
        $this->hasErrors = ( $errors != null and count( $errors ) > 0);
        $this->ohje = $this->tm->ohje($this->toiminto->toiminnonNimi);
        $this->otsikko = $this->tm->getText($this->toiminto->toiminnonNimi);

        // toiminto == toiminnon tulostettava nimi
        // $menu[toiminto][0] == linkki == L, ulkopuolinen linkki U,väliotsikko == V, T == tyhjärivi
        // $menu[toiminto][1] == linkin toiminto
        // $menu[toiminto][2] == syvyys hierarkiassa default == 1 (ei sisennystä)
        $this->menuPublic = array(
            'main'=>array('L','main',('Etusivu')),
            'pelit'=>array('L','pelit',('Pelit')),
            'kokoonpano'=>array('L','kokoonpano',('Kauden kokoonpano')),
            '1'=>array('T'),
            '2'=>array('V','',('Tilastot')),
            'pelaajatilastot'=>array('L','pelaajatilastot',('Pelaajat'),2),
            'joukkuetilastot'=>array('L','joukkuetilastot',('Joukkue'),2),
            'sarjatilastot'=>array('L','sarjatilastot',('Sarjat'),2),            
            '3'=>array('T'),
            'uutislista'=>array('L','uutislista',('Uutiset')),
            '3'=>array('T')
         );

         //$this->menuLoggedIn = array_merge($this->menuPublic);

         $this->menuLoggedIn = array(
            '3'=>array('T'),
            '11'=>array('V','',('Yll&auml;pito')),
            'joukkueet'=>array('L','joukkueet','Joukkueet',2),
            'joukkueenlisays'=>array('L','joukkueenlisays',('Joukkueen lis&auml;ys'),3),
            '20'=>array('T'),
            'seurat'=>array('L','seurat',('Seurat'),2),
            'seuranlisays'=>array('L','seuranlisays',('Seuran lis&auml;ys'),3),
            '18'=>array('T'),
            /*'kaudenlisays'=>array('L','kaudenlisays',$this->tm->getText('Kauden lis&auml;ys'),2),
            'sarjatyypinlisays'=>array('L','sarjatyypinlisays',$this->tm->getText('Sarjatyypin lis&auml;ys'),2),
            'toimenlisays'=>array('L','toimenlisays',$this->tm->getText('Toimen lis&auml;ys'),2),
            '12'=>array('T'),*/
            'sarjanjoukkueet'=>array('L','sarjanjoukkueet',('Sarjan joukkueet'),2),
            'sarjanpelit'=>array('L','sarjanpelit',('Sarjan pelien lis&auml;&auml;minen'),2),
            'sarjat'=>array('L','sarjat',('Sarjat'),2),
            'sarjanlisays'=>array('L','sarjanlisays',('Sarjan lis&auml;ys'),3),
            '13'=>array('T'),
            'hallit'=>array('L','hallit',('Hallit'),2),
            'hallinlisays'=>array('L','hallinlisays',('Hallin lis&auml;ys'),3),
            '16'=>array('T'),
            'kayttajat'=>array('L','kayttajat',('K&auml;ytt&auml;j&auml;t'),2),
            'kayttajanlisays'=>array('L','kayttajanlisays',('K&auml;ytt&auml;j&auml;n lis&auml;ys'),3),
            '14'=>array('T'),
            'henkilot'=>array('L','henkilot',('Henkil&ouml;t'),2),
            'henkilonlisays'=>array('L','henkilonlisays',('Henkil&ouml;n lis&auml;ys'),3),
            '15'=>array('T'),
            'tapahtumat'=>array('L','tapahtumat',('Tapahtumat'),2),
            'pelinlisays'=>array('L','pelinlisays',('Pelin lis&auml;ys'),3),
	    'tapahtumanlisays'=>array('L','tapahtumanlisays',('Tapahtuman lis&auml;ys'),3),
            '26'=>array('T'),
            'uutiset'=>array('L','uutiset',('Uutisen lis&auml;ys'),2),
            '25'=>array('T'),
            '2'=>array('V','',('Joukkueen alue')),
            'intranet'=>array('L','intranet',('Intranet'),2),
            '19'=>array('U','filethingie.php',('Tiedostojen lis&auml;ys'),2),
            '27'=>array('U','../koovee2',('Foorumi'),2)
         );

            /*
        'henkilonlisays'=>array('HenkilonLisays','henkilonlisays','x----'),
        'henkilonmuokkaus'=>array('HenkilonLisays','henkilonlisays','x----'),
        'joukkueet'=>array('Joukkueet','joukkueet','x----'),

        'henkilot'=>array('Henkilot','henkilot','x-xx-'),
        'uutiset'=>array('Uutiset','uutiset','x-xx-'),
        'uutislista'=>array('UutisLista','uutislista','x-xxx'),
        'tuloksenlisays'=>array('TuloksenLisays','tuloksenlisays','x-xx-'),

        'intranet'=>array('Intranet','intranet','x----')
        */
    }
    /**
     * Sets the action for this View.
     * Reference, not a copy of the object.
     *
    function setToiminto (&$toiminto) {
        $this->toiminto = &$toiminto;
    }*/

    /**
     * This method is called when page is to be rendered.
     * All output should be done here and in the functions this method calls.
     * calls:drawMiddle
     */
    function drawPage () {
        if ( $this->kantaanLaitettu != NULL and count($this->kantaanLaitettu) > 0 ){
            $this->p('Tiedot tallennettiin tietokantaan.');
            print   '<table bgcolor="#FF8000">';
            foreach ( $this->kantaanLaitettu as $k => $v) {
                print "<tr><td>$k</td><td>$v</td></tr>";
            }
            print   '</table>';
        }
        $this->drawOtsikko();
        $this->drawHelp();
        $this->printErrors();
        print '<br />';
        $this->drawMiddle();
    }
    function naytaKantaanLisatyt ($kantaanlaitettu) {
        $this->kantaanLaitettu = $kantaanlaitettu;
    }
    /**
     * Getter for the title of the page
     */
    function &getTitle(){
        return $this->title;
    }
    /**
     * Draws the header of page. This is called by drawPage.
     */
    function drawHeader () {

    }
    /**
     * Draws the footer of the page. This is called by drawPage.
     */
    function drawLogo() {

    }
    
    /**
     * Draws the banner in to the footer of the page. This is called by drawPage.
     */
    
    function drawFooterBanner() {
        printLocalFooter();
    }
    
    /**
     * Draws the footer of the page. This is called by drawPage.
     */
    function drawFooter () {
        ?>
        <p class="modified" align="right">
        	<table>
        		<tr>
        			<td align="right">
                        <?php
					       GLOBAL $EMAIL;
                           print $EMAIL;
                        ?>
					    <br />
					    <a href="index.php?toiminto=rekisteri">
					    <?php print $this->tm->getText('Rekisteriseloste').'</a></td><td>';
					    ?>
					

<?php
           print '</td></tr></table>';
    }

    /**
     * Draws the version of the Rysty team management program.
     *
     */
    function drawVersion() {
        print $this->tm->getText('Rysty versio').': 0.31 &copy; Lämmi 2006';
/*        print "<pre>";
        print_r($_SESSION['tilat']);
        print_r($_SESSION);
        print "</pre>";*/
    }

    /**
     * Draws the banner of the page. This is called by drawPage.
     */
    function drawBanner () {
        //$i = rand(1, 5);
        //print "<img src=\"kuvat/banner$i.jpg\" alt=\"Banner\" border=\"0\" >";
        GLOBAL $JOUKKUEENNIMI;
        print "$JOUKKUEENNIMI<br />";
    }
    /**
     * This is an abstract function.
     * Subclasses should override this.
     * All views should do theri rendering in this function.
     * This is called by drawPage.
     */
    function drawMiddle () {

    }
    /**
     *
     */
    function drawLinks () {
    	//<table border='0'><tr><td>
        print "<div><ul>";

        $this->printMenuList($this->menuPublic);
        //print '</td></tr> <tr><td>';
        if( $this->isLoggedIn() ) {
            $this->printMenuList($this->menuLoggedIn);
        }
        else {
            ?>
<!--            
<tr><td>
<br>
<br>
<br>
<br>
<br>
</td></tr>
-->
            <?php
        }
        print "</ul></div>";
        //</td></tr></table>
    }

    function printMenuList($menu) {
        $tyhja = false;
        foreach( $menu as $item ) {
            $menuitem = "";
            if( $item[0] === 'L' and onkoOikeuksia($item[1])) {             
                $menuitem = $this->getToimintoLink($item);
                $tyhja = false;
            }
            else if( $item[0] === 'U') {
                $menuitem = $this->getLink($item);
                $tyhja = false;
            }
            else if($item[0] === 'V') {
                $menuitem = '<b>'.$this->tm->getText($item[2]).'</b>';
                $tyhja = false;
            }
            else if( $item[0] === 'T') {
                if( !$tyhja ) {
                    $menuitem = "&nbsp;";
                    $tyhja = true;
                }
            }

            if( $menuitem !== "" ) {
                print "<li>";
/*                if( isset($item[3]) ) {
                    $i=1;
                    while($i < $item[3]) {
                        print "&nbsp;&nbsp;";
                        $i++;
                    }
                }
*/
                print "$menuitem</li>";
            }
        }
    }
    
	function sisenna(&$value) {
    	$sisennys = "";
		if( isset($value[3]) ) {
            $i=1;
            while($i < $value[3]) {
                $sisennys .= "&nbsp;&nbsp;";
                $i++;
            }
        }
        return $sisennys;
	}
	
    function getToimintoLink(&$value, $menu = '&amp;menu' ) {             
        return '<a href="http://'.$_SERVER['SERVER_NAME'].$_SERVER['PHP_SELF'].'?toiminto='.$value[1].$menu.'">'.
                            $this->sisenna($value).$this->tm->getText($value[2]).'</a>';
    }
    
    
    function getLink(&$value){
        return '<a target="_blank" href="'.$value[1].'">'.
                            $this->sisenna($value).$this->tm->getText($value[2]).'</a>';
    }
    function drawLoginLink(){
        $log = $this->tm->getText("Login");
        $logtype = "login";
        $nimi = "";
        if ( ( isset($_SESSION['nimi']) and isset($_SESSION['salasana']) ))
        {
            $log = $this->tm->getText("Logout");
            $logtype = "logout";
            $omat = $this->tm->getText("omattiedot");

            $nimi = "<a href=\"index.php?toiminto=omattiedot&amp;menu\">".$_SESSION['kokonimi']."<br />($omat)</a>";
        }
        print "<a href=\"index.php?toiminto=".$logtype."&amp;menu\">".$log."</a><br /><br />$nimi";
    }

    /**
     * prints erros that occured during action
     *
     */
    function printErrors() {
        $errors = $_SESSION['errors']; //$this->toiminto->getErrors();

        if( $errors != null and count( $errors ) > 0)
        {
            isoTeksti($this->tm->getText('Huomautus!'));

            print '<table class="virhe" ><tr><td>';

            foreach($errors as $error)
            {
                print $this->tm->getText($error)."<br />";
            }
            print '</td></tr></table>';
        }
        $_SESSION['errors'] = array();
    }

    function drawHistory () {

        $main = 'main';
        $history = $this->getToimintoLink($this->menuPublic[$main]);
        
       	$l = count($_SESSION['palaa']);
        
        for ($i = 0 ; $i < ($l-1) ; $i++ ){
            $tila = $_SESSION['palaa'][$i];

            $v = (isset($this->menu[$tila])?$this->menu[$tila]:$tila);

            if ( $tila == $main ) continue;

            $p= '';

            /*if  ( isset($this->menuPublic[$v]) ) {
                $p = $this->getToimintoLink($this->menuPublic[$v],'&his');
            }
           else if  ( isset($this->menuLoggedIn[$v]) ) {
                $p = $this->getToimintoLink($this->menuLoggedIn[$v],'&his');
            }
            else {*/
                $p = '<a href="index.php?toiminto='.$tila.'&amp;his">'.$this->tm->getText($tila).'</a>';
            //}

            $history .=  ' -> '.($p);


        }
        $tila = $_SESSION['palaa'][$l-1];
         $v = (isset($this->menu[$tila])?$this->menu[$tila]:$tila);
         if ( $tila != $main ) {
            $history .=  ' -> '.$this->tm->getText($v);
         }

        // Poistaa " -> "-merkit ja printtaa lopputuloksen
//        print substr($history, 0, -4);
        print $history;
    }
    /**
     * Prints the given text in the current language.
     */
    function p($v) {
        print $this->tm->getText($v);
    }
    function &trans($v) {
        return $this->tm->getText($v);
    }
    function &get($val) {
        return $this->toiminto->tiedot[$val][0];
    }
    function isLoggedIn() {
        if( $this->toiminto->LOGGED_IN ) {
            return true;
        }
        else {
            return false;
        }
    }
    
    function heading(&$text, $size = 1 )  {
    	print '<h'.$size.'>'.$text.'</h'.$size.'>';
    }

    function drawLanguageSelection() {
        print '<a href="index.php?toiminto=main&amp;kieli=fi&amp;menu">'.
                            $this->tm->getText('Suomi').'</a>';
        print ' - ';
        print '<a href="index.php?toiminto=main&amp;kieli=en&amp;menu">'.
                            $this->tm->getText('English').'</a>';
    }


    /**
     * Luo napin jota pitkin pääsee takaisin edelliselle sivulle jos on tultu
     * jotain muuta kuin menun kautta.
     *
     * @params array( name,value, name,value, ...) yksiulotteinen vektori
     */
    function palaaTakaisinButton( $params = NULL ) {
        $size = count($_SESSION['palaa']);
        if($size > 1) {
        	
            print '<form action="index.php?toiminto='.$_SESSION['palaa'][$size-2].'" method="post" >';
            
            if( is_array($params) ) {
            	$size = count($params);            	            
            	$i=2;
		while( $i <= $size ) {
		    print '<input type="hidden" name="'.$params[0].'" value="'.$params[1].'"/>';
		    $i += 2;
            	}
            }
           		
	    print '<input type="submit" name="takaisin" value="'.$this->tm->getText("Takaisin").'"/></form>';
        }
    }
    
        /**
     * Luo napin jota pitkin pääsee takaisin edelliselle sivulle jos on tultu
     * jotain muuta kuin menun kautta.
     *
     * @params array( name,value, name,value, ...) yksiulotteinen vektori
     */
    function palaaTakaisin( $params = NULL/*, $button = false*/ ) {
        $size = count($_SESSION['palaa']);
        if($size > 1) {
            print '<p class="linkbutton" align="center"><a href="index.php?toiminto='.$_SESSION['palaa'][$size-2];
            
            if( is_array($params) ) {
            	$size = count($params);            
            	$i=2;
			    while( $i <= $size ) {
           			print '&amp;'.$params[0].'='.$params[1];
           			$i += 2;
           		}
            }
             print '">'.$this->tm->getText("Takaisin").'</a>';
        }
    }
    
    
    
    /**
     * Draw description of the form
     */
    function drawHelp() {
        if ( !empty($this->ohje) and $_SESSION['onkooikeuksia']) {
            beginFrame('ohje');
            print $this->ohje;
            endFrame();
            print '<br>';
            print '<br>';

        }
    }
    function drawOtsikko() {
        if ( !empty($this->otsikko) ) {
            isoTeksti($this->otsikko);
            print '<br><br>';

        }
    }
    
    /**
     * Draw icons like Rss feed, validator, widsets, ..
     */
    function drawBannerIcons() {
	print '<div align="right">';
	print '<a href="rss.xml">';
	print '  <img src="kuvat/feed-icon-32x32.png" alt="Rss feed" title="Rss feed" />';
	print '</a>';
											   
	print '<a href="http://www.widsets.com/widgets?publicwidgetid=W1992">';
	print '  <img src="http://www.widsets.com/images/promote/large.gif" alt="Add to my Widsets"/>';
	print '</a>';
	
	print '</div>';
    }


} // end of View

function beginFrame($class=NULL) {
    if ( $class != NULL ) {
    print '<table class="'.$class.'"><tr><td class="reunat">';
    }
    else {
    print '<table><tr><td class="reunat">';
    }
}

function endFrame() {
    print '</td></tr></table>';
}
function isoTeksti($teksti){
    print '<font class="isoteksti">';
    print $teksti;
    print '</font>';
}

?>
