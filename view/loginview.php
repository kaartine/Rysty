<?php
/**
 * loginview.php  
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
 * class LoginView
 * 
 */
class LoginView extends View
{

    function drawMiddle () {
        if ( ( isset($_SESSION['nimi']) and isset($_SESSION['salasana']) ))
        {
            print $this->tm->getText('Tervetuloa').' '.$_SESSION['kokonimi'];
              print '<br /> <br />';
            $etusivu = $this->tm->getText("Etusivu");
            print "<a href=\"index.php?menu\">$etusivu</a>";
  
        }
        else // if not signed in 
        {
            if ( $this->toiminto->failed ) {
//                print $this->tm->getText("Tuliko kirjoitusvirhe?");
                print '<br />';
            }
            $name = $this->tm->getText('Nimi');                 
            $pw = $this->tm->getText('Salasana');
            $submit = $this->tm->getText('L&auml;het&auml;');
            $muista = $this->tm->getText('Muista minut');
            //print "Nimi: tepe ja salasana: tepe";
            // jos formissa käytti enctype="text/plain" niin post ei toiminut???
            print<<<END
            <form action="index.php?menu" method="post" > 
            $name: <input type="text" name="nimi"  size="20" maxlength="20" /><br />
            $pw: <input type="password" name="salasana" size="20" maxlength="20" /><br />
            <input type="checkbox" name="muistaminut" value="login" />$muista<br />
          <br /><input type="submit" name="send" value="$submit" />
          <input type="hidden" name="toiminto" value="login" />
          
              </form>
END;
            
        }        
    }


} // end of LoginView
?>