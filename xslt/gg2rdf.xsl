<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:bibo="http://purl.org/ontology/bibo/"
    xmlns:cito="http://purl.org/spar/cito/"
    xmlns:cnt="http://www.w3.org/2011/content#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
    xmlns:dwcFP="http://filteredpush.org/ontologies/oa/dwcFP#"
    xmlns:fabio="http://purl.org/spar/fabio/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:sdd="http://tdwg.org/sdd#"
    xmlns:trt="http://plazi.org/vocab/treatment#"
    xmlns:sdo="http://schema.org/"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:param name="treatmentID">
        <xsl:value-of select="/document/treatment/@httpUri"/>
    </xsl:param>
    <xsl:param name="pubID">
        <xsl:choose>
            <xsl:when test="/document/@ID-DOI">
                <xsl:text>http://dx.doi.org/</xsl:text>
                <xsl:value-of select="translate(/document/@ID-DOI, ' ', '')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains(/document/@docSource, 'dx.doi')">
                        <xsl:value-of select="document/@docSource"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'http://publication.plazi.org/id/'"/>
                        <xsl:value-of select="/document/@masterDocId"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:param name="taxonConceptID">
        <xsl:choose>
            <xsl:when test=" contains(' ZBK ZooBank ', concat(' ', /document/@docUuidSource, ' '))">
                <xsl:text>http://zoobank.org/NomenclaturalActs/</xsl:text>
                <xsl:value-of select="/document/@docUuid"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>http://taxon-concept.plazi.org/id/</xsl:text>
                <xsl:value-of select="/document/@docId"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <xsl:template match="/">
        <xsl:apply-templates select="//treatment"/>        
    </xsl:template>
    <xsl:template match="treatment">        
        <rdf:RDF>
            <rdf:Description
                rdf:about="{$treatmentID}">
                <rdf:type rdf:resource="http://plazi.org/vocab/treatment#Treatment"/>
                <trt:definesTaxonConcept rdf:resource="{$taxonConceptID}"/>
                <trt:publishedIn rdf:resource="{$pubID}"/>
                <xsl:apply-templates select="//treatmentCitation[@httpUri]" mode="object"/>
                <xsl:apply-templates select="//treatmentCitation" mode="literal"/>
                <xsl:apply-templates select="//materialsCitation" mode="object"/>
            </rdf:Description>
            <xsl:call-template name="publication"/>
            <xsl:apply-templates select=".//treatmentCitation" mode="subject"/>
            <xsl:apply-templates select=".//subSubSection[@type = 'nomenclature']"/>
            <xsl:apply-templates select=".//materialsCitation" mode="subject"/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template name="publication">
        <rdf:Description rdf:about="{$pubID}">
            <xsl:apply-templates select="//mods:mods/mods:titleInfo/mods:title"/>
            <xsl:apply-templates select="//mods:mods/mods:name[mods:role/mods:roleTerm/text() = 'Author']"/>
            <xsl:apply-templates select="//mods:mods[mods:classification = 'journal article']/mods:relatedItem[@type = 'host']" mode="journal"/>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="subSubSection[@type = 'nomenclature']">
        <rdf:Description rdf:about="{$taxonConceptID}">
            <rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonConcept"/>
            <xsl:apply-templates select="descendant::taxonomicName[1]/@*"/>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="materialsCitation" mode="object">
        <trt:material_examined rdf:resource="{$treatmentID}#material_{position()}"/>
    </xsl:template>
    <xsl:template match="materialsCitation" mode="subject">
        <rdf:Description rdf:about="{$treatmentID}#material_{position()}">
            <rdf:type rdf:resource="http://plazi.org/vocab/treatment#Material"/>
            <xsl:apply-templates select="@*"/>
        </rdf:Description>
    </xsl:template>
    <!-- MATERIALS AND TAXON CONCEPT TERMS -->
    <!-- Should map to proper dwc terms    -->
    <xsl:template match="materialsCitation/@* | taxonomicName/@*">
        <xsl:element name="dwc:{name()}">
            <xsl:value-of select="."></xsl:value-of>
        </xsl:element>
    </xsl:template>
    <xsl:template match="mods:title">
        <dc:title><xsl:value-of select="normalize-space(.)"/></dc:title>
    </xsl:template>
    <xsl:template match="mods:name[mods:role/mods:roleTerm/text() = 'Author']">
        <dc:creator><xsl:value-of select="child::mods:namePart"/></dc:creator>
    </xsl:template>
<!-- TEMPLATES FOR JOURNAL BIB DATA -->
<!-- bibo terms probably incorrect  -->
<!-- should use isPartOf?           -->    
    <xsl:template match="mods:relatedItem[@type = 'host']" mode="journal">
        <rdf:type rdf:resource="fabio:JournalArticle"/>
        <xsl:apply-templates select="mods:titleInfo/mods:title" mode="journal"/>
        <xsl:apply-templates select="mods:part/mods:date"/>
        <xsl:apply-templates select="mods:part/mods:detail"/>
        <xsl:apply-templates select="mods:part/mods:extent/mods:start"/>
        <xsl:apply-templates select="mods:part/mods:extent/mods:end"/>
    </xsl:template>
    <xsl:template match="mods:title" mode="journal">
        <bibo:journal><xsl:value-of select="."/></bibo:journal>
    </xsl:template>
    <xsl:template match="mods:date">
        <dc:date><xsl:value-of select="."/></dc:date>
    </xsl:template>
    <xsl:template match="mods:detail">
        <xsl:element name="bibo:{@type}"><xsl:value-of select="child::*"/></xsl:element>
    </xsl:template>   
    <xsl:template match="mods:start">
        <xsl:element name="bibo:startPage"><xsl:value-of select="."/></xsl:element>
    </xsl:template>
    <xsl:template match="mods:end">
        <xsl:element name="bibo:endPage"><xsl:value-of select="."/></xsl:element>
    </xsl:template>
    <xsl:template match="//NCBI_ID">
        <xsl:element name="dc:identifier"><xsl:value-of select="."></xsl:value-of></xsl:element>
    </xsl:template>
    
    <xsl:template match="treatmentCitation" mode="object">
        <cito:cites rdf:resource="{@httpUri}"/>
    </xsl:template>
    <xsl:template match="treatmentCitation" mode="subject">
        <rdf:Description rdf:about="{@httpUri}">
            <rdf:type rdf:resource="http://plazi.org/vocab/treatment#Treatment"/>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="treatmentCitation" mode="literal">
        <cito:cites>
            <xsl:apply-templates select="descendant::text()" mode="normalizeSpace"/>
        </cito:cites>
    </xsl:template>
    <xsl:template match="text()" mode="normalizeSpace">
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:if test="position() != last()">&#160;</xsl:if>
    </xsl:template>
    </xsl:stylesheet>
