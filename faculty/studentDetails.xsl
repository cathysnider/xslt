<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" />
<!-- by Cathy Snider, Web Communications, CU-Boulder -->
	<xsl:template match="root">
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
				<title>Faculty Photo Roster | University of Colorado Boulder</title>
				<style>
					body,td,th {font-family: Arial, Verdana, sans-serif;}
					table {margin-bottom:5px;}
					.outline {border:1px solid gray}
					.emphasis {	color: #990000}
					.attention { background-color : lemonchiffon;}
					div.photobox {width:110px; height:150px; padding:10px; border:1px dotted black; margin:10px; float:left;}
					@media print {
					.noprint {	display: none;}
					body,td,th {	font-family: Arial, Helvetica, sans-serif;	font-size: small;}
					}
				</style>
			</head>
			<body>
				 <!-- CREATE 'CLOSE THIS WINDOW' BOX -->
    <div class="noprint">
      <table class="outline" bgcolor="#EEEEEE" cellspacing="0" cellpadding="4" border="0" width="100%">
        <tr>
          <td align="right"><a href="javascript:window.close();">Close Window</a></td>
          
          
        </tr>
      </table>
    </div>
				<!--  CREATE HEADER -->
				<table border="0" cellpadding="4" cellspacing="0" class="lglink outline" width="100%">
					<tr>
						<td align="left">
							<strong> University of Colorado Boulder</strong>
							<br />
							<strong><xsl:value-of select="Subject" />-<xsl:value-of select="CatalogNbr" />-<xsl:value-of select="ClassSection" /> &#160;|&#160; <xsl:value-of select="Title" /> &#160;|&#160; 
								<xsl:call-template name="parseTerm">
									<xsl:with-param name="thisTerm" select="Term" />
								</xsl:call-template>
							</strong>
							<br />
							<xsl:if test="EmailRoster !=''">
								<a href="mailto:{EmailRoster}"><xsl:value-of select="EmailRoster" />	</a> (opens Email)</xsl:if>
						</td>
						<td valign="bottom" align="right">
							<strong>Printed From myCUInfo<br />
								<xsl:value-of select="Date" /> at <xsl:call-template name="parseTime">
									<xsl:with-param name="militaryTime" select="Time" />
								</xsl:call-template>
							</strong>
						</td>
					</tr>
				</table>
				
				<table width="100%" cellspacing="0" cellpadding="4" border="0">
					<tr>
						<td align="center" class="attention outline">This photo roster is made available to you for your use only as the instructor of this course. <br /> Per student privacy laws, photos may not be posted on the web or displayed for others to see.</td>
					</tr>
				</table>
				
				<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td valign="top">
							<img src="{Student/StudentPhoto}" alt="{Student/Name}" />
						</td>
						<td valign="top">&#160;</td>
						<td valign="top">
							<p>
								<strong><xsl:value-of select="Subject" />-<xsl:value-of select="CatalogNbr" />-<xsl:value-of select="ClassSection" /><br />
									<xsl:value-of select="Title" /><br />
									<xsl:call-template name="parseTerm">
										<xsl:with-param name="thisTerm" select="Term" />
									</xsl:call-template>
								</strong>
							</p>
							<p>
								<b>
									<xsl:value-of select="Student/Name" />
								</b>
								<br />
								<a href="mailto:{Student/Email}?subject={Subject} {CatalogNbr} {ClassSection} {Title}">
									<xsl:value-of select="Student/Email" />
								</a>
							</p>
							<!-- PROCESS STUDENT INFO -->
							<xsl:apply-templates select="Student" />
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Student">
		<p>
			<b>Status: </b>
		      <xsl:choose>
			<xsl:when test="Withdrawn">Withdrawn</xsl:when>
			<xsl:otherwise>
			<xsl:call-template name="enrollStatus">
				<xsl:with-param name="myStatus" select="EnrlStatus"></xsl:with-param>
			</xsl:call-template>
			</xsl:otherwise>
			</xsl:choose>
			<br />
			<b>College(s): </b>
			<xsl:value-of select="Program" />
			<br />
			<b>Major(s): </b>
			<xsl:value-of select="Major" />
			<br />
			<b>Minor(s): </b>
			<xsl:value-of select="Minor" />
			<br />
			<b>Class: </b>
			<xsl:value-of select="ClassLevel" />
			<br />
			<xsl:if test="FinalGrade !=''">
			<b>Final Grade: </b>
			<xsl:value-of select="FinalGrade" />
			<br />
				</xsl:if>
			<b>Phone: </b>
			<xsl:value-of select="PhoneNbr" />
		</p>
		<p>
			<xsl:choose>
				<xsl:when test="DeathDate != ''"> <b class="emphasis"> DECEASED </b>
				</xsl:when>
				<xsl:when test="Privacy = 'Y'">
					<a href="http://registrar.colorado.edu/regulations/nondisclosure_of_directory_information.html " target="_blank">
						<b class="emphasis"> PRIVACY ENABLED </b>
					</a>
				</xsl:when>
				<xsl:otherwise> &#160; </xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>
	<xsl:template name="parseTerm">
		<xsl:param name="thisTerm" />
		<xsl:choose>
			<xsl:when test="1=substring($thisTerm,4,1)">Spring&#160;</xsl:when>
			<xsl:when test="4=substring($thisTerm,4,1)">Summer&#160;</xsl:when>
			<xsl:when test="7=substring($thisTerm,4,1)">Fall&#160;</xsl:when>
		</xsl:choose> 20<xsl:value-of select="substring($thisTerm,2,2)" />
	</xsl:template>
	
	<xsl:template name="parseTime">
		<xsl:param name="militaryTime" />
		<xsl:variable name="firstHalf">
			<xsl:value-of select="substring($militaryTime, 1,2)" />
		</xsl:variable>
		<xsl:variable name="secondHalf">
			<xsl:value-of select="substring($militaryTime, 4,2)" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$firstHalf > 12"><xsl:value-of select="$firstHalf - 12" />:</xsl:when>
			<xsl:otherwise><xsl:value-of select="$firstHalf" />:</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$secondHalf" />
	</xsl:template>
	
	<xsl:template name="enrollStatus">
		<xsl:param name="myStatus"></xsl:param>
		<xsl:choose>
			<xsl:when test="$myStatus = 'E'">Enrolled</xsl:when>
			<xsl:when test="$myStatus = 'D'">Dropped</xsl:when>
			<xsl:when test="$myStatus = 'W'">Waitlisted</xsl:when>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
