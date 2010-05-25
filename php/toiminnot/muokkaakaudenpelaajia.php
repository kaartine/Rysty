<?php


/**
 * kaudenjoukkue.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 16.02.2005
 *
*/

require_once "lista.php";
require_once "lomakeelementit.php";
require_once "muokkaakaudenpelaajiaview.php";

class MuokkaaKaudenpelaajia extends Lista {

    var $pelipaikka;

    function MuokkaaKaudenpelaajia() {
        $this->Lista('muokkaakaudenpelaajia');

        unset($this->katisyys);
        unset($this->pelipaikka);

        $this->columns = array(
            'pelinumero',
            'etunimi',
            'sukunimi',
            'katisyys',
            'maila',
            'pelipaikka',
            'kapteeni',
            'syntymaaika',
            'aloituspvm',
            'lopetuspvm'
        );

        $this->links = array('sukunimi'=>array('hloid','henkilonlisays'),'etunimi'=>array('hloid','henkilonlisays'));

        $this->defaultorder = 'pelinumero';
        $this->viewname = "MuokkaaKaudenpelaajiaView";

        $this->tiedot=array('joukkue'=>"");

        /*if( !isset($_SESSION['joukkue']) ) {
            $_SESSION['joukkue'] = "1";
        }

        if( !isset($_REQUEST['joukkue']) ) {
            $_REQUEST['joukkue'] = $_SESSION['joukkue'];
        }*/
    }

    function suorita() {

        D("<pre>");
        //D( $this->tiedot);
        D( $_REQUEST);
        D("</pre>");

        if( isset($_REQUEST['paivita']) ) {
            $this->openConnection();

            // Takaisin ei tehdä päivitystä
            if(isset($_REQUEST['pelaaja'])) {
                foreach($_REQUEST['pelaaja'] as $key => $pelaaja)
                {
                    if(!isset($pelaaja['kapteeni']))
                        $pelaaja['kapteeni'] = "f";
                    else
                        $pelaaja['kapteeni'] = "t";

                    if( $pelaaja['pelinumero'] == "" or !is_numeric($pelaaja['pelinumero']))
                        $pelaaja['pelinumero'] = -1;

                    if( $pelaaja['pelipaikka'] === "EI" )
                        $pelaaja['pelipaikka'] = 'NULL';
                    else {
                        $pelaaja['pelipaikka'] = '\''.$pelaaja['pelipaikka'].'\'';
                    }
                    
                    if( $pelaaja['aloituspvm'] == "") {
                    	$pelaaja['aloituspvm'] = "NULL";
                    }
                    else {
                    	$pelaaja['aloituspvm'] = '\''.$pelaaja['aloituspvm'].'\'';	
                    }
                    
                    if( $pelaaja['lopetuspvm'] == "") {
                    	$pelaaja['lopetuspvm'] = "NULL";
                    }
                    else {
                    	$pelaaja['lopetuspvm'] = '\''.$pelaaja['lopetuspvm'].'\'';	
                    }
                    

                    $query = "UPDATE Pelaajat SET pelinumero = $pelaaja[pelinumero],".
                            " pelipaikka = $pelaaja[pelipaikka], kapteeni = '$pelaaja[kapteeni]'," .
                            " aloituspvm = $pelaaja[aloituspvm], lopetuspvm = $pelaaja[lopetuspvm]" .
                            " WHERE pelaaja = $key and joukkue = $_SESSION[kaudenjoukkueid] and kausi = $_SESSION[kausi]";
                    $this->db->doQuery($query);
                }
                $this->db->close();
            }

            if ( !$this->db->error ) {
            //tästa alkaa takaisinkytkennän toimintasarja
                $this->drawForm = false;
                $this->suoritaAutoRefresh();
                return;
            }
        }
        else if( isset($_REQUEST['takaisin']) ) {
            $this->drawForm = false;
            $this->suoritaAutoRefresh();
            return;
        }
        else {
            parent::suorita();
            $i = 0;
            foreach( $this->data as $pelaaja )
            {
                $this->pelipaikka[$i] = new Select(
                array(  array("EI",$this->tm->getText("eitiedossa")),
                        array("VL",$this->tm->getText("Vasenlaita")),
                        array("OL",$this->tm->getText("Oikealaita")),
                        array("KE",$this->tm->getText("Keskushy&ouml;kk&auml;&auml;j&auml;")),
                        array("PU",$this->tm->getText("Puolustaja")),
                        array("MV",$this->tm->getText("Maalivahti"))),"pelaaja[$pelaaja[pelaaja]][pelipaikka]",$pelaaja['pelipaikka']);
                $i++;
            }
        }
    }


    function getQuery() {
        return
          "SELECT pelaaja as hloid, pelaaja, joukkue, pelinumero, pelipaikka, kapteeni, aloituspvm, lopetuspvm,
            (SELECT katisyys FROM pelaaja WHERE pelaajaid = p.pelaaja) as katisyys,
            (SELECT maila FROM pelaaja WHERE pelaajaid = p.pelaaja) as maila,
            (SELECT trim(etunimi) FROM henkilo WHERE hloid = p.pelaaja) as etunimi,
            (SELECT trim(sukunimi) FROM henkilo WHERE hloid = p.pelaaja) as sukunimi,
            (SELECT syntymaaika FROM henkilo WHERE hloid = p.pelaaja) as syntymaaika
            FROM pelaajat as p WHERE joukkue = $_SESSION[kaudenjoukkueid] and kausi = $_SESSION[kausi]";
    }

/*    function suorita() {

    }
  */
}


?>
