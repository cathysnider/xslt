<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- by Cathy Snider and Tashi Daniels, Web Communications, CU-Boulder -->
<!-- updated May 2017 for LMS environment detection-->
<!-- and removing references to content server -->
<xsl:param name="theInitialTerm"><xsl:value-of select="root/CurrentTerm"/></xsl:param>
	
<xsl:template match="root">
<div id="facultytoolkit" style="position:relative">
<h2>Faculty Toolkit</h2> 
	
		<xsl:choose>
			<xsl:when test="CoursesInTerm">
		<!-- If there are courses, build out the Term Chooser Drop Down. Otherwise, don't bother -->
	
			<form name="facultyterms" id="facultyterms" action="">
            <label for="termSelect"><strong> Term: </strong></label>
			<select id="termSelect">
			<xsl:apply-templates select="TermValues"></xsl:apply-templates>
			</select>
			</form>
				
	<div class="btn-wrap"><a href="{/root/CSFacultyCenter}" class="sml-btn">Go to Web Grading</a></div>
		
	<xsl:apply-templates select="CoursesInTerm"></xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<div class="noTabs">
				<p>&#32;</p>
				<p class="emphasis">We are unable to retrieve your course information at this time.</p>
					<p>&#32;</p>
				<xsl:call-template name="facultycenter"></xsl:call-template>		
				</div>
				
				</xsl:otherwise>
		</xsl:choose>
	<xsl:if test="CoursesInTerm">
		<!-- If there are courses, build out the JavaScript; otherwise, don't bother -->
	<script type="text/javascript" language="javascript" src="https://proxy.prod.cu.edu/cucontent/portal/ep/ucb2/js/fancybox/jquery.fancybox-1.3.4.pack.js">x=1;</script>
<script>
// script checks through the environments starting with DEV; STG and PROD get same host url
	var lmsHost = "";
	var restOfURL = "/LMSManager/js/expresscreateiframe_init.js";
	var currentEnv = window.location.hostname;
	if (currentEnv.indexOf("dev") != -1) { lmsHost = "https://lmsmanager-dev.colorado.edu";	} 
	else if (currentEnv.indexOf("tst") != -1) {	lmsHost = "https://lmsmanager-test.colorado.edu"; 	} 
	else if (currentEnv.indexOf("stg") != -1) {	lmsHost = "https://lmsmanager-test.colorado.edu"; 	} 
 	else { lmsHost = "https://lmsmanager.colorado.edu"; }
	var lmsScript = document.createElement('script');
	lmsScript.src = lmsHost + restOfURL;
    document.head.appendChild(lmsScript);
