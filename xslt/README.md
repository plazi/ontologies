To deploy gg2rdf.xsl in SRS:

Store file in: 

plazi.cs.umb.edu:/var/lib/tomcat6/webapps/GgServer/WEB-INF/srsWebPortalData/gg2rdf.xsl

To clear that cache after you update the XSLT, you have to do the following:
* go to http://plazi.cs.umb.edu/GgServer/manager
* log in as (admin/taxonx)
* go to "Servlet Refresher"
* hit the "Re-Initialize" button in the row that reads "Re-initialize servlet GgSrsXSLT"
