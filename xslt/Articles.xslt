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

  <xsl:template match="/">
    <x4o:root>
      <xsl:for-each select="//file[not(x4w:alternateUrl) and dcterms:dateAccepted]">
        <xsl:sort select="dcterms:dateAccepted"/>
        <x4o:document href="{@path}.html">
          <html>
            <head>
              <xsl:call-template name="PopulateHeader">
                <xsl:with-param name="Title" select="dcterms:title" />
                <xsl:with-param name="Description" select="dcterms:abstract" />
                <xsl:with-param name="CanonicalUrl" select="@path" />
                <xsl:with-param name="Image" select="x4w:coverUrl" />
              </xsl:call-template>
              <meta name="robots" content="index, follow" />
              <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/styles/default.min.css" integrity="sha256-Zd1icfZ72UBmsId/mUcagrmN7IN5Qkrvh75ICHIQVTk=" crossorigin="anonymous" />
            </head>
            <body>
            <xsl:if test="x4w:coverUrl">
              <xsl:attribute name="class">hascover</xsl:attribute>
              <xsl:attribute name="style">
                <xsl:value-of select="concat('background-image: url(', x4w:coverUrl, ')')" />
              </xsl:attribute>
            </xsl:if>
              <xsl:call-template name="SiteHeader" />
              <main>
                <h1>
                  <xsl:value-of select="dcterms:title"/>
                </h1>
                <aside class="article-info">
                  <xsl:if test="x4w:category">
                    <ul class="categories">
                      <xsl:for-each select="x4w:category">
                        <li>
                          <a href="/categories/{x4h:UrlKey(.)}" title="Rubrika">
                            <i class="fal fa-tag">&#8197;</i>
                            <xsl:value-of select="."/>
                          </a>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </xsl:if>
                  <xsl:if test="x4w:serial">
                    <ul class="serials">
                      <xsl:for-each select="x4w:serial">
                        <li>
                          <a href="/serials/{x4h:UrlKey(.)}" title="Seriál">
                            <i class="fal fa-list-alt">&#8197;</i>
                            <xsl:value-of select="."/>
                          </a>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </xsl:if>
                  <div>
                    <a href="https://www.rider.cz/">Michal Altair Valášek&#160;</a>
                    <i class="fal fa-user">&#8203;</i>
                  </div>
                  <xsl:if test="dcterms:dateAccepted">
                    <div>
                      <time datetime="{dcterms:dateAccepted}" title="Datum vydání">
                        <xsl:value-of select="concat(x4h:FormatDateTime(dcterms:dateAccepted, 'd. MMMM yyyy', 'cs-CZ'), '&#160;')"/>
                        <i class="fal fa-calendar-alt">&#8203;</i>
                      </time>
                    </div>
                  </xsl:if>
                  <xsl:if test="x4w:coverCredits">
                    <div>
                      <xsl:value-of select="concat(x4w:coverCredits, '&#160;')" />
                      <i class="fal fa-camera">&#8203;</i>
                    </div>
                  </xsl:if>
                </aside>
                <section class="article-text" x4o:unescape="true">
                  <xsl:value-of select="x4h:GetItemHtml(@path)" />
                </section>
                <section class="issues">
                  <xsl:variable name="GitHubIssueUrl" select="concat('https://github.com/ridercz/Blog/issues/new?title=', x4h:UrlEncode(dcterms:title), '&amp;body=https://www.altair.blog', @path)" />
                  <xsl:variable name="GitHubEditUrl" select="concat('https://github.com/ridercz/Blog/edit/master/source', @path, '.md')" />
                  <header><i class="fab fa-github">&#8203;</i> Je v článku něco špatně? Chcete něco doplnit?</header>
                  <p>Komentáře zde nenajdete, ale pokud je v článku chyba nebo k němu chcete něco věcného doplnit, můžete na GitHubu <a href="{$GitHubIssueUrl}">otevřít nový issue</a> nebo <a href="{$GitHubEditUrl}">navrhnout změnu v textu</a> a poslat mi pull request.</p>
                </section>
                <section class="sharing">
                  <span>Pošli to dál:</span>
                  <ul>
                    <li>
                      <a href="https://twitter.com/intent/tweet?text=https://www.altair.blog{@path}">
                        <i class="fab fa-twitter">&#8203;</i>
                      </a>
                    </li>
                    <li>
                      <a href="https://www.facebook.com/sharer.php?u=https://www.altair.blog{@path}">
                        <i class="fab fa-facebook-f">&#8203;</i>
                      </a>
                    </li>
                  </ul>
                </section>
              </main>
              <xsl:call-template name="SiteFooter" />
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/highlight.min.js" integrity="sha256-iq71rXEe/fvjCUP9AfLY0cKudQuKAQywiUpXkRFSkLc=" crossorigin="anonymous">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/languages/cs.min.js" integrity="sha256-0c0t9KjDyV5CegSIuGZ4cUhQNpb9azCZ1Jwa1NP1fi4=" crossorigin="anonymous">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/languages/dos.min.js" integrity="sha256-OuB37kcDbrBUDPztYhGMQaxM7zVP/wkW95uklhZCkqE=" crossorigin="anonymous">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/languages/markdown.min.js" integrity="sha256-QisUfMmh1ba2V0Kn8uxkMS1ShgsY1LyhrVNmit2llf4=" crossorigin="anonymous">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/languages/openscad.min.js" integrity="sha256-INIXLRdrhfM2ihtmmR1En9GjWUL7kwseGJUQVC0bN/Y=" crossorigin="anonymous">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/languages/powershell.min.js" integrity="sha256-cRUESDACI7Yr/eSmoHs6zDQu6HmpAkCp0s4xrZ9RnE0=" crossorigin="anonymous">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/languages/scss.min.js" integrity="sha256-/27cA5aA9DgzXPb747VxVTzwPG/X5tihoKySMSq3bwk=" crossorigin="anonymous">//</script>
              <script type="text/javascript">
                  hljs.initHighlightingOnLoad();
              </script>
            </body>
          </html>
        </x4o:document>
      </xsl:for-each>
    </x4o:root>
  </xsl:template>

</xsl:stylesheet>
