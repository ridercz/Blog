<!-- dcterms:title = C# pro mírně pokročilé: IEquatable, IComparable a operátory -->
<!-- dcterms:abstract = Dnešní video o C# pro mírně pokročilé se zabývá rozhraními IEquatable, IComparable, operátory a type cast operátory. Všechny tyto věci se hodí, když chcete vytvořit třídu, reprezentující nějaký "reálný" fenomén a chcete s ní pohodlně pracovat. Zde budeme vytvářet třídu pro reprezentaci hodnoty úhlu. -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- x4w:pictureUrl = /perex-pictures/20211216-csharp-oper.jpg -->
<!-- x4w:pictureWidth = 150 -->
<!-- x4w:pictureHeight = 150 -->
<!-- x4w:coverUrl = /cover-pictures/20211216-csharp-oper.jpg-->
<!-- x4w:category = Z-TECH -->
<!-- x4w:category = IT -->
<!-- dcterms:dateAccepted = 2021-12-26 -->

Dnešní video o C# pro mírně pokročilé se zabývá rozhraními `IEquatable`, `IComparable`, operátory a type cast operátory. Všechny tyto věci se hodí, když chcete vytvořit třídu, reprezentující nějaký "reálný" fenomén a chcete s ní pohodlně pracovat. Zde budeme vytvářet třídu pro reprezentaci hodnoty úhlu.

<div style="position:relative;padding-top:56.25%;">
  <iframe src="https://www.youtube-nocookie.com/embed/0Qn_S9sCR4g" frameborder="0" allowfullscreen allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>

## Rozhraní IEquatable

Rozhraní `IEquatable` a jeho generická varianta `IEquatable<T>` definují různé overloady metody `Equals`, která umožňuje rozhodnout, zda jsou si dvě různé instance téže třídy rovny. Nikoliv z hlediska C# a .NET (např. zda se jedná o tutéž instanci nebo zda mají jejich vlastnosti tutéž hodnotu), ale z hlediska vnitřní logiky oné třídy samé.

> Řeč je z krátkosti jenom o třídách, ale i `struct` nebo `record` může implementovat interface a článek se na ně vztahuje také.

Například naše třída `Angle`, reprezentující rovinný úhel, může být zadána několika způsoby. V desetinných stupních, minutách nebo vteřinách, případně v radiánech. Platí tedy, že _12,5°_ a _12°30'_ nebo _90°_ a _&pi; / 2 rad_ reprezentují tytéž hodnoty a toto rozhraní to dokáže postihnout.

## Rozhraní IComparable

I rozhraní `IComparable` má generickou variantu `IComparable<T>` a je o něco schopnější, než to předchozí. Metoda `CompareTo` dokáže porovnat dvě instance téže třídy a vrátit `-1`, `0` nebo `1` podle toho, která z nich je větší. Opět platí, že co je _větší_ a co _menší_ rozhoduje vnitřní logika dané třídy.

Implementace metod rozhraní `IEquatable` a `IComparable` umožňuje jednoduše a abstraktně pracovat s "hodnotovými" třídami pomocí univerzálních metod. Lze je příkladmo řadit a podobně.

## Operátory

Pomocí klíčového slova `operator` lze definovat vlastní operátory. Ty mohou být porovnávací (`==`, `!=`, `<`, `<=`...) tak matematické (`+`, `-`, `*`, `/`, `%`). Implementace těch prvních je obecně vhodná ve chvíli, kdy implementujete shora uvedená rozhraní, aby `a.Equals(b)` dávalo tentýž výsledek jako `a == b`. Matematické operátory je vhodné implementovat pokud hrozí, že s instancemi třídy budete chtít počítat. Což se u úhlu docela hodí, protože sečíst či odečíst dva úhly nebo násobit a dělit úhel konstantou může být užitečné.

Poslední skupinou jsou operátory pro přetypování (_type cast_ operátory). Ty umožňují implicitně nebo explicitně přetypovat třídu na jiný typ. Implicitní operátory by se měly používat tam, kde přetypováním nedochází ke ztrátě informace a jejich použití je extrémně jednoduché. Díky nim lze například použít naši třídu `Angle` kdekoliv, kde se jinak používá typ `double`. To, mimo jiné, činí z implementace předchozích rozhraní a operátorů akademické cvičení, protože k dosažení téžě funkčnosti v tomto případě stačí přetypování. Explicitní operátor pro přetypování vyžaduje výslovnou konstrukci (např. `var b = (NovyTyp)a`) a používá se tehdy, pokud konverze může způsobit ztrátu nějaké informace.

## Zdrojový kód třídy Angle

