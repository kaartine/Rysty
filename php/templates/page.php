<?php
/*
 * Created on Jan 16, 2005
 *
 * Created by Teemu Lahtela
 * (c) Lämmi
 *
 * Page template.
 */

 // Get the view for content functions
 $view = &getView();

GLOBAL $CSSFILE;
GLOBAL $JOUKKUEENNIMI;

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="fi">
<meta name="GENERATOR" content="PHPEclipse 1.0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="<?php print $CSSFILE; ?>" rel="stylesheet" type="text/css">
<link rel="alternate" type="application/rss+xml" title="KooVee II - Uutiset" href="rss.xml" />
<link rel="shortcut icon" href="kuvat/favicon.ico">
<title>
<?php print $view->getTitle() ?>
</title>
</head>
<body>
<table width = "100%" summary="" title="" cellpadding = "0" cellspacing="0" border="0">
    <tr>
      <td width="180" align="center"  class="logo" >
          <a href="index.php?menu">
          <img src="kuvat/topleft_logo.jpg" alt="
            <?php print $JOUKKUEENNIMI;?>" border="0" width="100"></a>
      </td>
      <td bgcolor="#333377"  class="banner" colspan="2">


		  <table width="100%" cellpadding = "0" cellspacing="0" border="0">
		    <tr>
		      <th class="banner2">
		      <?php $view->drawBanner() ?>
		      </th>
		    </tr>
		    <tr>
		      <td>
		        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
		            <tr><td>&nbsp;</td><td></td></tr>
		            <tr>
		              <td>
						<p align="left">
		                <?php $view->drawHistory() ?>
		                </p>
		              </td>
		              <td>
		                <p align="right">
		                <?php $view->drawLanguageSelection() ?>
		                </p>
		              </td>
		            </tr>
		          </table>
		      </td>
		    </tr>
		  </table>
      </td>
    </tr>
    <tr>
      <td bgcolor="#333382" valign="top"  class="menu">
    		<?php $view->drawLinks(); ?>
      </td>
      <td class="middle" valign="top" colspan="2">
        	<?php $view->drawPage(); ?>
      </td>
    </tr>
    <tr>
      <td bgcolor="#333358"  class="bottommenu2">
      		<?php $view->drawLoginLink() ?>
      </td>
      <td bgcolor="#333358" class="bottombanner" align="right">
      	   <?php $view->drawFooterBanner(); ?>
      </td>
      <td bgcolor="#333358" class="bottommenu" align="right">
           <?php $view->drawFooter(); ?>
      </td>
    </tr>
  </table>
  <?php $view->drawVersion(); ?>
  <?php $view->drawBannerIcons(); ?>
 </body>
</html>
