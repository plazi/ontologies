# TreatmentOntologies
Ontologies for use in representing data from taxonomic treatments in RDF

The repo is radically under construction as is treatment.owl in particular.  Only the following files are even remotely meaningful:

1. treatment.owl  frequently change to attempt to suffice at least sufficient to model the two cases below
2. test/21401.n3  a minimalistic but real rdf treatment instance modeling the cited treatment http://treatment.plazi.org/id/1C4EDC178AD79DD7F1A5AB856E8C5BCA that is extracted from http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0001787  The intwntion is ultimately that treatment.owl is adequate to support this rdf treatment.
3. test/Szero_full.n3 an increasingly evolving rdf treatment instance modeling http://treatment.plazi.org/id/2358B75578BBAB653E79C93BF2783597 http://treatment.plazi.org/id/2358B75578BBAB653E79C93BF2783597 with the same criteria as for test/21401.n3

4. (frequently not current): for each of the active n3 instances there is generally an rdf/xml version produced by 
http://rdf-translator.appspot.com/ 
