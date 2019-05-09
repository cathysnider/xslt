<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" />
	<!-- by Cathy Snider, Web Communications, CU-Boulder -->
	<xsl:template match="/">
<div id="pglt_faculty_reporting" class="pglt_wrapper">
<h2 class="toggleHeader"><a class="toggleLink closed" id="pagelet_frpa_link" href="javascript:void(0)" 
aria-controls="pagelet_frpa_content" aria-expanded="false">Faculty Reporting &amp; DEPA</a></h2>
<div class="toggle_content" id="pagelet_frpa_content" aria-hidden="true">
<xsl:apply-templates select="facultyReporting" />
</div>                   
</div>
<script type="text/javascript"> 
$("a#pagelet_frpa_link").click(toggleLink);
</script>
</xsl:template>

	<xsl:template match="facultyReporting">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="SSOLink[name='FRPA']">
		<h3>Faculty Report of Professional Activity (FRPA)</h3>
		<div class="content">
			<p>All regular faculty are required to electronically submit FRPA each year as part of the annual merit evaluation process. Others (including research faculty and part-time faculty)
			are allowed to submit FRPA if they desire. Some units may require research and part-time faculty to submit FRPA as part of an internal process.</p>
			<form action="{tokenExchangeURL}" target="_blank" method="post" name="{keyword}">
				<input type="hidden" name="authType" value="{authtype}" />
				<input type="hidden" name="pstoken" value="{pstoken}" />
				<input type="hidden" name="dest" value="{keyword}" />
			</form>
			<div class="darkgraybutton">
				<a href="javascript:formSubmitLink('{keyword}');">Login to <xsl:value-of select="name" /></a>
			</div>
			<p class="small">If you have questions about FRPA, please contact Faculty Affairs at 303-492-3055.</p>
		</div>
	</xsl:template>
	<xsl:template match="SSOLink[name='DEPA']">
		<h3>Disclosure of External Professional Activity (DEPA)</h3>
		<div class="content">
			<p>The DEPA is a short questionnaire required by University policies regarding conflicts of interest and/or commitment. It should be submitted annually by all CU Boulder faculty and research personnel, as well as any other employee, or student with responsibility for the design, conduct and/or reporting of research.</p>
			<form action="{tokenExchangeURL}" target="_blank" method="post" name="{keyword}">
				<input type="hidden" name="authType" value="{authtype}" />
				<input type="hidden" name="pstoken" value="{pstoken}" />
				<input type="hidden" name="dest" value="{keyword}" />
			</form>
			<div class="darkgraybutton">
			<a href="javascript:formSubmitLink('{keyword}');">Login to <xsl:value-of select="name" /></a>
			</div>
			<p class="small">For difficulties accessing DEPA, please contact OIT at 5-HELP or <a href="mailto:help@colorado.edu">help@colorado.edu</a>. For content questions, please see <a href="http://www.colorado.edu/vcr/coi" target="_blank">the DEPA website</a>, or contact the Compliance Director: <a href="mailto:coi@colorado.edu">coi@colorado.edu</a> or 303-492-3024.</p>
            </div>
	</xsl:template>
	<xsl:template match="Error">
		<div class="content">
		All regular faculty are required to electronically submit FRPA each year as part of the annual merit evaluation process.<br /><br />
		Our records indicate that you are not required to submit a FRPA report. </div>
	</xsl:template>
</xsl:stylesheet>
