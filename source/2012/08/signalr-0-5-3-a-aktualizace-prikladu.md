<!-- dcterms:identifier = aspnetcz#399 -->
<!-- dcterms:title = SignalR 0.5.3 a aktualizace příkladů -->
<!-- dcterms:abstract = Dnes vyšla aktualizace knihovny SignalR na verzi 0.5.3. Obsahuje několik užitečných věcí, takže jsem aktualizoval příklady ze své přednášky. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Programování -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2012-08-24T17:16:27.053+02:00 -->
<!-- dcterms:dateAccepted = 2012-08-24T17:00:00+02:00 -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20120824-signalr-0-5-3-a-aktualizace-prikladu.png -->

Dnes vyšla aktualizace knihovny [SignalR](http://www.signalr.net) na verzi 0.5.3. Kompletní přehled novinek najdete na [blogu web tools týmu](http://blogs.msdn.com/b/webdev/archive/2012/08/22/announcing-the-release-of-signalr-0-5-3.aspx). Kromě odstranění několika chyb bylo přidáno lepší ošetření výjimek a poněkud změněn způsob práce s huby v jQuery klientovi. 

Původní způsob zůstává nadále funkční, ale přibyl nový, který je podobnější přístupu v C# klientovi. Tedy místo přímého přidávání metod lze odchytávat metodu "on" a pověsit na ni patřičný event handler. Mně se tento nový přístup líbí více, přijde mi "systematičtější". Je také pro C# programátora jednodušší na naučení, a navíc kód pro klientskou a serverovou stranu je velmi podobný.

Takto v nové verzi vypadá kód v C# klientovi:

    // Create SignalR hub
    var connection = new HubConnection(BASE_URL);
    var proxy = connection.CreateProxy("authChat");

    // Handle events
    proxy.On("userJoined", (string time, string userName) => {
        Console.WriteLine("[{0}] User {1} connected to chat", time, userName);
    });

    // Connect to server
    Console.Write("Starting connection...");
    connection.Start().Wait();
    Console.WriteLine("OK");

    // Authenticate
    Console.Write("Authenticating...");
    proxy.Invoke("authenticate", authCode).Wait();
    Console.WriteLine("OK");

Kód v JavaScriptu je prakticky tentýž:

    // Create connection and hub proxy
    var connection = $.hubConnection();
    var proxy = connection.createProxy("authChat");

    // Handle event
    proxy.on("userJoined", function (time, userName) {
        var html = FormatString("<div><span>[{time}]</span> <i>User {userName} connected to chat.</i></div>", {
            time: time,
            userName: userName
        });
        $(".chat").html(html + $(".chat").html());
    });

    // Connect to service and authenticate
    connection.start(function () {
        $(".chat").text("Authenticating...");
        proxy.invoke("authenticate", authCode);
    });

Přepsal jsem poslední příklad ze své [přednášky o SignalR](http://www.aspnet.cz/articles/396-signalr-realtime-web-v-asp-net) do nové syntaxe (a trochu vylepšil command line klienta), takže můžete obě řešení porovnat, nové příklady jsou ke stažení [zde](http://www.cdn.altairis.cz/Prednasky/20120824-signalr-0.5.3.zip).