<!-- dcterms:identifier = aspnetcz#62 -->
<!-- dcterms:title = Bezpečné načítání hodnot z query stringu podruhé -->
<!-- dcterms:abstract = V komentáři k mému předchozím článku o query string parametrech nabídl uživatel Meap své vlastní řešení: třídu QueryStringParser. Jeho řešení je pro jisté scénáře užitečné a zároveň technologicky zajímavé, a autor laskavě souhlasil s jeho zveřejněním na ASP Network. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2005-11-23T02:49:02.407+01:00 -->
<!-- dcterms:date = 2005-11-23T02:49:02.407+01:00 -->

V komentáři k mému článku [Vytváření vlastních parametrů podruhé - "bezpečný" query string parametr](/entry/article-20051109.aspx) nabídl uživatel Meap své vlastní řešení: třídu QueryStringParser. Jeho řešení je pro jisté scénáře užitečné a zároveň technologicky zajímavé, a autor laskavě souhlasil s jeho zveřejněním na ASP Network.

*   [Stáhněte si jeho kód (C#) spolu s mou ukázkovou aplikací ve VB.NET i v C# (10 kB)](https://www.cdn.altairis.cz/Blog/2005/20051123-QueryStringParser.zip)

Idea tohoto řešení je jednoduchá: Deklarujete si třídu, která reprezentuje parametry dané stránky. Pomocí atributu Arguments definujete, zda je daný parametr povinný, případně jakou má defaultní hodnotu:

    protected class QueryStringArguments
    {
        [Argument(ArgumentType.NonRequired, ParamName="StringParameter", DefaultValue="Defaultní hodnota nepovinného parametru")]
        public string StringParameter;
        [Argument(ArgumentType.Required, ParamName = "IntParameter")]
        public int IntParameter;
    }

Ve shora uvedené třídě jsem deklaroval dva parametry. Jeden je celočíselný a povinný, druhý je řetězcový, nepovinný s defaultní hodnotou.

V samotné stránce pak zavoláte metodu *QueryStringParser.ParseArguments*, která se pokusí naplnit tuto třídu hodnotami z query stringu. Pokud se jí to povede, získáte silně typovou sadu nastavení. Pokud ne (protože chybí povinné parametry, případně nesouhlasí typy), dojde k chybě.

Toto řešení velice elegantním způsobem řeší načítání parametrů procedurálně, tedy z vašeho kódu.