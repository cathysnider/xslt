<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- by Cathy Snider, Strategic Relations, CU Boulder -->
<!-- October 2016 -->
<!-- working on ARIA controls-->
<xsl:output method="html" cdata-section-elements="script" />
<xsl:param name="theInitialTerm"><xsl:value-of select="StudentSchedule/Institution/InitialStudentTerm" />	</xsl:param>
<xsl:template match="StudentSchedule">

  <div id="ScheduleAndGrades" class="infobox academicschedule" aria-labelledby="sglabel">

<h2 id="sglabel" class="element-invisible">Course Info</h2> <!--this label is hidden -->
	<xsl:choose>
		<xsl:when test="Error">
			<script type="text/javascript">
	
			  $( document ).ready(function() {
   			$("div.tabPanel").hide();
			$("div#schedule1").show();
			
			// Accessible Tab Panels
$("ul.tabList a").click(function(){ 
		
	    $("div.tabPanel").hide();
		$("div.tabPanel").attr("aria-hidden","true");
		$("ul.tabList li a").removeClass('current');
		$("ul.tabList li a").attr("aria-selected","false");
		$(this).addClass('current');
		$(this).attr("aria-selected","true");
		var tabname = $( this ).attr( "name" );
		$("div#" + tabname ).show();
		$("div#" + tabname  ).attr("aria-hidden","false");

		return false;
  	});
	
			});
			</script>
		  <div class="tabSet" id="emptytabs">
		    <ul role="tablist" class="tabList">
		      <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule1" name="schedule1" id="tab1" aria-selected="true" aria-label="Schedule" class="current">Schedule</a></li>
		      <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule2" name="schedule2" id="tab2" aria-selected="false" aria-label="Grades/Details">Grades/Details</a></li>
		      <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule3" name="schedule3" id="tab3" aria-selected="false" aria-label="Course Books">Course Books</a></li> 
              <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule4" name="schedule4" id="tab4" aria-selected="false" aria-label="Finals Schedule">Finals Schedule</a></li>
				</ul>
			<div id="tabline"><img src="http://www.colorado.edu/portal/ep/ucb2/images/clear.gif" alt="" width="1" height="1" role="presentation" /></div> 
<div class="contenterror">
  <div id="schedule1" class="tabPanel" role="tabpanel" aria-labelledby="tab1" aria-hidden="false"><p>We are unable to retrieve a Schedule of Courses for you at this time; please check back later.</p></div>
  <div id="schedule2" class="tabPanel" role="tabpanel" aria-labelledby="tab2" aria-hidden="true"><p>We are unable to retrieve your Grades and Details at this time; please check back later.</p></div>
  <div id="schedule3" class="tabPanel" role="tabpanel" aria-labelledby="tab3" aria-hidden="true"><p>We are unable to retrieve your Course Books at this time; please check back later.</p></div>
  <div id="schedule4" class="tabPanel" role="tabpanel" aria-labelledby="tab4" aria-hidden="true"><p>We are unable to retrieve your Finals Schedule at this time; please check back later.</p></div>
</div>
				</div> <!--/emptytabs -->
		</xsl:when>
		<xsl:when test="Institution">
	
      <script type="text/javascript">
	   $( document ).ready(function() {
		//initial setup of hiding and showing	
			 $("div.tabSet").hide();
   			$("div.tabPanel").hide();
			$('div#tabs-<xsl:value-of select="Institution/InitialStudentTerm"/>').show();
			$('div#<xsl:value-of select="Institution/InitialStudentTerm"/>-1').show();
	
// Accessible Tab Panels
$("ul.tabList a").click(function(){ 
		
	    $("div.tabPanel").hide();
		$("div.tabPanel").attr("aria-hidden","true");
		$("ul.tabList li a").removeClass('current');
		$("ul.tabList li a").attr("aria-selected","false");
		$(this).addClass('current');
		$(this).attr("aria-selected","true");
		var tabname = $( this ).attr( "name" );
		$("div#" + tabname ).show();
		$("div#" + tabname  ).attr("aria-hidden","false");

		return false;
  	});
	
//   Choose your semester
	$('select#scheduleTerm').bind('focus', function() { 
	  oldTerm = $(this).val();
		}).change(function() {
			$("div.tabSet").hide();
   			$("div.tabPanel").hide();
			var newTerm = $('select#scheduleTerm').val();
			var oldTabList = $('div#tabs-' + oldTerm + ' ul.tabList a'); 
			var newTabList = $('div#tabs-' + newTerm + ' ul.tabList a'); 
			var previousIndex = getTheIndex(oldTabList, "current"); //gets index of class currrent
			$('div#tabs-' + newTerm).show();
			$('div#tabs-' + newTerm + ' div.tabPanel').eq(previousIndex).show();
			$('div#tabs-' + newTerm + ' ul.tabList a').eq(previousIndex).addClass('current');		
	});
	
	$("table.tbl-schedule tr:even").addClass('rowone');
	$("table.tbl-schedule tr:odd").addClass('rowtwo');	
	
                           
       });  </script>
            <xsl:apply-templates select="Institution " />
	<script>
	//NOTE: THE CODE BREAKS IN PORTAL UNLESS THIS FUNCTION IS SEPARATED FROM THE OTHERS; NO IDEA WHY
	//  <![CDATA[   		
