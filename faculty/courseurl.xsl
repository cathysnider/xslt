<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" />
  <!-- by Cathy Snider, Web Communications, CU-Boulder -->
  <xsl:param name="message"></xsl:param>
  <xsl:template match="root">
    <html>
      <head>
        <title>Add/Edit Course URL</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
        <script type="text/javascript">
          
          $(document).ready(function(){
          
          $('a.clickToClose').click(function(){ 
          parent.$.fn.colorbox.close(); //WORKS!
          });
          
          });				
          
          function sendURL() {
          var theScript = "<xsl:value-of select='course-url/redirect' />"
          if (document.urlform.courseURL.value=='') {		
          var newURL = 'BLANK';		}
          else {	var newURL = document.urlform.courseURL.value;	}
          location.href = theScript + "&amp;curr_url=" + newURL;				
          }
          
          
        </script>
        <style>
          body {
          font-family:Arial, Helvetica, sans-serif;
          padding:2em;
          }
          a:focus {
          outline: thin dotted;
          }
          
          h1#colorboxFocus:focus {outline: thin dotted;}
          b.emphasis {
          color:#900;
          font-weight:bold;
          border:1px solid lightgrey;
          background-color:#fdf4c7;
          padding:.2em;
          }
        </style>
      </head>
      <body style="padding-top:0;" onLoad="document.getElementById('colorboxFocus').focus();">
        
        <!-- IFRAME WON'T CLOSE UNLESS DOCUMENT DOMAIN IS SPECIFIED--> 
        <script type="text/javascript" language='JavaScript'>
          var envURL = document.URL;
          if (envURL.indexOf("prod.cu.edu") > -1) {document.domain = "prod.cu.edu";} //PROD
          else if (envURL.indexOf("qa.cu.edu") > -1) {document.domain = "qa.cu.edu";} //STG and TST
          else {document.domain = "dev.cu.edu";} //DEV
        </script>
        <div class="noprint">
          <table cellspacing="0" cellpadding="6" border="0" width="100%">
            <tr>
              <td align="right"><a class="clickToClose" href="#"><img align="absmiddle" border="0" hspace="2" height="14" width="14" alt="close" role="presentation" src="http://www.colorado.edu/portal/ep/ucb2/images/close.gif"  /> Close window</a></td>
            </tr>
          </table>
        </div>
        <h1 id="colorboxFocus" tabindex="-1">Add/Edit Course URL</h1>
        <xsl:if test="course-url/message !=''">
          <p id="errorMessage"><b class="emphasis"><xsl:value-of select="course-url/message"/></b> </p>
        </xsl:if>
        <xsl:apply-templates select="course"/>
        
        <xsl:apply-templates select="course-url"/>
        
        <p>Add or edit the URL for your course web site by entering it in the box below. <br/>
          To completely remove the URL, clear the text box and click "Submit."</p>
        
        <form name="urlform" onsubmit="javascript:sendURL(); return false;">
          <label for="courseURL">Course URL
            <input name="courseURL" id="courseURL" type="text" maxlength="120" size="75" value="{course-url/url}" />
          </label>
          <input name="clear" type="button" value="Clear" onClick="document.urlform.courseURL.value=''"/>
          <input name="send" type="submit" value="Submit"/>
        </form>
 <p>&#160;</p>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="course">
    <p><strong><xsl:value-of select="dept"/>&#160;<xsl:value-of select="code"/>-<xsl:value-of select="section"/><br/>
      <xsl:value-of select="title"/><br/>
      <xsl:call-template name="parseTerm">
        <xsl:with-param name="thisTerm" select="term" />
      </xsl:call-template>
    </strong></p>
  </xsl:template>
  <xsl:template match="course-url">
    Current Course URL:
    <xsl:choose>
      <xsl:when test="url = ''">
        None
      </xsl:when>
      <xsl:otherwise>
        <a href="{url}" target="_blank"><xsl:value-of select="url"/></a>
      </xsl:otherwise>
    </xsl:choose>
    <br />
    Last validated:<xsl:value-of select="last-validated"/><br/>
  </xsl:template>
  <xsl:template name="parseTerm">
    <xsl:param name="thisTerm" />
    <xsl:choose>
      <xsl:when test="1=substring($thisTerm,4,1)">
        Spring&#160;
      </xsl:when>
      <xsl:when test="4=substring($thisTerm,4,1)">
        Summer&#160;
      </xsl:when>
      <xsl:when test="7=substring($thisTerm,4,1)">
        Fall&#160;
      </xsl:when>
    </xsl:choose>
    20<xsl:value-of select="substring($thisTerm,2,2)" />
  </xsl:template>
</xsl:stylesheet>
