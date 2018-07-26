<!-- dcterms:identifier = aspnetcz#100 -->
<!-- dcterms:title = Jak programově odstranit stránku z output cache? -->
<!-- dcterms:abstract = Output cache, neboli ukládání vygenerovaného výstupu do mezipaměti, takže se při dalším požadavku stránka nevolá znovu, je výtečný vynález. Častým dotazem je, jak lze takto nacacheovanou položku z mezipaměti odstranit. Existují na to dvě metody. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-06-28T19:46:12.787+02:00 -->
<!-- dcterms:dateAccepted = 2006-06-28T19:46:12.787+02:00 -->


		<p>Output cache, neboli ukládání vygenerovaného výstupu do mezipaměti, takže se při dalším požadavku stránka nevolá znovu, je výtečný vynález. Častým dotazem je, jak lze takto nacacheovanou položku z mezipaměti odstranit. Existují na to dvě metody.</p>
		<h2>RemoveOutputCacheItem</h2>
		<p>Tato metoda přináleží třídě <em>HttpResponse</em> a odstraní z output cache položku s danou adresou. Dlužno přiznat, že mi nikdy moc k srdci nepřirostla.</p>
		<p>Adresa se uvádí jako "absolutní virtuální cesta", tedy cesta od rootu web serveru (nikoliv vaší aplikace). Tj. musíte si zjistit cestu k rootu vaší aplikace a poskládat URL.</p>
		<p>Tuto metodu nemůžete využít pro web user controls a nepodařilo se mi nijak vystopovat její chování pro více cacheovaných verzí stránky, např. podle parametru v URL.</p>
		<h2>Cache item dependency</h2>
		<p>Osobně dávám přednost jinému a velmi elegantnímu triku: jednotlivé položky v cache na sobě mohou být závislé. Při ukládání do cache tedy můžete svou stránku učinit závislou na nějaké jiné položce, jejíž název si zvolíte:</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">context.Response.ContentType = <span style="COLOR: maroon">"image/gif"</span>;</p>
				<p style="MARGIN: 0px">context.Response.AppendHeader(<span style="COLOR: maroon">"Content-Disposition"</span>, <span style="COLOR: maroon">"image; filename=\"icon.gif\""</span>);</p>
				<p style="MARGIN: 0px">context.Response.Cache.SetCacheability(<span style="COLOR: teal">HttpCacheability</span>.ServerAndPrivate);</p>
				<p style="MARGIN: 0px">context.Response.Cache.SetExpires(<span style="COLOR: teal">DateTime</span>.Now.AddHours(8));</p>
				<p style="MARGIN: 0px">context.Response.Cache.VaryByParams[<span style="COLOR: maroon">"MediaTypeId"</span>] = <span style="COLOR: blue">true</span>;</p>
				<p style="MARGIN: 0px">context.Response.AddCacheItemDependency(<span style="COLOR: maroon">"MediaTypeIconFlag"</span>);</p>
		</div>
		<!--EndFragment-->
		<p>Poté, v okamžiku kdy chcete takto závislé stránky z cache odstranit, stačí změnit hodnotu předmětné položky v cache:</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">Cache.Insert(<span style="COLOR: maroon">"MediaTypeIconFlag"</span>, <span style="COLOR: teal">DateTime</span>.Now, <span style="COLOR: blue">null</span>, System.Web.Caching.<span style="COLOR: teal">Cache</span>.NoAbsoluteExpiration, System.Web.Caching.<span style="COLOR: teal">Cache</span>.NoSlidingExpiration, System.Web.Caching.<span style="COLOR: teal">CacheItemPriority</span>.NotRemovable, <span style="COLOR: blue">null</span>);</p>
		</div>
		<!--EndFragment-->
		<p>Tento složitější zápis používám proto, aby mi server při nedostatku paměti můj "flag" neodstranil. Není to nezbytně nutné, ale pak může dojít k "řetězové reakci".</p>
		<p>Cacheování bylo též tématem včerejšího semináře konaného v Microsoftu, záznam z něho zpracovávám, až bude k dispozici, napíšu o něm zprávu na tento web.</p>
		<!--EndFragment-->
