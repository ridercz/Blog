<!-- dcterms:identifier = aspnetcz#326 -->
<!-- dcterms:title = Použití obrázků a skriptů v ASP.NET server controls -->
<!-- dcterms:abstract = Při tvorbě webových komponent často potřebujeme mít k dispozici jistá externí data, jako například obrázky, skripty, CSS stylesheety a podobně. Nepochybně je můžete přibalit ke své knihovně a požadovat, aby byly nakopírovány na patřičná místa cílové aplikace, ale to není právě nejlepší řešení. ASP.NET disponuje několika technikami, které umožňují tento problém řešit. Popsal jsem je v článku (v angličtině) pro server CodeProject. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = Tipy, triky -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2011-06-28T03:33:06.877+02:00 -->
<!-- dcterms:dateSubmitted = 2011-06-28T03:37:17.53+02:00 -->
<!-- dcterms:dateAccepted = 2011-06-28T00:00:00+02:00 -->
<!-- x4w:alternateUrl = http://www.codeproject.com/KB/webforms/embedding_resources.aspx -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:pictureUrl = /perex-pictures/20110628-pouziti-obrazku-a-skriptu-v-asp-net-server-controls.jpg -->

Web components (such as ASP.NET Web Controls), often need to contain or access binary data, such as images, style sheets and JavaScript. Of course you can package them loose with your assembly and force developers to copy them to places where your components would expect them. But that’s a deployment nightmare and sometimes it’s not even possible.

Here ASP.NET WebResources come to the rescue, but at some cost and with some drawbacks on its own. In this article I will describe how you can use WebResources a how you can minimize the drawbacks with data URIs and content delivery networks.

## Using WebResources in ASP.NET

The web resource mechanism allows you to compile any data (such as images, CSS and JavaScript files) into your assembly. You can request the embedded resources using special handler, which is part of .NET Framework.

