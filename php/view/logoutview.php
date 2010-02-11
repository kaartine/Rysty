<?php
/**
 * logoutview.php  
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * author: tepe
 * created: 15.01.2005
 * 
*/

require_once("view.php");

/**
 * class LogoutView
 * 
 */
class LogoutView extends View
{
    
    function drawMiddle () {
        
        if ( isset($this->toiminto->loggedOut) )
        {      
            print $this->tm->getText('Kirjauduit ulos').' '.$this->toiminto->loggedOut;
        }
        else
        {
            print $this->tm->getText('Et ole kirjautunut sis&auml;&auml;n').".";
        }        
    }


} // end of LogoutView
?>