function getTheIndex(newList, theClass) {
//PASS IN A NODELIST AND A CLASS; FUNCTION CREATES NODE LIST, RETURNS FIRST INDEX OF CLASS
//EXAMPLE: var myList = document.getElementsByTagName("li"); var currentIndex = getTheIndex(myList, "current");
  var foundTheIndex = -1;
  var pattern = new RegExp("(^| )" + theClass + "( |$)");
  for (var i = 0; i < newList.length; i++) {
   if (pattern.test(newList[i].className)) {foundTheIndex = i; }
  }
  return foundTheIndex;
}
//  ]]>	
</script>
		</xsl:when>
		<xsl:otherwise>
			<script type="text/javascript">
			  $( document ).ready(function() {
   			$("div.tabPanel").hide();
			$("div#schedule1").show();
			
			// Accessible Tab Panels
$("ul.tabList a").click(function(){ 
		
	    $("div.tabPanel").hide();
		$("div.tabPanel").attr("aria-hidden","true");
		$("ul.tabList li a").removeClass('current');
		$("ul.tabList li a").attr("aria-selected","false");
		$(this).addClass('current');
		$(this).attr("aria-selected","true");
		var tabname = $( this ).attr( "name" );
		$("div#" + tabname ).show();
		$("div#" + tabname  ).attr("aria-hidden","false");

		return false;
  	});
	
			});
			</script>
				<div class="tabSet" id="emptytabs">
				  <ul role="tablist" class="tabList">
				    <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule1" name="schedule1" id="tab1" aria-selected="true" aria-label="Schedule" class="current">Schedule</a></li>
				    <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule2" name="schedule2" id="tab2" aria-selected="false" aria-label="Grades/Details">Grades/Details</a></li>
				    <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule3" name="schedule3" id="tab3" aria-selected="false" aria-label="Course Books">Course Books</a></li> 
                    <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-controls="schedule4" name="schedule4" id="tab4" aria-selected="false" aria-label="Finals Schedule">Finals Schedule</a></li>
				  </ul>
			
			<div id="tabline"><img src="http://www.colorado.edu/portal/ep/ucb2/images/clear.gif" alt="" width="1" height="1" role="presentation" /></div> 
<div class="contenterror">
  <div id="schedule1" class="tabPanel" role="tabpanel" aria-labelledby="tab1" aria-hidden="false"><p>We are unable to retrieve a Schedule of Courses for you at this time; please check back later.</p></div>
  <div id="schedule2" class="tabPanel" role="tabpanel" aria-labelledby="tab2" aria-hidden="true"><p>We are unable to retrieve your Grades and Details at this time; please check back later.</p></div>
  <div id="schedule3" class="tabPanel" role="tabpanel" aria-labelledby="tab3" aria-hidden="true"><p>We are unable to retrieve your Course Books at this time; please check back later.</p></div>
  <div id="schedule4" class="tabPanel" role="tabpanel" aria-labelledby="tab4" aria-hidden="true"><p>We are unable to retrieve your Finals Schedule at this time; please check back later.</p></div>
</div>
				</div> <!-- /emptytabs -->
		</xsl:otherwise>
	</xsl:choose>
<br clear="both" />
	<img src="http://www.colorado.edu/portal/ep/ucb2/images/clear.gif" width="550" height="1" />
  
</div>
</xsl:template>
<xsl:template match="Institution">
	
<form id="scheduleForm">
<label for="scheduleTerm">Term: </label>
<select id="scheduleTerm" name="scheduleTerm" >
<xsl:apply-templates select="TermValues" />
</select>
</form>

<xsl:apply-templates select="Term" />
  
</xsl:template>
<xsl:template match="Term">
	<div class="tabSet">
		<xsl:attribute name="id">tabs-<xsl:value-of select="STRM" /></xsl:attribute>
