<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- UPDATED OCTOBER 2016 -->
  <xsl:template match="CU_ALERTS_DET_Response">
    <html>
    <head>

  <link rel="stylesheet" href="http://www.colorado.edu/portal/ep/ucb2/css/2015/alertsPage.css" type="text/css" media="screen" />
  <!--
  <script type="text/javascript" language="javascript"  src="http://www.colorado.edu/portal/ep/ucb2/js/jquery.pack.js"></script>
  -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>

  <script type="text/javascript">
$(document).ready(function() {
	
$('a.clickToClose').click(function(){ 
	parent.$.fn.colorbox.close(); //WORKS!
	});
	
// this code hides/shows the tab sections 
$("div.alertBox").hide();
$("div.alertBox:first").show();
					
// code to make the main tabs work						
$("ul#alertTabs a").click(function(){
	$("div.alertBox").hide();
	$("div.alertBox").attr("aria-hidden","true");
	$("div.alertBox").attr("aria-expanded","false");
	$("ul#alertTabs a").removeClass('current');
	$("ul#alertTabs a").attr("aria-selected","false");
	$(this).addClass('current');
	$(this).attr("aria-selected","true");
	var tabclass = $( this ).attr( "name" );
	$("div#" + tabclass + "Panel" ).show();
	$("div#" + tabclass + "Panel" ).attr("aria-hidden","false");
	$("div#" + tabclass + "Panel" ).attr("aria-expanded","true");
});
  
// code to make the Alerts Detail link work						
$("div.moreinfo").hide();	
$("a.showDetails").click(function(){
	 var clicked_state = $(this).attr("aria-expanded");
	 var boxnum = $(this).attr("id");
    
	 if (clicked_state == "false") {
		$(this).attr("aria-expanded","true");
		$('div#more' + boxnum).attr("aria-hidden","false");
		}
		
	if (clicked_state == "true") {
		$(this).attr("aria-expanded","false");
		$('div#more' + boxnum).attr("aria-hidden","true");	
		}
	$(this).toggleClass('linkOpen').toggleClass('linkClosed');
    $('div#more' + boxnum).toggle();
    return false;  
   });	
  
});		
</script>
  <script type="text/javascript">
function submitForm(destination) {
	var destField = document.getElementById("dest");
	destField.value = destination;
	document.nelnetForm.submit();
	return false;
}
</script>
  </head>
  
  <body style="padding-top:0;" onLoad="document.getElementById('colorboxFocus').focus();">
   <!-- IFRAME WON'T CLOSE UNLESS DOCUMENT DOMAIN IS SPECIFIED--> 
<script type="text/javascript" language='JavaScript'>
 //SET DOCUMENT DOMAIN
var envURL = document.URL;
if (envURL.indexOf("prod.cu.edu") > -1) {document.domain = "prod.cu.edu";} //PROD
else if (envURL.indexOf("qa.cu.edu") > -1) {document.domain = "qa.cu.edu";} //STG and TST
else {document.domain = "dev.cu.edu";} //DEV
</script>
<div class="noprint">
  <table id="closelink" cellspacing="0" cellpadding="6" border="0" width="100%">
    <tr>
      <td align="right"><a class="clickToClose" href="#"><img align="absmiddle" border="0" hspace="2" height="14" width="14" alt="close" role="presentation" src="http://www.colorado.edu/portal/ep/ucb2/images/close.gif"  /> Close window</a></td>
    </tr>
  </table>
</div>
  <div id="nelnet_form_div" style="display:none;">
    <form id="nelnetForm" name="nelnetForm" action="%%url:CUSYSTokenExchanger%%" method="post"  target="_blank">
      <input type="hidden" name="pstoken" id="pstoken" value="%%pstoken%%" />
      <input type="hidden" name="authType" id="authType" value="pstoken" />
      <input type="hidden" name="dest" id="dest" value="nelnetEPay" />
      <input type="hidden" name="institution" value="%%institution%%" />
      <input type="hidden" name="accountGroup" value="MAIN" />
      <input type="submit" />
    </form>
  </div>
  <h2 id="colorboxFocus" tabindex="-1">My Holds and To-Do Items</h2>
  <ul id="alertTabs" role="tablist">
    <li role="presentation"> <a role="tab" name="holds" id="holds" href="javascript:void(0)" aria-controls="holdsPanel" aria-selected="true" class="current">Holds <span class="alertcount"><xsl:value-of select="holdscnt"/></span></a></li>
    <li role="presentation"> <a role="tab" name="todo" id="todo" href="javascript:void(0)" aria-controls="todoPanel" aria-selected="false">To-Do Items <span class="alertcount"><xsl:value-of select="todoscnt"/></span></a>  </li>
  </ul>
  <div id="alertTabsBox">
    <div class="alertBox" role="tabpanel" id="holdsPanel" aria-labelledby="holdsTab" aria-hidden="false" aria-expanded="true">
      <xsl:choose>
        <xsl:when test="holdscnt=0">
          <p>You have no holds at this time</p>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="OutstandingHolds" />
          
        </xsl:otherwise>
      </xsl:choose>
    </div>
    <div class="alertBox" role="tabpanel" id="todoPanel" aria-labelledby="todoTab" aria-hidden="true" aria-expanded="false">
      <xsl:choose>
        <xsl:when test="todoscnt=0">
          <p>You have no to-do items at this time</p>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="OutstandingTodos" />
          
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </div>
  </body>
  </html>
</xsl:template>
<xsl:template match="OutstandingHolds">
  <p>You have the following Holds on your account:</p>
  <ol>
  <xsl:for-each select="Hold">
  <xsl:variable name="thisRecord"><xsl:value-of select="SrvcIndCD"/>-<xsl:value-of select="SrvcIndReason"/></xsl:variable>
    <li>
    <!-- the following variable combines SrvcIndCD and SrvcIndReason to make a unique identifier-->
   
 <h3>  <a class="showDetails linkClosed"
          href="javascript:void(0)" 
          id="{$thisRecord}"  
          aria-controls="more{$thisRecord}" 
          aria-expanded="false">
           <xsl:value-of disable-output-escaping="yes" select="SrvdIndDescr"/></a></h3>
  
  
  <div class="moreinfo" id="more{$thisRecord}" aria-hidden="true">
         
    <p>
      <xsl:call-template name="longDescription">
        <xsl:with-param name="serviceCode" select="$thisRecord">
        </xsl:with-param>
      </xsl:call-template>
    </p>
    <ul>
      <li>Amount: <xsl:choose>
          <xsl:when test="Amount='0'">
            &#160;
          </xsl:when>
          <xsl:otherwise>
            $<xsl:value-of select="Amount"/>&#160;
          </xsl:otherwise>
        </xsl:choose>
      </li>
      <li>Start Date: <xsl:value-of select="SrvcIndActiveDt"/></li>
      <li>Start Term: <xsl:call-template name="parseTerm"><xsl:with-param name="thisTerm" select="SrvcIndActTerm" /></xsl:call-template></li>
      <li>End Date: <xsl:value-of select="SrvdIndEndDt"/></li>
      <li>End Term: <xsl:call-template name="parseTerm"><xsl:with-param name="thisTerm" select="SrvcIndEndTerm" /></xsl:call-template></li>
      <li>Department: <xsl:value-of select="DeptDescr"/></li>
    </ul>
   
  </div>
    </li>
  </xsl:for-each>
  </ol>
</xsl:template>
<xsl:template match="OutstandingTodos">
<p>The following To-Do Items need to be completed:</p>
<ol>
<xsl:for-each select="ToDo">
    <!-- the following translates any asterisks to dashes -->
<xsl:variable name="thisRecord" select="translate (ChkListItemCD, '*', '-'  )" />
<li>
 <h3><a class="showDetails linkClosed"
	id="{$thisRecord}"  
    aria-controls="more{$thisRecord}"
    href="javascript:void(0)" 
    aria-expanded="false">
    
  <xsl:value-of disable-output-escaping="yes" select="ChklistItemDescr"/></a></h3>
<div class="moreinfo" id="more{$thisRecord}" aria-hidden="true">
<p>
  <xsl:call-template name="longDescription">
    <xsl:with-param name="serviceCode" select="$thisRecord">
    </xsl:with-param>
  </xsl:call-template>
</p>
<ul>
  <li><b>Administrative Function:</b> <xsl:value-of select="AdminFunctionDescr"/>&#160;<xsl:value-of select="AidYearDescr" /></li>
  <li><b>Status:</b> <xsl:call-template name="statusDescription"><xsl:with-param name="thisStatus" select="ItemStatusDescr" /></xsl:call-template></li>
   <!-- ORIGINAL  <li>Status: <xsl:value-of select="ItemStatusDescr"/></li> -->
</ul>

</div>
</li>
  </xsl:for-each>
  </ol>
</xsl:template>
<xsl:template name="parseTerm">
  <xsl:param name="thisTerm" />
  <xsl:if test="$thisTerm != '0000'">
    <xsl:if test="$thisTerm != ''">
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
    </xsl:if>
  </xsl:if>
