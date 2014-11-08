<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 27, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <xsl:apply-templates select="//bibRef"/>
    </xsl:template>
    <xsl:template match="bibRef">
        <xsl:apply-templates select="DOI"/>
        <xsl:apply-templates select="author"/>
        <xsl:text>title: "</xsl:text>
        <xsl:value-of select="normalize-space(title)"/>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>year: "</xsl:text>
        <xsl:value-of select="normalize-space(year)"/>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>pagination: "</xsl:text>
        <xsl:value-of select="normalize-space(pagination)"/>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>citation: "</xsl:text>
        <xsl:value-of select="normalize-space(@author)"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(@title)"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(@year)"/>
        <xsl:text> </xsl:text>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    <xsl:template match="author">
        <xsl:text>author: "</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    <xsl:template match="DOI">
        <xsl:text>identifier: "</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
