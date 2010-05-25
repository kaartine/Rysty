<?php
/**
 * logout.php  
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
 require_once("logoutview.php");
/**
 * class Logout
 * 
 */
class Logout extends Toiminto
{
    /** Name of  user who just logged out */
    var $loggedOut;
    
    
    function Logout(){
        // call super
        $this->Toiminto('logout');
        // unset it so isset returns the correct value.
        
        unset($this->loggedOut);
    }
    
    function suorita( )
    {
        global $COOKIEHOURSTOLIVE;        
        // alustaa db muuttujan
        $this->createView("LogoutView");
                   
        if ( $this->LOGGED_IN )
        {
            
            $this->loggedOut = $_SESSION['nimi'];
            
            if ( setcookie('kvpelaaja1', FALSE, time()+60*60*$COOKIEHOURSTOLIVE, '/' ) ) { // time = 90 päivää
                D("COOKIE 1 SET OK");
            }
            if ( setcookie('kvpelaaja2', FALSE, time()+60*60*$COOKIEHOURSTOLIVE, '/' ) ) { // time = 90 päivää
                D("COOKIE 2 SET OK");
            }            
            unset($_SESSION['nimi']);
            unset($_SESSION['salasana']);
            
            //unset($_SESSION);
            
            $this->LOGGED_IN = false;
        }   
        else {
            unset($this->loggedOut);
        }     
    
    } // end of member function suorita

} // end of Logout
?>
