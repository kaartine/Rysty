<?php
########################################################
# Script Info
# ===========
# File: DirectoryListing.php
# Author: Ash Young (ash@evoluted.net
# Created: 20/12/03
# Modified: 27/09/04
# Website: http://evoluted.net/directorylisting.php
# Requirements: PHP
#
# Description
# ===========
# Displays all files contained within a directory in
# a well formed table, with category-image tags
#
# If you have any functions that you like to see 
# implemented in this script then please just send
# an email to ash@evoluted.net
#
# Useage
# ======
#
# To change the colours display when using the script
# scroll down to set up section
#
# To use the script just upload to your server with
# the images and point your browser to the scripts
# filename
#
# SETUP
# =====
# 
# Change the following variables to display what colours
# the script outputs
########################################################
error_reporting(null);
DEFINE("IMAGEROOT", "kuvat/images/");  #CHANGE /images/ TO THE PATH OF THE ASSOCIATED IMAGES

// name of folder, no starting / or ending / relative to index.php file
$HOMEDIR="intranet";

$HOMEDIR="./".$HOMEDIR."/";
$textcolor = "#FFFFFF";           #TEXT COLOUR
$bgcolor = "#535353";             #PAGE BACKGROUND COLOUR

$normalcolor = "#0066FF";         #TABLE ROW BACKGROUND COLOUR
$highlightcolor = "#006699";      #TABLE ROW BACKGROUND COLOUR WHEN HIGHLIGHTED
$headercolor = "#003366";         #TABLE HEADER BACKGROUND COLOUR
$bordercolor = "#202750";         #TABLE BORDER COLOUR
/* 
<html>
<head>
<title>Directory Listings of <? echo $_SERVER["REQUEST_URI"]; ?> </title>
<style type='text/css'>
<!--
body {     color: <? echo $textcolor; ?>; font: tahoma, small verdana,arial,helvetica,sans-serif; background-color: <? echo $bgcolor; ?>; }
table { font-family: tahoma, Verdana, Geneva, sans-serif; font-size: 7pt; border: 1px; border-style: solid; border-color: <? echo $bordercolor; ?>; }
.row { background-color: <? echo $normalcolor; ?>; border: 0px;}
a:link { color: <? echo $textcolor; ?>;  text-decoration: none; } 
a:visited { color: <? echo $textcolor; ?>;  text-decoration: none; } 
a:hover, a:active { color: <? echo $textcolor; ?>;  text-decoration: none; } 
img {border: 0;}
#bottomborder {border: <? echo $bordercolor;?>;border-style: solid;border-top-width: 0px;border-right-width: 0px;border-bottom-width: 1px;border-left-width: 0px}
.copy { text-align: center; color: <? echo $textcolor; ?>; font-family: tahoma, Verdana, Geneva, sans-serif;  font-size: 7pt; text-decoration: underline; }
//-->
</style>
</head>
<body>
*/
$files=array();
$dirs=array();
$tm = TranslationManager::instance();

clearstatcache();
$curDir = $HOMEDIR;
if ( isset($_REQUEST['directory'] ) ) {
    $path_parts = pathinfo($_REQUEST['directory']);
    //echo "$path_parts[basename]";

/*echo $path_parts['dirname'], "<br>\n";
echo $path_parts['basename'], "<br>\n";
//echo $path_parts['extension'], "<br>\n";
*/
    if ( substr_count($path_parts['dirname']."/",$HOMEDIR ) == 1 and
        substr_count($path_parts['dirname']."/","../" ) == 0 // no path altering  
        and $path_parts['basename'] != ".." ) { // double check
        $curDir = $path_parts['dirname']."/".$path_parts['basename']."/";
    }
    
}
$PHP_SELF = basename(__FILE__);
if ($handle = opendir($curDir)) {
  while (false !== ($file = readdir($handle))) { 
    if ($file != "."  && $file != substr($PHP_SELF, -(strlen($PHP_SELF) - strrpos($PHP_SELF, "/") - 1))) { 
        if ( $file == ".." and $curDir == $HOMEDIR) {
                continue;
      }
      
	  if (filetype($curDir.$file) == "dir") {
		  //SET THE KEY ENABLING US TO SORT
		  $n++;
		  if($_REQUEST['sort']=="date") {
			$key = filemtime($curDir.$file) . ".$n";
		  }
		  else {
			$key = $n;
		  }
          $dirs[$key] = $file . "/";
          
      }
      else {
		  //SET THE KEY ENABLING US TO SORT
		  $n++;
		  if($_REQUEST['sort']=="date") {
			$key = filemtime($curDir.$file) . ".$n";
		  }
		  elseif($_REQUEST['sort']=="size") {
			$key = filesize($curDir.$file) . ".$n";
		  }
		  else {
			$key = $n;
		  }
          $files[$key] = $file;
      }
    }
  }
closedir($handle); 
}

#USE THE CORRECT ALGORITHM AND SORT OUR ARRAY
if($_REQUEST['sort']=="date") {
	@ksort($dirs, SORT_NUMERIC);
	@ksort($files, SORT_NUMERIC);
}
elseif($_REQUEST['sort']=="size") {
	@natcasesort($dirs); 
	@ksort($files, SORT_NUMERIC);
}
else {
	@natcasesort($dirs); 
	@natcasesort($files);
}

