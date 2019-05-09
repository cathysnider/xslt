<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" />
  <!-- by Cathy Snider and Tashi Daniels, CU-Boulder -->
  
  <xsl:key name="category" match="Accommodation" use="@Category" />
  <xsl:template match="root">
   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Faculty Course Roster | University of Colorado Boulder</title>
    <style>
body, td, th {
	font-family: Arial, Verdana, sans-serif;
}
h1#colorboxFocus {margin:0;	text-align:center;}
h1#colorboxFocus:focus {outline:thin dotted;}
p.moreinfoLink {	font-weight:bold;}
p.linkClosed {
	padding-left:24px;
	background-image:url(%IMAGE(BLUE_PLUS));
	background-repeat:no-repeat;
	background-position:0% 50%;
}
p.linkOpen {
	padding-left:24px;
	background-image:url(%IMAGE(BLUE_MINUS));
	background-repeat:no-repeat;
	background-position:0% 50%;
}
table {
	margin-bottom:5px;
}
a.rosterbutton {
	display:block;
	padding:3px 7px;
	color:black;
	text-decoration:none;
	background-color:#ddd;
	border:1px solid gray;
	background-image:url(%IMAGE(BGGRAYPALE));
	background-position:bottom;
	background-repeat:repeat-x;
	-moz-border-radius:4px;
	-webkit-border-radius: 4px;
	font-size:85%;
}
a.rosterbutton:hover {
	color:black;
	text-decoration:underline;
	background-color:#ccc;
	background-repeat:repeat-x;
	background-image:url(%IMAGE(BGGRAYLIGHT));
}
.outline {	border:1px solid gray}
.emphasis {	color: #990000}

@media print {
.noprint {	display: none;}
body, td, th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 85%;}
}

div#a11yInfo {
margin:0 0 1em 0;
padding:5px;
border:1px solid black;
}
#a11yTable {	width:100%;	border-collapse:collapse;}
#a11yTable th {
	background-color:#dddddd;
	color:black;
	padding:5px;
	text-align:center;
	font-size: 18px;
}
#a11yTable tbody {
}
#a11yTable tbody tr td {
	font-size:90%;
	border-bottom:1px solid lightgrey;
	padding:5px;
}
#a11yTable tbody tr td.a11yCategory {
	font-weight: bold;
	font-size: 16px;
	padding:5px;
	border-bottom:none;
}
#a11yTable tbody tr td.subcatdesc {	padding-left: 20px;}
#a11yTable tbody tr td.accessFooter {padding-top:.5em: border-bottom:none;}
#a11yTable caption {	background-color:black;	color:white;	padding:5px;	font-weight: bold;	font-size: 18px;}
</style>
    <!-- SCRIPTS ON PAGE WILL NOT RUN CALL TO JQUERY LIBRARY -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
    <script type="text/javascript">

$(document).ready(function(){
	
$('a.clickToClose').click(function(){ 
	parent.$.fn.colorbox.close(); //WORKS!
	});
	
	
$("div.moreinfo").hide();	
$("p.moreinfoLink a").click(function(){
	 var clicked_state = $(this).attr("aria-expanded");
    
	 if (clicked_state == "false") {
		$(this).attr("aria-expanded","true");
		$(this).parent().next().attr("aria-hidden","false");
		}
		
	if (clicked_state == "true") {
		$(this).attr("aria-expanded","false");
		$(this).parent().next().attr("aria-hidden","true");	
	}
	$(this).parent().toggleClass('linkOpen').toggleClass('linkClosed');
    $(this).parent().next().slideToggle();
    return false;  
   });
				
 });
 

