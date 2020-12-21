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

  <!-- Setup output -->
  <xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />

  <!-- Variables -->
  <xsl:variable name="BaseUrl" select="'https://www.altair.blog'" />

  <!-- Key indices -->
  <xsl:key name="serials" match="//x4w:serial" use="." />
  <xsl:key name="categories" match="//x4w:category" use="." />

  <!-- Common header  -->
  <xsl:template name="SiteHeader">
    <header>
      <div>
        <a href="/">
          <img src="/content/images/logo_onblack.svg" alt="altair.blog" style="max-height:100px;max-width:80%" />
        </a>
      </div>
    </header>
    <nav>
      <ul>
        <li>
          <a href="https://www.rider.cz/" title="Autor: Michal Altair Valášek">
            <i class="fal fa-fw fa-user">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="/archive" title="Archiv článků">
            <i class="fal fa-fw fa-archive">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="/categories" title="Rubriky">
            <i class="fal fa-fw fa-tags">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="/serials" title="Seriály">
            <i class="fal fa-fw fa-list-alt">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="/search" title="Vyhledávání">
            <i class="fal fa-fw fa-search">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="https://www.rider.cz/#contact" title="Kontakt">
            <i class="fal fa-fw fa-envelope">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="https://facebook.com/rider.cz" title="Facebook">
            <i class="fab fa-fw fa-facebook">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="https://twitter.com/ridercz" title="Twitter">
            <i class="fab fa-twitter">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="https://github.com/ridercz" title="Github">
            <i class="fab fa-fw fa-github">&#8197;</i>
          </a>
        </li>
        <li>
          <a href="https://ask.fm/ridercz" title="Ask.fm">
            <i class="fal fa-fw fa-question">&#8197;</i>
          </a>
        </li>
      </ul>
    </nav>
  </xsl:template>

  <!-- Common footer -->
  <xsl:template name="SiteFooter">
    <footer>
      <ul class="logos">
        <li>
          <img src="/content/images/logo_onwhite.svg" alt="altair.blog" style="height:38px;" />
        </li>
      </ul>
      <ul class="text">
        <li>
          Copyright &#0169; <a href="https://www.rider.cz/">Michal Altair Valášek</a>, 2003-<xsl:value-of select="x4h:FormatDateTime(x4h:CurrentDateTime(), 'yyyy', 'cs-CZ')"/>
        </li>
        <li>
          Powered by <a href="https://www.xml4web.com/">XML4web</a> on <a href="https://www.github.com/">GitHub Pages</a>
        </li>
        <li>
          <i class="fal fa-rss">&#8203;</i> RSS: <a href="/feed.rss">všechno</a> | <a href="/feed-internal.rss">místní</a> | <a href="/feed-external.rss">odkazy</a>
        </li>
      </ul>
    </footer>
  </xsl:template>

  <!-- Document header -->
  <xsl:template name="PopulateHeader">
    <xsl:param name="Title" />
    <xsl:param name="Description" />
    <xsl:param name="CanonicalUrl" select="'/'" />
    <xsl:param name="Image" />
    <xsl:param name="Date" />

    <meta charset="utf-8"/>
    <xsl:choose>
      <xsl:when test="$Title = ''">
        <title>ALTAIR.blog</title>
      </xsl:when>
      <xsl:otherwise>
        <title>
          <xsl:value-of select="concat($Title, ' | ALTAIR.blog')" />
        </title>
      </xsl:otherwise>
    </xsl:choose>
    <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="cs-CZ" />
    <link rel="canonical" href="{$BaseUrl}{$CanonicalUrl}" />
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/firacode/5.2.0/fira_code.css" integrity="sha512-LaxQmGd9k/pW51CsEy2nLIlbUXCgsyvUEVT5fSguN2b2OBwHjMi2aiUdEEXSMg8Jvy+bCB01as61aNrHnL2DYQ==" crossorigin="anonymous" />
    <link rel="stylesheet" type="text/css" href="/content/styles.min.css?sha={x4h:ComputeHash('/content/styles.min.css')}" />
    <link rel="stylesheet" type="text/css" href="/content/fa-5.13.1/css/all.min.css" />
    <!-- RSS -->
    <link rel="alternate" type="application/rss+xml" href="{$BaseUrl}/feed.rss" title="RSS (všechny články)" />
    <link rel="alternate" type="application/rss+xml" href="{$BaseUrl}/feed-internal.rss" title="RSS (pouze místní články)" />
    <link rel="alternate" type="application/rss+xml" href="{$BaseUrl}/feed-external.rss" title="RSS (pouze odkazy)" />
    <!-- Favicon -->
    <link rel="shortcut icon" href="{$BaseUrl}/favicon.ico" />
    <link rel="icon" href="{$BaseUrl}/favicon.ico" />
    <!-- Twitter-->
    <meta name="twitter:card" content="summary" />
    <meta name="twitter:site" content="@ridercz" />
    <meta name="twitter:title" content="{$Title}" />
    <meta name="twitter:description" content="{$Description}" />
    <xsl:choose>
      <xsl:when test="$Image">
        <meta name="twitter:image" content="{$BaseUrl}{$Image}" />
      </xsl:when>
      <xsl:otherwise>
        <meta name="twitter:image" content="{$BaseUrl}/content/images/preview-1200.jpg" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$Date">
      <meta property="article:published_time" content="{$Date}" />
    </xsl:if>
    <!-- Facebook-->
    <meta property="og:type" content="article" />
    <meta property="og:site_name" content="ALTAIR.blog" />
    <meta name="author" content="Michal Altair Valášek" />
    <meta name="title" property="og:title" content="{$Title}" />
    <meta name="description" property="og:description" content="{$Description}" />
    <xsl:choose>
      <xsl:when test="$Image">
        <meta name="image" property="og:image" content="{$BaseUrl}{$Image}" />
      </xsl:when>
      <xsl:otherwise>
        <meta name="image" property="og:image" content="{$BaseUrl}/content/images/preview-1200.jpg" />
      </xsl:otherwise>
    </xsl:choose>
    <meta property="og:locale" content="cs_CZ" />
    <meta property="og:url" content="{$BaseUrl}{$CanonicalUrl}" />
    <!-- Fathom - https://github.com/usefathom/fathom -->
    <script>
      (function(f, a, t, h, o, m){
        a[h]=a[h]||function(){
          (a[h].q=a[h].q||[]).push(arguments)
        };
        o=f.createElement('script'),
        m=f.getElementsByTagName('script')[0];
        o.async=1; o.src=t; o.id='fathom-script';
        m.parentNode.insertBefore(o,m)
      })(document, window, '//stats.altair.blog/tracker.js', 'fathom');
      fathom('set', 'siteId', 'OBOTR');
      fathom('trackPageview');
    </script>
    <!-- Typo autocorrect - https://github.com/pavelglac/Automaticka-uprava-typografie -->
    <script src="/content/scripts/autocorrect.js" defer="defer" onload="typo.runAutoCorrector()">//</script>
  </xsl:template>

  <!-- Link to article with detail -->
  <xsl:template name="ArticleLink">
    <xsl:param name="ShowCategories" select="1" />
    <xsl:param name="ShowSerials" select="1" />

    <article>
      <xsl:if test="x4w:pictureUrl">
        <xsl:attribute name="class">haspicture</xsl:attribute>
        <aside>
          <a>
            <xsl:attribute name="href">
              <xsl:choose>
                <xsl:when test="x4w:alternateUrl">
                  <xsl:value-of select="x4w:alternateUrl"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@path"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <img src="{x4w:pictureUrl}" width="{x4w:pictureWidth}" height="{x4w:pictureHeight}" alt="" title="{x4w:pictureCredits}" />
          </a>
        </aside>
      </xsl:if>
      <header>
        <a>
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="x4w:alternateUrl">
                <xsl:value-of select="x4w:alternateUrl"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@path"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:value-of select="dcterms:title" />
        </a>
        <xsl:if test="x4w:alternateUrl">
          <sup title="Odkaz na můj článek jinde">
            <i class="fal fa-external-link">&#8197;</i>
          </sup>
        </xsl:if>
      </header>
      <div>
        <xsl:value-of select="dcterms:abstract" />
      </div>
      <footer>
        <time datetime="{dcterms:dateAccepted}" title="Datum vydání">
          <i class="fal fa-calendar-alt">&#8197;</i>
          <xsl:value-of select="x4h:FormatDateTime(dcterms:dateAccepted, 'D', 'cs-CZ') "/>
        </time>
        <xsl:if test="$ShowCategories = 1 and x4w:category">
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
        <xsl:if test="$ShowSerials= 1 and x4w:serial">
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
      </footer>
      <div class="clear"><!----></div>
    </article>
  </xsl:template>

  <!-- Pager interface -->
  <xsl:template name="Pager">
    <xsl:param name="UrlPrefix" />
    <xsl:param name="PageNumber" />
    <xsl:param name="PageCount" />

    <!-- Previous page links -->
    <xsl:choose>
      <xsl:when test="$PageNumber = 1">
        <!-- Do not display prev on first page-->
      </xsl:when>
      <xsl:when test="$PageNumber = 2">
        <span class="prev">
          <a href="{$UrlPrefix}" rel="first">
            <i class="fal fa-chevron-left">&#8203;</i>&#160;Novější
          </a>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span class="prev">
          <a href="{$UrlPrefix}" rel="first">
            <i class="fal fa-chevron-double-left">&#8203;</i>&#160;Nejnovější
          </a>
          <a href="{concat($UrlPrefix, '/', $PageNumber - 1)}" rel="prev">
            <i class="fal fa-chevron-left">&#8203;</i>&#160;Novější
          </a>
        </span>
      </xsl:otherwise>
    </xsl:choose>

    <!-- Next page links -->
    <xsl:choose>
      <xsl:when test="$PageNumber = $PageCount">
        <!-- Do not display next on last page-->
      </xsl:when>
      <xsl:when test="$PageNumber = $PageCount - 1">
        <span class="next">
          <a href="{concat($UrlPrefix, '/', $PageCount)}" rel="last">
            Starší&#160;<i class="fal fa-chevron-right">&#8203;</i>
          </a>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span class="next">
          <a href="{concat($UrlPrefix, '/', $PageNumber + 1)}" rel="next">
            Starší&#160;<i class="fal fa-chevron-right">&#8203;</i>
          </a>
          <a href="{concat($UrlPrefix, '/', $PageCount)}" rel="last">
            Nejstarší&#160;<i class="fal fa-chevron-double-right">&#8203;</i>
          </a>
        </span>
      </xsl:otherwise>
    </xsl:choose>

    <!-- Paging information -->
    <span class="info">
      <xsl:value-of select="concat($PageNumber, ' / ', $PageCount)"/>
    </span>
  </xsl:template>

  <!-- List of serials -->
  <xsl:template name="ListSerials">
    <xsl:param name="UlClass" />
    <xsl:param name="EmitUl" select="1" />

    <xsl:choose>
      <xsl:when test="$EmitUl = 1">
        <ul>
          <xsl:call-template name="ListSerials">
            <xsl:with-param name="UlClass" select="$UlClass"/>
            <xsl:with-param name="EmitUl" select="0"/>
          </xsl:call-template>
        </ul>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$UlClass">
          <xsl:attribute name="class">
            <xsl:value-of select="$UlClass" />
          </xsl:attribute>
        </xsl:if>
        <xsl:for-each select="//x4w:serial[generate-id() = generate-id(key('serials', .))]">
          <xsl:sort select="." />
          <xsl:variable name="Value" select="." />
          <li>
            <a href="/serials/{x4h:UrlKey(.)}">
              <xsl:value-of select="."/>
            </a>
            <span>
              <xsl:value-of select="concat('(', count(//page[x4w:serial = $Value and dcterms:dateAccepted]), ')')"/>
            </span>
          </li>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- List of categories -->
  <xsl:template name="ListCategories">
    <xsl:param name="UlClass" />
    <xsl:param name="EmitUl" select="1" />

    <xsl:choose>
      <xsl:when test="$EmitUl = 1">
        <ul>
          <xsl:call-template name="ListCategories">
            <xsl:with-param name="UlClass" select="$UlClass"/>
            <xsl:with-param name="EmitUl" select="0"/>
          </xsl:call-template>
        </ul>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$UlClass">
          <xsl:attribute name="class">
            <xsl:value-of select="$UlClass" />
          </xsl:attribute>
        </xsl:if>
        <xsl:for-each select="//x4w:category[generate-id() = generate-id(key('categories', .))]">
          <xsl:sort select="." />
          <xsl:variable name="Value" select="." />
          <li>
            <a href="/categories/{x4h:UrlKey(.)}">
              <xsl:value-of select="."/>
            </a>
            <span>
              <xsl:value-of select="concat('(', count(//page[x4w:category = $Value and dcterms:dateAccepted]), ')')"/>
            </span>
          </li>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
