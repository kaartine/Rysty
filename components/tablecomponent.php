<?php

/**
 * tablecomponent.php
 * Copyright Rysty 2006:
 *   Jukka Kaartinen
 * 
 * Created on 19.4.2006
 *
 * 
 * Lista on komponentti joka voidaan liitt‰‰ sivulle. Sill‰ on oma id jolla siihen viitataan.
 */

/******************************* Abstract Class ****************************
  Toiminto does not have any pure virtual methods, but its author
  defined it as an abstract class, so you should not use it directly.
  Inherit from it instead and create only objects from the derived classes
*****************************************************************************/
//require_once ('tietokanta.php');

require_once ('component.php');

class TableComponent extends Component {

	// Sis‰iset muuttujat (Perityn luokan pit‰‰ asettaa n‰m‰.)
	var $headers; // Taulukon otsikot 
	 
	// array(
	//		array('sarakkeen nimi', 'css class -name'),	nimi k‰‰nnet‰‰n automaattisesti, css nimi voi olla tyhja
	//		...
	//	); 

	var $links;
	//$this->links = array(
	// 'viiteheaderssiin' => 
	//	'SL' = sis‰inen linkki, 'toiminto', array(parametri1, ... parametrin pit‰‰ lˆyty‰ SQL lauseesta), 'target' kertoo mihin avataan
	//  'UL' = ulkoinen linkki, 'osoite', 'target'
	//						  , array(parametri1, parametri2, ... parametrin pit‰‰ lˆyty‰ SQL lauseesta), 'target'

	// Voiko k‰ytt‰j‰ j‰rjest‰‰ taulukkoa
	var $allowUserSort = true;

	var $data;
	
	var $db;

	function TableComponent($toiminto, $pageLength = 0) {
		$this->Component($toiminto);

		$this->set('pageLength', $pageLength); // Sivun pituus (rivien m‰‰r‰ sivulla) 
		// jos < 1 niin kaikki n‰ytet‰‰n oletus.
		$this->set('page', 1); // Valittu sivu

		/**
		 * N‰m‰ pit‰‰ m‰‰ritell‰ perityss‰ luokassa.
		 *
		 */
		//$this->set('dorder', array( 'col name2' , 'col name2') ));	// Oletus j‰rjestys. vain kaksi arvoa
        				
		if( $this->get('order') == NULL ) {			 
			$this->set('order', array());			// K‰ytt‰j‰n asettama j‰rjestys
		}
	}

	/**
	 * suorita
	 */
	function suorita() {

		$query = $this->getQuery();

		$this->data = $this->commitSingleSQLQuery($query);
		
		if( count($this->data) > 0 ) {
			$this->addUsersCollums();
	
			$this->processAction();
			
			$this->sortRows();
		}
	}
	
	/**
	 * Prosessoi k‰ytt‰j‰n painalluksen
	 */
	function processAction() {
		if( isset($_REQUEST['comID']) and $_REQUEST['comID'] == $this->ID ) {
			if( isset($_REQUEST['sort']) and array_key_exists($_REQUEST['sort'], $this->headers) ) {				
				$order = $this->get('order');		
				
				if( count($order) == 0 ) {//$_REQUEST['sort'] !== $order[0][0] and $_REQUEST['sort'] !== $order[1][0] ) {
					// Oletus suunnan vaihto
					if( $this->headers[$_REQUEST['sort']][2] === 'asc' ) {
						D('oletus: asc -> desc: '.$_REQUEST['sort'].' ');
						$this->makeOrder($order, 'desc');
					}	
					else {
						D('oletus: desc -> asc: '.$_REQUEST['sort'].' ');
						$this->makeOrder($order, 'asc');
					}
				}
				else {					
					// Katsotaan mink‰ mukaan j‰rjestet‰‰n
					// eka sama -> swapataan vain ekan suunta
					if( $order[0][0] === $_REQUEST['sort'] ) {
						D('eka sama kayttaja asettaa: asc -> desc: '.$_REQUEST['sort'].' ');
						if( $order[0][1] ===  'asc' ) {
							$order[0][1] = 'desc';
						}
						else {
							$order[0][1] = 'asc';
						}
					}	
					// toka sama -> vaihdetaan paikkoja mutta suunta pysyy samana 
					else if( $order[1][0] === $_REQUEST['sort'] ) {
						D('toka sama kayttaja asettaa: desc -> asc: '.$_REQUEST['sort'].' ');
//						if( $order[1][1] ===  'asc' ) {
//							$order[1][1] = 'desc';							
//						}
//						else {
//							$order[1][1] = 'asc';
//						}
						$tmp = $order[0];
						$order[0] = $order[1];
						$order[1] = $tmp;
					}
					// uusi kriteeri
					// uusi ekaksi sille oletus suunta ja vanha eka tokaksi
					else {
						D('toka sama kayttaja asettaa: desc -> asc: '.$_REQUEST['sort'].' ');
						$order[1] = $order[0];
						$order[0] = array($_REQUEST['sort'], $this->headers[$_REQUEST['sort']][2]);						
					}
				}
//				print '<pre>';
// 				print_r($order);
// 				print '</pre>';
				
				$this->set('order',$order);
			}
			else {
				D('Saraketta '.$_REQUEST['sort'].' ei loydy taulukosta!<br />');	
			}
			
        }		
	}

