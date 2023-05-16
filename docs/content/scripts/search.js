searchform.onsubmit = async function () {
    // Change the address and URI to correspond your site
    const url = "https://fulltext.altairis.cz/api/search/dc189fa1-1e41-4305-d372-08db55ee48c4.html?locale=cs-CZ&query=" + encodeURIComponent(searchform.query.value);

    // Get element to store results in
    const resultsDiv = document.getElementById("results");

    // Call API
    try {
        const response = await fetch(url);
        if (response.ok) {
            // Success
            resultsDiv.innerHTML = await response.text();
        } else if (response.status == 404) {
            // Empty result
            resultsDiv.innerHTML = "<div class='error'>Vašemu dotazu neodpovídá žádný článek.</div>";
        } else {
            // Other error
            resultsDiv.innerHTML = "<div class='error'>Chyba: " + response.status + ": " + response.statusText + "</div>";
        }
    } catch (e) {
        // Handle network or CORS error
        resultsDiv.innerHTML = "<div class='error'>Chyba připojení: " + e.message + "</div>";
    }
};