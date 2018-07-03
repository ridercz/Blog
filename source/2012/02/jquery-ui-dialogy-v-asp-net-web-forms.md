<!-- dcterms:identifier = aspnetcz#367 -->
<!-- dcterms:title = jQuery UI dialogy v ASP.NET Web Forms -->
<!-- dcterms:abstract = Doba si žádá své. Konkrétně dnešní doba si bohužel žádá "rich Internet applications", webové aplikace, které se chovají pokud možno tak, aby jako webové nevypadaly. Což zahrnuje i koncept v klasickém HTML obecně nevídaný, totiž virtuální okna realizovaná pomocí dynamického HTML a JavaScriptu. Knihovna jQuery UI nabízí nástroje pro práci s dialogy, ale pro bezchybnou spolupráci s ASP.NET Web Forms vyžadují trochu práce. Proto jsem připrvil v JavaScriptu rozšíření jQuery Dialog Helper, které se snaží tyto dva světy propojit. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-02-11T16:54:36.187+01:00 -->
<!-- dcterms:dateAccepted = 2012-02-11T16:55:00+01:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120211-jquery-ui-dialogy-v-asp-net-web-forms.png -->

Doba si žádá své. Konkrétně dnešní doba si bohužel žádá "rich Internet applications", webové aplikace, které se chovají pokud možno tak, aby jako webové nevypadaly. Což zahrnuje i koncept v klasickém HTML obecně nevídaný, totiž virtuální okna realizovaná pomocí dynamického HTML a JavaScriptu. Knihovna jQuery UI nabízí nástroje pro práci s dialogy, ale pro bezchybnou spolupráci s ASP.NET Web Forms vyžadují trochu práce. Proto jsem připrvil v JavaScriptu rozšíření jQuery Dialog Helper, které se snaží tyto dva světy propojit.

V čem spočívá jádro problému? jQuery UI předpokládá, že interakce s dialogem bude plně řízena JavaScriptem. Že třeba položky vyplnění v dialogu zase načteme skriptem a jím je také zpracujeme (a na server odešleme třeba JSON serializované pomocí nějakého callbacku). Pokud od začátku aplikaci píšete s tímto záměrem, je to v pořádku. Ale co když chcete jenom poněkud modernizovat stávající aplikaci a neumíte, nehodláte nebo nemůžete tento přístup použít? Moje pomocné rozšíření pro jQuery vychází z následujících ideových zásad:

*   Dialogy jsou design feature, jenom specifický způsob formátování na klientovi. Z hlediska serverové části aplikace neexistují, nevyžadují provádění žádných speciálních změn. 
*   Dialogy musejí být snadno lokalizovatelné, a to na serverové straně, pomocí standardních mechanismů, jako jsou resources. Skripty samy tedy nesmějí obsahovat žádné nezměnitelné zobrazované řetězce. 
*   Funkčnost stránky musí být zachována (byť třeba s menším komfortem), i když uživateli dialogy nebudou fungovat. Důvodem není ani tak podpora uživatelů, kteří mají JavaScript natvrdo vypnutý (takoví dnes již téměř vymřeli, protože se na dnešním Internetu daleko nedostanou), ale uživatelů, kterým JavaScript zrovna nějak nefunguje. Protože se třeba nějaký pomocný skript ještě nestáhl (nebo se nestáhl vůbec) atd. Vzhledem k tomu, že se často připojuji přes mobilní sítě, různé obskutní nespolehlivé WiFi a podobně, dokážu s takovými uživateli soucítit. 
*   Skript nesmí vyžadovat nějakou příliš rigidní strukturu HTML a musí být kompatibilní s kódem, který běžně generuje ASP.NET.  

