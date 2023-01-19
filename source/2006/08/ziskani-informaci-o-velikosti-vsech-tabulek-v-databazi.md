<!-- dcterms:identifier = aspnetcz#108 -->
<!-- dcterms:title = Získání informací o velikosti všech tabulek v databázi -->
<!-- dcterms:abstract = SQL Server Management Studio umí informace o velikosti jednotlivých tabulek zobrazit v podobě krásného reportu. Nicméně jak si poradit, pokud chcete tyto informace zobrazit pomocí vlastní aplikace, nebo pokud máte k dispozici pouze SQL Server 2000? -->
<!-- np9:categoryId = 1 -->
<!-- x4w:category = IT -->
<!-- np9:authorId = 1 -->
<!-- np9:authorEmail = michal.valasek@altairis.cz -->
<!-- dcterms:creator = Michal Altair Valášek -->
<!-- dcterms:created = 2006-08-10T04:00:00+02:00 -->
<!-- dcterms:date = 2006-08-10T04:00:00+02:00 -->


		<p>SQL Server Management Studio umí informace o velikosti jednotlivých tabulek zobrazit v podobě krásného reportu. Nicméně jak si poradit, pokud chcete tyto informace zobrazit pomocí vlastní aplikace, nebo pokud máte k dispozici pouze SQL Server 2000?</p>
		<p>Řešením je níže prezentovaná uložená procedura <em>TableStatistics</em>:</p>
		<div style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: black; FONT-FAMILY: 'Courier New', monospace">
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">CREATE PROCEDURE </span>[dbo].[TableStatistics]</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">AS</span>
				</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">BEGIN </span>
				</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">SET NOCOUNT ON</span></p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: green">-- Create the temporary table</span></p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">CREATE TABLE </span>#TableStatistics (</p>
				<p style="MARGIN: 0px">       <span style="COLOR: blue">name    </span>          nvarchar(100),</p>
				<p style="MARGIN: 0px">       <span style="COLOR: blue">rows    </span>          <span style="COLOR: blue">int</span>,</p>
				<p style="MARGIN: 0px">       reserved          <span style="COLOR: blue">varchar</span>(18),</p>
				<p style="MARGIN: 0px">       reserved_int      <span style="COLOR: blue">int default</span>(0),</p>
				<p style="MARGIN: 0px">       data              <span style="COLOR: blue">varchar</span>(18),</p>
				<p style="MARGIN: 0px">       data_int          <span style="COLOR: blue">int default</span>(0),</p>
				<p style="MARGIN: 0px">       index_size        <span style="COLOR: blue">varchar</span>(18),</p>
				<p style="MARGIN: 0px">       index_size_int    <span style="COLOR: blue">int default</span>(0),</p>
				<p style="MARGIN: 0px">       unused            <span style="COLOR: blue">varchar</span>(18),</p>
				<p style="MARGIN: 0px">       unused_int        <span style="COLOR: blue">int default</span>(0)</p>
				<p style="MARGIN: 0px">    )</p>
				<p style="MARGIN: 0px">    <span style="COLOR: green">-- Populate table</span></p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">EXEC </span>sp_MSforeachtable @command1="INSERT INTO #TableStatistics (name,rows,reserved,data,index_size,unused) EXEC sp_spaceused '?'"</p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: green">-- Return converted values</span></p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">SELECT </span></p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">name AS Name</span>,</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">rows AS Rows</span>,</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">CAST</span>(<span style="COLOR: blue">SUBSTRING</span>(reserved, 1, <span style="COLOR: blue">CHARINDEX</span>(<span style="COLOR: maroon">' '</span>, reserved)) <span style="COLOR: blue">AS int</span>) <span style="COLOR: blue">AS </span>Reserved,</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">CAST</span>(<span style="COLOR: blue">SUBSTRING</span>(data, 1, <span style="COLOR: blue">CHARINDEX</span>(<span style="COLOR: maroon">' '</span>, data)) <span style="COLOR: blue">AS int</span>) <span style="COLOR: blue">AS </span>Data,</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">CAST</span>(<span style="COLOR: blue">SUBSTRING</span>(index_size, 1, <span style="COLOR: blue">CHARINDEX</span>(<span style="COLOR: maroon">' '</span>, index_size)) <span style="COLOR: blue">AS int</span>) <span style="COLOR: blue">AS </span>IndexSize,</p>
				<p style="MARGIN: 0px">        <span style="COLOR: blue">CAST</span>(<span style="COLOR: blue">SUBSTRING</span>(unused, 1, <span style="COLOR: blue">CHARINDEX</span>(<span style="COLOR: maroon">' '</span>, unused)) <span style="COLOR: blue">AS int</span>) <span style="COLOR: blue">AS </span>Unused</p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">FROM </span>#TableStatistics <span style="COLOR: blue">ORDER BY Name</span></p>
				<p style="MARGIN: 0px"> </p>
				<p style="MARGIN: 0px">    <span style="COLOR: green">-- Delete the temporary table</span></p>
				<p style="MARGIN: 0px">    <span style="COLOR: blue">DROP TABLE </span>#TableStatistics</p>
				<p style="MARGIN: 0px">
						<span style="COLOR: blue">END</span>
				</p>
		</div>
		<!--EndFragment-->
		<p>Jejím výstupem je resultset, který obsahuje pro každou tabulku v databázi následující údaje:</p>
		<ul>
				<li>
						<strong>Name</strong> - název tabulky</li>
				<li>
						<strong>Rows</strong> - počet řádků</li>
				<li>
						<strong>Reserved</strong> - velikost prostoru, který je pro tabulku rezervován (v kB)</li>
				<li>
						<strong>Data</strong> - objem v kB, který skutečně zabírají data</li>
				<li>
						<strong>IndexSize</strong> - objem v kB, který skutečně zabírají indexy</li>
				<li>
						<strong>Unused</strong> - nevyužitý objem v kB </li>
		</ul>