<ul role="tablist" class="tabList">
<li role="presentation">
<a role="tab" href="javascript:void(0)"  aria-label="Schedule" aria-controls="{STRM}-1" name="{STRM}-1" id="{STRM}-1-link" aria-selected="true" class="current">Schedule</a></li>
<li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-label="Grades/Details" aria-controls="{STRM}-2" name="{STRM}-2" id="{STRM}-2-link" aria-selected="false" onclick="$.getScript('{../ScheduleLinks/D2LScriptLink}')">Grades/Details</a></li>
			<xsl:choose>
				<xsl:when test="not(Campus/BoulderBookLink)">
					<!-- when no BoulderBookLink, build unlinked tab -->
				  <li role="presentation"> <a role="tab" href="javascript:void(0)" aria-label="Course Books" aria-controls="{STRM}-3" name="{STRM}-3" id="{STRM}-3-link" aria-selected="false">Course Books</a></li> </xsl:when>
				<xsl:otherwise>
				  <li role="presentation"> <a role="tab" href="javascript:void(0)"  aria-label="Course Books" aria-controls="{STRM}-3" name="{STRM}-3" id="{STRM}-3-link" aria-selected="false" onclick="loadbooks('{STRM}-3books', '{Campus/BoulderBookLink}')" >Course Books</a></li> </xsl:otherwise>
			</xsl:choose>
