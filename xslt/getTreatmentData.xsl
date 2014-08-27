<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 27, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> terry</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:output encoding="UTF-8" method="text"/>

    <xsl:param name="prefixes">
        <xsl:text>@prefix cnt:   &lt;http://www.w3.org/2011/content#&gt;&#10;</xsl:text>
        <xsl:text>@prefix dc:    &lt;http://purl.org/dc/elements/1.1/&gt;&#10;</xsl:text>
        <xsl:text>@prefix rdf:   &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt;&#10;</xsl:text>
        <xsl:text>@prefix xsd:   &lt;http://www.w3.org/2001/XMLSchema#&gt;&#10;</xsl:text>
        <xsl:text>@prefix rdfs:  &lt;http://www.w3.org/2000/01/rdf-schema#&gt;&#10;</xsl:text>
        <xsl:text>@prefix dwcFP: &lt;http://filteredpush.org/ontologies/oa/dwcFP#&gt;&#10;</xsl:text>
        <xsl:text>@prefix dwc:   &lt;http://rs.tdwg.org/dwc/terms/&gt;&#10;</xsl:text>
        <xsl:text>@prefix trt:   &lt;http://plazi.org/vocab/treatment#&gt;&#10;</xsl:text>
        <xsl:text>@prefix bibo: &lt;http://purl.org/ontology/bibo/&gt;&#10;</xsl:text>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:param>
    <xsl:template match="/">
        <xsl:apply-templates select="//treatment"/>
    </xsl:template>

    <xsl:template match="treatment">
        <xsl:value-of select="$prefixes"/>
        <xsl:text>&lt;</xsl:text><xsl:value-of select="@httpUri"/><xsl:text>&gt;</xsl:text><xsl:text> a trt:Treatment ;&#10;</xsl:text>
        <xsl:text>&#9;rdfs:about &lt;</xsl:text>xxxxx<xsl:text>&gt;;&#10;</xsl:text>
        <xsl:text>&#9;trt:publishedIn &lt;</xsl:text><xsl:value-of select="'http://xxxx.com/xxxx'"/><xsl:text>&gt; ;&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="'http://xxxx.com/xxxx'"/><xsl:text> a bibo:Article ;&#10;</xsl:text>
        <xsl:apply-templates select="/document/mods:mods"/>
        <!--
                    doi:10.1371/journal.pone.0001787 a bibo:Article ;
                        dc:title "A revision of Malagasy species of Anochetus Mayr and Odontomachus Latreille (Hymenoptera: Formicidae)." ;
                        dc:creator "Fisher, B. L." ;
                        dc:creater "Smith, M. A. " ;
                        dc:date "1923-01-03" .
                      -->
    </xsl:template>

    <xsl:template match="mods:mods">
        <xsl:text>&#9;dc:title "</xsl:text>
        <xsl:value-of select="mods:titleInfo/mods:title"/>
        <xsl:text>" ;&#10;</xsl:text>
        <xsl:apply-templates select="mods:name[descendant::mods:roleTerm/text() = 'Author']"/>
        <xsl:text>&#9;dc:date "</xsl:text>
        <xsl:value-of
            select="mods:originInfo/mods:dateIssued | mods:relatedItem[@type = 'host']//mods:date"/>
        <xsl:text>" ;&#10;</xsl:text>
        <xsl:apply-templates
            select="child::mods:relatedItem[@type = 'host'][following-sibling::mods:classification/text() = 'journal article']"/>
        <xsl:text>&#9;bibo:startPage "</xsl:text>
        <xsl:value-of select="/document/@pageNumber"/>
        <xsl:text>" ;&#10;</xsl:text>

    </xsl:template>

    <xsl:template match="mods:name[descendant::mods:roleTerm/text() = 'Author']">
        <xsl:text>&#9;dc:creator "</xsl:text>
        <xsl:value-of select="child::mods:namePart"/>
        <xsl:text>" ;&#10;</xsl:text>
    </xsl:template>

    <xsl:template
        match="child::mods:relatedItem[@type = 'host'][following-sibling::mods:classification/text() = 'journal article']">
        <xsl:text>&#9;bibo:Journal "</xsl:text>
        <xsl:value-of select="mods:titleInfo/mods:title"/>
        <xsl:text>" ;&#10;</xsl:text>
        <xsl:text>&#9;bibo:volume "</xsl:text>
        <xsl:value-of select="mods:part/mods:detail[@type = 'volume']/*/text()"/>
        <xsl:text>" ;&#10;</xsl:text>
    </xsl:template>


</xsl:stylesheet>