</script>
   
	<!-- don't use xsl:comment tags or CDATA tags within the script tags; it breaks in I.E. -->
		<script type="text/javascript">
	$(document).ready(function() {	
	
	
$(".colorboxAlert").colorbox({iframe:true, escKey:true, width:"80%", height:"80%"});
$("table.tbl-roster tr:even").addClass('oddrow');
$("table.tbl-roster tr:odd").addClass('evenrow');	
	
// Initial set up of terms and panels 
$("div.termSet").hide();	
$("div.toolkitPanel").hide();
$("div.termSet.current").show();    
$("div.termSet.current div.toolkitPanel:first").show();
// Course Tools Tab - hide all but first one in each tools-Term-Panel 					   
$("div.courseinfo").hide();	
<xsl:for-each select="CoursesInTerm">$("div#term<xsl:value-of select='Strm'/> div.courseinfo:first").show();  </xsl:for-each>


				//Set Term Drop Down Change functionality
			$('select#termSelect').change(function() {
					var newTerm = $('select#termSelect').val();
					// reset everything when the term is changed
					$("div.termSet").hide();
   					$("div.toolkitPanel").hide();
					//show selected terms and panels
					 $("div#term" + newTerm + " div.toolkitPanel:first").show();			  
				     $("div#term" + newTerm).show();
				     $("div#term" + newTerm).css('display', 'block'); // this fixes an I.E. display error
					
				   $("ul.toolkitTabs li a").removeClass('current');
					$("ul.toolkitTabs li a").attr("aria-selected","false");
					$('div#term' + newTerm + ' ul.toolkitTabs li a:first').addClass('current');
					$('div#term' + newTerm + ' ul.toolkitTabs li a:first').attr("aria-selected","true");
					updateIframeSrc();
					
				});
				

//change course details panels depending on selection	
$('select.coursedetails').change(function() {
		var whichCourse = $(this).children(':selected').attr("value");
		$("div.courseinfo").hide();	
		$("div#" + whichCourse).show();	
		updateIframeSrc();
});
				
	// choose class on Roster tab, jump to Course Info tab
$('a.getcourseinfo').click(function() { 
				var openTerm = $(this).attr("rel");
				var openCourse = $(this).attr("rev");
				 $("div.courseinfo").hide();
				 $("select.coursedetails option").removeAttr('selected');
				 $("div#term" + openTerm + "-" + openCourse).show();
				$("option#term" + openTerm + "-" + openCourse + "-DD").attr('selected', 'selected');
				 $("div#term" + openTerm + " div.toolkitPanel:first").hide();
				$("div#term" + openTerm + " div.toolkitPanel:last").show();
				$("ul.toolkitTabs li a").removeClass('current');
				$("ul.toolkitTabs li a").attr("aria-selected","false");
				$('div#term' + openTerm + ' ul.toolkitTabs li a').eq(1).addClass('current');
				$('div#term' + openTerm + ' ul.toolkitTabs li a').eq(1).attr("aria-selected","true");
				updateIframeSrc();
			});
				
// Accessible Tab Panels
$("ul.toolkitTabs a").click(function(){ 
		
	    $("div.toolkitPanel").hide();
		$("div.toolkitPanel").attr("aria-hidden","true");
		$("ul.toolkitTabs li a").removeClass('current');
		$("ul.toolkitTabs li a").attr("aria-selected","false");
		$(this).addClass('current');
		$(this).attr("aria-selected","true");
		var tabname = $( this ).attr( "name" );
		$("div#" + tabname + "Panel" ).show();
		$("div#" + tabname + "Panel" ).attr("aria-hidden","false");

		return false;
  	});			
				
	});		
		</script>
<script>
function openNewWindow (theURL, winName) {
   var winNew = window.open(theURL, winName);
   winNew.focus();
}
</script>
	</xsl:if>
    
    <p><img alt=" " role="presentation" height="1" src="%Image(CLEARUCB2)" width="1"/></p>
    
</div>	
	</xsl:template>
	
	<xsl:template match="CoursesInTerm">
		<xsl:variable name="thisterm"><xsl:value-of select="Strm"/></xsl:variable>
        
		<div id="term{Strm}" class="termSet">
			<xsl:if test="Strm = $theInitialTerm">
				<xsl:attribute name="class">termSet current</xsl:attribute>
			</xsl:if>
<ul class="toolkitTabs" role="tablist">

