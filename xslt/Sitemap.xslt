<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:np9="http://schemas.altairis.cz/Nemesis/Publishing/9/"
                xmlns:x4w="http://schemas.altairis.cz/XML4web/PageMetadata/"
                xmlns:x4h="http://schemas.altairis.cz/XML4web/XsltHelper/"
                xmlns:x4o="http://schemas.altairis.cz/XML4web/OutputProcessor/"
                xmlns:x4c="http://schemas.altairis.cz/XML4web/Configuration/"
                xmlns:x4f="http://schemas.altairis.cz/XML4web/FileSystemInfo/"
                xmlns:void="http://tempuri.org/#void"
                exclude-result-prefixes="msxsl dcterms dc np9 x4w x4h x4o x4c x4f void">

  <xsl:output method="xml" encoding="utf-8" indent="yes" standalone="yes" omit-xml-declaration="no" version="1.0"/>

  <xsl:template match="/">
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
      <xsl:for-each select="//page[dcterms:date and not(x4w:alternateUrl)]">
        <xsl:sort select="dcterms:date" order="descending" />
        <url>
          <loc>
            <xsl:value-of select="concat('https://www.altair.blog', @path)" />
          </loc>
          <lastmod>
            <xsl:value-of select="dcterms:date"/>
          </lastmod>
        </url>
      </xsl:for-each>
    </urlset>
  </xsl:template>
</xsl:stylesheet>
