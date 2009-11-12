<?php
/**
 * translationmanager.php
 * Copyright Rysty 2004:
 *   Teemu Lahtela
 *   Jukka Kaartinen
 *   Teemu Siitarinen
 *
 * @author: Teemu Lahtela
 * created: 13.01.2005
 *
 */

/**
 * This is class is used to get access to static instace of
 * TranslationManager.
 *
 */
class Registry {
    var $_cache_stack;

    function Registry() {
        $this->_cache_stack = array(array());
    }
    function setEntry($key, &$item) {
        $this->_cache_stack[0][$key] = &$item;
    }
    function &getEntry($key) {
        return $this->_cache_stack[0][$key];
    }
    function isEntry($key) {
        return ($this->getEntry($key) !== null);
    }
    function &instance() {
        static $registry;
        if (!$registry) {
            $registry = new Registry();
        }
        return $registry;
    }

}

/**
 * class TranslationManager
 *
 */
class AbstractTranslationManager
{

    /** Aggregations: */
    var $selected;

    var $texts;
    /** Compositions: */

     /*** Attributes: ***/


    /**
     *
     *
     * @param String suomeksi
     * @return string
     * @access public
     */
    function &getText(  $suomeksi )
    {
        $text = strtolower($suomeksi);
        if ( isset($this->texts[$text]) )  {
            return $this->texts[$text];
        } else {
//            D("<br> $text <br>");
        }

        return $suomeksi;
    } // end of member function getText

    /**
     *
     *
     * @param int language
     * @return true jos asetus onnistui muuten false
     * @access public
     */
    function setLanguage(  $language )
    {
        global $LANGUAGES;
        if ( array_key_exists( $language, $LANGUAGES ) ) {
            $this->selected = $language;
            $this->loadCurrentLanguage();
            return true;
        }
        return false;

    } // end of member function setLanguage

    /**
     *
     *
     * @return void
     * @access public
     */
    function loadCurrentLanguage(){
        global $LANGUAGES;
        require_once($LANGUAGES[$this->selected]);
        $this->texts = &get();
    }
    /**
     * palauttaa annetulle toiminnolle ohjeet
     */
    function ohje($toiminto){
        $ohje = &help();
        if ( isset($ohje[$toiminto] ) ) {
            return $ohje[$toiminto];
        }
        return '';
    }
    /**
     * Returns a reference to the languages array.
     *
     * @return array
     * @access public
     */
    function &getLanguages( )
    {
        return $this->texts;
    } // end of member function getLanguages

    /**
     * Private constructor of this singleton class.
     *
     * @return void
     * @access private
     */
    function AbstractTranslationManager() {
        $this->selected = "fi";
        $registry = &Registry::instance();
        if ($registry->isEntry('singleton ' . get_class($this))) {
            trigger_error(
                    'Already an instance of singleton ' .
                    get_class($this));
        }
    }

    /**
     * Returns a reference to the global instance of this class.
     * Do not create instances of this class.
     * Use this method to get the only instance of this class.
     *
     *
     */
    function &instance($class) {
        $registry = &Registry::instance();
        if (!$registry->isEntry('singleton ' . $class)) {
            $registry->setEntry(
                    'singleton ' . $class, new $class());
        }
        return $registry->getEntry('singleton ' . $class);
    }


} // end of TranslationManager



class TranslationManager extends AbstractTranslationManager {

    function &instance() {
        return AbstractTranslationManager::instance(__CLASS__);
    }
}
?>