</xsl:template>
<xsl:template name="statusDescription">
    <xsl:param name="thisStatus" />
    <xsl:choose>
      <xsl:when test="$thisStatus = 'Initiated'">
       Initiated. We are requesting you to complete an action. Please complete this to-do item at your earliest convenience. If you are not sure what to do, please contact the listed department. </xsl:when>
       <xsl:when test="$thisStatus = 'Received'">
        Received. We have received some information from you in regards to the request; however, we have not completed a full review to determine that what was turned fulfills the request. No action required at this time.</xsl:when>
      <xsl:when test="$thisStatus = 'Processing'">
        Processing. We have received some information from you in regards to the request; however, we have not completed a full review to determine that what was turned fulfills the request. We need all requested documents turned in before we can complete review. Not action required for this checklist at this time.</xsl:when>
       <xsl:when test="$thisStatus = 'Complete'">
      Complete. We have received the information we need and you have now completed this requirement. No further action is required for this request.</xsl:when>
       <xsl:when test="$thisStatus = 'Incomplete'">
        Incomplete. We received information from you; however, we were unable to use the information you provided. If the To-Do List item's description does not provide a reason for the incomplete status or outline your next steps, you may contact the office for further guidance.</xsl:when>
       <xsl:when test="$thisStatus = 'Waived'">
