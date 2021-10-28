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
      <xsl:for-each select="//page[not(x4w:alternateUrl) and dcterms:dateAccepted]">
        <xsl:sort select="dcterms:dateAccepted"/>
        <x4o:document href="{@path}.html">
          <html>
            <head>
              <xsl:call-template name="PopulateHeader">
                <xsl:with-param name="Title" select="dcterms:title" />
                <xsl:with-param name="Description" select="dcterms:abstract" />
                <xsl:with-param name="CanonicalUrl" select="@path" />
                <xsl:with-param name="Image" select="x4w:coverUrl" />
                <xsl:with-param name="Date" select="dcterms:dateAccepted" />
              </xsl:call-template>
              <meta name="robots" content="index, follow" />
              <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/styles/default.min.css" integrity="sha512-3xLMEigMNYLDJLAgaGlDSxpGykyb+nQnJBzbkQy2a0gyVKL2ZpNOPIj1rD8IPFaJbwAgId/atho1+LBpWu5DhA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
                  <xsl:if test="dcterms:dateAccepted">
                    <div title="Datum vydání">
                      <time datetime="{dcterms:dateAccepted}">
                        <xsl:value-of select="concat(x4h:FormatDateTime(dcterms:dateAccepted, 'd. MMMM yyyy', 'cs-CZ'), '&#160;')"/>
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
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/highlight.min.js" integrity="sha512-Pbb8o120v5/hN/a6LjF4N4Lxou+xYZ0QcVF8J6TWhBbHmctQWd8O6xTDmHpE/91OjPzCk4JRoiJsexHYg4SotQ==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/bash.min.js" integrity="sha512-HIFqAH4BgdlJE3A1Uoyl6weoDR1WtdufmKBPWtemvTI+12lrV5dfPR5ekvJaePkq6w+zuPAek2X2hHxo/T5kag==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/c.min.js" integrity="sha512-+2nEdmDIEQVBw4y3LD2BLOgAvX1+xx9kPQawjQB/HNfi4bDgSF4ywg8yIQ67ijrLLO2ruHaX9dZ25ruG3HwZSg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/cpp.min.js" integrity="sha512-OsjySiIaNsR3uFe7uEH6yht3is/WrIXKocWeO0YHFs25jOwHwMtzIdkUENQjblQihTUIN78bpnLKbhMxRegjLw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/csharp.min.js" integrity="sha512-v7mtZg9ySysViDE/8FxpWzLPe4Qzj+xQ//OqdMkl0UapomXAjp79QNiziv6PLmG5GSXjTcfCOzEBv5B/Rp6COg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/css.min.js" integrity="sha512-YPTikIv0LRFoecQ53pI2EkYJ6tPal8/Yt7wqs2pg9k/3dcBWNNBUTaXhmiP31cHJWLzw9lITxY/nPp008hEQ8g==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/dos.min.js" integrity="sha512-rSz72KBUqBNvTYerDKClwWXCnKh0KzaZuPZKBlBTXl0yfPAVwjFXXdKvBZXn5EE6SLDo8ZoGVUMjOamZFWUjiw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/gcode.min.js" integrity="sha512-LlfaoxE1AmrmFU1UquZMB1mjbkB/gRZrtSs/uunxKJtjB3lEz0D6Qk5XlstgpN5CGm0qxf3ZR6W1wjgYcEHcKw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/http.min.js" integrity="sha512-Skje8zLT7byYmzJt9b5tx61nBRk5OIq+Uc3W+DMb9kbQAiTPQmtYBLeHfRz6NMxXWMLRxPX6k9614xJJ06ywnA==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/ini.min.js" integrity="sha512-1kSQ/fL3452y9xKXX07vK6MlVabIIe93sVIwF2Hbz28FQ2k5cx4yp5g+OsYd9Ik4T8SxDTjI9CnHujU44xhgZw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/javascript.min.js" integrity="sha512-Jvh5kXa0Zu4HoSxPaZIVhCWPkD7b7gnWHVzv6jiaJwAJ18a/U6BOXludYfJYwHorpy2WFH0Df6EcFi5udu1dWA==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/markdown.min.js" integrity="sha512-LdAorkqTMw8zT1g38/JJ0ZAG5BMSKlueJOrfdgzkpb/Griqbi1TiKYAplo7Mha+8t7RzMdglwO4mxyxuTM+Afg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/nginx.min.js" integrity="sha512-y3Mryvd8MCT1x8PScKC/zmbJTai3P3H6+5WH1yPpCV3UzoI3dKum7qyTeB92e1qwKnhMWjfWkTEN1Okz5rvvWg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/openscad.min.js" integrity="sha512-Vty2aofH9rMWd1UD+/hwWokgM4tNJHM3jy4t7foAxULaoT46JVhe87D/p2yQeAto5jm7PDao6K0EJa7eI4GcWg==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/powershell.min.js" integrity="sha512-YuSWm92dJVnrfmPg7UEqLnCTUB2fjuHWW85wj9lB16S4pfJ6xGgkD0bg005VqOYgQXUkwILCLZxh4WxvJfvUhw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/scss.min.js" integrity="sha512-dN9nogHEDJR7Ci37xBwKkB1z//k/iBGM6gHtwKYCeEdGx395nIvwVcSLH2feCrkxhMFRgo8YydNHqyqD8OSOvQ==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/sql.min.js" integrity="sha512-dPGKIbhyiX3A5dkNqttabOo7ASCqbOHbTL2PdPKNrojC2CWx/uCAgpZpVkd0HK82vQsEfAWzy9+8Np07wxjiJw==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
              <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/languages/xml.min.js" integrity="sha512-1UdiK7+k2GhyGJMG9hmQXQ51TP2NPjHjh65uWhCeqSXSZ4UlzDG5+/st9VWRksKWYxKeU37/qwSAuPfSkcWD6A==" crossorigin="anonymous" referrerpolicy="no-referrer">//</script>
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
