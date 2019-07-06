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

  <xsl:include href="_Common.xslt" />

  <xsl:template match="/">
    <x4o:root>
      <!-- Generate list of serials -->
      <x4o:document href="/serials/index.html">
        <html>
          <head>
            <xsl:call-template name="PopulateHeader">
              <xsl:with-param name="Title" select="'Seriály'" />
              <xsl:with-param name="Description" select="'Osobní weblog Michala A. Valáška'" />
              <xsl:with-param name="CanonicalUrl" select="'/serials'" />
            </xsl:call-template>
            <meta name="robots" content="index, follow" />
          </head>
          <body>
            <xsl:call-template name="SiteHeader" />
            <main>
              <h1>Seriály</h1>
              <xsl:call-template name="ListSerials" />
            </main>
            <xsl:call-template name="SiteFooter" />
          </body>
        </html>
      </x4o:document>

      <!-- Generate serial pages  -->
      <xsl:for-each select="//x4w:serial[generate-id() = generate-id(key('serials', .))]">
        <xsl:call-template name="Page">
          <xsl:with-param name="Serial" select="."/>
        </xsl:call-template>
      </xsl:for-each>
    </x4o:root>

  </xsl:template>

  <xsl:template name="Page">
    <xsl:param name="Serial" />

    <x4o:document href="/serials/{x4h:UrlKey($Serial)}.html">
      <html>
        <head>
          <xsl:call-template name="PopulateHeader">
            <xsl:with-param name="Title" select="concat('Seriál ', $Serial)" />
            <xsl:with-param name="Description" select="'Osobní weblog Michala A. Valáška'" />
            <xsl:with-param name="CanonicalUrl" select="concat('/serials/', x4h:UrlKey($Serial))" />
          </xsl:call-template>
        <meta name="robots" content="noindex, follow" />
        </head>
        <body>
          <xsl:call-template name="SiteHeader" />
          <main>
            <h1>
              <xsl:value-of select="concat('Seriál ', $Serial)"/>
            </h1>
            <section class="artlist">
              <xsl:for-each select="//page[x4w:serial = $Serial and dcterms:dateAccepted]">
                <xsl:sort select="dcterms:dateAccepted" />
                <xsl:call-template name="ArticleLink" >
                  <xsl:with-param name="ShowSerials" select="0" />
                </xsl:call-template>
              </xsl:for-each>
            </section>
          </main>
          <xsl:call-template name="SiteFooter" />
        </body>
      </html>
    </x4o:document>
  </xsl:template>

</xsl:stylesheet>
