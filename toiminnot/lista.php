<?php
/**
 * lista.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: tepe
 * created: 27.01.2005
 *
*/

require_once("toiminto.php");
require_once("lomakeelementit.php");


/**
 * class Joukkueet
 *
 */
class Lista extends Toiminto
{
    var $data;
    var $order;
    var $omasort;
    var $nextdirection;
    var $defaultorder;
    var $columns;
    var $viewname;
    var $direction;

    /** arrayhin menee kaksi arvoa.
     *
     * assosiaatio kertoo mihinkä listan sarakkeeseen linkki liitetään.
     * aliarrayssä ensimmäinen arvo on avain millä löydetään arvo ja
     * toinen arvo kertoo toiminnon
     *  $this->links = array('nimi'=>array('sarjaID','sarjanlisays'), 'kausi'=>array('kausi','kaudenlisays'));
     * 
     * TAI
     * 
     * assosiaatio kertoo mihinkä listan sarakkeeseen linkki liitetään.
     * aliarrayssä ensimmäinen arvo on array avaimia millä läydetään arvo ja
     * toinen arvo kertoo toiminnon  $this->links = array('nimi'=>array(array
     * ('joukkueID','kausi'),'kaudenjoukkue')); */
    var $links = array();

    function Lista ($toiminnonNimi) {
        $this->Toiminto($toiminnonNimi);
        unset($this->data);
        unset($this->order);
        unset($this->omasort);
        unset($this->nextdirection);
        unset($this->columns);
        unset($this->viewname);
        $this->direction = 'asc';
    }

    function suorita( )
    {
        $this->createView($this->viewname);

        if ( array_key_exists('sort',$_REQUEST) ) {
            $this->order = $this->getSort();
        }
        else {
            $this->order = NULL;
        }
        
        if( isset($_REQUEST['omasort']) ) {
            $this->omasort = $_REQUEST['omasort'];
        }
        else {
            $this->omasort = NULL;    
        }
        
        /*
        D( "<pre>");
        D($this);        
        D("</pre>");
        */        

        $sortby = $this->order;
        $direction = $this->direction;

        // if currently was sorted desc, next sort needs to be asc
        if ( array_key_exists('dir',$_REQUEST) /*and $this->direction === 'desc'*/ ){
            if( $_REQUEST['dir'] === 'desc' ) {
                $direction = 'desc';
                $this->nextdirection = 'asc';
            }
            else {
                $direction = 'asc';
                $this->nextdirection = 'desc';
            }
        }
        else {
            $direction = $this->direction;
            if( $this->direction === 'desc' ) {                
                $this->nextdirection = 'asc';
            }
            else {                
                $this->nextdirection = 'desc';
            }                        
        }

        if ( !in_array( $sortby, $this->columns) ) {
            $sortby = "$this->defaultorder $direction";
            $this->order = $this->defaultorder;
        }
        else {
            if ( $this->defaultorder == $sortby ) {
                $sortby .= " $direction";
            }
            else {
                $sortby .= " $direction , $this->defaultorder $direction";
            }


        }
        $query = $this->getQuery();
        if (  !empty($this->defaultorder) ) {
            $query .= " ORDER BY $sortby";
        }

        $this->data = $this->commitSingleSQLQuery($query);
    }
    
    function cmp($a, $b)
    {
        if( $a[$_REQUEST['omasort']] == $b[$_REQUEST['omasort']] ) {
            return 0;
        }
        if($_REQUEST['dir'] == 'desc')
            return ($a[$_REQUEST['omasort']] < $b[$_REQUEST['omasort']]) ? -1 : 1;
        else 
            return ($a[$_REQUEST['omasort']] > $b[$_REQUEST['omasort']]) ? -1 : 1;
    }

    function setOrder($order) {
        $this->direction = $order;        
    }

    function getSort(){
        return $_REQUEST['sort'];
    }
    function &getData( )
    {
        return $this->data;
    }

    function getQuery(){
        return NULL;
    }

} // end of Joukkueet
?>
