<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mods="http://www.loc.gov/mods/v3" xmlns:bibo="http://purl.org/ontology/bibo/"
	xmlns:cito="http://purl.org/spar/cito/" xmlns:cnt="http://www.w3.org/2011/content#"
	xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
	xmlns:dwcFP="http://filteredpush.org/ontologies/oa/dwcFP#"
	xmlns:fabio="http://purl.org/spar/fabio/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:sdd="http://tdwg.org/sdd#"
	xmlns:trt="http://plazi.org/vocab/treatment#" xmlns:sdo="http://schema.org/"
	xmlns:spm="http://rs.tdwg.org/ontology/voc/SpeciesProfileModel"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs" version="1.1">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:apply-templates select="//document"/>
		</rdf:RDF>
	</xsl:template>
	<xsl:template match="document">

		<xsl:param name="treatmentID">
			<xsl:value-of select="treatment/@httpUri"/>
		</xsl:param>
		<xsl:param name="pubID" tunnel="yes">
			<xsl:choose>
				<xsl:when test="@ID-DOI">
					<xsl:text>http://dx.doi.org/</xsl:text>
					<xsl:value-of select="translate(@ID-DOI, ' ', '')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="contains(@docSource, 'dx.doi')">
							<xsl:value-of select="@docSource"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'http://publication.plazi.org/id/'"/>
							<xsl:value-of select="@masterDocId"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="taxonConceptID" tunnel="yes">
			<xsl:choose>
				<xsl:when test=" contains(' ZBK ZooBank ', concat(' ', @docUuidSource, ' '))">
					<xsl:text>http://zoobank.org/NomenclaturalActs/</xsl:text>
					<xsl:value-of select="@docUuid"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>http://taxon-concept.plazi.org/id/</xsl:text>
					<xsl:value-of select="@docId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:message>FIRING DOCUMENT TEMPLATE</xsl:message>
		<xsl:message>
			<xsl:value-of select="concat('message',$pubID,$taxonConceptID,$treatmentID)"/>
		</xsl:message>
		<xsl:apply-templates select="//treatment">
			<xsl:with-param name="taxonConceptID" select="$taxonConceptID"/>
			<xsl:with-param name="pubID" select="$pubID"/>
			<xsl:with-param name="treatmentID" select="$treatmentID"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="treatment">
		<xsl:param name="treatmentID" tunnel="yes"/>
		<xsl:param name="taxonConceptID" tunnel="yes"/>
		<xsl:param name="pubID" tunnel="yes"/>
		<xsl:message>
			<xsl:value-of select="concat('message2',$pubID,$taxonConceptID,$treatmentID)"/>
		</xsl:message>
		<rdf:Description rdf:about="{$treatmentID}">
			<rdf:type rdf:resource="http://plazi.org/vocab/treatment#Treatment"/>
			<trt:definesTaxonConcept rdf:resource="{$taxonConceptID}"></trt:definesTaxonConcept>
			<trt:publishedIn rdf:resource="{$pubID}"/>
			<xsl:apply-templates select="//treatmentCitation[@httpUri] | //subSubSection[@type = 'reference_group']//taxonomicName[@httpUri]" mode="object">
				<xsl:with-param name="treatmentID" select="$treatmentID"/>				
			</xsl:apply-templates>
			<xsl:apply-templates select="//treatmentCitation | //subSubSection[@type = 'reference_group']//taxonomicName[not(ancestor::treatmentCitation)][not(child::treatmentCitation)]" mode="literal"/>
			<xsl:apply-templates select=".//subSubSection[@type != 'nomenclature']"  mode="object">
				<xsl:with-param name="treatmentID" select="$treatmentID"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="//materialsCitation" mode="object">
				<xsl:with-param name="treatmentID" select="$treatmentID"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="//figureCitation[@httpUri]" mode="object"/>
		</rdf:Description>
		<xsl:call-template name="publication">
			<xsl:with-param name="pubID" select="$pubID"/>
		</xsl:call-template>
		<xsl:apply-templates select=".//treatmentCitation[@httpUri] | //subSubSection[@type = 'reference_group']//taxonomicName[@httpUri]" mode="subject"/>
		<xsl:apply-templates select=".//subSubSection[@type = 'nomenclature']">
			<xsl:with-param name="taxonConceptID" select="$taxonConceptID"/>
		</xsl:apply-templates>
		<xsl:apply-templates select=".//subSubSection[@type != 'nomenclature']" mode="subject"><xsl:with-param name="treatmentID" select="$treatmentID"></xsl:with-param></xsl:apply-templates>
		<xsl:apply-templates select=".//materialsCitation" mode="subject"><xsl:with-param name="treatmentID" select="$treatmentID"></xsl:with-param></xsl:apply-templates>
		<xsl:apply-templates select=".//figureCitation[@httpUri]" mode="subject"/>

	</xsl:template>
	<xsl:template name="publication">
		<xsl:param name="pubID"/>
		<rdf:Description rdf:about="{$pubID}">
			<xsl:apply-templates select="//mods:mods/mods:titleInfo/mods:title"/>
			<xsl:apply-templates
				select="//mods:mods/mods:name[mods:role/mods:roleTerm/text() = 'Author']"/>
			<xsl:apply-templates
				select="//mods:mods[mods:classification = 'journal article']/mods:relatedItem[@type = 'host']"
				mode="journal"/>
		</rdf:Description>
	</xsl:template>
	<xsl:template match="subSubSection[@type = 'nomenclature']">
		<xsl:param name="taxonConceptID"/>
		<rdf:Description rdf:about="{$taxonConceptID}">
			<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonConcept"/>
			<xsl:apply-templates select="descendant::taxonomicName[1]/@*"/>
		</rdf:Description>
	</xsl:template>
	<xsl:template match="materialsCitation" mode="object">
		<xsl:param name="treatmentID"/>
		<trt:hasMaterialExamined rdf:resource="{$treatmentID}#material_{position()}"/>
	</xsl:template>
	<xsl:template match="materialsCitation" mode="subject">
		<xsl:param name="treatmentID"/>
		<rdf:Description rdf:about="{$treatmentID}#material_{position()}">
			<rdf:type rdf:resource="http://plazi.org/vocab/treatment#MaterialExamined"/>
			<xsl:apply-templates select="@*"/>
		</rdf:Description>
	</xsl:template>
	<!-- MATERIALS AND TAXON CONCEPT TERMS -->
	<!-- Should map to proper dwc terms	-->
	<xsl:template match="materialsCitation/@* | taxonomicName/@*">
		<xsl:element name="dwc:{name()}">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="mods:title">
		<dc:title>
			<xsl:value-of select="normalize-space(.)"/>
		</dc:title>
	</xsl:template>
	<xsl:template match="mods:name[mods:role/mods:roleTerm/text() = 'Author']">
		<dc:creator>
			<xsl:value-of select="child::mods:namePart"/>
		</dc:creator>
	</xsl:template>
	<!-- TEMPLATES FOR JOURNAL BIB DATA -->
	<!-- bibo terms probably incorrect  -->
	<!-- should use isPartOf?		   -->
	<xsl:template match="mods:relatedItem[@type = 'host']" mode="journal">
		<rdf:type rdf:resource="fabio:JournalArticle"/>
		<xsl:apply-templates select="mods:titleInfo/mods:title" mode="journal"/>
		<xsl:apply-templates select="mods:part/mods:date"/>
		<xsl:apply-templates select="mods:part/mods:detail"/>
		<xsl:apply-templates select="mods:part/mods:extent/mods:start"/>
		<xsl:apply-templates select="mods:part/mods:extent/mods:end"/>
	</xsl:template>
	<xsl:template match="mods:title" mode="journal">
		<bibo:journal>
			<xsl:value-of select="."/>
		</bibo:journal>
	</xsl:template>
	<xsl:template match="mods:date">
		<dc:date>
			<xsl:value-of select="."/>
		</dc:date>
	</xsl:template>
	<xsl:template match="mods:detail">
		<xsl:element name="bibo:{@type}">
			<xsl:value-of select="child::*"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="mods:start">
		<xsl:element name="bibo:startPage">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="mods:end">
		<xsl:element name="bibo:endPage">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="//NCBI_ID">
		<xsl:element name="dc:identifier">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="treatmentCitation | subSubSection[@type = 'reference_group']//taxonomicName" mode="object">
		<cito:cites rdf:resource="{@httpUri}"/>
	</xsl:template>
	<xsl:template match="treatmentCitation | subSubSection[@type = 'reference_group']//taxonomicName" mode="subject">
		<rdf:Description rdf:about="{@httpUri}">
			<rdf:type rdf:resource="http://plazi.org/vocab/treatment#Treatment"/>
			<dc:description><xsl:apply-templates select="descendant::text()" mode="normalizeSpace"/></dc:description>
		</rdf:Description>
	</xsl:template>
	<xsl:template match="treatmentCitation | subSubSection[@type = 'reference_group']//taxonomicName" mode="literal">
		<cito:cites>
			<xsl:apply-templates select="descendant::text()" mode="normalizeSpace"/>
		</cito:cites>
	</xsl:template>
	<xsl:template match="text()" mode="normalizeSpace">
		<xsl:value-of select="normalize-space(.)"/>
		<xsl:if test="position() != last()">&#160;</xsl:if>
	</xsl:template>

	<xsl:template match="figureCitation" mode="object">
		<fabio:hasPart rdf:resource="{translate(@httpUri, ' ', '')}"/>
	</xsl:template>
	<xsl:template match="figureCitation" mode="subject">
		<rdf:Description rdf:about="{translate(@httpUri, ' ', '')}">
			<rdf:type rdf:resource="http://purl.org/spar/fabio/Figure"/>
		</rdf:Description>
	</xsl:template>
	
	<xsl:template match="subSubSection[@type != 'nomenclature']" mode="object">
		<xsl:param name="treatmentID"/>
		<spm:hasInformation rdf:resource="{$treatmentID}#section_{position()}"/>
	</xsl:template>
	
	<xsl:template match="subSubSection[@type != 'nomenclature']" mode="subject">
		<xsl:param name="treatmentID"/>
		<rdf:Description rdf:about="{$treatmentID}#section_{position()}">
			<rdf:type rdf:resource="spm:InfoItem"/>
			<spm:hasContent><xsl:apply-templates mode="normalizeSpace"/></spm:hasContent>
		</rdf:Description>
	</xsl:template>
		
</xsl:stylesheet>