<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output omit-xml-declaration="yes">
  </xsl:output>
  <xsl:template match="alerts">
  <div id="pglt_alerts" class="pglt_wrapper" title="Alerts">
      <xsl:choose>
        <xsl:when test="error">
          <a href="javascript:void(0);" class="darkButton">Holds and To-Do Items<span class="alertcount" id="alertoff">&#160;</span></a>
        </xsl:when>
        <xsl:otherwise>
          <a href="{alertsdetailURL}" class="darkButton colorboxAlert">Holds and To-Do Items 
            <xsl:choose>
              <xsl:when test="alertscnt > 0">
                <span class="alertcount" id="alerton">
                  <xsl:value-of select="alertscnt"/>
                </span>
              </xsl:when>
              <xsl:otherwise>
                <span class="alertcount" id="alertoff">
                  <xsl:value-of select="alertscnt"/>
                </span>
              </xsl:otherwise>
            </xsl:choose>
          </a>
        </xsl:otherwise>
      </xsl:choose>
    
      <script type="text/javascript">				
        $(document).ready(function() {
        $(".colorboxAlert").colorbox({iframe:true, escKey:true, width:"80%", height:"80%"});
        });			
      </script> 
    </div>
  </xsl:template>
</xsl:stylesheet>
