<?xml version='1.0'?> 
<xsl:stylesheet  exclude-result-prefixes="d"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.0"> 
	
<xsl:import href="../../fo/docbook.xsl"/> 	
<xsl:import href="eccelerators-book-titlepage-fo.xsl"/>

<!-- Standard font size is 10 by default -->
<xsl:param name="body.font.master" select="10"/>
<xsl:param name="body.font.family">serif</xsl:param>
<xsl:param name="body.start.indent" select="0"/>

<xsl:template match="processing-instruction('linebreak')">
  <fo:block/>
</xsl:template>

<xsl:param name="local.l10n.xml" select="document('')"/>
<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
  <l:l10n language="en">
     <l:context name="title-numbered">
       <l:template name="chapter" text="%n.&#160;%t"/>
     </l:context>
  </l:l10n>
</l:i18n>

<xsl:attribute-set name="formal.title.properties" 
                   use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="font-size">5pt</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="header.column.widths">1 2 1</xsl:param>
<xsl:param name="ulink.show" select="0"/>
<xsl:param name="draft.mode" select="'maybe'"/>
<xsl:param name="draft.watermark.image">resources/mandatory/draft.png</xsl:param>
<xsl:param name="paper.type" select="'A4'"/>
<xsl:param name="region.before.extent" select="'2cm'"/>
<xsl:param name="body.margin.top" select="'2.5cm'"/>
<xsl:param name="region.after.extent" select="'2cm'"/>
<xsl:param name="body.margin.bottom" select="'2.5cm'"/>
<xsl:param name="page.margin.inner" select="'1.0cm'"/>
<xsl:param name="page.margin.outer" select="'1.0cm'"/>

<xsl:template match="processing-instruction('hard-pagebreak')">
   <fo:block break-after='page'/>
</xsl:template>

 <xsl:attribute-set name="xref.properties">
    <xsl:attribute name="color">blue</xsl:attribute>
    <xsl:attribute name="text-decoration">underline</xsl:attribute>
</xsl:attribute-set>    

<xsl:attribute-set name="section.title.properties">
  <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">2em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">3em</xsl:attribute>
</xsl:attribute-set>


<xsl:template name="fo-external-image">
  <xsl:param name="filename"/>

  <xsl:choose>
    <xsl:when test="$fop.extensions != 0">
      <xsl:value-of select="$filename"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$filename"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="header.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
-->

  <fo:block>

    <!-- sequence can be odd, even, first, blank -->
    <!-- position can be left, center, right -->
    <xsl:choose>
      <xsl:when test="$sequence = 'blank'">
        <!-- nothing -->
      </xsl:when>

      <xsl:when test="$position='left'"> 
        <!-- Same for odd, even, empty, and blank sequences -->
           <fo:block>
            <xsl:call-template name="draft.text"/>
           </fo:block>
           <fo:block>
           <fo:external-graphic content-height="1.2cm">
              <xsl:attribute name="src">
              <xsl:call-template name="fo-external-image">
                  <xsl:with-param name="filename" select="'resources/mandatory/Company_Logo.jpg'" />
              </xsl:call-template>
              </xsl:attribute>
          </fo:external-graphic>  
          </fo:block>
      </xsl:when>

      <xsl:when test="($sequence='odd' or $sequence='even') and $position='center'">
        <fo:block>
         <fo:inline color="#FF0000">
             <xsl:value-of select="/d:book/d:info/d:legalnotice" />
         </fo:inline>
        </fo:block>  
        <fo:block>
            - <xsl:value-of select="/d:book/d:info/d:title" /> -
        </fo:block>  
        <xsl:if test="$pageclass != 'titlepage'">
          <xsl:choose>
            <xsl:when test="ancestor::d:book and ($double.sided != 0)">
              <fo:retrieve-marker retrieve-class-name="section.head.marker"
                                  retrieve-position="first-including-carryover"
                                  retrieve-boundary="page-sequence"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="." mode="titleabbrev.markup"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:when>

      <xsl:when test="$position='center'">
        <!-- nothing for empty and blank sequences -->     
        <fo:block>
         <fo:inline color="#FF0000">
             <xsl:value-of select="/d:book/d:info/d:legalnotice" />
         </fo:inline>
        </fo:block>    
        <fo:block>
            - <xsl:value-of select="/d:book/d:info/d:title" /> -
        </fo:block>  
      </xsl:when>

      <xsl:when test="$position='right'">
        <!-- Same for odd, even, empty, and blank sequences -->
           <fo:block>
            <xsl:call-template name="draft.text"/>
           </fo:block>
           <fo:block>
               <xsl:value-of select="/d:book/d:info/d:edition" />
           </fo:block>
      </xsl:when>

      <xsl:when test="$sequence = 'first'">
        <!-- nothing for first pages -->
      </xsl:when>

      <xsl:when test="$sequence = 'blank'">
        <!-- nothing for blank pages -->
      </xsl:when>
    </xsl:choose>
  </fo:block>
</xsl:template>

<xsl:template name="footer.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
-->

  <fo:block>
    <!-- pageclass can be front, body, back -->
    <!-- sequence can be odd, even, first, blank -->
    <!-- position can be left, center, right -->
    <xsl:choose>
      <xsl:when test="$pageclass = 'titlepage'">
        <!-- nop; no footer on title pages -->
      </xsl:when>

      <xsl:when test="$double.sided != 0 and $sequence = 'even'
                      and $position='left'">
        <fo:page-number/>
      </xsl:when>

      <xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
                      and $position='right'">
        <fo:page-number/>
      </xsl:when>

      <xsl:when test="$double.sided = 0 and $position='center'">
        <fo:page-number/>
      </xsl:when>

      <xsl:when test="$sequence='blank'">
        <xsl:choose>
          <xsl:when test="$double.sided != 0 and $position = 'left'">
            <fo:page-number/>
          </xsl:when>
          <xsl:when test="$double.sided = 0 and $position = 'center'">
            <fo:page-number/>
          </xsl:when>
          <xsl:otherwise>
            <!-- nop -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>


      <xsl:otherwise>
        <!-- nop -->
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>

<xsl:template match="emphasis[@role='bold-italic']">
    <fo:inline font-weight="bold" font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
</xsl:template>

<!-- Expand this template to add properties to any cell's block -->
<xsl:template name="table.cell.block.properties">
  <xsl:attribute name="font-size">5</xsl:attribute>
  <!-- highlight this entry? -->
  <xsl:choose>
    <xsl:when test="ancestor::d:thead or ancestor::d:tfoot">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:when>
    <!-- Make row headers bold too -->
    <xsl:when test="ancestor::d:tbody and 
                    (ancestor::d:table[@rowheader = 'firstcol'] or
                    ancestor::d:informaltable[@rowheader = 'firstcol']) and
                    ancestor-or-self::d:entry[1][count(preceding-sibling::d:entry) = 0]">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>  
