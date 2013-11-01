<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:trt="http://plazi.org/vocab/treatment#"
    xmlns:tn="http://rs.tdwg.org/ontology/voc/TaxonName#"
    xmlns:tcom="http://rs.tdwg.org/ontology/voc/Common#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:bibo="http://purl.org/ontology/bibo/"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 30, 2013</xd:p>
            <xd:p><xd:b>Author:</xd:b> Terry</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

    <xsl:param name="default" select="'http://treatment.plazi.org/id/'"/>

    <xsl:template match="/">
        <rdf:RDF xml:base="{$default}">
            <xsl:apply-templates select="//document"/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="document">
        <xsl:param name="taxon-name" select="@docTitle"/>
        <xsl:param name="rank" select="child::subResults/taxonomicName/@rank"/>
        <xsl:param name="treatment-id" select="concat('http://plazi.org/id/', @docId)"/>        
        <xsl:param name="code" select="'http://rs.tdwg.org/ontology/voc/TaxonName#zoological'"/>
        <xsl:param name="author" select="@docAuthor"/>
        <xsl:param name="pub-title" select="@masterDocTitle"/>
        <xsl:param name="journal" select="@docOrigin"/>
        <xsl:param name="year" select="@docDate"/>
        <xsl:param name="master_first_page" select="@masterPageNumber"/>
        <xsl:param name="master_last_page" select="@masterLastPageNumber"/>
        <rdf:Description rdf:about="{$treatment-id}"> 
            <trt:nomenclature>
                <rdf:Description>
                    <tn:nomenclaturalCode
                        rdf:resource="{$code}"/>
                    <tn:nameComplete><xsl:value-of select="$taxon-name"/></tn:nameComplete>
                    <tn:rankString><xsl:value-of select="$rank"/></tn:rankString>
                </rdf:Description>
            </trt:nomenclature>
            <tcom:namePublishedIn>
                <rdf:Description>
                    <dc:title><xsl:value-of select="$taxon-name"></xsl:value-of></dc:title>
                    <bibo:pageStart><xsl:value-of select="@pageNumber"></xsl:value-of></bibo:pageStart>
                    <dc:isPartOf>
                        <rdf:Description>
                            <bibo:Article><xsl:value-of select="concat($author,'. ',$pub-title, ' ', $journal, ', ' , $year, ': ', $master_first_page, '-', $master_last_page)"></xsl:value-of></bibo:Article>
                        </rdf:Description>
                    </dc:isPartOf>
                </rdf:Description>
            </tcom:namePublishedIn>
      <!--      
            <trt:material_examined>
                <rdf:Description>
                    <dc:title>xxx</dc:title>
                </rdf:Description>
            </trt:material_examined>
       -->     
        </rdf:Description>
    </xsl:template>
</xsl:stylesheet>