> Pokud vás zajímá pozadí metody `ToString` a rozhraní `IFormattable`, vytvořil jsem o něm již dříve [separátní článek a video](https://www.altair.blog/2021/09/csharp-format).

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using static System.Math;

namespace OperatorsDemo {
    public struct Angle : IFormattable, IEquatable<Angle>, IComparable, IComparable<Angle> {

        // Properties

        public double Degrees { get; }

        public int WholeDegrees => (int)this.Degrees;

        public double Minutes => (Abs(this.Degrees) - (double)Abs(this.WholeDegrees)) * 60d;

        public int WholeMinutes => Abs((int)this.Minutes);

        public double Seconds => (Abs(this.Minutes) - Abs(this.WholeMinutes)) * 60d;

        public int WholeSeconds => (int)this.Seconds;

        // Constructors

        public Angle(double deg) {
            this.Degrees = deg;
        }

        public Angle(int deg, double min) {
            if (min < 0 || min >= 60) throw new ArgumentOutOfRangeException(nameof(min));

            this.Degrees = deg + min / 60d;
        }

        public Angle(int deg, int min, double sec) {
            if (min < 0 || min >= 60) throw new ArgumentOutOfRangeException(nameof(min));
            if (sec < 0 || sec >= 60) throw new ArgumentOutOfRangeException(nameof(sec));

            this.Degrees = deg + min / 60d + sec / 3600d;
        }

        // General methods

        public Angle Add(Angle a) => new(this.Degrees + a.Degrees);

        public Angle Subtract(Angle a) => new(this.Degrees - a.Degrees);

        public Angle ToNominal() => new(this.Degrees % 360);

        // Radian conversions

        public double ToRadians() => this.Degrees * PI / 180;

        public static Angle FromRadians(double rad) => new(rad * 180 / PI);

        // ToString & IFormattable

        public string ToString(string format, IFormatProvider formatProvider) {
            format ??= "S";

            // double formatting helper functions
            string formatComponent(double value, string format = "F0") => (value < 10 ? "0" : string.Empty) + value.ToString(format.Length == 1 ? "F" : "F" + format[1..], formatProvider);

            // Integer fomatting
            if (format == "D") return $"{this.Degrees.ToString("F0", formatProvider)}°";
            if (format == "M") return $"{this.WholeDegrees}°{formatComponent(this.Minutes)}'";
            if (format == "S") return $"{this.WholeDegrees}°{formatComponent(this.WholeMinutes)}'{formatComponent(this.Seconds)}\"";

            // Decimal formatting
            if (format.StartsWith("d")) return $"{this.Degrees.ToString("F", formatProvider)}°";
            if (format.StartsWith("m")) return $"{this.WholeDegrees}°{formatComponent(this.Minutes, format)}'";
            if (format.StartsWith("s")) return $"{this.WholeDegrees}°{formatComponent(this.WholeMinutes)}'{formatComponent(this.Seconds, format)}\"";

            throw new FormatException();
        }

        public override string ToString() => this.ToString("S", null);

        // IEquatable

        public override bool Equals(object obj) {
            if (obj is null) throw new ArgumentNullException(nameof(obj));
            return obj is Angle a ? this.Degrees.Equals(a.Degrees) : throw new ArgumentException(null, nameof(obj));
        }

        public bool Equals(Angle other) => this.Degrees.Equals(other.Degrees);

        public override int GetHashCode() => this.Degrees.GetHashCode();

        // IComparable

        public int CompareTo(object obj) {
            if (obj is null) throw new ArgumentNullException(nameof(obj));
            return obj is Angle a ? this.Degrees.CompareTo(a.Degrees) : throw new ArgumentException(null, nameof(obj));
        }

        public int CompareTo(Angle other) => this.Degrees.CompareTo(other.Degrees);

        // Arithmetic operators

        public static Angle operator +(Angle a1, Angle a2) => a1.Add(a2);

        public static Angle operator -(Angle a1, Angle a2) => a1.Subtract(a2);

        public static Angle operator *(Angle a, double factor) => new(a.Degrees * factor);

        public static Angle operator /(Angle a, double factor) => new(a.Degrees / factor);

        // Compare operators

        public static bool operator ==(Angle a1, Angle a2) => a1.Degrees == a2.Degrees;

        public static bool operator !=(Angle a1, Angle a2) => a1.Degrees != a2.Degrees;

        public static bool operator <(Angle a1, Angle a2) => a1.Degrees < a2.Degrees;

        public static bool operator >(Angle a1, Angle a2) => a1.Degrees > a2.Degrees;

        public static bool operator <=(Angle a1, Angle a2) => a1.Degrees <= a2.Degrees;

        public static bool operator >=(Angle a1, Angle a2) => a1.Degrees >= a2.Degrees;

        // Type cast operators (make arithmetic and compare operators unnecessary)

        public static implicit operator double(Angle a) => a.Degrees;

        public static implicit operator Angle(double d) => new(d);

    }
}
```