#ORDER ACCORDING TO ASCENDING OR DESCENDING AS REQUESTED
if($_REQUEST['order']=="desc" && $_REQUEST['sort']!="size") {$dirs = array_reverse($dirs);}
if($_REQUEST['order']=="desc") {$files = array_reverse($files);}
$dirs = @array_values($dirs); $files = @array_values($files);
$LINKNAME = $_SERVER['PHP_SELF']."?toiminto=intranet&directory=".$curDir."&";

echo $tm->getText("Hakemisto").": ".$curDir;

echo "<table width=\"450\" border=\"0\" cellspacing=\"0\" align=\"center\"><tr bgcolor=\"$headercolor\"><td colspan=\"2\" id=\"bottomborder\">";
if($_REQUEST['sort']!="name") {
  echo "<a href=\"".$LINKNAME."sort=name&order=asc\">\n";
}
else {
  if($_REQUEST['order']=="desc") {
    echo "<a href=\"".$LINKNAME."sort=name&order=asc\">\n";
  }
  else {
    echo "<a href=\"".$LINKNAME."sort=name&order=desc\">\n";
  }
}
echo $tm->getText("Tiedosto")."</td><td id=\"bottomborder\" width=\"50\"></a>\n";
if($_REQUEST['sort']!="size") {
  echo "<a href=\"".$LINKNAME."sort=size&order=asc\">\n";
}
else {
  if($_REQUEST['order']=="desc") {#
    echo "<a href=\"".$LINKNAME."sort=size&order=asc\">\n";
  }
  else {
    echo "<a href=\"".$LINKNAME."sort=size&order=desc\">\n";
  }
}
echo $tm->getText("Koko")."</td><td id=\"bottomborder\" width=\"120\" nowrap></a>\n";
if($_REQUEST['sort']!="date") {
  echo "<a href=\"".$LINKNAME."sort=date&order=asc\">\n";
}
else {
  if($_REQUEST['order']=="desc") {#
    echo "<a href=\"".$LINKNAME."sort=date&order=asc\">\n";
  }
  else {
    echo "<a href=\"".$LINKNAME."sort=date&order=desc\">\n";
  }
}
echo $tm->getText("Muokattu")."</a></td></tr>\n";

foreach ($dirs as $k => $v) {
   if ( substr( $v,-3) == "../") {
        $folderLink = $_SERVER['PHP_SELF']."?toiminto=intranet&directory=".$path_parts['dirname']."/";
   }
   else {
        $folderLink = $_SERVER['PHP_SELF']."?toiminto=intranet&directory=".$curDir.$v ;
   }
   
  echo "\t<tr class=\"row\" onMouseOver=\"this.style.backgroundColor='$highlightcolor'; this.style.cursor='hand';\" onMouseOut=\"this.style.backgroundColor='$normalcolor';\" onClick=\"window.location.href='" .$folderLink. "';\">";
  echo "\t\t<td width=\"16\"><img src=\"" . IMAGEROOT . "folder.gif\" width=\"16\" height=\"16\" alt=\"Directory\"></td>";
  echo "\t\t<td><a href=\"".$folderLink."\">" . $v . "</a></td>";
  echo "\t\t<td width=\"50\" align=\"left\">-</td>";
  echo "\t\t<td width=\"120\" align=\"left\" nowrap>" . date ("M d Y h:i:s A", filemtime($curDir.$v)) . "</td>";
  echo "\t</tr>\n";
}

foreach ($files as $k => $v) {
     
   switch (substr($v, -3)) {
    case "jpg":
      $img = "jpg.gif";
      break;
    case "gif":
      $img = "gif.gif";
      break;
    case "zip":
      $img = "zip.gif";
      break;
    case "png":
      $img = "png.gif";
      break;
    case "avi":
      $img = "move.gif";
      break;
    case "mpg":
      $img = "move.gif";
      break;
    default:
      $img = "what.gif";
      break;
  }
  
  echo "\t<tr class=\"row\" onMouseOver=\"this.style.backgroundColor='$highlightcolor'; this.style.cursor='hand';\" onMouseOut=\"this.style.backgroundColor='$normalcolor';\" onClick=\"window.location.href='" . $curDir.$v . "';\">\r\n";
  echo "\t\t<td width=\"16\"><img src=\"" . IMAGEROOT . "$img\" width=\"16\" height=\"16\" alt=\"Directory\"></td>\r\n";
  echo "\t\t<td><a href=\"" . $curDir.$v . "\">" . $v . "</a></td>\r\n";
  echo "\t\t<td width=\"50\" align=\"left\">" . round(filesize($curDir.$v)/1024) . "KB</td>\r\n";
  echo "\t\t<td width=\"120\" align=\"left\" nowrap>" . date ("M d Y h:i:s A", filemtime($curDir.$v)) . "</td>\r\n";
  echo "\t</tr>\r\n";
}
echo "</table>\n<div align=\"center\"><a href=\"http://evoluted.net/directorylisting.php\" class=\"copy\">Directory Listing Script</a>. <a href=\"http://evoluted.net/\" class=\"copy\">&copy 2003-2004 Ash Young</a></div>\n";
/*</body>
</html>
*/
?>