The main advantage of this feature is smaller number of files you need to deploy. The typical examples are icon libraries. You can easily get some library, such as the Silk Icon Set ([http://www.famfamfam.com/lab/icons/silk/](http://www.famfamfam.com/lab/icons/silk/)), but then you need to maintain and carry with you bunch of quite small but numerous icons. Some things in life can never be fully appreciated nor understood unless experienced firsthand. Copying the complete set of 1000 Silk icons to FTP server in hurry and over unstable connection is one of them.

The process is actually quite simple, but is prone to errors, typos and misunderstandings, which do not manifest as error messages or exceptions. It simply does not work and you don’t know why. 

This article offers step-by-step guide for how to create simple web control library with embedded resources.

### Preparing the files

First, create special folder for the files, you want to include in your assembly. It’s usually called `Resources` and lies in root of your project, but you may name and place it anywhere in your structure. Put your files there. When including multiple files, the easiest way is to drag them from Explorer window to the Solution Explorer in Visual Studio.

Then you need to mark all these files as *Embedded Resources*. Select all the files (you may select multiple files) and in the Properties window set the Build Action to *Embedded Resource* (not just *Resource*).

### Registering the web resources

Next step is registering the resource as WebResource. You can do it in any code file (C# or VB.NET) using the `WebResource` attribute. It does not really matter where you place the attribute, but I usually create file called `_ResourceRegistration.cs` in the folder, where the embedded files are placed (the underscore ensures that the file is on top of the list when sorted alphabetically).

The following is sample `_ResourceRegistration.cs` file, registering single image:

using System.Web.UI; [assembly: WebResource("Altairis.ResourceDemo.Controls.Resources.FlagBlue.png", "image/png")]

The first argument of the attribute definition is logical name of the resource. The logical name is the most problematic part of resource registration, because it must match exactly your project settings and file name. The logical name is case sensitive, even though it contains file names, which are generally not case sensitive. Problem in its definition would not cause any compilation or runtime error, it just won’t work.

The logical name consists of three parts, which are concatenated and separated by dot. First part is the root namespace of your project. The root namespace is set in project properties (Application tab) and by default matches project name. In the above example the root namespace is `Altairis.ResourceDemo.Controls`.

Second part is the path within project folder structure. In our case, the files are placed in the Resources folder in the root of project; therefore the part of the name is just `Resources`. In more complex structures, dot is used as path separator. The third and last part is file name, including extension. In the above example it’s `FlagBlue.png`.

Second argument is MIME type of the content. When requested using the WebResource.axd handler, the type is sent as Content-Type HTTP header and may be important from the web browser standpoint. The most common MIME types are `image/png`, `image/gif` and `image/jpeg` for image formats, `text/javascript` for JavaScript and `text/css` for style sheets.

### Getting the resource URL

The last step is to get the final resource URL, on which your embedded data can be accessed. This can be done by calling method `Page.ClientScript.GetWebResourceUrl`. The method has two arguments: first is the type to which the resource is related, usually the control using it. Second one is the logical name of resource. You may get path to the above resource by calling:

var imageLink = this.Page.ClientScript.GetWebResourceUrl(this.GetType(), "Altairis.ResourceDemo.Controls.Resources.FlagBlue.png");

The resulting paths points to the `~/WebResource.axd` handler and looks similar to the following:

/WebResource.axd?d=dseRjrCHl7PvN70cMzoiaJKEsWjA2FTOp8sEou4qLQKJBO_kc1b3cnhEI6E-eWw poXM-z4_GG5ApZbQR4SIsEOcpPyodXAeRk7ZKg-YQLxdLqIcBtUWb5mRQ-82wT8Pe2MxOiYZOyAN3dUvEj bsvhqPfDjQdtgCF4HtTkdsrUF9XBmnkjvja_B1l9bG0GZce0& t=634317785760223219

The long Base-64 encoded query string parameter is encrypted logical name of the resource and the assembly where it’s contained.

## Content Delivery Networks (CDN)

The above mechanism is used in the ASP.NET Web Forms infrastructure itself. For example, the helper JavaScript files used by validation controls (such as `RequiredFieldValidator`, `RegularExpressionValidator` etc.) are loaded this way.

With release of ASP.NET 4.0, Microsoft launched its own Content Delivery Network (CDN). All the files required by ASP.NET infrastructure, as well as jQuery and some jQuery plugins, are hosted on ajax.aspnetcdn.com. Full list of the CDN files can be found at the following address: [http://www.asp.net/ajaxlibrary/cdn.ashx](http://www.asp.net/ajaxlibrary/cdn.ashx).

The main reason for using content delivery networks is performance. The CDN consists of many servers placed in different parts of the world and the user’s request is routed to the nearest edge cache server, which may be reachable more quickly than your own server. Also the CDN resources are cached by browser. When different ASP.NET applications use the same support scripts, they aren’t loaded many times (like when they are requested separately from each web site), but only once from the shared location.

To enable ASP.NET CDN for the core server controls, place `ScriptManager` control to your page and set its `EnableCdn` property to `true`. If you don’t use Microsoft AJAX Framework, you can disable its automatic referencing as well:

<asp:scriptmanager runat="server" enablecdn="true" ajaxframeworkmode="Disabled" />

### Using CDN with web resources

If you are for example component vendor, you might want to use similar technique for distributing your resources. You might want to run your own CDN and reference the embedded resources from there.

It’s however not good idea to simply hardcode the CDN paths into your components and force users to use them. CDNs are not welcome in some scenarios, such as intranet applications, where access to Internet is limited, or offline development. It’s therefore recommended to do as Microsoft does: allow developers to turn the CDN on and off using the ScriptManager control.

When registering the resources, you might use additional named argument of the `WebResource` attribute, called `CdnPath`, which contains the full path to where the resource file is located in your CDN. When `EnableCdn` is set to `true`, the CDN link is issued instead to call to WebResource.axd.

The above sample can be modified as follows:

using System.Web.UI; [assembly: WebResource("Altairis.ResourceDemo.Controls.Resources.FlagBlue.png", "image/png", CdnPath = "http://yourcdn/Samples/EmbeddingResources/FlagBlue.png")]

ASP.NET won’t help you with building the CDN itself, it would just link to it. To build CDN, you can use various ways starting with easy and free solutions like CloudFlare (www.cloudflare.com), over paid services of big providers like Akamai and ending with deploying your own server farms worldwide, that’s up to you.

### Using SSL with CDN

Usage of CDNs can be problematic when your application uses encrypted connection – HTTPS or SSL/TLS. Referencing unsecured content from secured page is security risks and browsers would display miscellaneous annoying warnings to users.

In the default settings, CDN would be used only when the page is requested using nonsecured connection. If SSL is employed, the link would fall back to the WebResource.axd approach.

If your CDN offers HTTPS connection as well, you may indicate it by adding additional argument called `CdnSupportsSecureConnection` set to `true`. The registration would then look similar to:

[assembly: WebResource("Altairis.ResourceDemo.Controls.Resources.FlagBlue.png", "image/png", CdnPath = "http://yourcdn/Samples/EmbeddingResources/FlagBlue.png", CdnSupportsSecureConnection = true)]

When this argument is set to `true` and page is requested using HTTPS, the `CdnPath` is modified to use HTTPS as well. In the above example the link would thus begin with `https://yourcdn/…`

## Data URI scheme

Sometimes you can avoid use of the web resources altogether using the data URIs. Commonly, the URI contains HTTP address, which identifies the object (Uniform Resource Identifier) and usually also locates it, gives address where the object can be located. 

In case of Data URIs, the object itself is contained within the URI. This approach is most often used for small images, such as icons, where the binary image data are embedded in Base64 encoded form in the URI itself. See the following example (shortened for readability):

<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB………QCAYAAAAf8/9h=" />

The structure of Data URI is formally defined in RFC2397, but usually takes the form shown above. It starts with the “`data:`” scheme prefix followed by content type of the data (here “`image/png`”, as discussed above), semicolon, encoding type (“`base64`”), colon and the Base64-encoded binary data.

The main advantage of using Data URIs is limiting number of HTTP requests. If your page uses lots of small images, displaying it in browser may involve quite a number of HTTP requests. Although the amount of data itself is not big, the overhead is quite significant. By embedding the data in page itself, you limit number of requests. In addition to lower the transaction costs, limiting number of request lowers the load of the web server.

The main disadvantage is that Base64-encoded data are by 1/3 bigger than in their binary form. Also, when used the naive way outlined above, when used repeatedly in page, they must be repeated each time.

### Using style sheets with data URI scheme

The second disadvantage, repeating occurrences of the particular image, can be easily solved by not referencing the data directly using the “`src`” attribute, but using CSS classes and contain the image data in style sheet file.

To display red flag icon, we might define the following HTML in page itself:

<span class="redflag"></span>

Then we define the following markup in the page style sheet (again, the Base64 data are trimmed for readability):

.redflag { display: inline-block; width: 16px; height: 16px; background-position: center center; background-repeat: no-repeat; background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAA…); }

## The complete example

All the methods shown in this article are combined in sample application you can download. The source code contains two projects: `Altairis.ResourceDemo.Controls` is a class library, containing single web control and a bunch of resources. Second project is a sample web site, using the control library.

We define single web control, called `FlagIcon`. The control displays one of seven colored flag images, contained in the Silk icon set already mentioned in this article. The control has two interesting properties:

`FlagColor` is enum containing all available flag colors and defines which image is going to be displayed.

`LinkMode` controls the means by which the image is displayed. When set to `WebResource`, the embedded resources or CDN are used. When set to `DataUri`, the picture is inlined into HTML as Data URI. Third possible value is `StyleSheet`, which combines the approaches.

### Combining web resources and Data URIs

The last method combines the techniques mentioned here and tries to maximize the gains and minimize the losses.

The core is style sheet, containing inlined all seven images. The style sheet is compiled in the component library as web resource, as well as available through the Altairis Content Delivery Network.

The main challenge there is to reference the style sheet in page and do this only once, even when the page contains multiple icons. That’s what the `EnsureStyleSheetRegistration` method I developed is good for:

private void EnsureStyleSheetRegistration() { // We need <head runat="server"> for this code to work if (this.Page.Header == null) throw new NotSupportedException("No <head runat=\"server\"> control found in page."); // Get the stylesheet resource URL var styleSheetUrl = this.Page.ClientScript.GetWebResourceUrl(this.GetType(), STYLE_RESOURCE_NAME); // Check if this stylesheer is already registered var alreadyRegistered = this.Page.Header.Controls.OfType<HtmlLink>().Any(x => x.Href.Equals(styleSheetUrl)); if (alreadyRegistered) return; // no work here // If not, register it var link = new HtmlLink(); link.Attributes["rel"] = "stylesheet"; link.Attributes["type"] = "text/css"; link.Attributes["href"] = styleSheetUrl; this.Page.Header.Controls.Add(link); }

## Conclusion

ASP.NET offers nice mechanism for embedding resources, such as images, style sheets or JavaScript, into assemblies and reading them via the WebResource.axd handler. In case of small images, inlining them using Data URIs may be better alternative. Many negatives of inlining may be solved by combining the above methods and define inlined images in style sheets.

Another alternative, not discussed in this article, is use of image sprites. If you want to explore this idea in ASP.NET, there is a Sprite and Image Optimization Framework project available in ASP.NET Futures on CodePlex: [http://aspnet.codeplex.com/releases/view/50869](http://aspnet.codeplex.com/releases/view/50869).