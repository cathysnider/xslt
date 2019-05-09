<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:template match="StudentSchedule">
    <div id="{STRM}-1">
      <h4><xsl:value-of select="Campus/CampusCode" /> Campus - Course Schedule:
        <xsl:call-template name="getTheTerm" /></h4>
    <table  class="courseWeekTable" cellpadding="0" cellspacing="0" border="0">
      <tr>
        <td valign="top">
          <!-- create monday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th>MONDAY</th>
            </tr>
            <xsl:choose>
              <xsl:when test="count(//Meeting[descendant::MON='Y']) = 0">
                <tr>
                  <td>
                    <p>No Classes</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="//Meeting[descendant::MON='Y']">
                  <xsl:sort select="MEETING_TIME_START"/>
                  <tr>
                    <td><!-- Meeting time start and end -->
                      <div class="meetingtime">
                        <xsl:value-of select="STND_MTG_PAT"/>
                        <xsl:text>&#32;</xsl:text>
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            <xsl:text>&#32;</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_START"/>
                            </span>
                            -
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_END"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </div>
                      <!-- Subject catalog number -->
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>
                      &#160;
                      <xsl:value-of select="preceding-sibling::CATALOG_NBR" />
                      -
                      <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:otherwise>Meeting place unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  <tr>
                       <td><xsl:text>&#32;</xsl:text></td>
                  </tr>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </table>
          
          <!-- end Monday info -->
          
        </td>
        <td valign="top"><!-- GUTTER -->
          <table class="gutterTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th><xsl:text>&#32;</xsl:text></th>
            </tr>
          </table>
        </td>
        <td valign="top">
          <!-- create Tuesday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th>TUESDAY</th>
            </tr>
            <xsl:choose>
              <xsl:when test="count(//Meeting[descendant::TUES='Y']) = 0">
                <tr>
                  <td>
                    <p>No Classes</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="//Meeting[descendant::TUES='Y']">
                  <xsl:sort select="MEETING_TIME_START"/>
                  <tr>
                    <td><!-- Meeting time start and end -->
                      <div class="meetingtime">
                        <xsl:value-of select="STND_MTG_PAT"/>
                        <xsl:text>&#32;</xsl:text>
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            <xsl:text>&#32;</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_START"/>
                            </span>
                            -
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_END"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </div>
                      <!-- Subject catalog number -->
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>
                      &#160;
                      <xsl:value-of select="preceding-sibling::CATALOG_NBR"/>
                      -
                      <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:otherwise>Meeting place unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  <tr>
                       <td><xsl:text>&#32;</xsl:text></td>
                  </tr>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </table>
          <!-- end Tuesday info -->
          
        </td>
        <td valign="top"><!-- GUTTER -->
          <table class="gutterTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th><xsl:text>&#32;</xsl:text></th>
            </tr>
          </table>
        </td>
        <td valign="top">
          <!-- create Wednesday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th>WEDNESDAY</th>
            </tr>
            <xsl:choose>
              <xsl:when test="count(//Meeting[descendant::WED='Y']) = 0">
                <tr>
                  <td>
                    <p>No Classes</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="//Meeting[descendant::WED='Y']">
                  <xsl:sort select="MEETING_TIME_START"/>
                  <tr>
                    <td><!-- Meeting time start and end -->
                      <div class="meetingtime">
                        <xsl:value-of select="STND_MTG_PAT"/>
                        <xsl:text>&#32;</xsl:text>
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            <xsl:text>&#32;</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_START"/>
                            </span>
                            -
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_END"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </div>
                      <!-- Subject catalog number -->
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>
                      &#160;
                      <xsl:value-of select="preceding-sibling::CATALOG_NBR"/>
                      -
                      <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:otherwise>Meeting place unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  <tr>
                       <td><xsl:text>&#32;</xsl:text></td>
                  </tr>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </table>
          <!-- end Wednesday info -->
          
        </td>
        <td valign="top"><!-- GUTTER -->
          <table class="gutterTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th><xsl:text>&#32;</xsl:text></th>
            </tr>
          </table>
        </td>
        <td valign="top">
          <!-- create Thursday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th>THURSDAY</th>
            </tr>
            <xsl:choose>
              <xsl:when test="count(//Meeting[descendant::THURS='Y']) = 0">
                <tr>
                  <td>
                    <p>No Classes</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="//Meeting[descendant::THURS='Y']">
                  <xsl:sort select="MEETING_TIME_START"/>
                  <tr>
                    <td><!-- Meeting time start and end -->
                      <div class="meetingtime">
                        <xsl:value-of select="STND_MTG_PAT"/>
                        <xsl:text>&#32;</xsl:text>
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            <xsl:text>&#32;</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_START"/>
                            </span>
                            -
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_END"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </div>
                      <!-- Subject catalog number -->
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>
                      &#160;
                      <xsl:value-of select="preceding-sibling::CATALOG_NBR"/>
                      -
                      <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:otherwise>Meeting place unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  <tr>
                       <td><xsl:text>&#32;</xsl:text></td>
                  </tr>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </table>
          <!-- end Thursday info -->
          
        </td>
        <td valign="top"><!-- GUTTER -->
          <table class="gutterTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th><xsl:text>&#32;</xsl:text></th>
            </tr>
          </table>
        </td>
        <td valign="top">
          <!-- create FRIDAY table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
            <tr>
              <th>FRIDAY</th>
            </tr>
            <xsl:choose>
              <xsl:when test="count(//Meeting[descendant::FRI='Y']) = 0">
                <tr>
                  <td>
                    <p>No Classes</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="//Meeting[descendant::FRI='Y']">
                  <xsl:sort select="MEETING_TIME_START"/>
                  <tr>
                    <td><!-- Meeting time start and end -->
                      <div class="meetingtime">
                        <xsl:value-of select="STND_MTG_PAT"/>
                        <xsl:text>&#32;</xsl:text>
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            <xsl:text>&#32;</xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_START"/>
                            </span>
                            -
                            <span class="nowrap">
                              <xsl:value-of select="MEETING_TIME_END"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </div>
                      <!-- Subject catalog number -->
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>
                      &#160;
                      <xsl:value-of select="preceding-sibling::CATALOG_NBR"/>
                      -
                      <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                          <div class="meetingtime">
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>
                              <xsl:text>&#32;</xsl:text>
                              <xsl:value-of select="ROOM"/>
                            </a>
                          </div>
                        </xsl:when>
                        <xsl:otherwise>Meeting place unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  <tr>
                       <td><xsl:text>&#32;</xsl:text></td>
                  </tr>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </table>
          <!-- end FRIDAY info -->
          
        </td>
        
        <!-- test for Saturday content -->
        <xsl:if test="count(//Meeting[descendant::SAT='Y']) > 0">
          <td valign="top"><!-- GUTTER -->
            <table class="gutterTable" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <th><xsl:text>&#32;</xsl:text></th>
              </tr>
            </table>
          </td>
          <td valign="top">
            <!-- create SATURDAY table -->
            <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <th>SATURDAY</th>
              </tr>
              <xsl:for-each select="//Meeting[descendant::SAT='Y']">
                <xsl:sort select="MEETING_TIME_START"/>
                <tr>
                  <td><!-- Meeting time start and end -->
                    <div class="meetingtime">
                      <xsl:value-of select="STND_MTG_PAT"/>
                      <xsl:text>&#32;</xsl:text>
                      <xsl:choose>
                        <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                          <xsl:text>&#32;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <span class="nowrap">
                            <xsl:value-of select="MEETING_TIME_START"/>
                          </span>
                          -
                          <span class="nowrap">
                            <xsl:value-of select="MEETING_TIME_END"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </div>
                    <!-- Subject catalog number -->
                    <xsl:value-of select="preceding-sibling::SUBJECT"/>
                    &#160;
                    <xsl:value-of select="preceding-sibling::CATALOG_NBR"/>
                    -
                    <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                    <br/>
                    <!-- Name of class -->
                    <xsl:value-of select="preceding-sibling::DESCR"/>
                    <br/>
                    <!--Building and room -->
                    <xsl:choose>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                        <div class="meetingtime">
                          <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                            <xsl:value-of select="BLDG"/>
                            <xsl:text>&#32;</xsl:text>
                            <xsl:value-of select="ROOM"/>
                          </a>
                        </div>
                      </xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                        <div class="meetingtime">
                          <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                            <xsl:value-of select="BLDG"/>
                            <xsl:text>&#32;</xsl:text>
                            <xsl:value-of select="ROOM"/>
                          </a>
                        </div>
                      </xsl:when>
                      <xsl:otherwise>Meeting place unknown</xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>
                <tr>
                     <td><xsl:text>&#32;</xsl:text></td>
                
                </tr>
              </xsl:for-each>
            </table>
            <!-- end SATURDAY info -->
            
          </td>
        </xsl:if>
        
        <!-- test for Sunday content -->
        <xsl:if test="count(//Meeting[descendant::SUN='Y']) > 0">
          <td valign="top"><!-- GUTTER -->
            <table class="gutterTable" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <th><xsl:text>&#32;</xsl:text></th>
               
              </tr>
            </table>
          </td>
          <td valign="top">
            <!-- create SUNDAY table -->
            <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
              <tr>
                <th>SUNDAY</th>
              </tr>
              <xsl:for-each select="//Meeting[descendant::SUN='Y']">
                <xsl:sort select="MEETING_TIME_START"/>
                <tr>
                  <td><!-- Meeting time start and end -->
                    <div class="meetingtime">
                      <xsl:value-of select="STND_MTG_PAT"/>
                      <xsl:text>&#32;</xsl:text>
                      <xsl:choose>
                        <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                          <xsl:text>&#32;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <span class="nowrap">
                            <xsl:value-of select="MEETING_TIME_START"/>
                          </span>
                          -
                          <span class="nowrap">
                            <xsl:value-of select="MEETING_TIME_END"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </div>
                    <!-- Subject catalog number -->
                    <xsl:value-of select="preceding-sibling::SUBJECT"/>
                    &#160;
                    <xsl:value-of select="preceding-sibling::CATALOG_NBR" />
                    -
                    <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                    <br/>
                    <!-- Name of class -->
                    <xsl:value-of select="preceding-sibling::DESCR"/>
                    <br/>
                    <!--Building and room -->
                    <xsl:choose>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                        <div class="meetingtime">
                          <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                            <xsl:value-of select="BLDG"/>
                            <xsl:text>&#32;</xsl:text>
                            <xsl:value-of select="ROOM"/>
                          </a>
                        </div>
                      </xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                        <div class="meetingtime">
                          <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                            <xsl:value-of select="BLDG"/>
                            <xsl:text>&#32;</xsl:text>
                            <xsl:value-of select="ROOM"/>
                          </a>
                        </div>
                      </xsl:when>
                      <xsl:otherwise>Meeting place unknown</xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>
                <tr>
                     <td><xsl:text>&#32;</xsl:text></td>
                </tr>
              </xsl:for-each>
            </table>
            <!-- end SUNDAY info -->
            
          </td>
        </xsl:if>
      </tr>
    </table>
    
    <!-- NOW RUN THROUGH THE ENTIRE LIST AGAIN, PULLING OUT THE CLASSES WHOSE STND_MTG_PAT IS NULL -->
    
    <table width="100%" cellpadding="25" cellspacing="5" style="background-color:white; margin-top:5px;">
      <tr>
        <th align="left" style=" background-color: #666666; color: #f6f6f6; padding: 5px 5px;">Online Classes: No Time Assigned</th>
      </tr>
      <xsl:for-each select="//Meeting[descendant::STND_MTG_PAT='']">
        <tr>
          <td align="left" style="border:1px solid #ddd; padding: 5px;">
            <!-- Subject catalog number -->
            <xsl:value-of select="preceding-sibling::SUBJECT"/>
            &#160;
            <xsl:value-of select="preceding-sibling::CATALOG_NBR"
					/>
            -
            <xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
            <br/>
            <!-- Name of class -->
            <xsl:value-of select="preceding-sibling::DESCR"/>
            <br/>
            <!--Building and room -->
            <span class="meetingtime">
              <xsl:choose>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                  <div class="meetingtime">
                    <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                      <xsl:value-of select="BLDG"/>
                      <xsl:text>&#32;</xsl:text>
                      <xsl:value-of select="ROOM"/>
                    </a>
                  </div>
                </xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P'">
                  <div class="meetingtime">
                    <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                      <xsl:value-of select="BLDG"/>
                      <xsl:text>&#32;</xsl:text>
                      <xsl:value-of select="ROOM"/>
                    </a>
                  </div>
                </xsl:when>
                <xsl:otherwise>Meeting place unknown</xsl:otherwise>
              </xsl:choose>
            </span>
          </td>
        </tr>
      </xsl:for-each>
    </table>
      </div>
  </xsl:template>
  

</xsl:stylesheet>
