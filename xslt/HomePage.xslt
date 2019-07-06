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

  <xsl:param name="x4c:PageSize" />

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="PopulateHeader">
          <xsl:with-param name="Description" select="'Osobní weblog Michala A. Valáška'" />
        </xsl:call-template>
        <meta name="robots" content="index, follow" />
      </head>
      <body>
        <xsl:call-template name="SiteHeader" />
        <main>
          <p>Články na různá témata píšu už čtvrt století a vlastní blog mám už patnáct let. Poslední dobou se mi ale moje psaní vymklo z rukou. Píšu sice celkem dost, ale mé vlastní weby z toho nic nemají, protože píšu pro jiné. Rozhodl jsem se proto své psací projekty (ASPNET.CZ a osobní weblog) sloučit a přidat i odkazy na to, co píšu jinde.</p>
          <p>
            Tento web by mohl mít podtitul <em>všechno co napíšu</em>, protože sem budu dávat všechny své publikované texty - buďto přímo nebo alespoň jako odkazy.
          </p>
          <p style="text-align:right">
            <a href="https://www.rider.cz/">Michal Altair Valášek</a>
          </p>
          <section class="artlist hlfirst">
            <xsl:for-each select="//page[dcterms:dateAccepted]">
              <xsl:sort select="dcterms:dateAccepted" order="descending" />
              <xsl:if test="position() &lt;= $x4c:PageSize">
                <xsl:call-template name="ArticleLink" />
              </xsl:if>
            </xsl:for-each>
            <footer>
              <a href="/archive/2">
                <i class="fal fa-archive">&#8197;</i>
                Starší články najdete v archivu
              </a>
            </footer>
          </section>
        </main>
        <xsl:call-template name="SiteFooter" />
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
