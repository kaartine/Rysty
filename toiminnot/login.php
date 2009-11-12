<?php
/**
 * login.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 15.01.2005
 *
*/


require_once("toiminto.php");
require_once("loginview.php");
/**
 * class Login
 *
 */
class Login extends Toiminto
{
    function Login() {
        $this->Toiminto('login');    
    }
    
    var $failed;
    function suorita( )
    {
        $this->failed = false;
        $this->createView("LoginView");
        
 /*       
        print '<pre>';
        print_r($_SERVER);
        print '</pre>';
*/        

		if( !$this->LOGGED_IN  ) {
			$this->asetaSalaus(true);
		}
		
        if (array_key_exists('nimi', $_REQUEST) and !empty($_REQUEST['nimi']) and
            array_key_exists('salasana', $_REQUEST) and !empty($_REQUEST['salasana'])  )
        {       	
            $muista = array_key_exists('muistaminut', $_REQUEST) and !empty($_REQUEST['muistaminut']);
            $md5salasana = md5($_REQUEST['salasana']);
            $nimi = $_REQUEST['nimi'];
            $this->LOGGED_IN = $this->doLogin($nimi, $md5salasana, $muista);
            
            if ( $this->LOGGED_IN ) {
            //tästa alkaa takaisinkytkennän toimintasarja
		      	$this->asetaSalaus(false);
                return;
            } else {
                $this->failed = true;
                $this->addError($this->tm->getText('Nyt meni v&auml;&auml;rin joko tunnus tai salasana!'));                
            }
        }
        else {
            parent::suorita();   
        }

    } // end of member function suorita

} // end of Login
?>