	/**
	 * 
	 */
	function makeOrder(&$order, $direction) {
		$dorder = $this->get('dorder');
		// katsotaan onko sama kuin toinen j‰rjestys kriteeri jos on niin swapataan paikat
		// jos sama kuin eka niin k‰‰nnet‰‰n vain ekan suunta
		// muuten vanha eka tokaksi ja uusi sarake ekaksi oletus suunnalla
		if( $_REQUEST['sort'] === $dorder[1] ) {
			$order[1] = array($dorder[0], $this->headers[$dorder[0]][2]);
			$order[0] = array($_REQUEST['sort'], $direction);
		}
		else if( $_REQUEST['sort'] === $dorder[0] ) {
			$order[1] = array($dorder[1], $this->headers[$dorder[1]][2]);	
			$order[0] = array($_REQUEST['sort'], $direction);
		}
		else {
			D('k&auml;ytet&auml;&auml;n oletus suuntaa');
			$order[1] = array($dorder[0], $this->headers[$dorder[0]][2]);
			$order[0] = array($_REQUEST['sort'], $this->headers[$_REQUEST['sort']]);
		}
	}

	/**
	 * Omien kenttien lis‰‰minen.
	 */
	function addUsersCollums() {

		$usersheaders = array();
		
//		$orders = array();
//		$dorder = $this->get('dorder');
		
		foreach ($this->headers as $column ) {
			if ( !array_key_exists($column[0], $this->data[0]) ) {
				$usersheaders[] = $column[0];
			}
			
			// Set orders			
/*			if( !array_key_exists($column[0], $dorder) ) {
				$orders[$column[0]] = 'asc';
			}
			else {
				$orders[$column[0]] = $dorder[$column[0]];
			}
*/
		}
		
//		$this->set('dorder', $orders);
		
//		print '<pre>';
// 		print_r($_SESSION);
// 		print '</pre>';
	

		if (count($usersheaders) == 0) {
			return;
		}

   		$i = 0;
		foreach ($this->data as $row) {

			foreach ($usersheaders as $header) {				
				$this->data[$i][$header] = $this->column($i, $header);
			}
    		$i++;
		}
	}

	/**
	 * 
	 * Users defined column values that can't be inserted using DB.
	 */
	function column( $row, $column ) {
		D('tablecomponent: implement column()-function!');

		/*
		 * Esimerkki KOODIA!
		 * 	
		$ret = 0;
		
		switch ($column) {
			case 'mpero':
				if( $this->data['ottelut'] > 0 ) {
					$ret = $this->data['maalit'] / $this->data['ottelut'];
				}
				break;
		
			default:
				D('SARAKETTA ei lˆytynyt.');
				break;
		}
		
		return $ret;
		*/
	}

	/**
	  * Sorts all the rows. NO need to call out side the class!
	  * TableComponent = luokka jonka funktiota k‰ytet‰‰n!
	  */
	function sortRows() {
	    // Ei ole m‰‰ritelty j‰rjestyst‰, voi olla t‰m‰ on tehty jo tietokannalla
	    if( count($this->get('dorder')) > 0 ) {
    		usort($this->data, array("TableComponent", "cmp") );
	    }
	}
	
