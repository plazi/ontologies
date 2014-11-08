<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="root">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="row">
        <xsl:apply-templates select="*[normalize-space(.)]"/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:text>dwc:</xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&#160;"</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>"&#160;;&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>