<li role="presentation"><a role="tab" href="javascript:void(0)"  aria-label="Finals Schedule" aria-controls="{STRM}-4" name="{STRM}-4" id="{STRM}-4-link" aria-selected="false">Finals Schedule</a></li>
</ul>
		<div id="tabline"><img src="http://www.colorado.edu/portal/ep/ucb2/images/clear.gif" alt="" width="1" height="1" role="presentation" /></div> 
	  <!-- put this here -->
	  <xsl:apply-templates select="../ScheduleLinks" />
	  
		<div class="term-content">
			<xsl:attribute name="id">content-<xsl:value-of select="STRM" /></xsl:attribute>
			<!-- Begin fragment-1 : Schedule-->

		  <div id="{STRM}-1" class="tabPanel" role="tabpanel" aria-labelledby="{STRM}-1-link" aria-hidden="false">
      <h3>Schedule: <xsl:call-template name="getTheTerm" /></h3>
    <table class="courseWeekTable" cellpadding="0" cellspacing="0" border="0">
      <tr>
        <td valign="top">
          <!-- create monday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
          
          <thead>
            <tr>
              <th scope="col">Monday <span class="element-invisible">Classes</span></th>
            </tr>
            </thead>
             <tbody>
            <xsl:choose>
              <xsl:when test="count(descendant::Meeting[descendant::MON='Y']) = 0">
              <tr>
                  <td>
                    <p>No Classes for Monday</p>
                  </td>
                </tr>
               
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="descendant::Meeting[descendant::MON='Y']">
                  <xsl:sort select="MEETING_TIME_START_24"/>
                  
                  <tr>
                    <td><!-- Meeting time start and end -->
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            &#xA0;
                          </xsl:when>
                          <xsl:otherwise>
                            <strong><span class="nowrap"><xsl:value-of select="MEETING_TIME_START"/>-<xsl:value-of select="MEETING_TIME_END"/></span></strong>
                          </xsl:otherwise>
                        </xsl:choose>
                      
                       <!-- Subject catalog number -->
                      <br />
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </tbody>
           </table>
           <!-- end Monday info -->
          
        </td>
        
        <td valign="top" class="oddColumn">
          <!-- create Tuesday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
         
          <thead>
            <tr>
              <th scope="col">Tuesday <span class="element-invisible">Classes</span></th>
            </tr>
            </thead>
            <tbody>
            <xsl:choose>
              <xsl:when test="count(descendant::Meeting[descendant::TUES='Y']) = 0">
                
                <tr>
                  <td>
                    <p>No Classes for Tuesday</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="descendant::Meeting[descendant::TUES='Y']">
                  <xsl:sort select="MEETING_TIME_START_24"/>
                  
                  <tr>
                    <td><!-- Meeting time start and end -->
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            &#xA0;
                          </xsl:when><xsl:otherwise>
                            <strong><span class="nowrap"><xsl:value-of select="MEETING_TIME_START"/>-<xsl:value-of select="MEETING_TIME_END"/></span></strong>
                          </xsl:otherwise>
                        </xsl:choose>
                      
                       <!-- Subject catalog number -->
                      <br />
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
         </tbody>
          </table>
          <!-- end Tuesday info -->
          
        </td>
        
        <td valign="top">
          <!-- create Wednesday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
         <thead>
            <tr>
              <th scope="col">Wednesday <span class="element-invisible">Classes</span></th>
            </tr>
             </thead>
            <tbody>
            <xsl:choose>
              <xsl:when test="count(descendant::Meeting[descendant::WED='Y']) = 0">
                
                <tr>
                  <td>
                    <p>No Classes for Wednesday</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="descendant::Meeting[descendant::WED='Y']">
                  <xsl:sort select="MEETING_TIME_START_24"/>
                  <tr>
                    <td><!-- Meeting time start and end -->
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            &#xA0;
                          </xsl:when><xsl:otherwise>
                            <strong><span class="nowrap"><xsl:value-of select="MEETING_TIME_START"/>-<xsl:value-of select="MEETING_TIME_END"/></span></strong>
                          </xsl:otherwise>
                        </xsl:choose>
                      
                       <!-- Subject catalog number -->
                      <br />
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </tbody>
          </table>
          <!-- end Wednesday info -->
          
        </td>
        
       <td valign="top" class="oddColumn">
          <!-- create Thursday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th scope="col">Thursday <span class="element-invisible">Classes</span></th>
            </tr>
             </thead>
            <tbody>
            <xsl:choose>
              <xsl:when test="count(descendant::Meeting[descendant::THURS='Y']) = 0">
                  <tr>
                  <td>
                    <p>No Classes for Thursday</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="descendant::Meeting[descendant::THURS='Y']">
                  <xsl:sort select="MEETING_TIME_START_24"/>
                    <tr>
                    <td><!-- Meeting time start and end -->
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            &#xA0;
                          </xsl:when><xsl:otherwise>
                            <strong><span class="nowrap"><xsl:value-of select="MEETING_TIME_START"/>-<xsl:value-of select="MEETING_TIME_END"/></span></strong>
                          </xsl:otherwise>
                        </xsl:choose>
                      
                       <!-- Subject catalog number -->
                      <br />
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </tbody>
          </table>
          <!-- end Thursday info -->
          
        </td>
       
        
        <td valign="top">
          <!-- create Friday table -->
          <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th scope="col">Friday <span class="element-invisible">Classes</span></th>
            </tr>
            </thead>
            <tbody>
            <xsl:choose>
              <xsl:when test="count(descendant::Meeting[descendant::FRI='Y']) = 0">
                <tr>
                  <td>
                    <p>No Classes for Friday</p>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <xsl:for-each select="descendant::Meeting[descendant::FRI='Y']">
                  <xsl:sort select="MEETING_TIME_START_24"/>
                   <tr>
                    <td><!-- Meeting time start and end -->
                        <xsl:choose>
                          <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                            &#xA0;
                          </xsl:when><xsl:otherwise>
                            <strong><span class="nowrap"><xsl:value-of select="MEETING_TIME_START"/>-<xsl:value-of select="MEETING_TIME_END"/></span></strong>
                          </xsl:otherwise>
                        </xsl:choose>
                      
                       <!-- Subject catalog number -->
                      <br />
                      <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                      <br/>
                      <!-- Name of class -->
                      <xsl:value-of select="preceding-sibling::DESCR"/>
                      <br/>
                      <!--Building and room -->
                      <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                  
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </tbody></table>
          <!-- end Friday info -->
          
        </td>
        
        <!-- test for Saturday content -->
        <xsl:if test="count(descendant::Meeting[descendant::SAT='Y']) > 0">
          
          <td valign="top" class="oddColumn">
            <!-- create Saturday table -->
            <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th scope="col">Saturday <span class="element-invisible">Classes</span></th>
              </tr>
               </thead>
            <tbody>
              <xsl:for-each select="descendant::Meeting[descendant::SAT='Y']">
                <xsl:sort select="MEETING_TIME_START_24"/>
                 <tr>
                  <td><!-- Meeting time start and end -->
                      <xsl:choose>
                        <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                          &#xA0;
                        </xsl:when><xsl:otherwise>
                            <strong><span class="nowrap"><xsl:value-of select="MEETING_TIME_START"/>-<xsl:value-of select="MEETING_TIME_END"/></span></strong>
                          </xsl:otherwise>
                      </xsl:choose>
                    
                   
                    <!-- Subject catalog number -->
                    <br />
                    <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                    <br/>
                    <!-- Name of class -->
                    <xsl:value-of select="preceding-sibling::DESCR"/>
                    <br/>
                    <!--Building and room -->
                    
                    <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
                  </td>
                </tr>
                
              </xsl:for-each>
           </tbody> </table>
            <!-- end Saturday info -->
            
          </td>
        </xsl:if>
        
        <!-- test for Sunday content -->
        <xsl:if test="count(descendant::Meeting[descendant::SUN='Y']) > 0">
          
          <td valign="top">
            <!-- create Sunday table -->
            <table class="courseDayTable" cellpadding="0" cellspacing="0" border="0">
         <thead>
            <tr>
              <th scope="col">Sunday <span class="element-invisible">Classes</span></th>
              </tr>
              </thead>
              <tbody>
              <xsl:for-each select="descendant::Meeting[descendant::SUN='Y']">
                <xsl:sort select="MEETING_TIME_START_24"/>
                 <tr>
                  <td><!-- Meeting time start and end -->
                      <xsl:choose>
                        <xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' ">
                          &#xA0;
                        </xsl:when><xsl:otherwise>
                            <strong><span class="nowrap"><xsl:value-of select="MEETING_TIME_START"/>-<xsl:value-of select="MEETING_TIME_END"/></span></strong>
                          </xsl:otherwise>
                      </xsl:choose>
                    
                    <!-- Subject catalog number -->
                    <br />
                    <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
                    <br/>
                    <!-- Name of class -->
                    <xsl:value-of select="preceding-sibling::DESCR"/>
                    <br/>
                    <!--Building and room -->
                    <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                      <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
                  </td>
                </tr>
                
              </xsl:for-each>
           </tbody> </table>
            <!-- end Sunday info -->
            
          </td>
        </xsl:if>
      </tr>
    </table>
    
    <!-- NOW RUN THROUGH THE ENTIRE LIST AGAIN, PULLING OUT THE CLASSES WHOSE STND_MTG_PAT IS NULL -->
 <xsl:if test="count(descendant::Meeting[descendant::STND_MTG_PAT='']) > 0 or count(descendant::Meeting[descendant::STND_MTG_PAT='TBA']) > 0" > 
    <table width="100%" cellpadding="25" cellspacing="5" style="background-color:white; margin-top:5px;"><caption class="element-invisible">Classes with No Assigned Time</caption>
      <thead><tr>
        <th align="left" style=" background-color: #666666; color: #f6f6f6; padding: 5px 5px;">No Time Assigned</th>
      </tr>
      </thead>
      <tbody>
      <xsl:for-each select="descendant::Meeting[descendant::STND_MTG_PAT='']">
        <tr>
          <td align="left" style="border:1px solid #ddd; padding: 5px;">
            <!-- Subject catalog number -->
            <xsl:value-of select="preceding-sibling::SUBJECT"/>&#xA0;<xsl:value-of select="preceding-sibling::CATALOG_NBR"/>-<xsl:value-of select="preceding-sibling::CLASS_SECTION"/>
            <br/>
            <!-- Name of class -->
            <xsl:value-of select="preceding-sibling::DESCR"/>
            <br/>
            <!--Building and room -->
          
              
              <xsl:choose>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='DL'">Distance Learning</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='HY'">Hybrid Online/Classroom
                          
                           <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                       
                        </xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='MAIN'">Boulder Main Campus</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='CD'">Candidate for Degree</xsl:when>
                <xsl:when test="preceding-sibling::INSTRUCTION_MODE='IS'">Independent Study</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OL'">Online</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OS'">Online Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='OT'">Online Term Based</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='PS'">Print Self Paced</xsl:when>
                        <xsl:when test="preceding-sibling::INSTRUCTION_MODE='P' or preceding-sibling::INSTRUCTION_MODE='HN'">
                            <xsl:choose>
                              <xsl:when test="BLDG = 'SOCU'"> <!-- test for South Denver Campus -->
                                <a href="https://goo.gl/maps/3SCnO" target="_blank"><xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/></a>
                              </xsl:when>
                              <xsl:otherwise> <!-- class is on Boulder Main Campus -->
                            <a href="http://www.colorado.edu/campusmap/map.html?bldg={BLDG}" target="_blank">
                              <xsl:value-of select="BLDG"/>&#xA0;<xsl:value-of select="ROOM"/>
                            </a>
                              </xsl:otherwise>
                            </xsl:choose>
                          
                        </xsl:when>
                        <xsl:otherwise>Meeting Place Unknown</xsl:otherwise>
                      </xsl:choose>
          
          </td>
        </tr>
      </xsl:for-each>
    </tbody>
    </table>   
 </xsl:if>
            
 </div>
			
			<!-- end fragment-1 -->
			<!-- Begin fragment-2 : Grades / Details-->
			
		  <div id="{STRM}-2" class="tabPanel" role="tabpanel" aria-labelledby="{STRM}-2-link" aria-hidden="false">
				<h3>Grades / Details: <xsl:call-template name="getTheTerm" /></h3>
				<table class="tbl-schedule" cellspacing="0" width="100%">
					<thead><tr>
                    	<th scope="column" class="columnheader" align="left" width="25%">Course Title</th>
						<th scope="column" class="columnheader" align="left" width="20%">Course / Section</th>
						<th scope="column" class="columnheader" align="left">Days / Time</th>
						<th scope="column" class="columnheader" align="left" width="30%">Instructor</th>
						<th scope="column" class="columnheader" >Web Site</th>
						<th scope="column" class="columnheader" >Credits</th>
						<th scope="column" class="columnheader" >Status</th>
						<th scope="column" class="columnheader" >Grade</th>
					</tr>
                    </thead>
                    <tbody>
					<xsl:choose>
						<xsl:when test="Warning/WarnMessage">
							<tr><td colspan="8">
								<xsl:value-of select="Warning/WarnMessage"/>
							</td></tr>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="Campus/Course">
								<tr>
									<th scope="row" class="rowheader">
										<xsl:value-of select="DESCR" /><xsl:text>&#xA0;(</xsl:text><xsl:call-template name="SSRComponent" /><xsl:text>)</xsl:text>
									</th>
                                    <td>
										<xsl:value-of select="SUBJECT"/>&#xA0;<xsl:value-of select="CATALOG_NBR"
										/>-<xsl:value-of select="CLASS_SECTION" />
										<br />
										<a class="FCQlink" href="https://fcq.colorado.edu/scripts/broker.exe?_PROGRAM=fcqlib.fcqdata.sas&amp;subj={SUBJECT}&amp;crse={CATALOG_NBR}" target="_blank">FCQ*</a> 
									</td>
                                    
									<td align="left" nowrap="nowrap">
										<xsl:for-each select="Meeting">
											<div class="meetingtime"><xsl:value-of select="STND_MTG_PAT" /><xsl:text>&#32;</xsl:text>
											<xsl:choose>
												<xsl:when test="MEETING_TIME_START='00:00 AM' and MEETING_TIME_END='00:00 AM' "><xsl:text>&#32;</xsl:text></xsl:when>
												<xsl:otherwise>
											<span class="nowrap"><xsl:value-of select="MEETING_TIME_START" /></span> - <span class="nowrap"><xsl:value-of select="MEETING_TIME_END" /></span>
												</xsl:otherwise>
												</xsl:choose>
											</div>
										</xsl:for-each>
									</td>
									<td>
									<xsl:apply-templates select="PrimaryInstructor"></xsl:apply-templates>
								
									</td>
                                    
									<td align="center">
										<div class="d2llLinkDiv" id="{../../STRM}-{CRSE_ID}-{CRSE_OFFER_NBR}-{SESSION_CODE}-{CLASS_SECTION}">
									<img src="http://www.colorado.edu/portal/ep/ucb2/images/loadingbar.gif" height="15" width="120" alt="Loading ..." />
										</div>
										<!--
										<xsl:if test="d2lLink">
											<a class="FCQlink" href="{d2lLink}" target="_blank">D2L Site</a><br />
										</xsl:if>
										-->
											<xsl:if test="CourseLink">
												<a class="FCQlink" href="{CourseLink/LINK_URL}" target="_blank">Web Site</a>
											</xsl:if>
									</td>
									
									<td align="center"><xsl:value-of select="UNT_TAKEN" /></td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="CRSE_GRADE_OFF = 'W'">Withdrawn</xsl:when><!-- If Grade is W, the student is enrolled but has withdrawn -->
											<xsl:when test="ENRL_STATUS_REASON = 'WDRW'">Withdrawn</xsl:when><!-- If Status Reason is Withdrawn, the student is enrolled but has withdrawn -->
											<xsl:when test="STDNT_ENRL_STATUS = 'E'">Enrolled</xsl:when>
											<xsl:when test="STDNT_ENRL_STATUS = 'D'">Dropped</xsl:when>
											<xsl:when test="STDNT_ENRL_STATUS = 'W'">Waitlisted</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="STDNT_ENRL_STATUS" />
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="CRSE_GRADE_OFF = 'W'"> </xsl:when><!-- If Grade is W, student has withdrawn -->
											<xsl:otherwise>
												<xsl:value-of select="CRSE_GRADE_OFF" />
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:for-each>
						</xsl:otherwise></xsl:choose>
				</tbody></table>
				<p><b>* FCQ = Faculty Course Questionnaire (ratings of teachers and classes by CU students)</b></p>
			</div>
			
			<!-- end fragment-2 -->
			<!-- Begin fragment-3 : Course Books -->
			
	  <div id="{STRM}-3" class="tabPanel" role="tabpanel" aria-labelledby="{STRM}-3-link" aria-hidden="false">
				<h3>Course Books: <xsl:call-template name="getTheTerm" /></h3>
				<div id="{STRM}-3books">
				<!-- WE WILL WORK TOWARD LINKING TO THE BOOKSTORE
				  <p>For the most accurate and up-to-date list of your required books, please visit the <a href="http://www.cubookstore.com/courselistbuilder.aspx">CU Bookstore's Course List</a> page.</p>
				 -->
					<!--this table gets replaced by the AJAX call -->
				 <table class="booktable" cellspacing="0" width="100%">
							<thead>
								<tr>
					<th align="left">Author</th>
					<th align="left">Book Title</th>
					<th align="center">Required</th>
					<th align="left">Course</th>
					<th align="left">ISBN</th>
					
				</tr>
							</thead>
							<tbody>
						
						<xsl:choose>
							<xsl:when test="Warning/WarnMessage">
								<tr><td colspan="5">
									<xsl:value-of select="Warning/WarnMessage"/>
								</td></tr>
							</xsl:when>
							
							<xsl:when test="not(Campus/BoulderBookLink)">
								<!-- when no BoulderBookLink, build unlinked tab -->
								<p>We are unable to access your book list at this time. </p>
							</xsl:when>
							<xsl:otherwise>
								<!-- this is a backup load in case the 'load on tab click' fails -->
								<tr><td colspan="5">
									<p><img src="http://www.colorado.edu/portal/ep/ucb2/images/loadingbar.gif" height="15" width="120" alt="Loading ..." /></p>
									<p><a href="javascript:loadbooks('{STRM}-3books', '{Campus/BoulderBookLink}')">Loading Book List ...</a></p>
								</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
						</tbody>
				</table>
				</div>
				
      </div>
 
                <!-- end fragment-3 -->

                <!-- Begin fragment-4 : Finals Schedule-->
		  <div  id="{STRM}-4" class="tabPanel" role="tabpanel" aria-labelledby="{STRM}-4-link" aria-hidden="false">
				<h3>Finals Schedule: <xsl:call-template name="getTheTerm" /></h3>
				<table class="tbl-schedule" cellspacing="0" width="100%">
                <thead>
					<tr>
                   	 <th scope="column" class="columnheader" align="left" width="25%">Course Title</th>
						<th scope="column" class="columnheader" align="left">Course / Section</th>
                        <th scope="column" class="columnheader" align="left">Date</th>
                        <th scope="column" class="columnheader" align="left">Day</th>
						<th scope="column" class="columnheader" align="left">Start/Stop Time</th>
						<th scope="column" class="columnheader" align="left">Bldg / Room</th>
					</tr>
                    </thead>
                    <tbody>
					<xsl:choose>
						<xsl:when test="Warning/WarnMessage">
							<tr><td colspan="5">
								<xsl:value-of select="Warning/WarnMessage"/>
							</td></tr>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="Campus/Course">
								<tr>
                                <th scope="row" class="rowheader">
										<xsl:value-of select="DESCR" /><xsl:text>&#xA0;(</xsl:text><xsl:call-template name="SSRComponent" /><xsl:text>)</xsl:text>
									</th>
									<td>
										<xsl:value-of select="SUBJECT"/>&#xA0;<xsl:value-of select="CATALOG_NBR"/>-<xsl:value-of select="CLASS_SECTION" />
									</td>
									<td>
                                    <xsl:choose>
                                    <xsl:when test="EXAM_DT !=''">
                                    
                                    <xsl:call-template name="dateManipulation" />
                                    </xsl:when>
                                    <xsl:otherwise>TBA
                                    </xsl:otherwise>
                                    </xsl:choose>
                                    
                                   </td>
                                   <td>
                                 <xsl:choose>
                                    <xsl:when test="EXAM_DAY !=''">
                                    
                                   <xsl:call-template name="dayManipulation" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                    TBA
                                    </xsl:otherwise>
                                    </xsl:choose>
                                   </td>
                                   
									<td>
                                     <xsl:choose>
                                    <xsl:when test="EXAM_START_TIME !=''">
                                    <span class="nowrap"><xsl:value-of select="EXAM_START_TIME" /></span> - <span class="nowrap"><xsl:value-of select="EXAM_END_TIME" /></span>
                                    </xsl:when>
                                    <xsl:otherwise>TBA
                                    </xsl:otherwise>
                                    </xsl:choose>
                                    </td>
									<td>
                                     <xsl:choose>
                                    <xsl:when test="EXAM_BLDG !=''">
                                    <a href="http://www.colorado.edu/campusmap/map.html?bldg={EXAM_BLDG}" target="_blank">
										<xsl:value-of select="EXAM_BLDG" />&#xA0;<xsl:value-of select="EXAM_ROOM" />
									</a>
                                    </xsl:when>
                                     
                                    <xsl:otherwise>TBD
                                    </xsl:otherwise>
                                    </xsl:choose></td>							
									
								</tr>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</tbody>
                </table>
			</div>
                <!-- end fragment-4 -->
            </div>
            <!-- end div.term -->
	</div> <!-- end term-tabs div -->
