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
                xmlns:x4o="http://schemas.altairis.cz/XML4web/OutputProcessor/"
                xmlns:void="http://tempuri.org/#void"
                exclude-result-prefixes="msxsl dcterms dc np9 x4w x4h x4c void">

  <xsl:include href="_Common.xslt" />

  <xsl:param name="x4c:PageSize" />

  <xsl:variable name="ArticleCount" select="count(//file[dcterms:dateAccepted])" />
  <xsl:variable name="PageCount" select="ceiling($ArticleCount div $x4c:PageSize)" />

  <xsl:template match="/">
    <x4o:root>
      <xsl:call-template name="Page" />
    </x4o:root>
  </xsl:template>

  <xsl:template name="Page">
    <xsl:param name="PageNumber" select="1" />

    <x4o:document>
      <xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="$PageNumber = 1">archive/index.html</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('archive/', $PageNumber, '.html')" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:variable name="FromPosition" select="($PageNumber - 1) * $x4c:PageSize + 1" />
      <xsl:variable name="ToPosition" select="$FromPosition + $x4c:PageSize - 1" />
      <html>
        <head>
          <xsl:call-template name="PopulateHeader">
            <xsl:with-param name="Title" select="'Archiv článků'" />
            <xsl:with-param name="Description" select="'Osobní weblog Michala A. Valáška'" />
          </xsl:call-template>
          <meta name="robots" content="noindex, follow" />
        </head>
        <body>
          <xsl:call-template name="SiteHeader" />
          <main>
            <h1>Archiv článků</h1>
            <section class="artlist">
              <xsl:for-each select="//file[dcterms:dateAccepted]">
                <xsl:sort select="dcterms:dateAccepted" order="descending" />
                <xsl:if test="position() &gt;= $FromPosition and position() &lt;= $ToPosition">
                  <xsl:call-template name="ArticleLink" />
                </xsl:if>
              </xsl:for-each>
              <footer>
                <xsl:call-template name="Pager">
                  <xsl:with-param name="PageNumber" select="$PageNumber" />
                  <xsl:with-param name="PageCount" select="$PageCount" />
                </xsl:call-template>
              </footer>
            </section>
          </main>
          <xsl:call-template name="SiteFooter" />
        </body>
      </html>
    </x4o:document>

    <xsl:if test="$PageNumber &lt; $PageCount">
      <xsl:call-template name="Page">
        <xsl:with-param name="PageNumber" select="$PageNumber + 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
