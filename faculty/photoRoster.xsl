<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" />
<!-- by Cathy Snider, Web Communications, CU-Boulder -->
	<xsl:template match="root">
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<title>Faculty Photo Roster | University of Colorado Boulder</title>
				<style type="text/css">
					html { width:8.5in; height:10.5in; }					
					body, td, th {	font-family: Arial, Helvetica, sans-serif;	font-size: 85%;}
					h1#colorboxFocus {margin:0; text-align:center;}
					h1#colorboxFocus:focus {outline:thin dotted;}
					table {margin-bottom:5px;}
					a.rosterbutton { display:block; padding:3px 7px; color:black; text-decoration:none;  background-color:#ddd; border:1px solid gray; background-image:url(http://www.colorado.edu/portal/ep/ucb2/images/bgGrayPale.jpg);  background-position:bottom; background-repeat:repeat-x;  -moz-border-radius:4px;-webkit-border-radius: 4px; font-size:85%; }
					a.rosterbutton:hover { color:black; text-decoration:underline; background-color:#ccc;  background-repeat:repeat-x; background-image:url(http://www.colorado.edu/portal/ep/ucb2/images/bgGrayLight.jpg);}
					.outline {border:1px solid gray;}
					.emphasis {	color: #990000}
					.attention { background-color : lemonchiffon; font-size:90%; }
					td.photobox {width:102px; height:160px;  border:1px solid silver;  font-size: 85%; overflow:hidden;  }
					@media print {
					html { width:8.5in; height:10.5in; }	
					.noprint {	display: none;}
					}
				</style>
			</head>
			<body style="padding-top:0;" onLoad="document.getElementById('colorboxFocus').focus();">
				
				<!-- CREATE 'CLOSE THIS WINDOW' BOX -->
	<div class="noprint">
      <table class="outline" bgcolor="#EEEEEE" cellspacing="0" cellpadding="4" border="0" width="100%">
        <tr><td align="left"><a href="javascript:window.print();"><img role="presentation" align="absmiddle" border="0"  src="http://www.colorado.edu/portal/ep/ucb2/images/printer.gif" hspace="2" height="15" width="15" alt="print page" />Print Page</a></td>
          <td align="right"><a href="javascript:window.close();">Close Window</a></td>
          
          
        </tr>
      </table>
    </div>
				
				<!--  CREATE HEADER -->
				<table border="0" cellpadding="4" cellspacing="0" class="outline" width="100%">
                <tr><td colspan="2"><h1 id="colorboxFocus" tabindex="-1">Photo Roster</h1></td></tr>
					<tr>
						<td align="left">
							<strong> University of Colorado Boulder</strong>
							<br />
							<strong><xsl:value-of select="Subject" />-<xsl:value-of select="CatalogNbr" />-<xsl:value-of select="ClassSection" /> &#160;|&#160; 
								<xsl:value-of select="Title" /> &#160;|&#160; <xsl:call-template name="parseTerm">
									<xsl:with-param name="thisTerm" select="Term"></xsl:with-param>
								</xsl:call-template>					
							</strong>
							
						</td>
						<td valign="bottom" align="right">
							<strong>Printed From myCUInfo<br />
								<xsl:value-of select="Date" /> at <xsl:call-template name="parseTime">
									<xsl:with-param name="militaryTime" select="Time"></xsl:with-param>
								</xsl:call-template>		
							</strong>
						</td>
					</tr>
				</table>
				
				<table border="0" cellpadding="4" cellspacing="0"  align="center" class="noprint">
					<tr>
						
						<xsl:if test="EmailRoster !=''">						
							<td> <a href="mailto:{EmailRoster}" class="rosterbutton"><xsl:value-of select="EmailRoster" /> </a>  </td>
						</xsl:if>
						
						<xsl:if test="StudentRoster !=''">
							<td> <a href="{StudentRoster}" class="rosterbutton">Class Roster</a> </td>
						</xsl:if>
						
						<xsl:if test="DownloadCourseRoster !=''">
							<td> <a href="{DownloadCourseRoster}" class="rosterbutton">Download Excel-friendly Course Roster</a>  </td>
						</xsl:if>
						
						<xsl:if test="DownloadCUClicker !=''">
							<td> <a href="{DownloadCUClicker}" class="rosterbutton">Download CUClicker Roster</a>  </td>
						</xsl:if>
					</tr>
				</table>
				
				
				
				<table width="100%" cellspacing="0" cellpadding="4" border="0">
					<tr>
						<td align="center" class="attention outline">This photo roster is made available to you for your use only as the instructor of this course.  
							Per student privacy laws, photos may not be posted on the web or displayed for others to see.</td>
					</tr>
				</table>
				
			
						
					<!-- PROCESS STUDENT INFO				
				<xsl:apply-templates select="Student" >
					<xsl:sort select="Name"/>
				</xsl:apply-templates>
					-->	
				<xsl:for-each select="Student">
					<xsl:choose>
						<!--test for beginning of row, post first student -->
						<xsl:when test="(position()-1) mod 6 = 0">
							<table class="phototable" cellpadding="5" cellspacing="2" border="0"><tr>
								
							
								<td class="photobox" valign="top"><img src="{Photo}" width="102" height="120" alt="{Name}" /><br />
									<a href="{StudentDetails}"><xsl:value-of select="Name"/></a>
									
										<xsl:if test="DeathDate != ''"><br /><b class="emphasis">DECEASED</b></xsl:if>
										<xsl:if test="Privacy = 'Y'"><br /><a href="http://registrar.colorado.edu/regulations/nondisclosure_of_directory_information.html " target="_blank">
											<b class="emphasis">PRIVACY ENABLED</b></a></xsl:if>
										
									
								</td>
								
								
								<!-- now post rest of row -->
								<xsl:for-each select="following-sibling::Student[position() &lt; 6]">
									<td class="photobox" valign="top"><img src="{Photo}" width="102" height="120" alt="{Name}" /><br />
										<a href="{StudentDetails}"><xsl:value-of select="Name"/></a>
										<xsl:if test="DeathDate != ''"><br /><b class="emphasis">DECEASED</b></xsl:if>
										<xsl:if test="Privacy = 'Y'"><br /><a href="http://registrar.colorado.edu/regulations/nondisclosure_of_directory_information.html " target="_blank">
											<b class="emphasis">PRIVACY ENABLED</b></a></xsl:if>
									</td>
									
									</xsl:for-each>
							</tr></table>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			
			</body>
		</html>
	</xsl:template>
	
	
	
	<xsl:template match="Student">

		
		<td class="photobox"><img src="{Photo}" width="102" height="120" alt="{Name}" /><br />
			<a href="{StudentDetails}"><xsl:value-of select="Name"/></a><xsl:value-of select="position()"/>
			<xsl:choose>
				<xsl:when test="DeathDate != ''"><br /><b class="emphasis">DECEASED</b>
				</xsl:when>
				<xsl:when test="Privacy = 'Y'"><br /><a href="http://registrar.colorado.edu/regulations/nondisclosure_of_directory_information.html " target="_blank">
						<b class="emphasis">PRIVACY ENABLED</b>
					</a>
				</xsl:when>
				<xsl:otherwise>   </xsl:otherwise>
			</xsl:choose>
		</td>
		
		
	</xsl:template>
	<xsl:template name="parseTerm">
		<xsl:param name="thisTerm"></xsl:param>
		<xsl:choose>
			<xsl:when test="1=substring($thisTerm,4,1)">Spring&#160;</xsl:when>
			<xsl:when test="4=substring($thisTerm,4,1)">Summer&#160;</xsl:when>
			<xsl:when test="7=substring($thisTerm,4,1)">Fall&#160;</xsl:when>
		</xsl:choose>
		20<xsl:value-of select="substring($thisTerm,2,2)"/>		
	</xsl:template>
	<xsl:template name="parseTime">
		<xsl:param name="militaryTime"></xsl:param>
		<xsl:variable name="firstHalf"><xsl:value-of select="substring($militaryTime, 1,2)"/></xsl:variable>
		<xsl:variable name="secondHalf"><xsl:value-of select="substring($militaryTime, 4,2)"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="$firstHalf > 12"><xsl:value-of select="$firstHalf - 12"/>:</xsl:when>
			<xsl:otherwise><xsl:value-of select="$firstHalf"/>:</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$secondHalf"/>
	</xsl:template>
</xsl:stylesheet>