</script>
    </head>
    
    <body style="padding-top:0;" onLoad="document.getElementById('colorboxFocus').focus();">
    
    <!-- CREATE 'CLOSE THIS WINDOW' BOX -->
    <div class="noprint">
      <table class="outline" bgcolor="#EEEEEE" cellspacing="0" cellpadding="4" border="0" width="100%">
        <tr><td align="left"><a href="javascript:window.print();">
        <img role="presentation" align="absmiddle" border="0"  src="%IMAGE(PRINTER)" hspace="2" height="15" width="15" alt="print page" />Print Page</a></td>
          <td align="right"><a href="javascript:window.close();">Close Window</a></td>
          
          
        </tr>
      </table>
    </div>
    
    <!--  CREATE HEADER -->
    <table border="0" cellpadding="4" cellspacing="0" class="lglink outline" width="100%">
      <tr>
        <td colspan="2"><h1 id="colorboxFocus" tabindex="-1">Class Roster</h1></td>
      </tr>
      <tr>
        <td align="left"><strong> University of Colorado Boulder</strong> <br />
          <strong><xsl:value-of select="Subject" />-<xsl:value-of select="CatalogNbr" />-<xsl:value-of select="ClassSection" />&#160;|&#160; <xsl:value-of select="Title" />&#160;|&#160;
          <xsl:call-template name="parseTerm">
            <xsl:with-param name="thisTerm" select="Term">
            </xsl:with-param>
          </xsl:call-template>
          </strong></td>
        <td valign="bottom" align="right"><strong>Printed from myCUInfo<br />
          <xsl:value-of select="Date" /> at
          <xsl:call-template name="parseTime">
            <xsl:with-param name="militaryTime" select="Time">
            </xsl:with-param>
          </xsl:call-template>
          </strong></td>
      </tr>
    </table>
    
    <!-- CREATE TABLE FOR ACCESSIBILITY INFORMATION -->
    
    <xsl:if test="not(Accessibility = '')">
      <p class="linkClosed moreinfoLink noprint"><a href="javascript:void(0)" aria-expanded="false" aria-controls="a11yInfo" id="a11yLink">View Accessibility Requirements</a></p>
      <div class="moreinfo" id="a11yInfo" aria-hidden="true" aria-labelledby="a11yLink">
        <table id="a11yTable">
        <caption>Accessibility Requirements</caption>
          <thead>
            <tr>
              <th>Type Required</th>
              <th>Description</th>
              <th>Full Details</th>
              <th># of Students</th>
            </tr>
          </thead>
          <tbody>
            <xsl:apply-templates select="Accessibility" />
            
           
          </tbody>
        </table>
        <p class="accessFooter">This data is provided by Disability Services. If you have questions about this information, please visit <a href="http://www.colorado.edu/disabilityservices/faculty-staff/working-disability-services-students/mycuinfo-faculty-toolkit" target="_blank">FAQ: Accommodation Details in Faculty Toolkit</a> or email <a href="mailto:dsinfo@colorado.edu">dsinfo@colorado.edu</a>.</p>
      </div>
    </xsl:if>
    
    <!-- CREATE TABLE FOR ROSTER BUTTONS -->
    
    <table border="0" cellpadding="4" cellspacing="0"  align="center" class="noprint">
      <tr>
        <xsl:if test="EmailRoster !=''">
          <td><a href="mailto:{EmailRoster}" class="rosterbutton"><xsl:value-of select="EmailRoster" /> </a></td>
        </xsl:if>
        <xsl:if test="PhotoRoster !=''">
          <td><a href="{PhotoRoster}" class="rosterbutton">Photo Roster</a></td>
        </xsl:if>
        <xsl:if test="DownloadCourseRoster !=''">
          <td><a href="{DownloadCourseRoster}" class="rosterbutton">Download Excel-friendly Course Roster</a></td>
        </xsl:if>
        <xsl:if test="DownloadCUClicker !=''">
          <td><a href="{DownloadCUClicker}" class="rosterbutton">Download CUClicker Roster</a></td>
        </xsl:if>
      </tr>
    </table>
    
    <!-- CREATE TABLE FOR STUDENT DATA -->
    <table width="100%" border="1" cellpadding="3" cellspacing="0">
    <caption>Student Roster Data</caption>
      <thead>
        <tr bgcolor="#dddddd">
          <th valign="bottom" scope="col"> <b class="lglink">Name and E-mail </b> </th>
          <th valign="bottom" scope="col" nowrap="nowrap"> <b class="lglink">Status </b> </th>
          <th valign="bottom" scope="col" nowrap="nowrap"> <b class="lglink">Student ID</b> </th>
          <th valign="bottom" scope="col"> <b class="lglink">Class Level</b> </th>
          <th valign="bottom" scope="col"> <b class="lglink">College</b> </th>
          <th valign="bottom" scope="col"> <b class="lglink">Major</b> </th>
          <th valign="bottom" scope="col"> <b class="lglink">Minor</b> </th>
          <th valign="bottom" scope="col"> <b class="lglink">Final<br /> Grade</b> </th>
          <th valign="bottom" scope="col"> <b class="lglink">Phone</b> </th>
          <th valign="bottom" scope="col" width="25" align="center" class="noprint"> <b class="lglink">Student<br />Details</b> </th>
        </tr>
      </thead>
      <tbody>
        <!-- PROCESS STUDENT INFO -->
        <xsl:apply-templates select="Student" >
          <xsl:sort select="Name"/>
        </xsl:apply-templates>
      </tbody>
    </table>
    </body>
    </html>
  </xsl:template>
  <xsl:template match="Accessibility">
    <xsl:apply-templates select="Accommodation"/>
  </xsl:template>
  <xsl:template match="Accommodation">
    <tr>
      <td title="{@Category}"><xsl:value-of select="CategoryDescription" /></td>
      <td title='{@Type}' class="subcatdesc"><xsl:value-of select="TypeDescription" /></td>
      <td><xsl:value-of select="LongDescription" /></td>
      <td align="center" style="font-weight:bold"><xsl:value-of select="StudentCount" /></td>
    </tr>
  </xsl:template>
  <xsl:template match="Student">
    <tr>
      <td align="top">
      
     <!-- privacy flag -->
     <xsl:if test="Privacy = 'Y' or DeathDate != ''">
   <img src="%IMAGE(REDFLAGTINY)" alt="This student has requested privacy" width="32" height="32" border="0" hspace="3" vspace="6"  align="left" />
 </xsl:if>
              
              <xsl:value-of select="Name" /><br />
              <a href="mailto:{Email}?subject={/root/Subject}-{/root/CatalogNbr}-{/root/Section}  {/root/Title}"><xsl:value-of select="Email" /></a>
              
              <xsl:choose>
                <xsl:when test="DeathDate != ''">
                  <br />
                  <b class="emphasis">DECEASED</b>
                </xsl:when>
                <xsl:when test="Privacy = 'Y'">
                  <br />
                  <a href="http://www.colorado.edu/registrar/students/records/ferpa/full-limited-privacy" target="_blank"><b class="emphasis">PRIVACY ENABLED</b></a>
                </xsl:when>
                <xsl:otherwise>&#160;</xsl:otherwise>
              </xsl:choose>
              
        
        </td>
      <td align="center"><xsl:choose>
          <xsl:when test="Withdrawn">
            Withdrawn
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="enrollStatus">
              <xsl:with-param name="myStatus" select="EnrlStatus">
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        &#160;</td>
      <td><xsl:value-of select="EMPLID" />&#160;</td>
      <td><xsl:value-of select="ClassLevel" />&#160;</td>
      <td><xsl:value-of select="Program" />&#160;</td>
      <td><xsl:value-of select="Major" />&#160;</td>
      <td><xsl:value-of select="Minor" />&#160;</td>
      <td align="center"><xsl:choose>
          <xsl:when test="FinalGrade = ''">
            <xsl:text>-</xsl:text>&#160;
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="FinalGrade" />&#160;
          </xsl:otherwise>
        </xsl:choose></td>
      <td><xsl:value-of select="PhoneNbr" />&#160;</td>
      <td align="center" class="noprint"><a href="javascript:void(window.open('{StudentDetails}','_blank',''));"><img src="%IMAGE(ZOOM)" alt="More Information" width="24" height="24" border="0" /></a></td>
    </tr>
  </xsl:template>
  <xsl:template name="parseTerm">
    <xsl:param name="thisTerm"></xsl:param>
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
    20<xsl:value-of select="substring($thisTerm,2,2)"/>
  </xsl:template>
  <xsl:template name="parseTime">
    <xsl:param name="militaryTime"></xsl:param>
    <xsl:variable name="firstHalf"><xsl:value-of select="substring($militaryTime, 1,2)"/></xsl:variable>
    <xsl:variable name="secondHalf"><xsl:value-of select="substring($militaryTime, 4,2)"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="$firstHalf > 12">
        <xsl:value-of select="$firstHalf - 12"/>:
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$firstHalf"/>:
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$secondHalf"/>
  </xsl:template>
  <xsl:template name="enrollStatus">
    <xsl:param name="myStatus"></xsl:param>
    <xsl:choose>
      <xsl:when test="$myStatus = 'E'">
        Enrolled
      </xsl:when>
      <xsl:when test="$myStatus = 'D'">
        Dropped
      </xsl:when>
      <xsl:when test="$myStatus = 'W'">
        Waitlisted
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
