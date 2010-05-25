<?php
/**
 * tietokanta.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * author: Jukka
 * created: 21.01.2005
 *
*/


/**
 * class Tietokanta
 *
 *
 * Example:
 * db = new Tietokanta();
 * db->open();
 * db->doQuery("SELECT * from pelit");
 * if(data != OK)
 *     db->rollback();
 * else
 *     db->commit();
 * db->close();
 *
 */
class Tietokanta
{
    var $db_link;
    var $error;

    function Tietokanta()
    {
        unset($this->db_link);
        $this->error = false;
    }

    /**
     * Opens connection to database
     * @return true if connection was opened false otherwise.
     */
    function open()
    {
        // set the enviroment variable to make postgres use dd.mm.yyyy
        // putenv('PGDATESTYLE=German'); // now in postgresql.conf
        GLOBAL $dbuser;
        $this->db_link = pg_connect($dbuser);
        if ( ! $this->db_link ) {
            $this->error = false;
            return false;
        }
          // set real datestyle dd.mm.yyyy
          // $this->doQuery("set DateStyle TO German") ;
          //$this->doQuery("set DateStyle TO ISO") ;

        pg_query($this->db_link, "begin");
        return true;
    }

    /**
     * Closes connection to database
     *
     */
    function close()
    {
        if( $this->error === true ) {
            D("DB_ERROR");
            $this->rollback();
        }
        else {
            D( "<br>DB_OK<br><br>");
            $this->commit();
        }
        $this->closeConnection();
    }

    function closeConnection()
    {
        pg_query($this->db_link, "end");
        pg_close($this->db_link);
    }

    /**
     * Commits transaction
     */
    function commit()
    {
        pg_query($this->db_link, "commit");
    }

    /**
     * Rollback transaction
     */
    function rollback()
    {
        pg_query($this->db_link, "rollback");
    }

    /**
     * Executes SQL query
     * @param query SQL statement
     * @return array that contains the result of the query
     */
    function &doQuery($query)
    {
        D( $query."<br>");
        $result = pg_query($this->db_link, $query);

        if ( ! $result ) {
            D('<br>VIRHE KANTAANLAITOSSA<br>');
            D($query);

            //die ( "getRow fatal error: ".pg_result_error() );
            $this->error = true;
        }
        else {

            $res = array();
            while ( $row = pg_fetch_array( $result, NULL, PGSQL_ASSOC ) )
                array_push( $res, $row );

            return $res;
       }
    }

    function succeeded() {
        return !$this->error;
    }

} // end of Tietokanta
?>