	function cmp($a, $b)
    {
    	$order = $this->get('order');

  		if( count($order) < 1 ) {
  			$tmp = $this->get('dorder');
  			$order = array();
  			$i = 0;
  			foreach( $tmp as $column ) {
      			$order[$i] = array($tmp[$i], $this->headers[$tmp[$i]][2]);
      			$i++;
  			}
  		}
  		
		for( $i = 0; $i < count($order); $i++ ) {
		    $header = $order[$i];

			if( $a[$header[0]] == $b[$header[0]] ) {
				continue;
			}
						
            if($header[0] == 'asc')
	            return ($a[$header[0]] < $b[$header[0]]) ? -1 : 1;
	        else 
	            return ($a[$header[0]] > $b[$header[0]]) ? -1 : 1;
		}
		// Ei lˆytynyt eroa
		return 0;
    }
	
	

	/**
	 * 
	 * Set query.
	 */
	function getQuery() {}

	/**
	 * Returns number of pages.
	 */
	function numberOfPages() {

	}

	/**
	 * Valitsee sivun joka piirret‰‰n. Jos ei kutsuta n‰ytet‰‰n oletus sivu.
	 * V‰‰r‰n sivun valinta n‰ytt‰‰ oletus sivun.
	 */
	function selectPage() {

	}

	/** 
	 * Draws the page selection
	 */
	function drawPageSelector() {
		if( $this->get('pageLength') > 0 ) {
			D('TODO: Implement drawPageSelector()- function!');
		}
	}

	/**
	 * Draws the table
	 */
	function drawTable() {
		
	    print '<table class="'.$this->outfit['tableclass'].'">';
	    $this->drawTableHeaders();
		$this->drawTableRows();
		print '</table>';
	}
	
	function drawTableHeaders() {
	    // headerit
		print '<tr>';
		foreach( $this->headers as $header ) {
            $line = '<th class="'.$this->outfit['thclass'].'">';
			if( $this->allowUserSort == true ) {
    			$line .= '<a href="?toiminto='.$this->toiminto.'&amp;comID='.$this->ID.'&amp;sort='.$header[0].'">';
			}
			$line .= $this->TM->getText($header[0]);
			if( $this->allowUserSort == true ) {
			    $line .= '</a>';
			}
			$line .= '</th>';
			print $line;
		}
		print '</tr>';
	}
	
	function drawTableRows() {
		// taulukon arvot		
		foreach( $this->data as $row ) {
			print '<tr class="'.$this->outfit['trclass'].'">';
			foreach( $this->headers as $header ) {
				print '<td class="'.$header[1].'">';
				print $this->createLink($header[0], $row);
				print '</td>';
			}
			print '</tr>';			
		}
	}
	
	
	/**
	 * Luo linkit jotka on m‰‰ritelty $this->links muutujaan
	 */
	function createLink($column, &$row) {
		if( isset($this->links) and array_key_exists($column, $this->links) ) {
			// Linkki voi olla sis‰inen tai ulkoinen
			// $this->links['column'][0] = linkin tyyppi
			// $this->links['column'][1] = toiminnon nimi
			// $this->links['column'][2] = array(parametrin nimi, parametrin arvo, ...)
			// $this->links['column'][3] = array(parametrin nimi, parametrin arvo, ...)
			// SL = sis‰inen linkki
			if( $this->links[$column][0] == 'SL' ) {
				$link = '<a href="?toiminto='.$this->links[$column][1];
				foreach( $this->links[$column][2] as $param ) {
					$link .= '&amp;'.$param.'='.$row[$param];
				}
				if( isset($this->links[$column][3]) ) {
	    			foreach( $this->links[$column][3] as $param  => $value ) {
						$link .= '&amp;'.$param.'='.$value;
					}
				}
				return $link.'">'.$row[$column].'</a>';
			}
			// Ulkoinen linkki
			else if( $this->links[$column][0] == 'UL' ) {
				return 'TODO: link to out size';
			}
			
		}
		// linkki ei ole liitetty arvoon joten palautetaan vain arvo
		return $row[$column];
	}

	/**
	 * Piirt‰‰ komponentin. 
	 */
	function draw() {
		$this->drawPageSelector();
		$this->drawTable();
	}

	/**
	* Avaa yhteyden kantaan ja suorittaa kyselyn, sulkee yhteyden ja palauttaa
	* tuloksen.
	*/
	function & commitSingleSQLQuery(& $query) {
		$this->openConnection();
		$result = $this->db->doQuery(& $query);
		//$this->db->commit();
		$this->db->close();
		return $result;
	}

    function openConnection(){
        $this->db = new Tietokanta();
        $this->db->open();
    }
}
?>

