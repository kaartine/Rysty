<?php
/*
 * Created on Apr 5, 2005
 *
 * Created by Teemu Lahtela
 * (c) L&auml;mmi
 */
 class JoukkueTieto {
        var $joukkueid;
        var $maalienlkm;
        var $rangaistustenlkm;
        var $epaonnistuneidenlkm;
        var $nimi;
        var $toiminto;
        var $tyyppi;
        var $peliid;

        var $pelaajat = array();
        var $maalit = array();
        var  $jaahyt = array();
        var  $epaonnisrankut = array();
        var $maalivahdit = array();
        var $kapteenit = array();

        var $viewOnly;
        var $kaikkiPelaajat=array();
        var $select;
        var $errors = array();
        var $AJAT = array('tapahtumisaika','paattymisaika');
        var $NUMEROTX = array('paastetytmaalit','syy','minuutit');

        var $maaliArrayTiedot= array(
                            'rangaistuslaukaus' => 'f',
                            'siirrangaikana' => 'f',
                            'tyyppi' => 'no',
                            'tekija' => '',
                            'syottaja' =>'',
                            'tyhjamaali' => 'f',
                            'tapahtumisaika' => '',
                            'joukkueid' => NULL,
                            'peliid' => NULL

                            );
        var $jaahyArrayTiedot2= array(
                            'saaja' => 'f',
                            'syy' => '',
                            'paattymisaika' => '',
                            'tapahtumisaika' =>'',
                            'minuutit' => '',
                            'joukkueid' => NULL,
                            'peliid' => NULL
                            );

        var $epaonnistuneetArrayTiedot2= array(
                            'tapahtumisaika' => '',
                            'tekija'=> '',
                            'tyyppi'=> 'no',
                            'tyhjamaali' => '',
                            'siirrangaikana' => '',
                            'joukkueid' => NULL,
                            'peliid' => NULL
                            );

        var $jaahyArrayTiedot= array(
                            'jhsaaja' => 'f',
                            'jhsyy' => '',
                            'jhpaattymisaika' => '',
                            'jhtapahtumisaika' =>'',
                            'jhminuutit' => '',
                            'joukkueid' => NULL,
                            'peliid' => NULL
                            );

        var $epaonnistuneetArrayTiedot= array(
                            'ertapahtumisaika' => '',
                            'ertekija'=> '',
                            'ertyyppi'=> 'no',
                            'ertyhjamaali' => '',
                            'ersiirrangaikana' => '',
                            'joukkueid' => NULL,
                            'peliid' => NULL
                            );

        var $kapteeniksituloArrayTiedot= array(
                            'kapteenihlo' =>'',
                            'kaptuloaika' => '',
                            );

        var $maalivahdiksituloArrayTiedot= array(
                            'maalivahtihlo' => '',
                            'mvtuloaika' => '',
                            'paastetytmaalit' =>'',
                            );
        var $tm;
        function JoukkueTieto ($joukkueid, $tyyppi) {
            $this->joukkueid = $joukkueid;
            //$this->toiminto = &$toiminto;
            $this->tyyppi = $tyyppi;
            unset($this->maalienlkm);
            unset($this->rangaistustenlkm);
            unset($this->epaonnistuneidenlkm);
            unset($this->nimi);
            unset($this->peliid);
            $this->tm = &TranslationManager::instance();
            $this->select = array(array('-1',$this->tm->getText('Valitse pelaaja'),-1));
            $this->viewOnly = FALSE;
        }
        function pelaajatilastot (&$db) {
            foreach ( $this->pelaajat as $id => $p ) {
                // tarkistetaan onko pelaaja mukana kokoonpanossa
                if( !isset($p['kokoonpanossa']) or !$p['kokoonpanossa'] ) {
                    continue;
                }

                $p['kokoonpanossa'] = NULL;
                $p['pelipaikka'] = NULL;
                $p['nimi'] = NULL;
                $rows = '';
                $values = '';
                $arvojaON = FALSE;
                foreach ( $p as $k => $val ) {


                    if ( $val != NULL ) {
                        if ( strpos( $k, 'aika' ) !== false and strpos( $k, 'aikana' ) === false ) { // lisätään aikaan ne tunnin nollat
                            $val = tarkistaAika($val);
                            $values = $values.trim($val).',';
                        } else {
                            $values = $values."'".trim($val)."',";
                        }
                        $rows = $rows.$k.',';
                        $arvojaON = TRUE;
                    }
                }
                 if ( $arvojaON ) {
                    $query = "INSERT INTO pelaajatilasto (".substr($rows, 0, -1).') VALUES ('.substr($values, 0, -1).')' ;
                    $db->doQuery($query);
                }

            }
        }
        /**
         *
         */
        function haePelaajamerkinnat (&$db) {
            $this->peliid = $_REQUEST['peliid'];
        $pelaajat = &$db->doQuery('SELECT  peliid, joukkue, pelaaja, plusmiinus, numero,'.
             "kapteeni, maalivahti, to_char(kaptuloaika,'MI:SS') as kaptuloaika, to_char(mvtuloaika,'MI:SS') as mvtuloaika, peliaika, torjunnat, paastetytmaalit, lisatieto, ".
             "(SELECT (sukunimi || ' ' || etunimi) FROM henkilo WHERE hloid = pelaaja) as nimi " .
             "FROM pelaajatilasto where (peliid = $_REQUEST[peliid] and joukkue = $this->joukkueid)");

            foreach ($pelaajat as $p ) {
                $this->pelaajat[$p['pelaaja']] = $p;
                $this->pelaajat[$p['pelaaja']]['kokoonpanossa'] = true;
                if ( $this->viewOnly )  {
                    if ($p['maalivahti'] == 't') {
                        $this->maalivahdit[$p['pelaaja']] = $p;
                    }
                    if ($p['kapteeni'] == 't') {
                        $this->kapteenit[$p['pelaaja']] = $p;
                    }

                }
            }
        }

        function maalitKantaan (&$db) {
            foreach ( $this->maalit as $v) {

                 if ($v['tekija'] == -1 ) {
                    print "Merkint&auml;&auml; ei laitettu ei maalintekij&auml;&auml; merkattu";
                    continue;
                 }
                $this->asetaArvo( $v['tyhjamaali']) ;
                $this->asetaArvo( $v['siirrangaikana']) ;
                $this->asetaArvo( $v['rangaistuslaukaus']) ;
                 $syottaja = ', syottaja';
                 $syottajaarvo = ", '$v[syottaja]'";
                 if ($v['syottaja'] == -1 ) {
                    $syottaja = '';
                    $syottajaarvo  = '';
                 }

                $tilastoid = $this->laitaTilastomerkinta($db, tarkistaAika($v['tapahtumisaika']));

                $q1 = "INSERT INTO maali ( maaliid , tekija $syottaja , tyyppi , tyhjamaali , siirrangaikana , rangaistuslaukaus ) ".
                           "VALUES ('$tilastoid', '$v[tekija]' $syottajaarvo , '$v[tyyppi]', '$v[tyhjamaali]', '$v[siirrangaikana]', '$v[rangaistuslaukaus]')";
                 $db->doQuery($q1);

            }
        }
        function jaahytKantaan (&$db) {
            foreach ( $this->jaahyt as $v) {

                 if ($v['saaja'] == -1 ) {
                    print "Merkint&auml;&auml; ei laitettu ei j&auml;&auml;hynsaajaa merkattu";
                    continue;
                 }

                $tilastoid = $this->laitaTilastomerkinta($db, tarkistaAika($v['tapahtumisaika']));
                $v['paattymisaika'] = tarkistaAika($v['paattymisaika']);
                $db->doQuery(
                            'INSERT INTO rangaistus ( rangaistusid , saaja , syy , minuutit , paattymisaika ) '.
                           "VALUES ('$tilastoid', '$v[saaja]' , '$v[syy]' , '$v[minuutit]', $v[paattymisaika])");

            }
        }
        function epaonnistuneetKantaan (&$db) {
            foreach ( $this->epaonnisrankut as $v) {

                 if ($v['tekija'] == -1 ) {
                    print "Merkint&auml;&auml; ei laitettu ei ep&auml;onnistujaa merkattu";
                    continue;
                 }


                $tilastoid = $this->laitaTilastomerkinta($db, tarkistaAika($v['tapahtumisaika']));
                $this->asetaArvo( $v['tyhjamaali'] ) ;

                $this->asetaArvo( $v['siirrangaikana']) ;


                $db->doQuery(
                            'INSERT INTO  epaonnisrankku( epaonnisrankkuid , tekija , tyyppi , tyhjamaali , siirrangaikana ) '.
                           "VALUES ('$tilastoid', '$v[tekija]' , '$v[tyyppi]' , '$v[tyhjamaali]', '$v[siirrangaikana]')");

            }
        }
        function asetaArvo(&$v){
             if (empty($v) ){
                $v =  'false';
             }
             else {
                $v = 'true';
             }
        }
        function laitaTilastomerkinta(&$db, $aika){
                $result = $db->doQuery("SELECT nextval('tilastomerkinta_timerkintaid_seq')");
                $tilastoid = $result[0]['nextval'];
                $db->doQuery( 'INSERT INTO tilastomerkinta ( timerkintaid, peliid, joukkueid, tapahtumisaika) '.
                           "VALUES ('$tilastoid', '$this->peliid', '$this->joukkueid', $aika)");

                 return $tilastoid;
        }

        function haeMaalitJaJaahyt(&$db){
            $this->maalit = &$db->doQuery(
                "SELECT m.rangaistuslaukaus, m.siirrangaikana, m.tyyppi, m.maaliID,m.tekija, m.syottaja, m.tyhjamaali, m.siirrangaikana, to_char(t.tapahtumisaika,'MI:SS') as tapahtumisaika, t.peliid, t.joukkueID " .
                "from maali m, tilastomerkinta t where  (m.maaliid = t.timerkintaid  and t.peliid = $_REQUEST[peliid] and t.joukkueID = $this->joukkueid)");

            $this->jaahyt = &$db->doQuery(
                "SELECT m.rangaistusid, m.saaja, m.syy, m.minuutit, to_char(m.paattymisaika,'MI:SS') as paattymisaika, to_char(t.tapahtumisaika,'MI:SS') as tapahtumisaika, t.peliid, t.joukkueID " .
                "from rangaistus m, tilastomerkinta t where  (m.rangaistusID = t.timerkintaid  and t.peliid = $_REQUEST[peliid] and t.joukkueID = $this->joukkueid)");

            $this->epaonnisrankut = &$db->doQuery(
                "SELECT tekija, tyyppi, tyhjamaali,  siirrangaikana , to_char(t.tapahtumisaika,'MI:SS') as tapahtumisaika from epaonnisrankku, " .
                "tilastomerkinta t where  (epaonnisrankkuid = t.timerkintaid  and t.peliid = $_REQUEST[peliid] and t.joukkueID = $this->joukkueid)");

              $this->rangaistustenlkm = count($this->jaahyt);
              $this->epaonnistuneidenlkm= count($this->epaonnisrankut);
        }

    function luoPelaajat ($kausi,&$db) {
//        print '<hr>';
        $pelaajat = &$db->doQuery('SELECT pelaaja, joukkue, pelinumero as numero, pelipaikka, ' .
            "kapteeni, " .
            "(SELECT trim(sukunimi) || ' ' || trim(etunimi) FROM henkilo WHERE hloid = p.pelaaja) as nimi " .
            " FROM pelaajat as p WHERE joukkue = $this->joukkueid and kausi = $kausi" );

         $pelaajat2 =  &$db->doQuery('SELECT henkilo as pelaaja, henkilo, kaudenjoukkue as joukkue, ' .
            "tehtava as toimi, (SELECT trim(sukunimi) || ' ' || trim(etunimi) FROM henkilo WHERE hloid = t.henkilo) " .
            'as nimi' .
            " FROM Toimi as t WHERE kaudenjoukkue = $this->joukkueid and kausi = $kausi" );


        foreach ($pelaajat2 as $p ) {
            $p['maalivahti'] = 'f';
            $p['plusmiinus'] = '';
            $p['lisatieto'] = '';
            $p['peliaika'] = '';
            $p['numero'] = '';
            $p['kapteeni'] = 'f';
            $p['kaptuloaika'] ='00:00';
            $p['mvtuloaika'] = '00:00';
            $p['paastetytmaalit'] = $this->maalienlkm;

            if ( $this->viewOnly ) {
                $this->kaikkiPelaajat[$p['pelaaja']] = $p;
            } else {
                $this->pelaajat[$p['pelaaja']] = $p;
            }

        }

        foreach ($pelaajat  as $p ) {
            $p['maalivahti'] = $p['pelipaikka']=='MV'?'t':'f';
            $p['plusmiinus'] = '';
            $p['lisatieto'] = '';
            $p['peliaika'] = '';
            $p['kaptuloaika'] ='00:00';
            $p['mvtuloaika'] = '00:00';
            $p['paastetytmaalit'] = $this->maalienlkm;

            if ( $this->viewOnly ) {
                $this->kaikkiPelaajat[$p['pelaaja']] = $p;
            } else {
                $this->pelaajat[$p['pelaaja']] = $p;
            }
        }
        $this->haePelaajamerkinnat($db);
        $this->haeMaalitJaJaahyt($db);


    }
    function sortPelaajat(){
        $sortpelaajat = $this->pelaajat;
        $this->pelaajat = array();
        usort($sortpelaajat , 'compare');
        foreach ($sortpelaajat  as $p ) {
            $this->pelaajat[$p['pelaaja']] = $p;
        }
    }
    /**
     * @param maalien määrä
     * @param joukkue id
     */
    function luoMaalit () {
        $this->maalit = $this->taytaTiedot($this->maalit, $this->maaliArrayTiedot,$this->maalienlkm);
        $this->jaahyt = $this->taytaTiedot($this->jaahyt, $this->jaahyArrayTiedot2, $this->rangaistustenlkm);
        $this->epaonnisrankut = $this->taytaTiedot($this->epaonnisrankut, $this->epaonnistuneetArrayTiedot2, $this->epaonnistuneidenlkm);

    }
    function taytaTiedot(&$taulu, $arrayTiedot, $lkm) {

        $maalintekijat = array();
        reset($taulu);
        for( $i = 0 ; $i < $lkm ; $i++ ) {



            $maali = each($taulu);
            if ( !$maali ) {
                $ar = $arrayTiedot;
                array_push($maalintekijat,$ar);
            }
            else {
                array_push($maalintekijat, $maali['value']);
            }
        }
        return $maalintekijat;
    }

    function taytaMaalivathditjaKokoonpano(&$toiminto) {
        $success = TRUE;
        $this->select = array(array('-1',$this->tm->getText('Valitse pelaaja'),-1));
        $this->maalivahdit = array();
        $this->kapteenit = array();
        foreach ( $this->pelaajat as $k => $p ) {
            $id = $k;
            $isPlayer = FALSE;
            if (isset($_REQUEST[$this->tyyppi.'numero'.$id]) ) {
                $numero = trim($_REQUEST[$this->tyyppi.'numero'.$id]);
                if ( !empty($numero) and !is_numeric($numero)) {
                    $success = FALSE;
                    $toiminto->addError($this->tm->getText("Virheellinen pelinumero: \"$numero\""));
                }

            }
            else {
                $numero = $p['numero'];
            }
            $pelaajannimi = $numero.' '.$p['nimi'];
            if ( array_key_exists($this->tyyppi.'pelaaja'.$id,$_REQUEST) ) {
                    $isPlayer = TRUE;
            }
            if ( $isPlayer ) {
                if ( array_key_exists($this->tyyppi.'maalivahti'.$id,$_REQUEST) ) {
                        $this->maalivahdit[$id] = $pelaajannimi;
                        if ( empty($p['mvtuloaika'] )) {
                            $this->pelaajat[$id]['mvtuloaika'] = '00:00';
                        }
                        $this->pelaajat[$id]['maalivahti'] = 't';
                } else {
                    $this->pelaajat[$id]['maalivahti'] = 'f';
                }
                if ( array_key_exists($this->tyyppi.'kapteeni'.$id,$_REQUEST) ) {
                        $this->kapteenit[$k]  = $pelaajannimi;
                        if ( empty($p['kaptuloaika'] )) {
                            $this->pelaajat[$id]['kaptuloaika'] = '00:00';
                        }
                        $this->pelaajat[$id]['kapteeni'] = 't';
                } else {
                    $this->pelaajat[$id]['kapteeni'] = 'f';
                }
            }

            $this->pelaajat[$k]['numero'] = $numero;//$_REQUEST[$this->tyyppi.'numero'.$id];
            $this->pelaajat[$k]['plusmiinus'] = trim($_REQUEST[$this->tyyppi.'plusmiinus'.$id]);
            $this->pelaajat[$k]['peliaika'] = trim($_REQUEST[$this->tyyppi.'peliaika'.$id]);
            $this->pelaajat[$k]['lisatieto'] = trim($_REQUEST[$this->tyyppi.'lisatieto'.$id]);
            $this->pelaajat[$k]['peliid'] = $this->peliid;

            if ( !empty($this->pelaajat[$k]['plusmiinus']) and !is_numeric($this->pelaajat[$k]['plusmiinus'])) {
                $success = FALSE;
                $toiminto->addError($this->tm->getText('Virheellinen plusminus: "'.$this->pelaajat[$k]['plusmiinus'].'"'));
            }
            if ( !empty($this->pelaajat[$k]['peliaika']) and !is_numeric($this->pelaajat[$k]['peliaika']) ) {
                $success = FALSE;
                $toiminto->addError($this->tm->getText('Virheellinen peliaika: "'.$this->pelaajat[$k]['peliaika'].'"'));
            }

            if ( $isPlayer ) {
                array_push($this->select, array($k,$pelaajannimi,$numero));
                $this->pelaajat[$k]['kokoonpanossa'] = true;
            }
            else {
                $this->pelaajat[$k]['kokoonpanossa'] = false;
            }

        }
        usort($this->select,'selectSort');
       /*print '<pre> ';
        print_r($this->pelaajat);
       print '</pre> ';*/
        return $success;
    }

       /**
        *
        */
        function lueRequestMaalit() {
            $kps = array();
            $mvs = array();
            $success = TRUE;
             if ( !$this->lueRequesttiedot($this->maalit, $this->maaliArrayTiedot, $this->maalienlkm) ){
                $success = FALSE;
             }
             if ( !$this->lueRequesttiedot($this->epaonnisrankut,$this->epaonnistuneetArrayTiedot,$this->epaonnistuneidenlkm, 'er')){
                $success = FALSE;
             }
             if ( ! $this->lueRequesttiedot($kps, $this->kapteeniksituloArrayTiedot, count($this->kapteenit))){
                $success = FALSE;
             }
             if ( !$this->lueRequesttiedot($mvs, $this->maalivahdiksituloArrayTiedot, count($this->maalivahdit))){
                $success = FALSE;
             }


            foreach ( $kps as $kp) {
                $this->pelaajat[$kp['kapteenihlo']]['kapteeni'] = 't';
                $this->pelaajat[$kp['kapteenihlo']]['kaptuloaika'] = $kp['kaptuloaika'];
            }
            foreach ( $mvs as $mv) {
                $this->pelaajat[$mv['maalivahtihlo']]['maalivahti'] = 't';
                $this->pelaajat[$mv['maalivahtihlo']]['mvtuloaika'] = $mv['mvtuloaika'];
                $this->pelaajat[$mv['maalivahtihlo']]['paastetytmaalit'] = $mv['paastetytmaalit'];
            }

            if ( !$this->lueRequesttiedot($this->jaahyt, $this->jaahyArrayTiedot, $this->rangaistustenlkm, 'jh')) {
                $success = FALSE;
            }
            return $success;
        }

        function lueRequesttiedot(&$maalit, $maaliArrayTiedot, $lkm,$alku = NULL) {
            $maalit = array();
            $success = TRUE;
            for ($index = 1; $index <= $lkm ; $index++) {
                $maali = array();
                $insert = FALSE;
                foreach ( $maaliArrayTiedot as $k => $v) {
                    $key = $k;
                    if ( $alku != NULL ) { // tarkistetaan onko muuttujan alussa merkkiä( jh = jäähy , er = epäonnistunut rankku jne.)
                        $p = strpos($k, $alku);
                        if (  $p === 0 ) {
                            $key = substr($k, strlen($alku));
                        } else {
                            $key = $k;
                        }
                    }

                    if ( array_key_exists( $this->tyyppi.$k.$index, $_REQUEST)
                            and !empty( $_REQUEST[$this->tyyppi.$k.$index] ) ) {
                        $val = $_REQUEST[$this->tyyppi.$k.$index];
                        $maali[$key] = $val;
                        $insert = TRUE;
                        if ( $key == 'syottaja' and $val != -1) {
                            if ( $maali['syottaja'] == $maali['tekija'] ) {
                                array_push($this->errors, 'Maalintekij&auml; on sama kuin sy&ouml;tt&auml;j&auml;!');
                                array_push($this->errors, $this->pelaajat[$maali['syottaja']]['nimi']);

                                $success = FALSE;
                            }
                        }

                        if ( in_array(trim($key), $this->NUMEROTX,false) ) {
                            if ( !is_numeric($val)){
                                D( "SUCCEESS FALSE: $key : $val <br>");
                                array_push($this->errors, 'Laiton numero!');
                                array_push($this->errors, "$key = $val");
                                $success = FALSE;
                            } else if ( $key == 'minuutit' ) {
                                if ( !($val == 2 or $val == 5 or $val == 10 or $val == 20)) {
                                    array_push($this->errors, 'Laiton j&auml;&auml;hyn kesto!');
                                    array_push($this->errors, "$key = $val");
                                    $success = FALSE;

                                }
                            }
                        }
                    // ajan tarkistus
                        if ( in_array($key,$this->AJAT) ) {
                        //if ( strpos($key,'aika') !== false and strpos( $k, 'aikana' ) === false ) { // tarkistetaan onko kyseess&auml; aika
                            if ( !isLegalTimeMMSS2($maali[$key] ) ) {
                                D( "SUCCEESS FALSE: $key : $val <br>");
                                array_push($this->errors, 'Laiton aika!');
                                array_push($this->errors, "$key = $val");
                                $success = FALSE;
                            }
                        }
                    }
                    else {
                        if ( isset($maali['saaja']) and $maali['saaja'] != -1 and in_array($key,$this->NUMEROTX) ) {
                            D( "SUCCEESS FALSE: $key : $val <br>");
                            array_push($this->errors, 'Tyhj&auml; kentt&auml;:');
                            array_push($this->errors, $key);
                            $success = FALSE;
                        }
                        $maali[$key] = NULL;
                    }




                }

                if ( $insert ) {
                    $maali['joukkueid'] = $this->joukkueid;
                    $maali['peliid'] = $this->peliid;
                    array_push($maalit, $maali);
                }

            }
            return $success;
        }

    function lisaaPiste (&$pelaaja, $tyyppi) {
        if ( isset($pelaaja[$tyyppi]) ) {
            $pelaaja[$tyyppi]++;
        }
        else {
             $pelaaja[$tyyppi] = 1;
        }

    }
 }
function selectSort($a,$b){
    return ($a[2] > $b[2]);
}

function compare($a, $b)
{
    return ($a['numero'] > $b['numero']);
}


?>