<li role="presentation"><a href="javascript:void(0)" role="tab" name="courses{Strm}" aria-controls="courses{Strm}Panel" aria-selected="true" class="current">My Courses</a></li>
<li role="presentation"><a href="javascript:void(0)" role="tab" name="tools{Strm}" aria-controls="tools{Strm}Panel" aria-selected="false">Course Tools</a></li>
			</ul>
            
            
      
			<div id="courses{Strm}Panel" class="toolkitPanel" role="tabpanel" aria-labelledby="courses{Strm}PanelLabel"  aria-hidden="false">
			<h3 class="subHead" id="courses{Strm}PanelLabel">Course Information:  <xsl:for-each select="/root/TermValues/TermData[Term = $thisterm]"> <xsl:value-of select="substring-before(TermDescr, 'UC Boulder')" /> </xsl:for-each></h3>
				
				<table class="tbl-roster">
                <thead>
					<tr valign="bottom" class="headerRow">
						<th scope="col" valign="bottom">Course </th>
                        <th scope="col"><span class="element-invisible">Requested Accessibility Accommodations</span><img alt="" border="0" height="20" src="%Image(WHEELCHAIRINVERT)" aria-hidden="true"/></th> <!--accessibility icon holder -->
						
						<th scope="col" valign="bottom">Days</th>
						<th scope="col" valign="bottom">Time</th>
						<th scope="col" valign="bottom">Room</th>
						<th scope="col" valign="bottom" align="center">Rosters</th>						
						<th scope="col" valign="bottom">Email<br />Class</th>
                        <th scope="col" valign="bottom">Final <br />Exam</th>
					</tr>
					</thead>
					<!-- process the courses -->
				<xsl:choose>
			<xsl:when test="Course">
            <tbody>
				<xsl:apply-templates select="Course" mode="courselist"></xsl:apply-templates>
                </tbody>
			</xsl:when>
					<xsl:otherwise>
                    <tbody>
						<tr valign="bottom">
							<td colspan="8"><p>There are no courses on file for this term</p></td> </tr>	
                            </tbody>					
					</xsl:otherwise>
				</xsl:choose>
				</table>
				<xsl:call-template name="facultycenter"></xsl:call-template>
			</div>
            
            
            
            <!--Course Toolkit-->
			<div id="tools{Strm}Panel" class="toolkitPanel" role="tabpanel" aria-labelledby="tools{Strm}PanelLabel"  aria-hidden="true">
			<h3 class="subHead" id="tools{Strm}PanelLabel">Course Tools: <xsl:for-each select="/root/TermValues/TermData[Term = $thisterm]"> <xsl:value-of select="substring-before(TermDescr, 'UC Boulder')" /> </xsl:for-each></h3>

				<xsl:choose>
                
					<xsl:when test="Course">
						
				<table class="plaintable">
					<tr>
						<td><b>Courses:</b></td>
						<td><form action="">
							<select class="coursedetails">
								<xsl:for-each select="Course">
									<option id="term{../Strm}-{Subject}-{CatalogNbr}-{ClassSection}-DD" value="term{../Strm}-{Subject}-{CatalogNbr}-{ClassSection}"><xsl:value-of select="Subject"/>-<xsl:value-of select="CatalogNbr"/>-<xsl:value-of select="ClassSection"/></option>
								
									</xsl:for-each>
							</select>
						</form></td>
					</tr>
				</table>
						
				<xsl:apply-templates select="Course" mode="coursetools"></xsl:apply-templates>
					
					</xsl:when>
					<xsl:otherwise>
						<p>There are no courses on file for this term</p>				
					</xsl:otherwise>
				</xsl:choose>	
			</div>
	</div>
	</xsl:template>
	
	<xsl:template match="Course" mode="courselist">
			<tr class="classdata">
			<th scope="row"><a href="javascript:void(0);" class="getcourseinfo" rel="{../Strm}" rev="{Subject}-{CatalogNbr}-{ClassSection}"><xsl:value-of select="Title" /><br /><xsl:value-of select="Subject"/>-<xsl:value-of select="CatalogNbr"/>-<xsl:value-of select="ClassSection"/></a>  </th>
            <td>
           
<!-- Accessibility Test Code -->
<xsl:if test="Accessibility = 'True'">
<a href="{ClassRoster}&amp;a11y=Y" class="colorboxAlert"><img alt="accessibility accommodations are requested" border="0" height="20" src="%Image(WHEELCHAIRUCB2)" /></a>
</xsl:if>
<br />&#32;

<!-- End Accessibility Test Code -->

            </td>
			
			<!-- process the first class location -->
			<xsl:apply-templates select="Locations" mode="first"/>
			<td align="center">
				<xsl:choose>
					<xsl:when test="EmailRoster != ''">
					
						<a href="mailto:{EmailRoster}"> <img alt="email" border="0" height="20"
							src="%Image(EMAILUCB2)" width="18"/></a>
					</xsl:when>
					<xsl:otherwise>&#45;</xsl:otherwise>
				</xsl:choose>
			</td>
            <td>
            <!-- process the next class locations, including Final Exam locations -->
            <xsl:apply-templates select="Locations" mode="second"/>
            </td>
		</tr>
		
		
	</xsl:template>
	
	<xsl:template match="Course" mode="coursetools">	
		<div id="term{../Strm}-{Subject}-{CatalogNbr}-{ClassSection}" class="courseinfo"> 
			<table role="presentation">
				<tr>
					<td colspan="5" valign="top"><h4><strong><xsl:value-of select="Subject"/>-<xsl:value-of select="CatalogNbr"/>-<xsl:value-of select="ClassSection"/>:  <xsl:value-of select="Title"/></strong></h4>						
					</td></tr>
				<tr>
					<td colspan="5" valign="top">&#32;</td></tr>
				<tr>
					<td width="33%" valign="top">
						<p>Students enrolled: <xsl:value-of select="EnrollmentTotal"/><br />
						Students withdrawn: <xsl:value-of select="WithdrawnTotal"/><br />
							Students wait-listed: <xsl:value-of select="WaitlistTotal"/><br />
							Enrollment limit: <xsl:value-of select="EnrollmentCap"/> <br />
							Type: <xsl:call-template name="Type" /><br />
							Location(s):<br />
							&#32; &#32; - <xsl:value-of select="Locations/Location[position()=1]/FacilityID" /> &#160; <a href="https://www.colorado.edu/campusmap/map.html?search={substring(Locations/Location[position()=1]/FacilityID,1,4)}" target="_blank">View Campus Map</a></p>
        <p><xsl:apply-templates select="Instructors" /></p>
	<p><b>Description: </b> <xsl:value-of select="Desc"/></p>
                              
