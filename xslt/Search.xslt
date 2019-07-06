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
    <html>
      <head>
        <xsl:call-template name="PopulateHeader">
          <xsl:with-param name="Title" select="'Vyhledávání'" />
          <xsl:with-param name="Description" select="'Osobní weblog Michala A. Valáška'" />
          <xsl:with-param name="CanonicalUrl" select="'/search'" />
        </xsl:call-template>
        <meta name="robots" content="index, follow" />
      </head>
      <body>
        <xsl:call-template name="SiteHeader" />
        <main>
          <h1>Vyhledávání</h1>
          <div class="gcse-searchbox" data-personalizedAds="false" data-safeSearch="off">&#8197;</div>
          <div class="gcse-searchresults">Vyhledávání používá Google Custom Search. Pokud vidíte tento text, pravděpodobně vám ho blokuje nějaký doplněk prohlížeče.</div>
          <script>
            (function () {
            var cx = '008719556634765943184:sgxqsp1qwmm';
            var gcse = document.createElement('script');
            gcse.type = 'text/javascript';
            gcse.async = true;
            gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(gcse, s);
            })();
          </script>
        </main>
        <xsl:call-template name="SiteFooter" />
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
