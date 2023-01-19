<!-- dcterms:title = NGROK: Užitečný nástroj pro dočasné zpřístupnění localhostu z Internetu -->
<!-- dcterms:abstract = Aplikace úspěšně běží na localhostu ve vývojovém serveru. Ale je třeba ji otestovat z mobilu, nebo ukázat někomu zvenčí. Jak to udělat, aniž byste museli aplikaci nasazovat na hosting nebo složitě nastavovat forwardování portů z Internetu, což někdy není možné? Od toho je tady služba NGrok.  -->
<!-- x4w:category = IT -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:date = 2022-03-31 -->
<!-- x4w:coverUrl = /cover-pictures/20220331-ngrok.jpg -->
<!-- x4w:pictureUrl = /perex-pictures/20220331-ngrok.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->

Aplikace úspěšně běží na localhostu ve vývojovém serveru. Ale je třeba ji otestovat z mobilu, nebo ukázat někomu zvenčí. Jak to udělat, aniž byste museli aplikaci nasazovat na hosting nebo složitě nastavovat forwardování portů z Internetu, což někdy není možné? Od toho je tady služba NGrok. 

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/ykensGvcNc0" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

V té nejjednodušší podobě stačí bezplatná registrace a stažení jednoho EXE souboru bez dalších závislostí. NGrok udělá z vašeho počítače tunel a vygeneruje náhodnou HTTP a HTTPS adresu, na které bude váš lokálně běžící web dostupný z Internetu. Tuto adresu pak můžete poslat například klientovi kterému chcete něco ukázat nebo si ji zobrazit z mobilního zařízení, abyste si vyzkoušeli, jak vám to funguje na mobilu. Zároveň na adrese `http://localhost:4040/` vidíte všechny požadavky, které aplikací prošly.

Placené tarify umějí mnohem víc. Například používat vlastní domény, mít persistentní tunely, publikovat nejenom HTTP ale i obecné síťové porty a další.