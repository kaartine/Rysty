<?php
/**
 * sarjaview.php  
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen 
 *   Teemu Siitarinen 
 * 
 * author: tepe
 * created: %date%
 * 
*/

require_once("listaview.php");

/**
 * class SarjaView
 * 
 */
class SarjaView extends ListaView
{

	/**
     * rakentajan viite (&) on tärkeä muistaa laittaa mukaan. 
     */
    function SarjaView (&$arg) {
    	$this->ListaView($arg);

        $this->headers = array(
        	'nimi'=>$this->tm->getText('Sarja'),
        	'kausi'=>$this->tm->getText('Kausi'),
        	'tyyppi'=>$this->tm->getText('Tyyppi'),
        	'kuvaus'=>$this->tm->getText('Kuvaus'),
        	'jarjestaja'=>$this->tm->getText('j&auml;rjest&auml;j&auml;')
        );
        $this->toiminnonNimi = "sarjat";
    }
    
    /** Aggregations: */

    /** Compositions: */

     /*** Attributes: ***/

	/*function drawMiddle () {    
	    $name = $this->tm->getText("Nimi");				
		$description = $this->tm->getText("Kuvaus");
		$organizer = $this->tm->getText("J&auml;rjest&auml;j&auml;");
		$season = $this->tm->getText("Kausi");
		$type = $this->tm->getText("Tyyppi");
		$button = $this->tm->getText("Lis&auml;&auml;");
		$modify = $this->tm->getText("Muokkaa");
				
	    if( !isset($_REQUEST[action]) or $_REQUEST[action] == listaa ) {
	    	print<<<END
	    	<table>
			<tr>
			<th>$name</th>
			<th>$description</th>
			<th>$season</th>
			<th>$type</th>
			<th>$organizer</th>
			<th>&nbsp;</th>
			</tr>	
END;
			foreach($this->toiminto->getData("series") as $value)
			{																	
				print<<<END
				<tr><td>$value[nimi]</td><td>$value[kuvaus]</td><td>$value[kausi]</td>
				<td>$value[tyyppi]</td><td>$value[jarjestaja]</td>
				<td>
				
				<form action="index.php" method="post">
				<input type="hidden" name="toiminto" value="sarjat" />
				<input type="hidden" name="action" value="muokkaa" />
				<input type="hidden" name="sarjaID" value="$value[sarjaid]" />
				<input type="submit" name="send" value="$modify" />
				</form>
				</td>
				</tr>
END;
			}
			print<<<END
			</table>
			
			<form action="index.php" method="post">
			<input type="submit" name="send" value="$button" />
			<input type="hidden" name="toiminto" value="sarjat" />
			<input type="hidden" name="action" value="uusi" />
			</form>
END;
	    }
	    else {				
	    	
	    	$serie = $this->toiminto->getData("series");
	    	print_r ($serie);
			$serie = $serie[0];	    		    	
	    		    	
			print<<<END
			<form action="index.php" method="post">
			<input type="hidden" name="action" value="lisaa">
			<table>
			<tr>
				<th>$name</th>
				<td><input type="text" name="nimi" value="$serie[nimi]" size="20" maxlength="20"/></td>
			</tr>
			<tr>
				<th>$description</th>
				<td><input type="text" name="kuvaus" value="$serie[kuvaus]" size="20" maxlength="20"/></td>
			</tr>
			<tr>
			<th>$season</th>
			<td>
		    	<select name="kausi">
END;
				foreach($this->toiminto->getData("season") as $tyyppiValue) {
					foreach($tyyppiValue as $value) {
						$v = $this->tm->getText($value);
						print "<option value=\"".$value."\" ".($value == $serie[vuosi] ? "default" : ""). ">".$v."</option>";
					}
				}					
				print<<<END
		      	</select>
			</td>
			</tr>
			<tr>
			<th>$type</th>
			<td>
				<select name="tyyppi">
END;
				foreach($this->toiminto->getData("types") as $tyyppiValue) {
				    foreach($tyyppiValue as $value) {
						$v = $this->tm->getText($value);
						print "<option value=\"".$value."\" ".($value == $serie[tyyppi] ? "default" : ""). ">".$v."</option>";
					}
				}					
				print<<<END
				</select>
			</td>
			</tr>
			<tr>
				<th>$organizer</th>
				<td><input type="text" name="jarjestaja" value="$serie[jarjestaja]" size="20" maxlength="20"/></td>
			</tr>
			</table>
			<input type="submit" name="send" value="$button" />
			<input type="hidden" name="toiminto" value="sarjat" />
			</form>
END;
	    }
	}*/




} // end of SarjaView
?>