Výše uvedené zásady umožní vestavět i dodatečně dialogy do klasických ASP.NET Web Forms aplikací, obvykle s nulovými zásahy do backendového kódu (C#/VB.NET…) a minimálními zásahy do front-endového kódu (ASPX). Výhodou je, že jejich implementace je snadná i pro uživatele, který nemá příliš hluboké znalosti JavaScriptu a nehodlá je získávat.

## Jak DialogHelper nasadit?

Postup je velmi jednoduchý. Vaše stránka musí referencovat [jQuery](http://www.jquery.com/), [jQuery UI](http://jqueryui.com/) a patřičný styl pro jQuery UI prvky (ten si můžete vytvořit třeba pomocí [ThemeRolleru](http://jqueryui.com/themeroller/)). Dále pak můj soubor `jquery.dialogHelper.js`, který je k mání na konci článku. 

Poté stačí jenom zavolat metodu `dialogHelper` a ona se postará o všechno sama. Patřičný jQuery kód je:

$(function () { // Activate dialog helper $(this).dialogHelper(); });

Aby dialogy ožily, stačí patřičným HTML elementům přidat různé `data-` atributy, které definuje HTML 5. Jejich názvy lze v případě potřeby změnit jiným overloadem metody `dialogHelper`, já nadále popisuji výchozí hodnoty. Data atributy jsou výborná novinka v HTML 5, která umožňuje rozšířit jakýkoliv HTML element o neomezené množství vlastních atributů, které jsou pak zpracovány skriptem. Mohou se jmenovat jakkoliv, jenom musejí začínat prefixem `data-`.

DialogHelper umí vytvářet tři druhy dialogů: informační, potvrzovací a obecné modální.

## Informační dialogy

Informační dialog je zpráva, která se zobrazí jako modální okno při načtení stránky a aby se uživatel dostal dál, musí stisknout OK nebo zmáčknout Enter. Typicky se jedná o různé formy potvrzení, že předchozí operace proběhla úspěšně. Pro její zobrazení stačí libovolnému elementu dát atribut `data-dialog-message`. Jeho hodnota se zobrazí jako titulek okna, obsah elementu se zobrazí jako obsah okna. Dialog bude zobrazen jako modální, bude mít automatickou velikost a bude mít jediné tlačítko "OK".

HTML markup může vypadat například takto:

<p data-dialog-message="Potvrzení">Vaše heslo bylo úspěšně změněno</p>

Obsah dialogu může být i komplexnější, i když se neočekává, že bude příliš interaktivní, ve smyslu formulářových prvků atd.:

<div data-dialog-message="Uživatel zastřelen"> <p><b>Uživatel byl úspěšně zastřelen.</b> Nyní zvažte následující kroky:</p> <ul> <li>Objednejte si někoho, kdo zlikviduje tělo.</li> <li>Pro jistotu si najděte <a href="http://www.cak.cz">dobrého advokáta</a>, kdyby se něco zvrtlo.</li> </ul> </div>

Data atributy můžete dávat i většině ASP.NET server controls, všechny prvky poděděné od `System.Web.UI.WebControls.WebControl` automaticky kopírují všechny neznámé serverové atributy beze změny na výstup. Můžete tedy použít například:

<asp:Label ID="LabelSuccess" runat="server" Text="Operace byla dokončena úspěšně" data-dialog-message="Potvrzení" />

Dialog helper poté prvek, tvořící dialog, skryje. Nebude tedy na stránce strašit navždy. Na druhou stranu, pokud volání skriptu selže, bude text zobrazen normálně, jako fallback.

## Potvrzovací dialogy

Potvrzovací dialog slouží k potvrzení nějaké akce, která je potenciálně nebezpečná, nevratná nebo jinak problematická. Typicky smazání záznamu a podobně. Z hlediska HTML je potvrzovanou akcí klepnutí na něco – typicky na formulářové tlačítko nebo hypertextový odkaz.

DialogHelper vyžaduje, aby potvrzovaný element měl atribut `data-dialog-confirm`, který obsahuje text potvrzovací zprávy. Například:

<a href="http://www.weblog.rider.cz/" data-confirm-prompt="Altairův blog není pro citlivé povahy. Opravdu chcete pokračovat?">Weblog</a>

V takovém případě se zobrazí okno, jehož titulek bude "Confirmation" a bude obsahovat tlačítka "Yes" a "No".

Pokud chcete tyto texty změnit, můžete použít další dva atributy. Atribut `data-confirm-title` umožní specifikovat titulek okna, zatímto `data-confirm-buttons` umožní změnit texty ma tlačítkách, přičemž první je potvrzovací, druhý stornující a jsou oddělené středníkem. Například:

<asp:Button runat="server" CommandName="Delete" data-confirm-prompt="Opravdu chcete záznam smazat?" data-confirm-title="Smazání záznamu" data-confirm-buttons="Ano;Ne" />

Pokud uživateli nefunguje skriptování, požadovaná operace se provede bez potvrzení.

## Obecné dialogy

Obecné dialogy slouží ke skrytí části stránky, dokud není dialog výslovně vyvolán. Například pokud budu mít na stránce seznam položek a zřídkavě používaný dialog pro přidání nové, mohu chtít dialog pro přidání nové položky schovat a zobrazit jenom ve chvíli, kdy si to uživatel vyžádá.

Tento dialog vyžaduje dva elementy: jeden (typicky odkaz, tlačítko) který vyvolává dialog a druhý, který jej obsahuje. Minimální implementace spočívá v tom, že se vyvolávacímu odkazu dá atribut data-dialog-open, jehož hodnotou je klientské ID elementu, který obsahuje dialog. Například:

<a href="#helpDialog" data-dialog-open="helpDialog">nápověda</a> ... <div id="helpDialog"> <h1>Nápověda</h1> ... </div>

Element dialogu (ve výše zmíněném příkladu to bude `div`) může obsahovat i dva další atributy:

*   `title` – standardní HTML atribut, pokud je specifikován, použije se jako titulek dialogu. 
*   `data-dialog-options` – seznam [nastavení dialogu](http://jqueryui.com/demos/dialog/), jako řetězce ve formátu "`název:hodnota`", oddělené středníkem. Lze tak nastavit jakékoliv vlastnosti, jaké jQuery UI dialog zná, typicky například rozměry.  

Následující příklad využívá rozšířené možnosti a zároveň ukazuje použití na straně ASP.NET Web Forms:

<a href="#newUserDialog" data-dialog-open="newUserDialog">nový uživatel</a> ... <asp:Panel ID="newUserDialog" runat="server" ClientIdMode="Static" title="Nový uživatel" data-dialog-options="minWidth:500;minHeight:400"> <asp:CreateUserWizard runat="server" /> </asp:Panel>

DialogHelper se postará o to, aby bylo možné formulář odeslat na server (jQuery dialogy standardně vyhodí z dokumentu a postback by nefungoval) a také všechna tlačítka (`input type="submit"`) skryje a znovu je vytvoří jako dialogová tlačítka se stejnou funkcí.

Pokud uživateli skripty nefungují, obsah dialogu se zobrazí přímo v původní stránce.

## Zdrojový kód

Kód mého pluginu je velmi přímočarý a JavaScriptoví programátoři by mu jistě dokázali ledacos vytknout, já to píšu jako C#. Nicméně vypadá to, že je docela dobře funkční, jakkoliv uvítám konstruktivní připomínky.

/// <reference path="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.1.min.js" /> /// <reference path="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.17/jquery-ui.min.js" /> (function ($) { $.fn.dialogHelper = function (options) { // Read settings var settings = $.extend({ dataDialogOpen: "dialog-open", dataDialogOptions: "dialog-options", dataDialogMessage: "dialog-message", dataConfirmPrompt: "confirm-prompt", dataConfirmTitle: "confirm-title", dataConfirmButtons: "confirm-buttons", dataConfirmDone: "confirm-done", confirmTitle: "Confirmation", confirmYes: "Yes", confirmNo: "No", showEffect: "clip", hideEffect: "clip" }, options); // Initialize general dialogs $("*[data-" + settings.dataDialogOpen + "]").each(function () { var dialogElement = $("#" + $(this).data(settings.dataDialogOpen)); // Create dialog dialogElement.dialog({ autoOpen: false, modal: true, show: settings.showEffect, hide: settings.hideEffect }); // Set dialog options if (dialogElement.data(settings.dataDialogOptions) != null) { var options = dialogElement.data(settings.dataDialogOptions).split(";"); for (var i = 0; i < options.length; i++) { var option = options[i].split(":"); dialogElement.dialog("option", option[0], option[1]); } } // Recreate all buttons as dialog buttons var buttons = []; $("input[type=submit]", dialogElement).each(function () { var button = $(this); button.hide(); buttons.push({ text: button.val(), click: function () { button.click() } }); }); if (buttons.length != 0) dialogElement.dialog("option", "buttons", buttons); // Move to <form runat=server> dialogElement.parent().appendTo($("form:first")); // Handle click $(this).click(function () { dialogElement.dialog("open"); return false; }); }); // Initialize message dialogs $("*[data-" + settings.dataDialogMessage + "]").each(function () { $(this).dialog({ modal: true, show: settings.showEffect, hide: settings.hideEffect, title: $(this).data(settings.dataDialogMessage), resizable: false, buttons: { OK: function () { $(this).dialog("close"); } } }); }); // Click confirmation $("*[data-" + settings.dataConfirmPrompt + "]").click(function () { var clickedObject = $(this); // Get href from this element or its children var href = clickedObject.attr("href"); if (href == null) href = clickedObject.children("*[href]").attr("href"); if (href && href.indexOf("javascript:") == 0) href = null; if (clickedObject.data(settings.dataConfirmDone) != true) { // Get button names var title = settings.confirmTitle; var buttonYes = settings.confirmYes; var buttonNo = settings.confirmNo; if (clickedObject.data(settings.dataConfirmTitle) != null) title = $(this).data(settings.dataConfirmTitle); if (clickedObject.data(settings.dataConfirmButtons) != null) { var buttonNames = $(this).data(settings.dataConfirmButtons).split(";"); buttonYes = buttonNames[0]; buttonNo = buttonNames[1]; } // Display jQuery UI confirmation dialog $("<div><p>" + clickedObject.data(settings.dataConfirmPrompt) + "</p></div>").dialog({ modal: true, show: settings.showEffect, hide: settings.hideEffect, resizable: false, title: title, buttons: [{ text: buttonYes, click: function () { $(this).dialog("close"); if (href) { window.location = href; } else { clickedObject.data(settings.dataConfirmDone, true); clickedObject.click(); } } }, { text: buttonNo, click: function () { $(this).dialog("close"); } }] }); clickedObject.data(settings.dataConfirmDone, false); } return clickedObject.data(settings.dataConfirmDone); }); } })(jQuery);