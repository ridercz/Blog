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

  <xsl:include href="_Common.xslt" />


  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="PopulateHeader">
          <xsl:with-param name="Title" select="'ALTAIR.blog'" />
          <xsl:with-param name="Description" select="'Osobní weblog Michala A. Valáška'" />
        </xsl:call-template>
      </head>
      <xsl:call-template name="SiteHeader" />
      <body>
        <section class="artlist">
          <xsl:for-each select="//file[dcterms:dateAccepted]">
            <xsl:sort select="dcterms:dateAccepted" order="descending" />
            <xsl:if test="position() &lt;= 5">
              <xsl:call-template name="ArticleLink" />
            </xsl:if>
          </xsl:for-each>
        </section>
        <xsl:call-template name="SiteFooter" />
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
