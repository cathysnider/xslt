<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="BigDoc">
		
		
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
					<xsl:when test="Course/CourseBooks">
						<xsl:apply-templates select="Course" />
					</xsl:when>
					<xsl:otherwise>
						<tr><td colspan="5">
							<p>There is no book information for this term.</p>	</td></tr>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
		
		<script type="text/javascript">
			$("table.booktable").tablesorter({sortList: [[0,0]]});
		</script>
		
		<p><b>To see books for waitlisted courses (or any other courses), visit the CU Book Store's <a href="http://www.cubookstore.com/courselistbuilder.aspx" target="_blank">Course List Builder</a> page.</b></p>
		
	</xsl:template>
	
	<xsl:template match="Course">		
		<xsl:apply-templates select="CourseBooks" />			
	</xsl:template>
	
	<!--  https://www.cubookstore.com/booklist.aspx?catalogid={crse_id}&uterm={$uTerm} -->
	<xsl:template match="CourseBooks">
		<xsl:variable name="uTerm">
			<xsl:choose>
				<xsl:when test="1=substring(term,4,1)">Spring</xsl:when>
				<xsl:when test="4=substring(term,4,1)">Summer</xsl:when>
				<xsl:when test="7=substring(term,4,1)">Fall</xsl:when>
			</xsl:choose>20<xsl:value-of select="substring(term,2,2)" />
		</xsl:variable>
		<tr>
			<td><xsl:value-of select="author" /></td>
			<td><xsl:value-of select="title" /></td>
			<td align="center">
				<xsl:choose>
					<xsl:when test="requirement = 'R'">Required</xsl:when>
					<xsl:when test="requirement = 'O'">Optional</xsl:when>
					<xsl:when test="requirement = 'C'"><a href="https://www.cubookstore.com/booklist.aspx?catalogid={class_nbr}&amp;uterm={$uTerm}" target="_blank">Choice (see bookstore)</a></xsl:when>
					<xsl:when test="requirement = 'B'">Recommended by Bookstore</xsl:when>
					<xsl:otherwise><xsl:value-of select="requirement" /></xsl:otherwise>
				</xsl:choose></td>
			<td><xsl:value-of select="course" />-<xsl:value-of select="section" /></td>
			<td><xsl:value-of select="isbn" /></td>
			
		</tr>
	</xsl:template>
	
	<xsl:template name="getTheTerm">
		<xsl:choose>
			<xsl:when test="1=substring(term,4,1)">Spring</xsl:when>
			<xsl:when test="4=substring(term,4,1)">Summer</xsl:when>
			<xsl:when test="7=substring(term,4,1)">Fall</xsl:when>
		</xsl:choose>20<xsl:value-of select="substring(STRM, 2,2)" />
	</xsl:template>
	
</xsl:stylesheet>