Waived. We requested this information, but have found another way to satisfy this requirement or no longer need this information from you. No action is required.</xsl:when>
       <xsl:when test="$thisStatus = 'Cancelled'">
    Cancelled. We requested this information, but have found another way to satisfy this requirement or no longer need this information from you. No action is required. </xsl:when>      
      <xsl:otherwise>
        <xsl:value-of select="$thisStatus" />
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>
<xsl:template name="longDescription">
  <xsl:param name="serviceCode"></xsl:param>
  <xsl:choose>
    
    <!-- BEGIN HOLDs -->
    <xsl:when test="$serviceCode = 'B01-B01'">
      Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> for your past due balance for the hold to be released. Contact the Bursar's Office if you have questions, bursar@colorado.edu or 303-492-5381.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B02-B02'">
      Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> for your past due balance for the hold to be released. Contact the Bursar's Office if you have questions, bursar@colorado.edu or 303-492-5381.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B40-B40'">
      Please <a target="_parent" href="%%url:CSBase%%/SA_LEARNER_SERVICES.CU_SS_DEPOSIT_PAY.GBL?Page=CU_SS_DEPOSIT_BLD">pay your confirmation deposit</a>. If you have questions, please contact the Bursar's Office at bursar@colorado.edu or 303-492-5381.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B41-B41'">
      Please <a target="_parent" href="%%url:CSBase%%/SA_LEARNER_SERVICES.CU_SS_DEPOSIT_PAY.GBL?Page=CU_SS_DEPOSIT_BLD">pay your confirmation deposit</a>. If you have questions, please contact the Bursar's Office at bursar@colorado.edu or 303-492-5381.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B55-B55'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B57-B57A'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B57-B57B'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B57-B57C'">
      The web transaction that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B57-B57D'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B57-B57E'">
      The web transaction that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B61-B61A'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B61-B61B'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B61-B61C'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B61-B61D'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B61-B61E'">
      The web transaction that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B61-B61F'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B62-B62'">
      The web transaction that was presented for payment on your tuition account encountered an error in processing. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B63-B63A'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B63-B63B'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B63-B63C'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B63-B63D'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B63-B63E'">
      The web transaction that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B64-B64'">
      The web transaction that was presented for payment of the confirmation deposit encountered an error in processing. Your spot at the university is still confirmed, however, you MUST <a target="_parent" href="%%url:CSBase%%/SA_LEARNER_SERVICES.CU_SS_DEPOSIT_PAY.GBL?Page=CU_SS_DEPOSIT_BLD">pay the confirmation deposit</a> before you will be able to register for classes. If you have questions, please contact Student Billing at bursar@colorado.edu or 303-492-5381.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B65-B65A'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B65-B65B'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B65-B65C'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B65-B65D'">
      The check that was presented for payment on your tuition account was returned by your bank as unpaid. You have been assessed a finance charge of $20. Please <a href="javascript:void(0)" onclick="submitForm('nelnetEPay');">make payment</a> now to avoid holds that prevent registration, transcript and diploma release. If you have questions, please contact Student Debt Management at 303-492-5571.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B71-B71'">
      You must complete a loan exit interview for your Federal Perkins Loan. Go to <a target="_blank" href="http://www.mycampusloan.com">http://www.mycampusloan.com</a> to complete the interview online. If you have questions, call Student Debt Management at 303-492-5571 or 800-925-9844.
    </xsl:when>
    <xsl:when test="$serviceCode = 'B73-B73'">
      Your Federal Perkins Loan is past due. Please <a target="_blank" href="http://www.mycampusloan.com">make payment.</a> If you have questions, call Student Debt Management at 303-492-5571 or 800-925-9844.
    </xsl:when>
    <xsl:when test="$serviceCode = 'F01-GRAD'">
      Our records indicate that you have applied for graduation. If you are postponing your graduation or entering a new program at CU Boulder after graduating, please complete the <a target="_blank" href="https://www.colorado.edu/financialaid/node/178">Graduating Student Eligibility Form</a>.  Please note this hold will not prevent refunds from being issued.
    </xsl:when>
    <xsl:when test="$serviceCode = 'R2L-D2L'">
      You are required to complete the New Student Welcome Online Experience, our online orientation program, before you can enroll in classes.  Log in to <a href="https://mycuinfo.colorado.edu">MyCUInfo</a> to start the Online Experience. Contact New Student &amp; Family Programs at <a href="mailto:welcome@colorado.edu">welcome@colorado.edu</a> or call or text 303-492-4431.
    </xsl:when>
    <xsl:when test="$serviceCode = 'R91-MOBL'">
      You are required to complete the following items in the MyCUInfo portal before you enroll in classes.
      <ol>
        <li>Add/update your local and home addresses, phone number and emergency contact information</li>
        <li>Accept the terms of the Tuition and Fee Agreement and Disclosure.</li>
        <li>Apply for and/or authorize the College Opportunity Fund (COF).</li>
        <li>Select any desired student opportunities.</li>
      </ol>
      Visit the Office of the Registrar's website for <a href="http://www.colorado.edu/registrar/students/registration/before-enroll/preregistration-items" target="blank">step-by-step instructions</a>. If you have questions, please contact the <a href="mailto:registrar@colorado.edu">Office of the Registrar</a> 
    </xsl:when>
    <xsl:when test="$serviceCode = 'R94-MOBL'">
      <p>You are required to complete the following items in the MyCUInfo portal before you enroll in classes.</p>
      <ol type="1">
        <li>Add/update your local and home addresses, phone number and emergency contact information</li>
        <li>Accept the terms of the Tuition and Fee Agreement and Disclosure.</li>
        <li>Apply for and/or authorize the College Opportunity Fund (COF) -- Undergraduate Colorado Residents Only.</li>
      </ol>
      <p>Visit the Office of the Registrar's website for <a href="http://www.colorado.edu/registrar/registration-grades/register/new/prepare/prereg" target="blank">step-by-step instructions</a>. If you have questions, please contact the <a href="mailto:registrar@colorado.edu">Office of the Registrar</a>.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'S55-ARSC'">
      A&amp;S First Year Event required. See <a target="_blank" href="http://www.colorado.edu/buffessentials">www.colorado.edu/buffessentials</a> for more information.
    </xsl:when>
    <!-- END HOLDS -->
    <!-- BEGIN TODOs -->
    <xsl:when test="$serviceCode = 'BAUTHP'">
      Tuition and fee bills are only online. No bills are mailed.  You are responsible for payment of your tuition and fees. If your parent or someone else is helping to pay your tuition and fees, you must give them access to the bill and to receive notifications. Authorizing payers also gives the Bursar's Office permission to discuss your bill with them. <a href="javascript:void(0)" onclick="submitForm('nelnetAuthorizedPayer');">Add Authorized Payer</a> 
    </xsl:when>
    <xsl:when test="$serviceCode = 'FADHS'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your active duty military housing allowance status. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FADHS.pdf">www.uccs.edu/Documents/finaid/2013_FADHS.pdf</a> (copy and paste this address into your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FALLOW'">
      Please complete a Living Allowances Verification Form (located on our website at <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2011-2012%20Living%20Allowances%20Verification%20Form.pdf">http://www.uccs.edu/Documents/finaid/2011-2012 Living Allowances Verification Form.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FALTB'">
      Please complete a Previous Borrower Alternative Loan Disclosure form located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/previous%20alt%20disclosure.pdf">http://www.uccs.edu/Documents/finaid/previous alt disclosure.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FASSTP'">
      When your parents filled out the FAFSA (Free Application for Federal Student Aid) they did not answer questions 89 - 91. These answers are required to complete the processing of your student aid. Please complete the Parent Assets Verification Form located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/Parent%20Assets%20Verification%20Form.pdf">http://www.uccs.edu/Documents/finaid/Parent Assets Verification Form.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FASSTS'">
      When you filled out the FAFSA (Free Application for Federal Student Aid) you did not answer questions 89 - 91. These answers are required to complete the processing of your student aid. Please complete the Student Assets Verification Form located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/Student%20Assets%20Verification%20Form.pdf">http://www.uccs.edu/Documents/finaid/Student Assets Verification Form.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FCHILD'">
      Please complete a Child Care Expense Verification Form located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/ChildCareExpenseVerification.pdf">http://www.uccs.edu/Documents/finaid/ChildCareExpenseVerification.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FDEPV'">
      The U.S. Department of Education has forwarded your Free Application for Federal Student Aid (FAFSA) results to our office. We are unable to confirm your answer(s) to determine your dependency status for financial aid. Please go to <a target="_blank" href="http://www.uccs.edu/%7EDocuments/finaid/2013_FDEPV.pdf">www.uccs.edu/~Documents/finaid/2013_FDEPV.pdf</a> (cut and paste address into your browser) to view the grid and return acceptable proof as listed.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FDISWK'">
      You indicated on your Free Application for Federal Student Aid (FAFSA) that you or a family member is a dislocated worker. You may be eligible for a re-evaluation of your Financial Aid eligibility. In order for the Financial Aid Office to consider a special circumstance, please complete the 2010-2011 Special Circumstances Form (located on our website at: <a target="_blank" href="http://www.uccs.edu/finaid/">http://www.uccs.edu/finaid/</a> -&gt; Forms -&gt; Financial Aid Forms -&gt; Appeals) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FDLGPL'">
      You have applied for a Graduate PLUS Loan; however, in order to receive this loan you will need to complete your Graduate PLUS Loan Master Promissory Note. You may complete your Graduate PLUS MPN at <a target="_blank" href="http://www.studentloans.gov">www.studentloans.gov</a>. You will log in using your Social Security Number and Federal Aid Pin (same as the one you used for your FAFSA). Please click on the box for Apply for Graduate PLUS Loan and complete the instructions.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FDLPLS'">
      Your parent(s) have applied for a Parent PLUS Loan; however, in order to receive this loan they will need to complete their Parent PLUS Loan Master Promissory Note. Your parent may complete their parent PLUS MPN at <a target="_blank" href="http://www.studentloans.gov">www.studentloans.gov</a>. Your parent will log in using their Social Security Number and Federal Aid Pin (same as the one they used for your FAFSA). Please click on the box for Apply for Parent PLUS Loan and complete the instructions.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FDRUG'">
      Please complete the <a target="_blank" href="http://www.uccs.edu/Documents/finaid/Drug%20Conviction%20Eligibility%20Form.pdf">Drug Conviction Eligibility Form (pdf)</a>  and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FESTAX'">
      You indicated on your Free Application for Federal Student Aid (FAFSA) that your (and your spouse or parent(s) if applicable) federal income tax return was not filed the day you completed your FAFSA. You will not be offered an official aid package and no aid can be processed and/or paid until we receive updated tax information. You have the option of automatically retrieving your income and tax data from the Internal Revenue Service (IRS) and having it automatically transferred into your FAFSA. The online application will walk you through the process, which requires that you provide your PIN and confirm that you want to retrieve your IRS data. To access this new feature, please go back in to your FAFSA at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>. For alternative ways to complete the above and more information, please see our website at <a target="_blank" href="http://www.uccs.edu/finaid">www.uccs.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FEXIT'">
      IF YOU HAVE REPAID ALL YOUR STUDENT LOANS IGNORE THIS LETTER! We have received notification that you have graduated, dropped below half time, or are no longer enrolled at the University of Colorado Colorado Springs. As a federal loan borrower, you are required to complete Stafford Loan Exit Counseling. You may complete exit counseling online by visiting <a target="_blank" href="http://www.nslds.ed.gov">www.nslds.ed.gov</a> or you may complete the enclosed exit counseling document and mail back it to the Department of Education's Direct Loan Servicer. You may obtain your Direct Loan servicer name and address at <a target="_blank" href="http://www.nslds.ed.gov">www.nslds.ed.gov</a>. Your financial aid file at the University will remain incomplete until this is done or you re-enroll.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FEXITE'">
      IF YOU HAVE REPAID ALL YOUR STUDENT LOANS IGNORE THIS LETTER! We have received notification that you have graduated, dropped below half time, or are no longer enrolled at the University of Colorado Colorado Springs. As a federal loan borrower, you are required to complete Stafford Loan Exit Counseling. You may complete exit counseling online by visiting <a target="_blank" href="http://www.nslds.ed.gov">www.nslds.ed.gov</a> or you may complete the enclosed exit counseling document and mail back it to the Department of Education's Direct Loan Servicer. You may obtain your Direct Loan servicer name and address at <a target="_blank" href="http://www.nslds.ed.gov">www.nslds.ed.gov</a>. Your financial aid file at the University will remain incomplete until this is done or you re-enroll.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FFTX10'">
      Your file has been selected for verification. A component of the federal requirement is that we compare tax data information from the tax return to the information reported on the Free Application for Federal Student Aid (FAFSA).  You have the option of automatically retrieving your income and tax data from the Internal Revenue Service (IRS) and having it automatically transferred into your FAFSA. The online application will walk you through the process, which requires that you provide your PIN and confirm that you want to retrieve your IRS data. To access this new feature, please go back in to your FAFSA at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>. If you are unable to retrieve your data or if you make modifications to the IRS data then provide our office with a signed copy of your father's 2010 federal tax return. Please ensure that it is signed and all of the form is legible. If they filed a 1040 or 1040a, we would need the first two pages. If they filed a 1040ez, we only need the first page. For alternative ways to complete the above requirement and/or for more information, please see our website at <a target="_blank" href="http://www.uccs.edu/finaid">www.uccs.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FIPDV'">
      The U.S. Department of Education has forwarded your Free Application for Federal Student Aid (FAFSA) results to our office. We are unable to confirm your answer(s) to determine your dependency status for financial aid. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FIPDV.pdf">www.uccs.edu/Documents/finaid/2013_FIPDV.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FIVFD'">
      Please complete a Dependent Verification Worksheet located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2011-2012%20Dependent%20Verification%20Worksheet.pdf">http://www.uccs.edu/Documents/finaid/2011-2012 Dependent Verification Worksheet.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FIVFI'">
      Please complete an Independent Verification Worksheet located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2011-2012%20Dependent%20Verification%20Worksheet.pdf">http://www.uccs.edu/Documents/finaid/2011-2012 Dependent Verification Worksheet.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FJTX09'">
      Please complete a Joint Tax Filers Statement located on our website at <a target="_blank" href="http://www.uccs.edu/finaid/forms.html">http://www.uccs.edu/finaid/forms.html</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FJTX10'">
      Please complete a Joint Tax Filers Statement located on our website at <a target="_blank" href="http://www.uccs.edu/finaid/forms.html">http://www.uccs.edu/finaid/forms.html</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FLIVE'">
      Please complete a Housing Plans Form (located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2011-2012%20Housing%20Plans%20Form.pdf">http://www.uccs.edu/Documents/finaid/2011-2012 Housing Plans Form.pdf</a> (input this link into your browser) and return it to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FMTX10'">
      Your file has been selected for verification. A component of the federal requirement is that we compare tax data information from the tax return to the information reported on the Free Application for Federal Student Aid (FAFSA).  You have the option of automatically retrieving your income and tax data from the Internal Revenue Service (IRS) and having it automatically transferred into your FAFSA. The online application will walk you through the process, which requires that you provide your PIN and confirm that you want to retrieve your IRS data. To access this new feature, please go back in to your FAFSA at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>. If you are unable to retrieve your data or if you make modifications to the IRS data then provide our office with a signed copy of your mother's 2010 federal tax return. Please ensure that it is signed and all of the form is legible. If they filed a 1040 or 1040a, we would need the first two pages. If they filed a 1040ez, we only need the first page. For alternative ways to complete the above requirement and/or for more information, please see our website at <a target="_blank" href="http://www.uccs.edu/finaid">www.uccs.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FOCHLD'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your child support payment. Please go to <a target="_blank" href="http://www.uccs.edu/%7EDocuments/finaid/2013_FOCHLD.pdf">www.uccs.edu/~Documents/finaid/2013_FOCHLD.pdf</a> (cut and paste address into your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FOCITI'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your citizenship status. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FOCITI.pdf">http://www.uccs.edu/Documents/finaid/2013_FOCITI.pdf</a> (cut and paste address in to your browser) to view acceptable documentation.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FOHHD'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your household size. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FOHHD.pdf">www.uccs.edu/Documents/finaid/2013_FOHHD.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FOHHI'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your household size. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FOHHI.pdf">www.uccs.edu/Documents/finaid/2013_FOHHI.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FONCD'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your reported number in college. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FONCD.pdf">www.uccs.edu/Documents/finaid/2013_FONCD.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FONCI'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your reported number in college. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FONCI.pdf">www.uccs.edu/Documents/finaid/2013_FONCI.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FOPFOD'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your parent(s) food stamp recipient status. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FOPFOD.pdf">www.uccs.edu/Documents/finaid/2013_FOPFOD.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FORJCT'">
      The U.S. Department of Education was unable to process your 2012-2013 Free Application for Federal Student Aid (FAFSA) due to incomplete information. Please refer to your Student Aid Report (SAR) and make the necessary corrections at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FOSFOD'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your food stamp recipient status. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FOSFOD.pdf">www.uccs.edu/Documents/finaid/2013_FOSFOD.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FPNF11'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your parent(s) non-tax filing status. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FPNF11.pdf">www.uccs.edu/Documents/finaid/2013_FPNF11.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FPTX10'">
      Your file has been selected for verification. A component of the federal requirement is that we compare tax data information from the tax return to the information reported on the Free Application for Federal Student Aid (FAFSA).  You have the option of automatically retrieving your income and tax data from the Internal Revenue Service (IRS) and having it automatically transferred into your FAFSA. The online application will walk you through the process, which requires that you provide your PIN and confirm that you want to retrieve your IRS data. To access this new feature, please go back in to your FAFSA at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>. If you are unable to retrieve your data or if you make modifications to the IRS data then provide our office with a signed copy of your parents' 2010 federal tax return. Please ensure that it is signed and all of the form is legible. If they filed a 1040 or 1040a, we would need the first two pages. If they filed a 1040ez, we only need the first page. For alternative ways to complete the above requirement and/or for more information, please see our website at <a target="_blank" href="http://www.uccs.edu/finaid">www.uccs.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FPTX11'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your parent(s) adjusted gross income and taxes paid. Please either submit a correction to your FAFSA using the Internal Revenue Service (IRS) retrieval tool or by requesting a tax transcript (submitting Form 4506-T to the IRS or using the IRS online request system at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a> ).
    </xsl:when>
    <xsl:when test="$serviceCode = 'FSLOW'">
      Please submit the Verification of Income and Expenses Form located on our website at: <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2011-2012%20Verification%20of%20Income%20and%20Expenses%20Form.doc">http://www.uccs.edu/Documents/finaid/2011-2012 Verification of Income and Expenses Form.doc</a> (input this link into your browser) to resolve a question we have regarding your file.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FSNF11'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your non-tax filing status. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FSNF11.pdf">www.uccs.edu/Documents/finaid/2013_FSNF11.pdf</a> (cut and paste address in to your browser) to access the form.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FSSR'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your selective service registration status. Federal regulations mandate that all federal financial aid applicants be registered with the Selective Service, unless they are exempt. The Selective Service has not been able to verify your registration and because you are over 26 years of age are no longer able to register with the Selective Service. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FSSR.pdf">www.uccs.edu/Documents/finaid/2013_FSSR.pdf</a> (cut and paste address in to your browser) to access the form and proof that you need to complete and submit.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FSTX10'">
      Your file has been selected for verification. A component of the federal requirement is that we compare tax data information from the tax return to the information reported on the Free Application for Federal Student Aid (FAFSA).  You have the option of automatically retrieving your income and tax data from the Internal Revenue Service (IRS) and having it automatically transferred into your FAFSA. The online application will walk you through the process, which requires that you provide your PIN and confirm that you want to retrieve your IRS data. To access this new feature, please go back in to your FAFSA at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>. If you are unable to retrieve your data or if you make modifications to the IRS data then provide our office with a signed copy of your 2010 federal tax return. Please ensure that it is signed and all of the form is legible. If you filed a 1040 or 1040a, we would need the first two pages. If you filed a 1040ez, we only need the first page. For alternative ways to complete the above requirement and/or for more information, please see our website at <a target="_blank" href="http://www.uccs.edu/finaid">www.uccs.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FSTX11'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your adjusted gross income and taxes paid. Please either submit a correction to your FAFSA using the Internal Revenue Service (IRS) retrieval tool or by requesting a tax transcript (submitting Form 4506-T to the IRS or using the IRS online request system at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a> ).
    </xsl:when>
    <xsl:when test="$serviceCode = 'FVENC'">
      Based on the results of your Free Application for Federal Student Aid (FAFSA) we are required to verify your non-citizen status. Please go to <a target="_blank" href="http://www.uccs.edu/Documents/finaid/2013_FOCITI.pdf">http://www.uccs.edu/Documents/finaid/2013_FOCITI.pdf</a> (cut and paste address in to your browser) to view acceptable documentation. Please bring the ORIGINAL documentation physically to our office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FXDRFT'">
      You must submit proof to the financial aid office that you are registered with the Selective Service. To register or obtain proof of registration, please go to <a target="_blank" href="http://www.sss.gov">www.sss.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FXENTP'">
      You have applied for a Graduate PLUS Loan; however, in order to receive this loan you will need to complete Graduate PLUS Entrance Counseling. You may complete your Entrance Counseling at <a target="_blank" href="http://www.studentloans.gov">www.studentloans.gov</a>. You will log in using your Social Security Number and Federal Aid Pin (same as the one you used for your FAFSA). Please click on the box for Graduate Student Entrance Counseling and complete the instructions.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FXENTR'">
      You have accepted a Stafford Loan in your Self Service. In order to receive a Stafford Loan, you will need to complete your Stafford Loan Entrance Counseling. You may complete your Stafford Loan Entrance Counseling at <a target="_blank" href="http://www.studentloans.gov">www.studentloans.gov</a>. You will log in using your Social Security Number and Federal Aid Pin (same as the one you used for your FAFSA). Please click on the box for Stafford Entrance Counseling and complete the instructions.
    </xsl:when>
    <xsl:when test="$serviceCode = 'FZTX10'">
      Your file has been selected for verification. A component of the federal requirement is that we compare tax data information from the tax return to the information reported on the Free Application for Federal Student Aid (FAFSA).  You have the option of automatically retrieving your income and tax data from the Internal Revenue Service (IRS) and having it automatically transferred into your FAFSA. The online application will walk you through the process, which requires that you provide your PIN and confirm that you want to retrieve your IRS data. To access this new feature, please go back in to your FAFSA at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>. If you are unable to retrieve your data or if you make modifications to the IRS data then provide our office with a signed copy of your spouse's 2010 federal tax return. Please ensure that it is signed and all of the form is legible. If they filed a 1040 or 1040a, we would need the first two pages. If they filed a 1040ez, we only need the first page. For alternative ways to complete the above requirement and/or for more information, please see our website at <a target="_blank" href="http://www.uccs.edu/finaid">www.uccs.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'G1SSN'">
      The Social Security Administration (SSA) did not confirm that the Social Security Number (SSN) you reported on your FAFSA is correct, and also could not confirm your U.S. citizenship. If you believe that the SSN you reported in Item 8 is correct, contact the SSA by calling 1-800-772-1213 or by visiting <a target="_blank" href="http://www.socialsecurity.gov">www.socialsecurity.gov</a>. If the SSN is incorrect, you must correct the SSN on a paper SAR or submit a new FAFSA online with the correct SSN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'G2SSN'">
      The date of birth you reported on your FAFSA does not match the date of birth in the Social Security Administration's (SSA) records for your Social Security Number (SSN). Therefore, you must correct your SSN (Item 8) or your date of birth (Item 9). If your date of birth is correct, you must confirm it by re-entering it in Item 9. If you confirm your date of birth, you should also contact the SSA to make sure they correct it in their records. The SSA can be contacted by calling 1-800-772-1213 or by visiting <a target="_blank" href="http://www.socialsecurity.gov">www.socialsecurity.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'G3SSN'">
      The name you reported on your FAFSA does not match the name in the Social Security Administration's (SSA) records for your Social Security Number (SSN). Therefore, you must correct your SSN (Item 8) or name (Items 1 and 2). If your name is correct, you must confirm it by re-entering both your first and last names in Items 1 and 2. If you confirm your name, you should also contact the SSA to make sure that they correct it in their records. The SSA can be contacted by calling 1-800-772-1213 or by visiting <a target="_blank" href="http://www.socialsecurity.gov">www.socialsecurity.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GCONV3'">
      Your answer to the drug-related conviction question on the FAFSA indicates that your drug conviction(s) have made you ineligible for financial aid for the current year. For questions, please see <a target="_blank" href="http://studentaid.ed.gov">studentaid.ed.gov</a> or contact the Office of Financial Aid.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GDPLS1'">
      Your parent has applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any PLUS loan funds to your university bill. Your parent should submit the completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Parent PLUS loan. We will electronically receive a confirmation the MPN has been completed.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GDPLS2'">
      Your parent has applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any PLUS loan funds to your university bill. Your parent should submit the completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Parent PLUS loan. We will electronically receive a confirmation the MPN has been completed.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GDPLS3'">
      Your parent has applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any PLUS loan funds to your university bill. Your parent should submit the completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Parent PLUS loan. We will electronically receive a confirmation the MPN has been completed.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GDPLS4'">
      Your parent has applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any PLUS loan funds to your university bill. Your parent should submit the completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Parent PLUS loan. We will electronically receive a confirmation the MPN has been completed.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GDPLS5'">
      Your parent has applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any PLUS loan funds to your university bill. Your parent should submit the completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Parent PLUS loan. We will electronically receive a confirmation the MPN has been completed.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GDRFXX'">
      We are unable to verify that you have registered with Selective Service. Proof of registration or exemption must be submitted to our office before you can be awarded federal financial aid. If you have registered, please submit a copy of your registration card to our office. If you have not registered, you can go to <a target="_blank" href="http://www.sss.gov">www.sss.gov</a> and register on-line. Females are not required to register with Selective Service. If you are female, please correct your FAFSA application (some students accidentally skip the question - leaving it blank generates this request) and indicate that you are female. Once your correction has been processed by FAFSA, please contact our office. If you have questions about Selective Service, please visit their web site ( <a target="_blank" href="http://www.sss.gov">www.sss.gov</a> ) or call them at 847-688-6888. If you are over 26 and did not already register with Selective Service, you must submit a letter to our office explaining why you failed to register. Additional documentation will be required.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GDRUG'">
      Your answers on the FAFSA indicate that you may have had a drug conviction in the past that could impact your eligibility for financial aid. Please submit documents to the financial aid office to demonstrate the date and nature of your conviction so that we can determine your eligibility. For additional questions, please refer to the FAFSA guidelines for prior drug convictions at <a target="_blank" href="http://studentaid.ed.gov">http://studentaid.ed.gov</a> or contact the financial aid office.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GFACT'">
      Because of your Satisfactory Academic Progress (SAP) violation, you must complete the <a target='_blank' href='http://studentloans.gov/myDirectLoan/index.action'>Financial Awareness Counseling Tool</a> if you plan on submitting a SAP appeal. You will need your FSA ID to sign in. This tool presents a series of exercises to help you understand your financial aid and help manage your finances.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GFAFSA'">
      To be considered for financial aid, you must first submit the Free Application for Federal Student Aid (FAFSA). The FAFSA is available online at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> , the Federal School Code for the University of Colorado Boulder (001370) must be listed.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLM1'">
      You have accepted a Federal Graduate PLUS Loan. To apply for a Federal Direct PLUS Loan, you must complete the PLUS Loan Application. You should request a PLUS loan by completing the Direct PLUS Loan Application for the Graduate PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that you have completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLM2'">
      You have accepted a Federal Graduate PLUS Loan. To apply for a Federal Direct PLUS Loan, you must complete the PLUS Loan Application. You should request a PLUS loan by completing the Direct PLUS Loan Application for the Graduate PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that you have completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLM3'">
      You have accepted a Federal Graduate PLUS Loan. To apply for a Federal Direct PLUS Loan, you must complete the PLUS Loan Application. You should request a PLUS loan by completing the Direct PLUS Loan Application for the Graduate PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that you have completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLM4'">
      You have accepted a Federal Graduate PLUS Loan. To apply for a Federal Direct PLUS Loan, you must complete the PLUS Loan Application. You should request a PLUS loan by completing the Direct PLUS Loan Application for the Graduate PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that you have completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLM5'">
      You have accepted a Federal Graduate PLUS Loan. To apply for a Federal Direct PLUS Loan, you must complete the PLUS Loan Application. You should request a PLUS loan by completing the Direct PLUS Loan Application for the Graduate PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that you have completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLS1'">
      You have applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any Graduate/Professional PLUS loan funds to your university bill. Submit your completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Graduate PLUS loan. We will electronically receive a confirmation that you have completed the MPN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLS2'">
      You have applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any Graduate/Professional PLUS loan funds to your university bill. Submit your completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Graduate PLUS loan. We will electronically receive a confirmation that you have completed the MPN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLS3'">
      You have applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any Graduate/Professional PLUS loan funds to your university bill. Submit your completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Graduate PLUS loan. We will electronically receive a confirmation that you have completed the MPN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLS4'">
      You have applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any Graduate/Professional PLUS loan funds to your university bill. Submit your completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Graduate PLUS loan. We will electronically receive a confirmation that you have completed the MPN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGPLS5'">
      You have applied for a Federal Direct PLUS loan. We must have a record of a completed Federal Direct PLUS Loan Master Promissory Note (MPN) on file before we can apply any Graduate/Professional PLUS loan funds to your university bill. Submit your completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a> to complete an electronic MPN for a Graduate PLUS loan. We will electronically receive a confirmation that you have completed the MPN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GGRDLT'">
      According to our records you have applied for graduation. If you are not going to graduate after this semester, or if you're graduating but starting a new program here at CU, you will need to complete the Graduating Student Eligibility form available at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a> in order to receive financial aid.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GIVF24'">
      To verify your dependency status, please complete the Dependency Status Verification Form available online at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GMPN'">
      You have accepted a Federal Direct Stafford loan. We must have a record of a completed Federal Direct Stafford Loan Master Promissory Note (MPN) on file before we can apply any Stafford loan funds to your university bill. Submit your completed paper MPN to the Department of Education, or go online to <a target="_blank" href="https://studentloans.gov">studentloans.gov</a> to complete an electronic MPN for a Subsidized/Unsubsidized loan. We will electronically receive a confirmation that you have completed the MPN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GPERKQ'">
      To receive the Federal Perkins Loan, you must complete the Federal Perkins Loan Program Questionnaire. This form is available on our website at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GPLSM1'">
      If you and your parent would like to apply for a Federal Direct PLUS Loan, your parent must complete the PLUS Loan Application. Your parent should request a PLUS loan by completing the Direct PLUS Loan Application for the Parent PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that your parent has completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GPLSM2'">
      If you and your parent would like to apply for a Federal Direct PLUS Loan, your parent must complete the PLUS Loan Application. Your parent should request a PLUS loan by completing the Direct PLUS Loan Application for the Parent PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that your parent has completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GPLSM3'">
      If you and your parent would like to apply for a Federal Direct PLUS Loan, your parent must complete the PLUS Loan Application. Your parent should request a PLUS loan by completing the Direct PLUS Loan Application for the Parent PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that your parent has completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GPLSM4'">
      If you and your parent would like to apply for a Federal Direct PLUS Loan, your parent must complete the PLUS Loan Application. Your parent should request a PLUS loan by completing the Direct PLUS Loan Application for the Parent PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that your parent has completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GPLSM5'">
      If you and your parent would like to apply for a Federal Direct PLUS Loan, your parent must complete the PLUS Loan Application. Your parent should request a PLUS loan by completing the Direct PLUS Loan Application for the Parent PLUS loan type online at <a target="_blank" href="https://studentloans.gov">https://studentloans.gov</a>. We will electronically receive a confirmation that your parent has completed the application.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GREJCT'">
      Our records show that you have begun filling out the Free Application for Federal Student Aid (FAFSA) but it was unable to be processed due to missing or conflicting information. Review your FAFSA application online at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> and make all necessary corrections. Once the corrections are processed, CU will automatically download the updated version (typically within 1 week of completion).
    </xsl:when>
    <xsl:when test="$serviceCode = 'GSAPDA'">
      You have exceeded or will exceed 150% of the published required hours necessary to complete your program (a violation of the Office of Financial Aid's Satisfactory Academic Progress or SAP policy). If you are submitting a SAP appeal, it must include the SAP Degree Audit Form available on our website at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a>. The form must be completed and signed by your academic advisor(s).
    </xsl:when>
    <xsl:when test="$serviceCode = 'GSAPSP'">
      You are not meeting Satisfactory Academic Progress towards your degree; therefore, you are ineligible to receive financial aid for the Spring semester. If you have extenuating circumstances, you may submit an appeal as soon as you receive official notification via email or no later than three weeks before the end of the semester. To begin the appeal process, submit the appeal form and supporting documentation to the Office of Financial Aid. This form is available at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GSAPFA'">
      You are not meeting Satisfactory Academic Progress towards your degree; therefore, you are ineligible to receive financial aid for the Fall semester. If you have extenuating circumstances, you may submit an appeal as soon as you receive official notification via email or no later than three weeks before the end of the semester. To begin the appeal process, submit the appeal form and supporting documentation to the Office of Financial Aid. This form is available at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GSAPSM'">
      You are not meeting Satisfactory Academic Progress towards your degree; therefore, you are ineligible to receive financial aid for the Summer semester. If you have extenuating circumstances, you may submit an appeal as soon as you receive official notification via email or no later than three weeks before the end of the semester. To begin the appeal process, submit the appeal form and supporting documentation to the Office of Financial Aid. This form is available at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GSEP'">
      If you are unable to appear in person at the Office of Financial Aid at CU-Boulder, please complete the Statement of Educational Purpose Form available at <a target="_blank" href="http://www.colorado.edu/financialaid/forms">www.colorado.edu/financialaid/forms</a>. This form must be completed in the presence of a notary and then mailed to the Office of Financial Aid along with a copy of your government-issued photo ID. If you are able to appear in person at the Office of Financial Aid at CU-Boulder, please complete the form in our office. Bring your original government-issued photo ID, such as a driver's license or passport, with you.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GSIGN'">
      Our records show that you have completed the FAFSA but it was unable to be processed due to missing or conflicting information, including a missing signature. At least one parent is required to sign the FAFSA for dependent students. Review your FAFSA application online at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> and make all necessary corrections. The FAFSA can be electronically signed using your FSA ID.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GXDONR'">
      One or more scholarship donors have requested your grades and/or financial aid information. If you authorize the release of such information to private donors and/or other educational institutions, please submit a Grade Release Form to Scholarship Services. The form can be found online at <a target="_blank" href="http://www.colorado.edu/scholarships/forms">www.colorado.edu/scholarships/forms</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'GXDRFT'">
      We are unable to verify that you have registered with Selective Service. Proof of registration or exemption must be submitted to our office before you can be awarded federal financial aid. If you have registered, please submit a copy of your registration card to our office. If you have not registered, you can go to <a target="_blank" href="http://www.sss.gov">www.sss.gov</a> and register on-line. Females are not required to register with Selective Service. If you are female, please correct your FAFSA application and indicate that you are female. After making this correction, please contact our office or submit a personal statement indicating that you have corrected your FAFSA. If you have questions about Selective Service, please visit their web site ( <a target="_blank" href="http://www.sss.gov">www.sss.gov</a> ) or call them at 847-688-6888. If you are over 26 and did not already register with Selective Service, you must submit a letter to our office explaining why you failed to register. Additional documentation will be required.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PATS'">
      Agreement to Serve (ATS) ( <a target="_blank" href="https://teach-ats.ed.gov/">https://teach-ats.ed.gov/</a> )
    </xsl:when>
    <xsl:when test="$serviceCode = 'PDEFLT'">
      Based upon information received by our office, you have at least one federal student loan in default status. Until the default has been resolved, you are ineligible for federal student aid, including federal loans and grants. Please contact the entity associated with the defaulted loan(s) or NSLDS at <a target="_blank" href="http://www.nslds.ed.gov">www.nslds.ed.gov</a> or 1-800-433-3243 to resolve the default.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PDLGPL'">
      Please complete a Direct Loan Graduate PLUS Master Promissory Note (MPN) at <a target="_blank" href="http://www.dlenote.ed.gov">dlenote.ed.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PDLPLS'">
      Please complete a Direct Loan Parent PLUS Master Promissory Note (MPN) at <a target="_blank" href="http://www.dlenote.ed.gov">dlenote.ed.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PDLSTF'">
      Please complete a Direct Loan Stafford Master Promissory Note (MPN) at <a target="_blank" href="http://www.dlenote.ed.gov">dlenote.ed.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PENTRD'">
      Entrance Counseling for Loan for Disadvantaged Students. You may complete entrance counseling online at <a target="_blank" href="http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx">http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PENTRF'">
      Entrance Counseling for Nurse Faculty Loan. You may complete entrance counseling online at <a target="_blank" href="http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx">http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PENTRH'">
      Entrance Counseling for Health Professions Loan. You may complete entrance counseling online at <a target="_blank" href="http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx">http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PENTRN'">
      Entrance Counseling for Federal Nursing Loan. You may complete entrance counseling online at <a target="_blank" href="http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx">http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PENTRT'">
      TEACH Grant Initial or Subsequent Counseling ( <a target="_blank" href="https://teach-ats.ed.gov/">https://teach-ats.ed.gov/</a> )
    </xsl:when>
    <xsl:when test="$serviceCode = 'PEXIT1'">
      TEACH Grant Exit Counseling ( <a target="_blank" href="https://www.dl.ed.gov/">https://www.dl.ed.gov/</a> )
    </xsl:when>
    <xsl:when test="$serviceCode = 'PEXIT2'">
      TEACH Grant Exit Counseling ( <a target="_blank" href="https://www.dl.ed.gov/">https://www.dl.ed.gov/</a> )
    </xsl:when>
    <xsl:when test="$serviceCode = 'PFAMD'">
      Verification of Family Information for Dependent Student form. The form may be downloaded from the Forms and Tools page of the Financial Aid Office Website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PFAMI'">
      Verification of Family Information for Independent Student form. The form may be downloaded from the Forms and Tools page of the Financial Aid Office Website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PHMLES'">
      You indicated on the FAFSA that you are considered an unaccompanied youth who was homeless or was at risk of becoming homeless on or after July 1. Please complete and submit to the University of Colorado Denver | Anschutz Medical Campus Financial Aid Office the Unaccompanied Youth Form. The form is available on the Financial Aid Office website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>. Look for the Forms and Tools link after selecting your campus. The form may be submitted by fax to 303-352-3554.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PIRSP'">
      Your parent was eligible to use the IRS Data Retrieval Tool when filing the FAFSA, but your parent either elected not to use it or used it but elected not to transfer IRS data into the FAFSA. Please instruct your parent to either file a FAFSA correction online at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> and transfer IRS data OR submit a Tax Return Transcript. A Tax Return Transcript may be ordered from the IRS online at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a>. DO NOT SUBMIT A COPY OF YOUR PARENT'S FEDERAL TAX RETURN (1040).
    </xsl:when>
    <xsl:when test="$serviceCode = 'PIRSS'">
      You were eligible to use the IRS Data Retrieval Tool when filing your FAFSA, but you either elected not to use it or used it but elected not to transfer IRS data into the FAFSA. Please file a FAFSA correction online at <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> and transfer your data OR submit a Tax Return Transcript. A Tax Return Transcript may be ordered from the IRS online at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a>. DO NOT SUBMIT A COPY OF YOUR FEDERAL TAX RETURN (1040).
    </xsl:when>
    <xsl:when test="$serviceCode = 'PISIR'">
      Free Application for Federal Student Aid ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> )
    </xsl:when>
    <xsl:when test="$serviceCode = 'PIVFD'">
      Complete and submit to the UC Denver Financial Aid Office the Verification Worksheet for Dependent Students. The worksheet is available on the Financial Aid Office website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>. Look for the Forms and Tools link after selecting your campus. The completed form may be faxed to 303-352-3554.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PIVFI'">
      Complete and submit to the UC Denver Financial Aid Office the Verification Worksheet for Independent Students. The worksheet is available on the Financial Aid Office website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>. Look for the Forms and Tools link after selecting your campus. The completed form may be faxed to 303-352-3554.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PMPNG'">
      Master Promissory Note (MPN) - Gradate PLUS. Complete the Graduate PLUS MPN online at <a target="_blank" href="http://www.StudentLoans.gov">StudentLoans.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PMPNP'">
      Master Promissory Note (MPN) - Parent PLUS. Your parent may complete the Parent PLUS MPN online at <a target="_blank" href="http://www.StudentLoans.gov">StudentLoans.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PMPNS'">
      Master Promissory Note (MPN) - Subsidized/Unsubsidized Stafford. Complete the Subsidized/Unsubsidized MPN online at <a target="_blank" href="http://www.StudentLoans.gov">StudentLoans.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PNONP'">
      Verification of Income for Parent Non Filers. The form may be downloaded from the Forms and Tools page of the Financial Aid Office Website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PNONS'">
      Verification of Income for Student Non Filers. The form may be downloaded from the Forms and Tools page of the Financial Aid Office Website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PPLUSR'">
      Please have your parent complete the PLUS Application/Request Process on <a target="_blank" href="http://www.StudentLoans.gov">StudentLoans.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PSIGN'">
      You did not sign your FAFSA. Please visit FAFSA on the Web ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> ) and apply an electronic signature using your PIN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PSIGNP'">
      Your parent did not sign your FAFSA. Please have your parent visit FAFSA on the Web ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> ) and apply an electronic signature using his or her PIN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PSNAPP'">
      Documentation of the food stamp/assistance benefit received by a member of your parent's household in 2010 or 2011. This could be a Food Assistance Approval Letter, a Notice of Action (NOA 1020) from the State of Colorado, or a Colorado PEAK ( <a target="_blank" href="https://peak.state.co.us/selfservice/">https://peak.state.co.us/selfservice/</a> ) account printout listing the benefit. Documents may be submitted by fax to 303-352-3554. Please write your student ID on each page.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PSNAPS'">
      Documentation of the food stamp/assistance benefit received by a member of your household in 2010 or 2011. This could be a Food Assistance Approval Letter, a Notice of Action (NOA 1020) from the State of Colorado, or a Colorado PEAK ( <a target="_blank" href="https://peak.state.co.us/selfservice/">https://peak.state.co.us/selfservice/</a> ) account printout listing the benefit. Documents may be submitted by fax to 303-352-3554. Please write your student ID on each page.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PSPRTP'">
      Child Support Paid by Parent form. The form may be downloaded from the Forms and Tools page of the Financial Aid Office Website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PSPRTS'">
      Child Support Paid by Student/Spouse form. The form may be downloaded from the Forms and Tools page of the Financial Aid Office Website, <a target="_blank" href="http://www.ucdenver.edu/finaid">www.ucdenver.edu/finaid</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PTAX11'">
      Please submit to the University of Colorado Denver | Anschutz Medical Campus Financial Aid Office a 2011 Tax Return Transcript. A Tax Return Transcript may be ordered from the IRS online at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a>. You may submit the Tax Return Transcript by fax to 303-352-3554. Please write your student ID on each page. If you indicated on your FAFSA that you have not but will file a 2011 income tax return, you may be eligible to use the FAFSA IRS Data Retrieval Tool approximately two weeks after you file your tax return electronically. If you use the IRS Data Retrieval Tool and make no changes to your tax data, we will waive the Tax Return Transcript requirement. Until July 15, if you have difficulty using the FAFSA IRS Data Retrieval Tool or obtaining a Tax Return Transcript, we may accept copies of your SIGNED 2011 Federal Income Tax form 1040,1040A, 1040EZ, or 1040 NR.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PTXF11'">
      Please submit to the University of Colorado Denver | Anschutz Medical Campus Financial Aid Office your father's 2011 Tax Return Transcript. Your father may order a Tax Return Transcript from the IRS online at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a>. You may submit your father's Tax Return Transcript by fax to 303-352-3554. Please write your student ID on each page. Until July 15, if your father has difficulty obtaining a Tax Return Transcript, we may accept copies of his SIGNED 2011 Federal Income Tax form 1040,1040A, 1040EZ, or 1040 NR.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PTXM11'">
      Please submit to the University of Colorado Denver | Anschutz Medical Campus Financial Aid Office your mother's 2011 Tax Return Transcript. Your mother may order a Tax Return Transcript from the IRS online at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a>. You may submit your mother's Tax Return Transcript by fax to 303-352-3554. Please write your student ID on each page. Until July 15, if your mother has difficulty obtaining a Tax Return Transcript, we may accept copies of her SIGNED 2011 Federal Income Tax form 1040,1040A, 1040EZ, or 1040 NR.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PTXP11'">
      Please submit to the University of Colorado Denver | Anschutz Medical Campus Financial Aid Office your parent's 2011 Tax Return Transcript. Your parent may order a Tax Return Transcript from the IRS online at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a>. You may submit your parent's Tax Return Transcript by fax to 303-352-3554. Please write your student ID on each page. If your parent indicated on the FAFSA that your parent has not but will file a 2011 income tax return, your parent may be eligible to use the FAFSA IRS Data Retrieval Tool approximately two weeks after your parent files a tax return electronically. If your parent uses the IRS Data Retrieval Tool and makes no changes to tax data, we will waive the Tax Return Transcript requirement. Until July 15, if your parent has difficulty using the FAFSA IRS Data Retrieval Tool or obtaining a Tax Return Transcript, we may accept copies of your parent's SIGNED 2011 Federal Income Tax form 1040,1040A, 1040EZ, or 1040 NR.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PTXS11'">
      Please submit to the University of Colorado Denver | Anschutz Medical Campus Financial Aid Office your spouse's 2011 Tax Return Transcript. Your spouse may order a Tax Return Transcript from the IRS online at <a target="_blank" href="http://www.irs.gov">www.irs.gov</a>. You may submit your spouse's Tax Return Transcript by fax to 303-352-3554. Please write your student ID on each page. Until July 15, if your spouse has difficulty obtaining a Tax Return Transcript, we may accept copies of your spouse's SIGNED 2011 Federal Income Tax form 1040,1040A, 1040EZ, or 1040 NR.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVASS'">
      The FAFSA processor could not verify some information on your FAFSA. Please log into your application with your PIN via the FAFSA website: <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a>. You must provide your asset information.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVDOB'">
      The FAFSA processor was unable to confirm your date of birth. Please visit FAFSA on the Web ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> ) and review your answer to question 9. If your date of birth is correct, please confirm your date of birth by re-entering it after selecting Make Corrections to a Processed FAFSA. If your date of birth is incorrect, correct it.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVDOBP'">
      The FAFSA process was unable to confirm your parents Date of Birth. Please log into your FAFSA at <a target="_blank" href="http://www.fafsa.ed.gov">http://www.fafsa.ed.gov</a> and review your answer to question 63 and 67. If the date of birth is correct, please re-enter your answer and resubmit your FAFSA, if the information is incorrect then correct the response and resubmit the correction. This will require your parent to re-sign your application with their PIN.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVNAM'">
      The FAFSA processor could not verify your name. Please visit FAFSA on the Web ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> ) and review your answers to questions 1 &amp; 2. If your name is correct, please confirm your name by re-entering it after selecting Make Corrections to a Processed FAFSA.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVNAMP'">
      The FAFSA processor could not verify your parents names. Please have your parents visit FAFSA on the Web ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> ) and review their answers to the questions asking for their names. If your parents names are correct, please have them confirm their names by re-entering them after selecting Make Corrections to a Processed FAFSA.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVSERV'">
      Please submit to the University of Colorado Denver | Anschutz Medical Campus proof that you registered with the Selective Service. If you have not registered, visit <a target="_blank" href="http://www.sss.gov">www.sss.gov</a> to register and submit to us a copy of your registration card. If you have registered but need proof, call 847-688-6888 to request a replacement registration card. You may submit a copy of your registration card to us by fax at 303-352-3554. If you are unable or unwilling to register, please contact the Financial Aid Office to speak with an advisor.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVSSN'">
      The FAFSA processor could not confirm your social security number (SSN). Please visit FAFSA on the Web ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> ) and review your SSN. If your date of birth is correct, please confirm your date of birth by re-entering it after selecting Make Corrections to a Processed FAFSA. If your date of birth is incorrect, correct it.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PVTAX'">
      The FAFSA processor was unable to verify some of the tax information you provided on the FAFSA. Please visit FAFSA on the Web ( <a target="_blank" href="http://www.fafsa.gov">www.fafsa.gov</a> ) and review your answers to questions relating to Taxes Paid and AGI. If you are dependent, please also review the answers to questions relating to Parents Taxes Paid and AGI. If the answers are correct, please confirm them by re-entering them after selecting Make Corrections to a Processed FAFSA.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PXENTB'">
      Entrance Counseling for V. R. Boynton Loan. You may complete entrance counseling online at <a target="_blank" href="http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx">http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PXENTC'">
      Entrance Counseling for Medical Center Loan. You may complete entrance counseling online at <a target="_blank" href="http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx">http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PXENTK'">
      Entrance Counseling for Federal Perkins Loan. You may complete Perkins entrance counseling online at Mapping Your Future ( <a target="_blank" href="http://mappingyourfuture.org/oslc/counseling/index.cfm?act=Intro&amp;OslcTypeID=3">http://mappingyourfuture.org/oslc/counseling/index.cfm?act=Intro&amp;OslcTypeID=3</a> ).
    </xsl:when>
    <xsl:when test="$serviceCode = 'PXENTP'">
      Entrance Counseling. Complete Entrance Counseling for graduate/professional students online at <a target="_blank" href="http://www.StudentLoans.gov">StudentLoans.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PXENTR'">
      Entrance Counseling. Complete Entrance Counseling online at <a target="_blank" href="http://www.StudentLoans.gov">StudentLoans.gov</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'PXENTS'">
      Entrance Counseling for Medical Student Loan. You may complete entrance counseling online at <a target="_blank" href="http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx">http://www.ucdenver.edu/student-services/resources/CostsAndFinancing/DenverCampus/LoansRepaymentDebt/Pages/EntranceandExitCounseling.aspx</a>.
    </xsl:when>
    <xsl:when test="$serviceCode = 'RIX'">
      You are required to complete the online Community Equity module through Desire2Learn (D2L) at<a  target="_blank"  href="https://learn.colorado.edu">https://learn.colorado.edu</a> before you can enroll in classes. The module is under community spaces on the D2L home page. For more details, go to the Office of Institutional Equity
      and Compliance's <a target="_blank" href="http://www.colorado.edu/institutionalequity/training-and-education">Training and Education</a> page and click on the "Mandatory Training for New Students" section.
    </xsl:when>
    <xsl:when test="$serviceCode = 'RT9'">
      You are required to attend one in-person session of Bystander Intervention Skills Training before you can enroll in classes. For details on when this course is offered, go to the Office of Institutional Equity
      and Compliance's <a target="_blank" href="http://www.colorado.edu/institutionalequity/training-and-education">Training and Education</a> page and click on the "Mandatory Training for New Students" section.
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPREG'">
      You are required to complete the following items before you register for courses.
      <ol type="1">
        <li>Add/update your local and home addresses, phone number and emergency contact information:
          <ol type="A">
            <li>Add/update your home and local addresses.</li>
            <li>Add/update your cell/mobile phone number.</li>
            <li>Add/update your emergency contact information.</li>
            <li>Verify your information and click submit.</li>
          </ol>
        </li>
        <li>Accept the terms of the Tuition and Fee Agreement and Disclosure.</li>
        <li>Apply for and authorize the College Opportunity Fund (COF).</li>
        <li>Select student opportunities.</li>
      </ol>
      Visit the Office of the Registrar's website for <a href="http://www.colorado.edu/registrar/students/registration/before-enroll/preregistration-items" target="blank">step-by-step instructions</a>. If you have questions, please contact the <a href="mailto:registrar@colorado.edu">Office of the Registrar</a>.
    </xsl:when>
    <!-- New ToDos, or maybe Holds I don't know -->
    
    <xsl:when test="$serviceCode = 'TPCREZ'">
      <p>Please submit proof of your petitioning parent/guardian's physical presence for the domicile qualifying year. This can be a copy of a lease or warranty deed or a statement. A lease must clearly show the names and signatures of the landlord and renter(s), the address of the residence and the term of the lease. A warranty deed must show the address of the property purchased, date purchased and names of seller(s) and purchaser(s). If your parent/guardian does not have a formal lease or warranty deed, you can submit a signed letter from the landlord or homeowner with all parties' names and start and end dates.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCREZ'">
      <p>Please submit proof of your physical presence for the domicile qualifying year. This can be a copy of a lease, deed or a statement. A lease must clearly show the names and signatures of the landlord and renter(s), the address of the residence and the term of the lease. A warranty deed must show the address of the property purchased, date purchased and names of seller(s) and purchaser(s). If you do not have a formal lease or warranty deed, you can submit a signed letter from the landlord or homeowner with names and start and end dates.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPCODL'">
      <p>Please provide a copy of your petitioning parent/guardian's Colorado driver's license or Colorado State ID Card. If the parent/guardian petitioner's driver's license has been reissued, please provide a driver's history record from the Colorado DMV.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCODL'">
      <p>Please provide a copy of your Colorado driver's license or Colorado State ID Card. If your driver's license has been reissued, please provide a driver's history record from the Colorado DMV.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCCAR'">
      <p>Please provide a copy of your petitioning parent/guardian's Colorado vehicle registration.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPCVTR'">
      <p>Please provide a copy of your petitioning parent/guardian's Colorado voter registration.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCVTR'">
      <p>Please provide a copy of your Colorado voter registration.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPOCAR'">
      <p>If your petitioning parent/guardian is driving a vehicle that is owned by another person or registered in another state, please submit a copy of the registration and explain why your parent/guardian is driving a vehicle that is owned by another person or registered in another state.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSOCAR'">
      <p>If you are driving a vehicle that is owned by another person or registered in another state, please submit a copy of the registration and explain why you are driving a vehicle that is owned by another person or registered in another state.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSVHCL'">
      <p>Please submit a copy of the current registration for the vehicle that you are currently driving, whether that vehicle is owned by yourself or another person.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TRESID'">
      <p>Please submit a residency statement from the petitioner (whether student or parent/guardian) which includes the petitioner's intent to create a true, fixed and permanent home in Colorado, including future plans for employment and residency after the student graduates. If you submitted a residency statement with your petition, be sure to submit a statement from the petitioner which covers all the points mentioned above.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSWEDD'">
      <p>Please provide a copy of your marriage certificate.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPCITZ'">
      <p>Please submit a copy of a citizenship document for your petitioning parent/guardian which shows the date of issue and any expiration date. Examples of citizenship documents include a copy of the permanent residency (green) card or current visa, an application for permanent residency, etc.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCITZ'">
      <p>Please submit a copy of your citizenship document for which shows the date of issue and any expiration date. Examples of citizenship documents include a copy of your permanent residency (green) card or current visa, an application for permanent residency, etc.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPJOBV'">
      <p>Please submit copies of your petitioning parent/guardian's employment verification which includes start and end (or most recent) dates of employment. Examples of employment verification include: first and last pay stub, a letter from employer, an employment contract, a W-2 or other tax forms.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSJOBV'">
      <p>Please submit copies of your employment verification which includes start and end (or most recent) dates of employment. Examples of employment verification include: first and last pay stub, a letter from employer, an employment contract, a W-2 or other tax forms.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPFTXO'">
      <p>Please submit a photocopy of the first and second page of your petitioning parent/guardian's form 2015 1040 form (or just the first page of the 1040EZ). Do not include schedules.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSFTXO'">
      <p>Please submit a photocopy of the first and second page of your form 2015 1040 form (or just the first page of the 1040EZ). Do not include schedules.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPFTXE'">
      <p>Please submit a photocopy of the first and second page of your petitioning parent/guardian's form 2014 1040 form (or just the first page of the 1040EZ). Do not include schedules.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSFTXE'">
      <p>Please submit a photocopy of the first and second page of your form 2014 1040 form (or just the first page of the 1040EZ). Do not include schedules.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPCTXO'">
      <p>Please submit a copy of your petitioning parent/guardian's entire 2015 Colorado Form 104, and if the parent/guardian filed as a part-year resident or non-resident, also submit a copy of the 104PN form.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCTXO'">
      <p>Please submit a copy of your entire 2015 Colorado Form 104, and if you filed as a part-year resident or non-resident, also submit a copy of the 104PN form.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPCTXE'">
      <p>Please submit a copy of your petitioning parent/guardian's entire 2014 Colorado Form 104, and if the parent/guardian filed as a part-year resident or non-resident, also submit a copy of the 104PN form.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCTXE'">
      <p>Please submit a copy of your entire 2014 Colorado Form 104, and if you filed as a part-year resident or non-resident, also submit a copy of the 104PN form.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPOTXE'">
      <p>Please submit a copy of your petitioning parent/guardian's entire 2014 tax return from any other states besides Colorado where the parent/guardian filed in 2014. If the parent/guardian filed as a part-year resident or non-resident in that state, please also submit a copy of the part-year/non-resident form if applicable in that state.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSOTXE'">
      <p>Please submit a copy of your entire 2014 tax return from any other states besides Colorado where you filed in 2014. If you filed as a part-year resident or non-resident in that state, please also submit a copy of the part-year/non-resident form if applicable in that state.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TPOTXO'">
      <p>Please submit a copy of your petitioning parent/guardian's entire 2015 tax return from any other states besides Colorado where the parent/guardian filed in 2015. If the parent/guardian filed as a part-year resident or non-resident in that state, please also submit a copy of the part-year/non-resident form if applicable in that state.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSOTXO'">
      <p>Please submit a copy of your entire 2015 tax return from any other states besides Colorado where you filed in 2015. If you filed as a part-year resident or non-resident in that state, please also submit a copy of the part-year/non-resident form if applicable in that state.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TEINCM'">
      <p>Please submit a document describing all employment income you received in the twelve-month domicile year. The document must include the name of the employer, employment start and end dates, and the salary that you received. Examples of employment income documentation include: twelve months of pay stubs, W-2 forms, and signed letters from employers.  In some cases you may only need to provide the first and last pay stub in each year during the domicile period if the document includes year-to-date salary information.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TLOAN'">
      <p>For all loans you received in the twelve-month domicile year (including private loans), please submit a promissory note which shows any and all co-signers on the loan. If the loan is coming from a private lender, please describe your relationship to the lender.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TSCHLP'">
      <p>Please submit documentation for all private scholarships you received in the twelve-month domicile period.  Private scholarships may come from your high school, businesses, or other sources outside of CU financial aid.  Include verification of the source of the scholarship and the amount received.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TBGBNK'">
      <p>Please submit a bank statement(s that clearly show the beginning balance that you had in any or all accounts at the start of the domicile qualifying year. You must also provide evidence showing the source of this balance such as W2 forms or pay stubs if from prior employment, letters from employers, letters indicating gifts from family or friends and so on.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TGINCM'">
      <p>Please submit a signed letter or document from the donor indicating the amount of the gift and the reason for the gift.  Examples might include a letter from a grandparent indicating a gift for a birthday etc.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TBANKS'">
      <p>Please submit a copy of all bank statements for the twelve-month domicile period. These should clearly indicate the balance at the beginning of the domicile qualifying year.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TTUITF'">
      <p>Please submit a copy of invoices for all tuition and fees paid at other educational institutions in the twelve-month domicile period.  These documents should clearly indicate any financial aid, grants, or loans used to cover the payments.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'THELTH'">
      <p>Please submit a copy of documentation for health insurance not acquired from CU for the twelve-month domicile period.  This documentation should include verification of payment of insurance such as an indication on payroll records, bank statements or invoices.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TMRTGS'">
      <p>Please submit a copy of lease or a signed statement from your landlord indicating your residence in Colorado during the domicile qualifying year. If you have purchased a home, please provide a copy of your warranty deed verifying the date of purchase and the Colorado address of your home.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TMMLTR'">
      <p>Please provide a copy (both sides) of the military member's military identification card. If the student is a military dependent, also copy (both sides) of the student's military identification card.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TDMLTR'">
      <p>Please provide a copy (both sides) of the student's military dependent identification card.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TDBRTH'">
      <p>Please submit a copy of the military dependent's birth certificate.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TDADPT'">
      <p>Please submit a copy of the military dependent's adoption certificate.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TMRRGE'">
      <p>Please submit a copy of your marriage certificate.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TMLORD'">
      <p>Please provide a copy of the military member's orders verifying Permanent Change of station status in Colorado.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TCMLOR'">
      <p>Please provide a copy of the military member's orders verifying Permanent Change of station status in Colorado.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TTMPOR'">
      <p>Please submit a copy of your Temporary Duty orders to Colorado including the dates you were in Colorado.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TDD214'">
      <p>Please provide the long version of the DD214 which includes items 23 through 30 and shows how the person in question was discharged.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TQSTXO'">
      <p>Please provide a copy of your qualifying state 2015 tax return.  If you filed as a Colorado part-year or non-resident, you must include the Colorado 104 N form.</p>
      <p>Refer to <a target='_blank' href = "http://www.colorado.edu/registrar/node/644">Residency Resources and Documentation</a> for guidance on collecting many legal documents. Documents should be submitted to the Office of the Registrar.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    <xsl:when test="$serviceCode = 'TRELCT'">
      <p>Please provide Documentation of the date of the company's relocation to Colorado.</p>
      <p>You may direct any questions related to this request to <a href="mailto:tuitclass@colorado.edu">tuitclass@colorado.edu</a> or 303-492-0907 or in person in Regent Administrative Center room 101.</p>
    </xsl:when>
    
    <!-- END TODOs -->
    <xsl:otherwise>
      <!-- for Holds --><xsl:value-of disable-output-escaping="yes" select="ReasonDescrl"/>
      <!-- for ToDos --><xsl:value-of disable-output-escaping="yes" select="ChklstDescrLong"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
</xsl:stylesheet>
