<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" />

	<xsl:template match="records">
		<xsl:apply-templates select="record" />
	</xsl:template>

	<xsl:template match="record">
		<xsl:for-each select="Rank">
			<xsl:value-of select="." />
			
			<xsl:value-of select="'&#9;'" />
		</xsl:for-each>
		<xsl:for-each select="ObjInfo1">
			<xsl:value-of select="." />
			
			<xsl:value-of select="'&#9;'" />
		</xsl:for-each>
		<xsl:for-each select="ObjInfo2">
			<xsl:value-of select="." />
			
			<xsl:value-of select="'&#9;'" />
		</xsl:for-each>
		<xsl:for-each select="Score">
			<xsl:value-of select="." />
		</xsl:for-each>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
