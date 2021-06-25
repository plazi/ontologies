# Plazi Ontologies
A place to define and document the ontologies used by plazi, notably ontologies for use in representing data from taxonomic treatments in RDF.

## Background and use
Several resources served by the [plazi treatment bank](http://tb.plazi.org) are avaible as RDF. Currently the only supported RDF serialiization is `rdf/xml`.

### Examples

Dereferencing a taxon name:
```
curl -H "Accept: application/rdf+xml" http://taxon-name.plazi.org/id/Animalia/Carvalhoma_ovatum
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia/Carvalhoma_ovatum" xmlns:dwc="http://rs.tdwg.org/dwc/terms/" xmlns:cnt="http://www.w3.org/2011/content#" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:bibo="http://purl.org/ontology/bibo/" xmlns:sdo="http://schema.org/" xmlns:trt="http://plazi.org/vocab/treatment#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:fabio="http://purl.org/spar/fabio/" xmlns:cito="http://purl.org/spar/cito/" xmlns:sdd="http://tdwg.org/sdd#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dwcFP="http://filteredpush.org/ontologies/oa/dwcFP#"><rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/><dwc:kingdom>Animalia</dwc:kingdom><dwc:phylum>Arthropoda</dwc:phylum><dwc:class>Insecta</dwc:class><dwc:order>Hemiptera</dwc:order><dwc:family>Miridae</dwc:family><dwc:genus>Carvalhoma</dwc:genus><dwc:species>ovatum</dwc:species><dwc:rank>species</dwc:rank><trt:hasParentName>http://taxon-name.plazi.org/id/Animalia/Carvalhoma</trt:hasParentName></rdf:Description>
```

Dereferencinig a treatment:
```
curl -H "Accept: application/rdf+xml" http://treatment.plazi.org/id/000087F6E32CFF9BFDAEFAB4FD49FBDF
<rdf:RDF xmlns:dwc="http://digir.net/schema/conceptual/darwin/2003/1.0" xmlns:cnt="http://www.w3.org/2011/content#" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:bibo="http://purl.org/ontology/bibo/" xmlns:sdo="http://schema.org/" xmlns:trt="http://plazi.org/vocab/treatment#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:fabio="http://purl.org/spar/fabio/" xmlns:cito="http://purl.org/spar/cito/" xmlns:sdd="http://tdwg.org/sdd#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dwcFP="http://filteredpush.org/ontologies/oa/dwcFP#">
<rdf:Description rdf:about="http://treatment.plazi.org/id/000087F6E32CFF9BFDAEFAB4FD49FBDF">
<rdf:type rdf:resource="http://plazi.org/vocab/treatment#Treatment"/>
<trt:definesTaxonConcept rdf:resource="http://taxon-concept.plazi.org/id/Animalia/Carvalhoma_ovatum_Namyatova_2016"/>
<dc:creator>Namyatova, Anna A.</dc:creator>
<dc:creator>Cassis, Gerasimos</dc:creator>
<trt:publishedIn rdf:resource="http://doi.org/10.5281/zenodo.3854762"/>
<cito:cites rdf:resource="http://dx.doi.org/10.5281/zenodo.3850851"/>
<cito:cites rdf:resource="http://dx.doi.org/10.5281/zenodo.3850859"/>
<cito:cites rdf:resource="http://dx.doi.org/10.5281/zenodo.3850877"/>
<cito:cites rdf:resource="http://dx.doi.org/10.5281/zenodo.3850889"/>
<cito:cites rdf:resource="http://dx.doi.org/10.5281/zenodo.3850851"/>
</rdf:Description>
<rdf:Description rdf:about="http://doi.org/10.5281/zenodo.3854762">
<dc:title>Revision of the staphylinoid and ground-dwelling genus Carvalhoma Slater &amp; Gross (Insecta: Heteroptera: Miridae: Cylapinae) of Australia</dc:title>
<dc:creator>Namyatova, Anna A.</dc:creator>
<dc:creator>Cassis, Gerasimos</dc:creator>
<rdf:type rdf:resource="http://purl.org/spar/fabio/JournalArticle"/>
<bibo:journal>European Journal of Taxonomy</bibo:journal>
<dc:date>2016</dc:date>
<bibo:pubDate>2016-12-22</bibo:pubDate>
<bibo:volume>253</bibo:volume>
<bibo:startPage>1</bibo:startPage>
<bibo:endPage>27</bibo:endPage>
<fabio:hasPart rdf:resource="http://dx.doi.org/10.5281/zenodo.3850851"/>
<fabio:hasPart rdf:resource="http://dx.doi.org/10.5281/zenodo.3850859"/>
<fabio:hasPart rdf:resource="http://dx.doi.org/10.5281/zenodo.3850877"/>
<fabio:hasPart rdf:resource="http://dx.doi.org/10.5281/zenodo.3850889"/>
<fabio:hasPart rdf:resource="http://dx.doi.org/10.5281/zenodo.3850851"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-concept.plazi.org/id/Animalia/Carvalhoma_ovatum_Namyatova_2016">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonConcept"/>
<dwc:class>Insecta</dwc:class>
<dwc:family>Miridae</dwc:family>
<dwc:genus>Carvalhoma</dwc:genus>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:order>Hemiptera</dwc:order>
<dwc:phylum>Arthropoda</dwc:phylum>
<dwc:rank>species</dwc:rank>
<dwc:species>ovatum</dwc:species>
<dwc:scientificNameAuthorship>Namyatova &amp; Cassis, 2016</dwc:scientificNameAuthorship>
<trt:hasTaxonName rdf:resource="http://taxon-name.plazi.org/id/Animalia/Carvalhoma_ovatum"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia/Carvalhoma_ovatum">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:phylum>Arthropoda</dwc:phylum>
<dwc:class>Insecta</dwc:class>
<dwc:order>Hemiptera</dwc:order>
<dwc:family>Miridae</dwc:family>
<dwc:genus>Carvalhoma</dwc:genus>
<dwc:species>ovatum</dwc:species>
<dwc:rank>species</dwc:rank>
<trt:hasParentName rdf:resource="http://taxon-name.plazi.org/id/Animalia/Carvalhoma"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia/Carvalhoma">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:phylum>Arthropoda</dwc:phylum>
<dwc:class>Insecta</dwc:class>
<dwc:order>Hemiptera</dwc:order>
<dwc:family>Miridae</dwc:family>
<dwc:genus>Carvalhoma</dwc:genus>
<dwc:rank>genus</dwc:rank>
<trt:hasParentName rdf:resource="http://taxon-name.plazi.org/id/Animalia/Miridae"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia/Miridae">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:phylum>Arthropoda</dwc:phylum>
<dwc:class>Insecta</dwc:class>
<dwc:order>Hemiptera</dwc:order>
<dwc:family>Miridae</dwc:family>
<dwc:rank>family</dwc:rank>
<trt:hasParentName rdf:resource="http://taxon-name.plazi.org/id/Animalia/Hemiptera"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia/Hemiptera">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:phylum>Arthropoda</dwc:phylum>
<dwc:class>Insecta</dwc:class>
<dwc:order>Hemiptera</dwc:order>
<dwc:rank>order</dwc:rank>
<trt:hasParentName rdf:resource="http://taxon-name.plazi.org/id/Animalia/Insecta"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia/Insecta">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:phylum>Arthropoda</dwc:phylum>
<dwc:class>Insecta</dwc:class>
<dwc:rank>class</dwc:rank>
<trt:hasParentName rdf:resource="http://taxon-name.plazi.org/id/Animalia/Arthropoda"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia/Arthropoda">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:phylum>Arthropoda</dwc:phylum>
<dwc:rank>phylum</dwc:rank>
<trt:hasParentName rdf:resource="http://taxon-name.plazi.org/id/Animalia"/>
</rdf:Description>
<rdf:Description rdf:about="http://taxon-name.plazi.org/id/Animalia">
<rdf:type rdf:resource="http://filteredpush.org/ontologies/oa/dwcFP#TaxonName"/>
<dwc:kingdom>Animalia</dwc:kingdom>
<dwc:rank>kingdom</dwc:rank>
</rdf:Description>
<rdf:Description rdf:about="http://dx.doi.org/10.5281/zenodo.3850851">
<rdf:type rdf:resource="http://purl.org/spar/fabio/Figure"/>
<dc:description>Fig. 1. Habitus of Carvalhoma species. Scale bar = 1 mm. When two specimens of the same species are shown, the male is on the left and the female on the right. C. ovatum sp. nov. shows the male holotype. C. taplini Slater &amp; Gross, 1977 shows the female holotype.</dc:description>
<fabio:hasRepresentation>https://zenodo.org/record/3850851/files/figure.png</fabio:hasRepresentation>
</rdf:Description>
<rdf:Description rdf:about="http://dx.doi.org/10.5281/zenodo.3850859">
<rdf:type rdf:resource="http://purl.org/spar/fabio/Figure"/>
<dc:description>Fig. 3. SEM images of C. ovatum sp. nov., Ƌ. A. Head and pronotum, lateral view. B. Head and pronotum, dorsal view. C. Head, anterior view. D. Fore- and middle femora. E. Scutellum and hemelytra. F. Genital segment, lateral view. G. Pleura. H. Setae on hemelytron. I. Antenna.</dc:description>
<fabio:hasRepresentation>https://zenodo.org/record/3850859/files/figure.png</fabio:hasRepresentation>
</rdf:Description>
<rdf:Description rdf:about="http://dx.doi.org/10.5281/zenodo.3850877">
<rdf:type rdf:resource="http://purl.org/spar/fabio/Figure"/>
<dc:description>Fig. 8. Genitalia of C. ovatum sp. nov. A. Aedeagus, left lateral view. B. Aedeagus, ventral view. C. Genital capsule. D. Right paramere. E. Left paramere. Scale bars = 0.1 mm (the large scale bar is for A–B and D–E, the small scale bar is for C).</dc:description>
<fabio:hasRepresentation>https://zenodo.org/record/3850877/files/figure.png</fabio:hasRepresentation>
</rdf:Description>
<rdf:Description rdf:about="http://dx.doi.org/10.5281/zenodo.3850889">
<rdf:type rdf:resource="http://purl.org/spar/fabio/Figure"/>
<dc:description>Fig. 11. Distribution of Carvalhoma species.</dc:description>
<fabio:hasRepresentation>https://zenodo.org/record/3850889/files/figure.png</fabio:hasRepresentation>
</rdf:Description>
<rdf:Description rdf:about="http://dx.doi.org/10.5281/zenodo.3850851">
<rdf:type rdf:resource="http://purl.org/spar/fabio/Figure"/>
<dc:description>Fig. 1. Habitus of Carvalhoma species. Scale bar = 1 mm. When two specimens of the same species are shown, the male is on the left and the female on the right. C. ovatum sp. nov. shows the male holotype. C. taplini Slater &amp; Gross, 1977 shows the female holotype.</dc:description>
<fabio:hasRepresentation>https://zenodo.org/record/3850851/files/figure.png</fabio:hasRepresentation>
</rdf:Description>
</rdf:RDF>
```
The easyrdf online service converts the above in the more readable `Turtle` serialization at https://www.easyrdf.org/converter?in=rdfxml&out=turtle&uri=http://treatment.plazi.org/id/000087F6E32CFF9BFDAEFAB4FD49FBDF

On a daily basis a `Turtle` version of every treatment is also added to the Repo: https://github.com/plazi/treatments-rdf, this data is added to a SPARQL endpoint taht backs the 
[synospecies application](https://synospecies.plazi.org/)

A different RDF representation of the same treatment is available here: http://treatment.plazi.org/GgServer/rdf/000087F6E32CFF9BFDAEFAB4FD49FBDF



## Scope of this project

This project shall document which ontologies are used in the RDF data publicly exposed by plazi. Where no suitable existing and sufficiently documented ontologies are available new ontologies may be definded in this project. Ontologies should be defined using the [Turte Syntax](https://www.w3.org/TR/turtle/) stored in files with the `.ttl` extension and defined terms within the `https://vocab.plazi.org/` namespace, provided that these conditions are met, the URIs of the terms will be automatically dereferenceable within a few minutes. See `ontologies/vernacular.ttl` for an example.

## Major issues

The most pressing issue is to redefine our ontology usage in suchh a way that we no longer need to different RDF representations of treatments. https://github.com/plazi/ontologies/issues/22

## More

Major issues in transition: (a) hasScope object property (b) modeling of traits in descriptions

The repo is radically under construction as is treatment.owl in particular.  Only the following files are even remotely meaningful:

1. treatment.owl  frequently change to attempt to suffice at least sufficient to model the two cases below

2. test/21401.n3  a minimalistic but real rdf treatment instance modeling the cited treatment http://treatment.plazi.org/id/1C4EDC178AD79DD7F1A5AB856E8C5BCA that is extracted from http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0001787  The intention is ultimately that treatment.owl is adequate to support this rdf treatment.

3. test/Szero_full.n3 an increasingly evolving rdf treatment instance modeling http://treatment.plazi.org/id/2358B75578BBAB653E79C93BF2783597 http://treatment.plazi.org/id/2358B75578BBAB653E79C93BF2783597 with the same criteria as for test/21401.n3

4. (frequently not current): for each of the active n3 instances there is generally an rdf/xml version produced by 
http://rdf-translator.appspot.com/ called in a script test/n32xml.sh which should be run in test/  Ultimately we expext to support a git commit hook to run that automagically at commit.
