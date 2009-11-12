<?php


/**
 * kaudenjoukkue.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 20.03.2005
 *
*/

require_once("toiminto.php");
require_once("lomakeelementit.php");



class MultiLista extends Toiminto {

    var $limit;
    var $sorting; // Voiko otsikoista sortata

    function MultiLista($toiminnonNimi) {
        $this->Toiminto($toiminnonNimi);

        /**
         * $this->columns = array(
                    'pelaajat' => array('pelinumero','etunimi', 'sukunimi', 'pelipaikka', 'kapteeni'),
                    'toimihenkilot' => array('tehtava','etunimi', 'sukunimi'));
         */
        $this->columns = array();


        /**
         * $this->links = array('pelaajat' => array(
                'pelinumero'=>array(array('pelaaja'),'pelaajakortti'),
                'etunimi'=>array(array('pelaaja'),'pelaajakortti'),
                'sukunimi'=>array(array('pelaaja'),'pelaajakortti')),
            'toimihenkilot' => array(
                'tehtava'=>array(array('henkilo'),'pelaajakortti'),
                'etunimi'=>array(array('henkilo'),'pelaajakortti'),
                'sukunimi'=>array(array('henkilo'),'pelaajakortti')));
         */
        $this->links = array();

        $this->data = array();

        $this->defaultorder = array();

        $this->order = array();

        $this->nextdirection = array();

        $this->direction = array();

        $this->viewname = "";

        unset($this->limit);
        $this->sorting = true;
    }

    function suorita( )
    {
        $this->createView($this->viewname);

        $direction = $this->direction;

        foreach($this->columns as $key => $value) {
            if ( array_key_exists('sort'.$key,$_REQUEST) ) {
                $this->order[$key] = $this->getSort($key);
            }
            else {
                $this->order[$key] = NULL;
            }

            // if currently was sorted desc, next sort needs to be asc
            if ( array_key_exists('dir',$_REQUEST) and $_REQUEST['dir'] === 'desc' ){
                if( $direction[$key] === 'desc' )
                    $direction[$key] = 'asc';
                else
                    $direction[$key] = 'desc';

                $this->nextdirection[$key] = 'asc';
            }
            else {
                $this->nextdirection[$key] = 'desc';
            }

            $sortby = $this->sortBy($key,$this->order[$key],$direction[$key]);
            $query = $this->getQuery($key);
            if (  !empty($this->defaultorder[$key]) ) {
                $query .= " ORDER BY $sortby";
            }

            if( isset($this->limit) ) {
                $query .= ' LIMIT '.$this->limit;
            }

            $this->data[$key] = $this->commitSingleSQLQuery($query);
        }
    }

    function sortBy($key,$sortby,$direction) {
        if ( !in_array( $sortby, $this->columns[$key]) ) {
            $sortby = $this->defaultorder[$key]." ".$direction;
            $this->order[$key] = $this->defaultorder[$key];
        }
        else {
            if ( $this->defaultorder[$key] == $sortby ) {
                $sortby .= " $direction";
            }
            else {
                $sortby .= " $direction , ".$this->defaultorder[$key]." ".$direction;
            }
        }
        return $sortby;
    }

    function &getQuery($key) {
        /**
         * if($key == 'pelaajat')
         *  return   SELECT 1;
         * else if($key == 'toimihenkilot')
         *  return   SELECT 2;
         */
    }

    function &getData($key) {
        if( array_key_exists($key, $this->data) ) {
            return $this->data[$key];
        }
    }

    function getSort($key){
        return $_REQUEST['sort'.$key];
    }

    function setLimit($number) {
        $this->limit = $number;
    }
    
    function setSortin($sort) {
        $this->sorting = $sort;
    }
}


?>