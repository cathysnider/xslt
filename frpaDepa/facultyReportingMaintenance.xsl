<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" />
  <!-- by Cathy Snider, Web Communications, CU-Boulder -->
  <xsl:template match="/">
    <div id="pglt_faculty_reporting" class="pglt_wrapper">
      <h2 class="toggleHeader"><a class="toggleLink closed" id="pagelet_frpa_link" href="javascript:void(0)" aria-controls="pagelet_frpa_content" aria-expanded="false">Faculty Reporting &amp; DEPA</a></h2>
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
      <p>Due to emergency electrical maintenance, the FRPA reporting tool will be unavailable until Sunday, April 3, at 6:00 p.m Visit<a href="http://www.colorado.edu/oit/node/16815" target="_blank">OIT News</a>for more information.</p>
    </div>
  </xsl:template>
  <xsl:template match="SSOLink[name='DEPA']">
    <h3>Disclosure of External Professional Activity (DEPA)</h3>
    <div class="content">
      <div class="content">
        <p>Due to emergency electrical maintenance, the DEPA reporting tool will be unavailable until Sunday, April 3, at 6:00 p.m Visit<a href="http://www.colorado.edu/oit/node/16815" target="_blank">OIT News</a>for more information.</p>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="Error">
    <div class="content">All regular faculty are required to electronically submit FRPA each year as part of the annual merit evaluation process.<br />
      <br />
      Our records indicate that you are not required to submit a FRPA report.</div>
  </xsl:template>
</xsl:stylesheet>
