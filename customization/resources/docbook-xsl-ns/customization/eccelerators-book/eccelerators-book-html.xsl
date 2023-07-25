<?xml version='1.0'?> 
<xsl:stylesheet  
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 

<!-- <xsl:import href="../../xhtml5/onechunk.xsl"/>  not accepting linebreaks cause extending with xlmns="" -->

<xsl:import href="../../html/onechunk.xsl"/> 
<xsl:import href="eccelerators-book-titlepage-html.xsl"/>

<xsl:param name="html.stylesheet" select="'corpstyle.css'"/> 
<xsl:param name="admon.graphics" select="1"/>

<xsl:template match="processing-instruction('linebreak')">
  <br/> 
</xsl:template>

<xsl:param name="draft.mode" select="'maybe'"/>
<xsl:param name="draft.watermark.image">resources/mandatory/draft.png</xsl:param>

</xsl:stylesheet>
