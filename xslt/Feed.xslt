<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:np9="http://schemas.altairis.cz/Nemesis/Publishing/9/"
                xmlns:x4w="http://schemas.altairis.cz/XML4web/PageMetadata/"
                xmlns:x4h="http://schemas.altairis.cz/XML4web/XsltHelper/"
                xmlns:x4c="http://schemas.altairis.cz/XML4web/Configuration/"
                xmlns:void="http://tempuri.org/#void"
                exclude-result-prefixes="msxsl dcterms dc np9 x4w x4h x4c void">

  <xsl:output method="xml" encoding="utf-8" indent="yes" standalone="yes" omit-xml-declaration="no" version="1.0"/>

  <xsl:template match="/">
    <rss version="2.0">
      <channel>
        <title>ALTAIR.blog</title>
        <link>https://www.altair.blog/</link>
        <description>Weblog Michala A. Valáška</description>
        <language>cs-CZ</language>
        <xsl:for-each select="//file[dcterms:dateAccepted]">
          <xsl:sort select="dcterms:dateAccepted" order="descending" />
          <xsl:if test="position() &lt;= 15">
            <item>
              <guid isPermaLink="true">
                <xsl:choose>
                  <xsl:when test="x4w:alternateUrl">
                    <xsl:value-of select="x4w:alternateUrl"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat('https://www.altair.blog', @path)" />
                  </xsl:otherwise>
                </xsl:choose>
              </guid>
              <title>
                <xsl:value-of select="dcterms:title"/>
              </title>
              <description>
                <xsl:value-of select="dcterms:description"/>
              </description>
              <link>
                <xsl:choose>
                  <xsl:when test="x4w:alternateUrl">
                    <xsl:value-of select="x4w:alternateUrl"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat('https://www.altair.blog', @path)" />
                  </xsl:otherwise>
                </xsl:choose>
              </link>
              <xsl:for-each select="dcterms:creator">
                <author>
                  <xsl:value-of select="."/>
                </author>
              </xsl:for-each>
              <xsl:for-each select="x4w:category">
                <category>
                  <xsl:value-of select="."/>
                </category>
              </xsl:for-each>
              <pubDate>
                <xsl:value-of select="x4h:FormatDateTime(dcterms:dateAccepted, 's', 'cs-CZ')"/>
              </pubDate>
            </item>
          </xsl:if>
        </xsl:for-each>
      </channel>
    </rss>
  </xsl:template>
</xsl:stylesheet>