<!-- Accessibility Test Code -->
<xsl:if test="Accessibility = 'True'">
    <p><a href="{ClassRoster}&amp;a11y=Y" class="colorboxAlert"><img alt="requested accessibility accommodations" align="left" border="0" height="50" style="padding-right:3px;" src="%Image(WHEELCHAIRUCB2)" /></a> A student or students in your class have identified as requiring special accommodations. See the <a href="{ClassRoster}&amp;a11y=Y" class="colorboxAlert">Accessibility Requirements</a> for more information.</p>
</xsl:if>

<!-- End Accessibility Test Code -->
                              
					</td>
					<td valign="top"><img src="%Image(CLEARUCB2)" alt=" " role="presentation" width="15px" height="15px" ></img></td>
					<td width="33%" valign="top"><h4 class="colHead">Course specific tools</h4>
						<xsl:if test="CourseTools/CourseURL !=''">
							<div class="toolLink3"><a href="{CourseTools/CourseURL}" class="colorboxAlert">Add/Edit Course URL</a></div>
						</xsl:if>
						<xsl:if test="CourseTools/CULearnCourse !=''">
                            <div class="toolLink3">
                                <a id="{../Strm}-{Subject}-{CatalogNbr}-{ClassSection}-express-create-btn" class="express-create-btn" href="#" >Create D2L Course</a><!-- or D2L -->
                            </div>
                            <a style="display:none;" id="{../Strm}-{Subject}-{CatalogNbr}-{ClassSection}-request-url" href="{CourseTools/CULearnCourse}"  target="_blank">Request Desire2Learn Course</a>
                        </xsl:if>
						<xsl:if test="CourseTools/LibraryReservations !=''">
							<div class="toolLink3"><a href="{CourseTools/LibraryReservations}" target="_blank">View Library Course Reserves</a></div>
						</xsl:if>
						<xsl:if test="EmailRoster != ''">
						
						<div class="toolLink3"><a href="mailto:{EmailRoster}" target="_blank">Email the Class (opens email)</a></div>
							</xsl:if>
						<h4 class="colHead">General Tools</h4>
						<div class="toolLink3"><a href="https://www.colorado.edu/oit/services/teaching-learning-spaces/technology-equipped-classrooms" target="_blank">Request Media Key</a></div>
						<div class="toolLink3"><a href="https://www.colorado.edu/oit/services/teaching-learning-tools/cuclickers" target="_blank">Request CUClicker receiver</a></div>
						<div class="toolLink3"><a href="http://cuboulder.verbacollect.com/" target="_blank">Textbook Adoption </a></div>
						<div class="toolLink3"><a href="https://www.colorado.edu/libraries/services/course-reserves" target="_blank">How to Place Library Materials on Reserve </a></div></td>
					<td valign="top"><img src="%Image(CLEARUCB2)" alt=" " role="presentation" width="15px" height="15px" ></img></td>
					<td width="33%" valign="top"><h4 class="colHead2">Rosters</h4>
						
						<div class="rostergroup">
							<xsl:choose>
								<xsl:when test="EnrollmentTotal=0">
									<p>There are no students enrolled in this class.</p>
								</xsl:when>
								<xsl:otherwise>
							<xsl:if test="ClassRoster !=''">
							<!-- <div class="toolLink2"><a href="javascript:void(window.open('{ClassRoster}','_blank',''));" >Print-friendly Class Roster</a></div> -->
					<div class="toolLink2"><a href="javascript:openNewWindow('{ClassRoster}','classWindow');">Print-friendly Class Roster</a></div>
							
                            </xsl:if>

							<xsl:if test="PhotoRoster !=''">
							<!-- <div class="toolLink2"><a href="javascript:void(window.open('{PhotoRoster}','_blank',''));" >Print-friendly Photo Roster </a></div> -->
                            <div class="toolLink2"><a href="javascript:openNewWindow('{PhotoRoster}','photoWindow')" >Print-friendly Photo Roster</a></div>
							</xsl:if>
							<xsl:if test="CourseTools/DownloadCUClicker !=''">
							<div class="toolLink2"><a href="{CourseTools/DownloadCUClicker}">Download CUClicker Roster</a></div>
						    </xsl:if>
							<xsl:if test="CourseTools/DownloadCourseRoster !=''">
							<div class="toolLink2"><a href="{CourseTools/DownloadCourseRoster}">Download Excel-friendly Class Roster</a></div>
							</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</div>
							
						<div style="border:1px solid #ccc; background-color:whitesmoke; padding:5px; margin-top:1.5em"><strong>Web Grading:</strong> available in the Faculty Center
							<div class="facbtn"><a href="{/root/CSFacultyCenter}" class="fac-btn">Go to Web Grading</a></div>
						</div></td>
				</tr>
			</table>
		</div>
		<!-- end course tools -->	
	</xsl:template>
	<xsl:template match="Locations" mode="first">
		<xsl:variable name="enrollment"><xsl:value-of select="following-sibling::EnrollmentTotal"/></xsl:variable>
		
			<xsl:for-each select="Location[position()=1]">
				<xsl:variable name="building"><xsl:value-of select="substring(FacilityID,1,4)"/></xsl:variable>
			<td>
				<xsl:value-of select="Days"/>
				
			</td>
			<td>
				<xsl:value-of select="Time"/>
			</td>
			<td><xsl:choose>
				<xsl:when test="starts-with($building, 'SEE')">
					<xsl:value-of select="FacilityID"/>
				</xsl:when>
                <xsl:when test="starts-with($building, 'Cont')">
					<xsl:value-of select="FacilityID"/>
				</xsl:when>
				<xsl:otherwise>
				<a href="https://www.colorado.edu/campusmap/map.html?search={$building}" target="_blank"><xsl:value-of select="FacilityID"/></a>
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<!-- Are students enrolled? If not, don't show links to course and photo rosters -->
			<xsl:choose>
				<xsl:when test="$enrollment = 0">
					<td align="center">No Students Enrolled</td>
				</xsl:when>
				<!-- show links to rosters if there is enrollment -->
				<xsl:otherwise>
					<td align="center">
						<xsl:choose>
							<xsl:when test="../../ClassRoster !=''">
							    <a href="javascript:void(window.open('{../../ClassRoster}','_blank',''));" class="FCQlink" >Class Roster</a>
						</xsl:when>
							<xsl:otherwise>&#45;</xsl:otherwise>
							</xsl:choose>
					<br />
						<xsl:choose>
							<xsl:when test="../../PhotoRoster !=''">
							    <a href="javascript:void(window.open('{../../PhotoRoster}','_blank',''));" class="FCQlink" >Photo Roster</a>
							
							</xsl:when>
							<xsl:otherwise>&#45;</xsl:otherwise>
			</xsl:choose>
				
					</td>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Locations" mode="second">
		<xsl:for-each select="Location[position()&gt;1]">
			<xsl:variable name="building"><xsl:value-of select="substring(FacilityID,1,4)"/></xsl:variable>
			<xsl:choose>
            <xsl:when test="$building != ''">
				<xsl:if test="FinalExam = 'True'">
                
					<div class="examdata">
						
						
							<b>
								<xsl:value-of select="Days"/>
								<xsl:text> </xsl:text>
							</b>
						<br />
							<b>
								<xsl:value-of select="Time"/>
								<xsl:text> </xsl:text>
							</b>
						<br />
							<xsl:choose>
								<xsl:when test="starts-with($building, 'SEE')">
									<b><xsl:value-of select="FacilityID"/></b>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="FacilityID !=''">
									<b><a href="https://www.colorado.edu/campusmap/map.html?search={$building}" target="_blank"><xsl:value-of select="FacilityID"/>&#32;</a></b>
									</xsl:if>
									<xsl:text> </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
                            </div>
						
			</xsl:if>
					</xsl:when>
                    <xsl:otherwise>
                    TBD</xsl:otherwise></xsl:choose>
				
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="TermValues">
		<xsl:for-each select="TermData">
			<option>
				<xsl:if test="Term = $theInitialTerm">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="value">
					<xsl:value-of select="Term" />
				</xsl:attribute>
				<xsl:value-of select="substring-before(TermDescr, 'UC Boulder')" />
			</option>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="Instructors">
		<b>Other Instructors:</b>
		<xsl:choose>
			<xsl:when test=". = ''"> none</xsl:when>
			<xsl:otherwise>
		<xsl:for-each select="Instructor">
			<br /><xsl:value-of select="."/>
		</xsl:for-each>
				</xsl:otherwise></xsl:choose>
		<br /><br />		
	</xsl:template>
	
	<xsl:template name="facultycenter" >
		<p>&#32;</p>
		<table width="100%" role="presentation">
			<tr>
