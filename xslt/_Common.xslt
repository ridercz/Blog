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

  <!-- Setup output -->
  <xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />

  <!-- Key indices -->
  <xsl:key name="serials" match="//x4w:serial" use="." />
  <xsl:key name="categories" match="//x4w:category" use="." />

  <!-- Common header  -->
  <xsl:template name="SiteHeader">
    <header>
      <div>
        <a href="/">
          <img src="/content/images/logo_onwhite.svg" alt="altair.blog" style="height:100px;" />
        </a>
      </div>
    </header>
  </xsl:template>

  <!-- Common footer -->
  <xsl:template name="SiteFooter">
    <footer>
      Footer
    </footer>
  </xsl:template>

  <!-- Document header -->
  <xsl:template name="PopulateHeader">
    <xsl:param name="Title" />
    <xsl:param name="Description" />

    <meta charset="utf-8"/>
    <xsl:if test="$Title != ''">
      <title>
        <xsl:value-of select="$Title" />
      </title>
    </xsl:if>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="cs-CZ" />
    <xsl:if test="$Description != ''">
      <meta name="Description" content="{$Description}"/>
    </xsl:if>
    <link rel="stylesheet" type="text/css" href="/content/styles.min.css" />
    <link rel="alternate" type="application/rss+xml" href="/feed.rss" title="RSS Feed" />
  </xsl:template>

  <!-- Link to article with detail -->
  <xsl:template name="ArticleLink">
    <xsl:param name="ShowCategories" select="1" />
    <xsl:param name="ShowSerials" select="1" />

    <article>
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
      </header>
      <xsl:if test="x4w:pictureUrl">
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
            <img src="{x4w:pictureUrl}" width="{x4w:pictureWidth}" height="{x4w:pictureHeight}" alt="" />
          </a>
        </aside>
      </xsl:if>
      <div>
        <xsl:value-of select="dcterms:abstract" />
      </div>
      <footer>
        <time datetime="{dcterms:dateAccepted}">
          <xsl:value-of select="x4h:FormatDateTime(dcterms:dateAccepted, 'D', 'cs-CZ') "/>
        </time>
        <xsl:if test="$ShowCategories = 1 and x4w:category">
          <ul class="categories">
            <xsl:for-each select="x4w:category">
              <li>
                <a href="/categories/{x4h:UrlKey(.)}">
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
                <a href="/serials/{x4h:UrlKey(.)}">
                  <xsl:value-of select="."/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:if>
      </footer>
    </article>
  </xsl:template>

  <!-- Pager interface -->
  <xsl:template name="Pager">
    <xsl:param name="PageNumber" />
    <xsl:param name="PageCount" />

    <!-- Previous page link -->
    <xsl:choose>
      <xsl:when test="$PageNumber = 1">
        <!-- Do not display prev on first page-->
      </xsl:when>
      <xsl:when test="$PageNumber = 2">
        <a href="./" rel="first">Novější</a>
      </xsl:when>
      <xsl:otherwise>
        <a href="./" rel="first">Nejnovější</a>
        <a href="{concat('./', $PageNumber - 1)}" rel="prev">Novější</a>
      </xsl:otherwise>
    </xsl:choose>

    <!-- NextPageLink -->
    <xsl:choose>
      <xsl:when test="$PageNumber = $PageCount">
        <!-- Do not display next on last page-->
      </xsl:when>
      <xsl:when test="$PageNumber = $PageCount - 1">
        <a href="{concat('./', $PageCount)}" rel="last">Starší</a>
      </xsl:when>
      <xsl:otherwise>
        <a href="{concat('./', $PageNumber + 1)}" rel="next">Starší</a>
        <a href="{concat('./', $PageCount)}" rel="last">Nejstarší</a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- List of serials -->
  <xsl:template name="ListSerials">
    <xsl:param name="ulClass" />

    <ul>
      <xsl:if test="$ulClass">
        <xsl:attribute name="class">
          <xsl:value-of select="$ulClass" />
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="//x4w:serial[generate-id() = generate-id(key('serials', .))]">
        <li>
          <a href="/serials/{x4h:UrlKey(.)}">
            <xsl:value-of select="."/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- List of categories -->
  <xsl:template name="ListCategories">
    <xsl:param name="ulClass" />

    <ul>
      <xsl:if test="$ulClass">
        <xsl:attribute name="class">
          <xsl:value-of select="$ulClass" />
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="//x4w:category[generate-id() = generate-id(key('categories', .))]">
        <li>
          <a href="/categories/{x4h:UrlKey(.)}">
            <xsl:value-of select="."/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

</xsl:stylesheet>
