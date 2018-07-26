<!-- dcterms:identifier = aspnetcz#99 -->
<!-- dcterms:title = Ranking functions v SQL 2005 - konečně pohodlné stránkování -->
<!-- dcterms:abstract = Verze 2005 přinesla do SQL Serveru řadu užitečných novinek. Jednou z nich jest též implementace tzv. ranking functions - dalo by se to překládat např. jako hodnotící funkce. Takové funkce jsou celkem čtyři a využijete je především, pokud chcete vypisovat z databáze pouze část záznamů. Vyloženě školním příkladem je využití funkce ROW_NUMBER() pro stránkování výpisů. Znamená to, že nebudeme muset nadále závidět uživatelům MySQL jejich SELECT LIMIT a budeme se moci štastně vzdát šílených stránkovacích procedur realizovaných pomocí rozličných kombinací SELECT TOP. -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-06-27T01:13:39.333+02:00 -->
<!-- dcterms:dateAccepted = 2006-06-27T01:13:39.333+02:00 -->

 

Verze 2005 přinesla do SQL Serveru řadu užitečných novinek. Jednou z nich jest též implementace tzv. *ranking functions* - dalo by se to překládat např. jako *hodnotící funkce*. Takové funkce jsou celkem čtyři a využijete je především, pokud chcete vypisovat z databáze pouze část záznamů. Vyloženě školním příkladem je využití funkce `ROW_NUMBER()` pro stránkování výpisů. Znamená to, že nebudeme muset nadále závidět uživatelům MySQL jejich `SELECT LIMIT` a budeme se moci štastně vzdát šílených stránkovacích procedur realizovaných pomocí rozličných kombinací `SELECT TOP`.

## ROW_NUMBER()

Funkce `ROW_NUMBER()` slouží nepříliš překvapivě k vrácení čísla řádku, k sekvenčnímu číslování. Jednoduchý dotaz (nad tabulkou `Person.Contact` z ukázkové databáze `AdventureWorks`) s využitím této funkce může vypadat takto:

`SELECT LastName, FirstName, EmailAddress, ROW_NUMBER() OVER (ORDER BY LastName) AS RowNumber FROM Person.Contact ORDER BY LastName`

Výsledek bude obsahovat pole RowNumber, ve kterém bude sekvenční číslo, stoupající od jedné. My zpravidla ovšem nechceme toto číslo získat, ale spíše se podle něj zařídit - zkonstruovat odpovídající podmínku. Ranking functions ovšem není možné použít ve `WHERE` části dotazu, proto si musíme pomoci malým trikem:

`WITH X AS (SELECT LastName, FirstName, EmailAddress, ROW_NUMBER() OVER (ORDER BY LastName) AS RowNumber FROM Person.Contact) SELECT * FROM X WHERE X.RowNumber BETWEEN 21 AND 40 ORDER BY X.LastName`

Pomocí klíčového slova WITH si vytvoříme poddotaz, na který aplikujeme požadovanou podmínku, v našem případě touhu po záznamech 21-40, tedy hypotetické druhé stránce při stránkování po dvaceti.

## RANK() a DENSE_RANK()

Funkce `RANK()` a `DENSE_RANK()` jsou o něco složitější. Nevracejí totiž číslo řádku, ale pořadí hodnoty. Provedeme si drobnou demografickou analýzu jmen kontaktů firmy *Adventure Works* - budeme zjišťovat, jaká křestní jména se mezi nimi nejčastěji vyskytují. Použijeme k tomu následující dotaz, obsahující všechny dosud představené funkce:

`SELECT FirstName, COUNT(*) AS PersonCount, ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS RowNumber, RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank, DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS DenseRank FROM Person.Contact GROUP BY FirstName ORDER BY PersonCount DESC`

Výsledek tohoto dotazu (resp. jeho úvodní část) bude vypadat takto:

<table style="MARGIN-LEFT: auto; MARGIN-RIGHT: auto"><colgroup><col><col style="TEXT-ALIGN: right" span="4"></colgroup><thead>
<tr><th>FirstName</th><th>PersonCount</th><th>RowNumber</th><th>Rank</th><th>DenseRank</th></tr></thead>
<tbody>
<tr>
<td>Richard</td>
<td>103</td>
<td>1</td>
<td>1</td>
<td>1</td></tr>
<tr>
<td>Katherine</td>
<td>99</td>
<td>2</td>
<td>2</td>
<td>2</td></tr>
<tr>
<td>Marcus</td>
<td>97</td>
<td>3</td>
<td>3</td>
<td>3</td></tr>
<tr>
<td>James</td>
<td>97</td>
<td>4</td>
<td>3</td>
<td>3</td></tr>
<tr>
<td>Jennifer</td>
<td>96</td>
<td>5</td>
<td>5</td>
<td>4</td></tr>
<tr>
<td>Dalton</td>
<td>93</td>
<td>6</td>
<td>6</td>
<td>5</td></tr>
<tr>
<td>Alexandra</td>
<td>93</td>
<td>7</td>
<td>6</td>
<td>5</td></tr>
<tr>
<td>Lucas</td>
<td>93</td>
<td>8</td>
<td>6</td>
<td>5</td></tr>
<tr>
<td>Morgan</td>
<td>92</td>
<td>9</td>
<td>9</td>
<td>6</td></tr>
<tr>
<td>Isabella</td>
<td>92</td>
<td>10</td>
<td>9</td>
<td>6</td></tr>
<tr>
<td>Seth</td>
<td>92</td>
<td>11</td>
<td>9</td>
<td>6</td></tr>
<tr>
<td>Natalie</td>
<td>91</td>
<td>12</td>
<td>12</td>
<td>7</td></tr>
<tr>
<td>Robert</td>
<td>90</td>
<td>13</td>
<td>13</td>
<td>8</td></tr>
<tr>
<td>Eduardo</td>
<td>90</td>
<td>14</td>
<td>13</td>
<td>8</td></tr>
<tr>
<td>Sydney</td>
<td>90</td>
<td>15</td>
<td>13</td>
<td>8</td></tr>
<tr>
<td>Kaitlyn</td>
<td>90</td>
<td>16</td>
<td>13</td>
<td>8</td></tr>
<tr>
<td>Ian</td>
<td>89</td>
<td>17</td>
<td>17</td>
<td>9</td></tr>
<tr>
<td>Julia</td>
<td>89</td>
<td>18</td>
<td>17</td>
<td>9</td></tr>
<tr>
<td>Xavier</td>
<td>88</td>
<td>19</td>
<td>19</td>
<td>10</td></tr>
<tr>
<td>Chloe</td>
<td>88</td>
<td>20</td>
<td>19</td>
<td>10</td></tr></tbody></table>

*   Sloupec `PersonCount` obsahuje počet osob obdařených daným křestním jménem. 
*   Sloupec `RowNumber` obsahuje výsledek nám již známé funkce `ROW_NUMBER()`, tedy souvislou číselnou řadu stoupající po jedné. 
*   Sloupec `Rank`, jako výsledek stejnojmenné funce, obsahuje pořadí sledované hodnoty (počtu osob). Vidíme, že s hodnotou 97 se jména Marcus a James dělí o třetí místo. Čtvrtá příčka zůstává neobsazena a pokračujeme až jménem Jennifer, které obsadilo pátou pozici.
*   Posledním je sloupec `DenseRank`. Funkce `DENSE_RANK()` vrací stejný typ výsledku jako předchozí, ale nepřeskakuje "nevyužitá" místa -- o třetí místo se jména dělí a Jennifer je na místě čtvrtém.

## NTILE()

Poslední ranking function, `NTILE()`, rozdělí výsledek do určeného počtu skupin (*n-tin*, jako např. *pětin* pro n=5) a vrátí číslo oné *n-tiny*.

## PARTITION BY

Ve všech shora uvedených funkcích můžete použít klauzuli `PARTITION BY`. V takovém případě se pořadí (atd.) počítá pouze v rámci v této klauzuli specifikované podmínky. Jedná se o jakousi obdobu klauzule `GROUP BY`. Pokud bychom v tabulce `Person.Contact` měli ještě sloupeček `Country` (což bohužel nemáme) mohli bychom statistiku rozšířit na jednotlivé země právě podle `PARTITION BY Country`.