<td class="facultyCenterLinks" valign="top" width="48%">
For additional features, including  class search and entering grades:
<div class="facbtn"><a href="{/root/CSFacultyCenter}" class="fac-btn">Go to Faculty Center</a></div>

</td>
<td valign="top" role="presentation"><img src="%Image(CLEARUCB2)" alt=" " width="15px" height="15px" role="presentation"></img></td>
<td class="facultyCenterLinks" valign="top" width="48%">Questions about your course schedule?
<div class="facbtn"><a href="https://www.colorado.edu/mycuinfo/help/faculty.html" target="_blank" class="fac-btn">Get help</a></div></td>
			</tr>
		</table>
		
	</xsl:template>

	<xsl:template name="Type">
		<xsl:choose>
			<xsl:when test="Type = 'CLN'">Clinical</xsl:when>
			<xsl:when test="Type = 'CNF'">Conference</xsl:when>
			<xsl:when test="Type = 'CON'">Continuance</xsl:when>
			<xsl:when test="Type = 'COP'">Cooperative Education</xsl:when>
			<xsl:when test="Type = 'COR'">Correspondence</xsl:when>
			<xsl:when test="Type = 'DIS'">Dis</xsl:when>
			<xsl:when test="Type = 'EXT'">Externship</xsl:when>
			<xsl:when test="Type = 'FLD'">Field Studies</xsl:when>
			<xsl:when test="Type = 'IND'">Independent Study</xsl:when>
			<xsl:when test="Type = 'INT'">Internship</xsl:when>
			<xsl:when test="Type = 'LAB'">Laboratory</xsl:when>
			<xsl:when test="Type = 'LEC'">Lecture</xsl:when>
			<xsl:when test="Type = 'MLS'">Main Lab ClassSection</xsl:when>
			<xsl:when test="Type = 'PRA'">Practicum</xsl:when>
			<xsl:when test="Type = 'PRC'">Practicum</xsl:when>
			<xsl:when test="Type = 'PRI'">Private Instruction</xsl:when>
			<xsl:when test="Type = 'REC'">Recitation</xsl:when>
			<xsl:when test="Type = 'RES'">Research</xsl:when>
			<xsl:when test="Type = 'RSC'">Research</xsl:when>
			<xsl:when test="Type = 'SEM'">Seminar</xsl:when>
			<xsl:when test="Type = 'STU'">Studio</xsl:when>
			<xsl:when test="Type = 'SUP'">Supervision</xsl:when>
			<xsl:when test="Type = 'SYM'">Symposium</xsl:when>
			<xsl:when test="Type = 'THE'">Thesis</xsl:when>
			<xsl:when test="Type = 'TUT'">Tutorial</xsl:when>
			<xsl:when test="Type = 'WKS'">Workshop</xsl:when>
			<xsl:otherwise><xsl:value-of select="Type"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
