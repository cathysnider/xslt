<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" />
    <!-- by Cathy Snider, Web Communications, CU-Boulder -->
    
    
    <xsl:key name="category" match="Accommodation" use="@Category" />
    
    <xsl:template match="root">
        
        
        
       <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
              
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
                <script type="text/javascript">
                    $(document).ready(function(){
                    $('a.clickToClose').click(function(){ 
                    parent.$.fn.colorbox.close(); //WORKS!
                    });
                    
                    });
                </script>
                <style>
                    body {font-family:Arial, Helvetica, sans-serif;padding:2em;}
                    a:focus {outline: thin dotted;}
                    #colorboxFocus:focus {outline: darkgray thin dotted;}
					#a11yTable caption {background-color:black; color:white; padding:5px; font-weight: bold; font-size: 18px;}
                    div#a11yDiv {margin:0 0 1em 0; padding:5px; border:1px solid black;}
                    #a11yTable {width:100%;	border-collapse:collapse; }
                    #a11yTable th { background-color:#dddddd; color:black; padding:5px; text-align:center; font-size: 18px;}
                    #a11yTable tbody {}
                    #a11yTable tbody tr td {font-size:90%; border-bottom:1px solid lightgrey; padding:5px;}
                    #a11yTable tbody tr td.a11yCategory { font-weight: bold; font-size: 16px; padding:5px; border-bottom:none;}
                    #a11yTable tbody tr td.subcatdesc {padding-left: 20px;}
                    #a11yTable tbody tr td.accessFooter {padding-top:.5em: border-bottom:none;}
                    
                </style>
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
                        <table cellspacing="0" cellpadding="6" border="0" width="100%">
                            <tr>
                                <td align="right"><a class="clickToClose" href="#"><img align="absmiddle" border="0" hspace="2" height="14" width="14" alt="close" role="presentation" src="http://www.colorado.edu/portal/ep/ucb2/images/close.gif"  /> Close window</a></td>
                            </tr>
                        </table>
                    </div>
                    
                     <h1 id="colorboxFocus" tabindex="-1">Accessibility Requirements</h1>
                     
                    <div id="a11yDiv">
                    
                        <table id="a11yTable">
                            
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

    
</xsl:stylesheet>
