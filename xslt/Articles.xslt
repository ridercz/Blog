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
      <xsl:for-each select="//page[not(x4w:alternateUrl) and dcterms:date]">
        <xsl:sort select="dcterms:date"/>
        <x4o:document href="{@path}.html">
          <html>
            <head>
              <xsl:call-template name="PopulateHeader">
                <xsl:with-param name="Title" select="dcterms:title" />
                <xsl:with-param name="Description" select="dcterms:abstract" />
                <xsl:with-param name="CanonicalUrl" select="@path" />
                <xsl:with-param name="Image" select="x4w:coverUrl" />
                <xsl:with-param name="Date" select="dcterms:date" />
              </xsl:call-template>
              <meta name="robots" content="index, follow" />
              <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/styles/default.min.css" integrity="sha512-hasIneQUHlh06VNBe7f6ZcHmeRTLIaQWFd43YriJ0UND19bvYRauxthDg8E4eVNPm9bRUhr5JGeqH7FRFXQu5g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
                  <div title="Autor">
                    <a href="https://www.rider.cz/">Michal Altair Valášek&#160;</a>
                    <i class="fal fa-user">&#8203;</i>
                  </div>
                  <xsl:if test="dcterms:date">
                    <div title="Datum vydání">
                      <time datetime="{dcterms:date}">
                        <xsl:value-of select="concat(x4h:FormatDateTime(dcterms:date, 'd. MMMM yyyy', 'cs-CZ'), '&#160;')"/>
                        <i class="fal fa-calendar-alt">&#8203;</i>
                      </time>
                    </div>
                  </xsl:if>
                  <xsl:if test="x4w:coverCredits">
                    <div title="Autor úvodního obrázku">
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
                  <xsl:variable name="GitHubHistoryUrl" select="concat('https://github.com/ridercz/Blog/commits/master/source', @path, '.md')" />
                  <header><i class="fab fa-github">&#8203;</i> Je v článku něco špatně? Chcete něco doplnit?</header>
                  <p>Komentáře zde nenajdete, ale pokud je v článku chyba nebo k němu chcete něco věcného doplnit, můžete na GitHubu <a href="{$GitHubIssueUrl}">otevřít nový issue</a> nebo <a href="{$GitHubEditUrl}">navrhnout změnu v textu</a> a poslat mi pull request.</p>
                  <p>Tamtéž také najdete <a href="{$GitHubHistoryUrl}">historii všech verzí článku</a>, pokud v něm byly provedeny nějaké změny či úpravy.</p>
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
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/highlight.min.js" integrity="sha512-IaaKO80nPNs5j+VLxd42eK/7sYuXQmr+fyywCNA0e+C6gtQnuCXNtORe9xR4LqGPz5U9VpH+ff41wKs/ZmC3iA==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/arduino.min.js" integrity="sha512-bOF+tbLNVPwsmPKbwZAJT2KD7J2soKGicZMV+iFZVyqD7qgZtpWOiY9+EmB+HyPgTP3Kah7K0aQVtX6mVK3sBg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/bash.min.js" integrity="sha512-yyMT1pQvQ9ZFAB8j/dUWeEjWTEQZBmV9pitXN7fmJYbqsoizQ0kVw8wONhrwBHE0Z/S8tKQyRcvbW4pG4m5cIw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/c.min.js" integrity="sha512-lzcjwENIEpri/9RQiWGJLxGxZ21Pr1qWvzEIpEa4yxPTSEderzTew+5Ff5XBbTC3OuLrb4P0qSwISoq1E/ddLg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/csharp.min.js" integrity="sha512-2S5x4UDJdymqDOBGIz88WSMwb/HC27t9gZyAus7RyUA2n3YXVJlYUrX606FkkU5+XrE+i12FNOhczUpPEh2XiQ==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/css.min.js" integrity="sha512-2EZCMzH/v5Q+9kXnio4UlG/iGM7Iy16NPjb4fFmtu501/gdvebqlP3sa2VvJsxnTJVWlFX8EN+BHxG4efqELWw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>¨
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/dos.min.js" integrity="sha512-4QYHD9PAHudNw8hYXd79O8t7BrFe2kl19eYIPAwdCxiJ7bYxERRpvS2VbFixd+kfLqVzUH9m1LBnmZlUf3VuAA==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/gcode.min.js" integrity="sha512-BIiAVlWdHwCcZSixwJwhoUJSVGaNtPXCDzcyR5AVlyzXS9FDies/go5012bSdZr15eCTZG4G42GqMSkIhKpSoQ==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/javascript.min.js" integrity="sha512-Z5vOg00atIeZ04QhYxz3iRlFnU5qnrB0eYbBDmXMhHqJYx4dc6n1KY5qzh3fEfrFzaR05D34mOin6ObjPjuWdA==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/json.min.js" integrity="sha512-WRejcYn/ITFLjqnYYgF3Es2b2dc3GnVc70wF3nO/G6uQtsN/LhxSlZp5y7E9JP3gqQ5gY/TPg9QdOlB3SY+ucQ==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/markdown.min.js" integrity="sha512-8YFObAd0dPoua15RGQBCDtnXMA4zJnAxaL4QSjgLLEKmJ1A2Aar7M1gamz2512/mKzx1ut96KNV7ggEV8WvRxg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/openscad.min.js" integrity="sha512-r7SipMjtLS3BxLiHtjRORcw8/sJDk6Ums0BwzuEMQoWe4hSKYQs3Zk2qClX3AwVw9lrTFIu3rTVcGgODqwBMww==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/scss.min.js" integrity="sha512-0U8Ud0Dh6EsQR0cokSx1hPYzG3i8AnfYEaDXNGi5rSsVJMdAaas/gif/b/8JrGsuuC7xl7dfBGHFgZrhWb39Bg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/sql.min.js" integrity="sha512-LxrbI3MKe/9KnjAs8zlLrZFRpp2J+jp0pML7zd6OAo/LHH8CEKM2Ef/jTfSX1gm8Auex3J5Jdj0rMkYejmMVMQ==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/languages/xml.min.js" integrity="sha512-2EQPABfCqv0Tr9AxzXh2U9DrbRre5g5H/BL7j/hGbES3mRjQ44bBks0I+2EoPbA4YzWHQ8BsVHNTaHr7t5RHKw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script>
                  hljs.initHighlightingOnLoad();
              </script>
            </body>
          </html>
        </x4o:document>
      </xsl:for-each>
    </x4o:root>
  </xsl:template>

</xsl:stylesheet>