</xsl:template>

<xsl:template match="Institution/TermValues">
	<xsl:for-each select="TermData">
		<option>
			<xsl:if test="TERM = $theInitialTerm">
				<xsl:attribute name="selected"> Selected </xsl:attribute>
			</xsl:if>
			<xsl:attribute name="value">
				<xsl:value-of select="TERM" />
			</xsl:attribute>
            
			<xsl:value-of select="TERM_DESCR" />
		</option>
	</xsl:for-each>
</xsl:template>



<xsl:template match="ScheduleLinks">
 <h3 class="element-invisible">Scheduling Tools</h3>
	<ul class="schedule-links">
		<li><a href="javascript:void(window.open('{PrintableScheduleLink}','newWindow',''));">
			<strong>Print This<br role="presentation" />Schedule</strong>	
			</a>
		</li>
	<xsl:choose>
<xsl:when test="NewClicker='Yes'">
           <li><a href="{CUClickerLink}" class="fancyboxCUClicker" target="_blank"><strong>CUClicker<br role="presentation" />Registration</strong></a></li>
</xsl:when>
	<xsl:otherwise>
 <li><a href="{CUClickerLink}" class="fancyboxCUClicker"><strong>CUClicker<br role="presentation" />Registration</strong></a></li></xsl:otherwise>
	</xsl:choose>
	   <li>
	   <a href="{EditClassOptionsLink}">
	      <strong>Edit Class<br role="presentation" />Options</strong>
	    </a>
	  </li>
	  <li>
	    <a href="{MakeChangesToYourScheduleLink}">
	      <strong>Change Your<br role="presentation" />Schedule</strong>
	    </a>
	  </li>
	 
	  <li>
	    <a href="{GPACalculatorLink}">
	      <strong>Calculate<br role="presentation" />Your GPA</strong>
	    </a>
	  </li>
      
	      
      </ul>
	</xsl:template>
	
	<xsl:template match="PrimaryInstructor">
		<xsl:for-each select="Name">
			<xsl:if test=". !=''">
				<div class="meetingtime"><xsl:value-of select="." />&#xA0;&#xA0;<a class="FCQlink" href="https://fcq.colorado.edu/scripts/broker.exe?_PROGRAM=fcqlib.fcqdata.sas&amp;iname={substring-after(., '&#x20;')},{substring-before(., '&#x20;')}" target="_blank">FCQ*</a>	</div>
			</xsl:if>
		</xsl:for-each>
		</xsl:template>
        
        <xsl:template name="getTheTerm">
		<xsl:choose>
			<xsl:when test="1=substring(STRM,4,1)">Spring&#32;</xsl:when>
			<xsl:when test="4=substring(STRM,4,1)">Summer&#32;</xsl:when>
			<xsl:when test="7=substring(STRM,4,1)">Fall&#32;</xsl:when>
		</xsl:choose>20<xsl:value-of select="substring(STRM, 2,2)" />
	</xsl:template>
    
	<xsl:template name="dateManipulation">
 <!-- <xsl:value-of select="EXAM_DT"/>--> 
   <xsl:variable name="examDate" select="EXAM_DT" />
    <xsl:value-of select="substring($examDate,6,2)" />  -
    <xsl:value-of select="substring($examDate,9,2)" /> -
     <xsl:value-of select="substring($examDate,1,4)" />

	</xsl:template>
    
    <xsl:template name="dayManipulation">
 <!-- <xsl:value-of select="EXAM_DT"/>--> 
   <xsl:variable name="examDay" select="EXAM_DAY" />
    <xsl:choose>
    <xsl:when test="$examDay = 1">Sunday</xsl:when>
    <xsl:when test="$examDay = 2">Monday</xsl:when>
    <xsl:when test="$examDay = 3">Tuesday</xsl:when>
    <xsl:when test="$examDay = 4">Wednesday</xsl:when>
    <xsl:when test="$examDay = 5">Thursday</xsl:when>
    <xsl:when test="$examDay = 6">Friday</xsl:when>
    <xsl:when test="$examDay = 7">Saturday</xsl:when>
    <xsl:otherwise>TBD</xsl:otherwise>
    </xsl:choose>

	</xsl:template>
    
	<xsl:template name="SSRComponent">
		<xsl:choose>
			<xsl:when test="SSR_COMPONENT = 'CLN'">Clinical</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'CNF'">Conference</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'CON'">Continuance</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'CON'">Continuance</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'COP'">Cooperative Education</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'COR'">Correspondence</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'DIS'">Dis</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'EXT'">Externship</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'FLD'">Field Studies</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'IND'">Independent Study</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'INT'">Internship</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'LAB'">Laboratory</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'LEC'">Lecture</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'MLS'">Main Lab Section</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'PRA'">Practicum</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'PRC'">Practicum</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'PRI'">Private Instruction</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'REC'">Recitation</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'RES'">Research</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'RSC'">Research</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'SEM'">Seminar</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'STU'">Studio</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'SUP'">Supervision</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'SYM'">Symposium</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'THE'">Thesis</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'TUT'">Tutorial</xsl:when>
			<xsl:when test="SSR_COMPONENT = 'WKS'">Workshop</xsl:when>
			<xsl:otherwise><xsl:value-of select="SSR_COMPONENT"/></xsl:otherwise>
		</xsl:choose>
</xsl:template>
	
</xsl:stylesheet>
