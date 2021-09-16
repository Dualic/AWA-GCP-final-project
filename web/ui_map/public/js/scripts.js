window.addEventListener("load", function() {
                
    let codes = ['ad', 'ae', 'af', 'al', 'am', 'ao', 'ar', 'at', 'au', 'az', 'ba', 'bd', 'be', 'bf', 'bg', 'bh', 'bi', 'bj', 'bn', 'bo', 'br',
            'bt', 'bw', 'by', 'bz', 'ca', 'cd', 'cf', 'cg', 'ch', 'ci', 'cl', 'cm', 'cn', 'co', 'cr', 'cu', 'cv', 'cy', 'cz', 'de', 'dj',
            'dk', 'do', 'dz', 'ec', 'ee', 'eg', 'er', 'es', 'et', 'fi', 'fr', 'ga', 'gb', 'ge', 'gf', 'gh', 'gl', 'gm', 'gn', 'gq', 'gr',
            'gt', 'gw', 'gy', 'hk', 'hn', 'hr', 'ht', 'hu', 'id', 'ie', 'il', 'in', 'iq', 'ir', 'is', 'it', 'jm', 'jo', 'jp', 'ke', 'kg','kh',
            'kr', 'kw', 'kz', 'la', 'lb', 'li', 'lk', 'lr', 'ls', 'lt', 'lu', 'lv', 'ly', 'ma', 'mc', 'md', 'me', 'mg', 'mk', 'ml', 'mm',
            'mn', 'mo', 'mr', 'mt', 'mu', 'mv', 'mw', 'mx', 'my', 'mz', 'na', 'ne', 'ng', 'ni', 'nl', 'no', 'np', 'nz', 'om',
            'pa', 'pe', 'pg', 'ph', 'pk', 'pl', 'ps', 'pt', 'py', 'ro', 'rs', 'ru', 'rw', 'sa', 'sc', 'sd', 'se', 'sg', 'si', 'sk', 'sl', 'sm',
            'sn', 'so', 'sr', 'st', 'sv', 'sy', 'sz', 'td', 'tg', 'th', 'tj', 'tl', 'tn', 'tr', 'tw', 'tz', 'ua', 'ug', 'us', 'uy', 'uz', 'va', 've',
            'vn', 'ye', 'za', 'zm', 'zw',]

    let airports = ["Andorra", "United Arab Emirates", "Afghanistan", "Albania", "Armenia", "LAD", "Argentina", "Austria", "Australia", "Azerbaijan", "Bosnia and Herzegovina",
            "Bangladesh", "Belgium", "OUA", "Bulgaria", "Bahrain", "BJM", "COO", "Brunei", "Bolivia", "Brazil", "Bhutan", "GBE", "Belarus", "Belize", "Canada",
            "BZV", "BGF", "BZV", "Switzerland", "ABJ", "Chile", "DLA", "China", "Colombia", "Costa Rica", "Cuba", "RAI", "Cyprus",
            "Czechia", "Germany", "JIB", "Denmark", "Dominican Republic", "ALG", "Ecuador", "Estonia", "CAI", "ASM", "Spain", "ADD", "Finland", "France", "LBV",
            "MAN", "Georgia", "CKY", "ACC", "Greenland", "BJL", "CKY", "SSG", "Greece", "Guatemala", "OXB", "Guyana", "Hong Kong",
            "Honduras", "Croatia", "Haiti", "Hungary", "Indonesia", "Ireland", "Israel", "India", "Iraq", "Iran", "Iceland", "Italy", "Jamaica", "Jordan", "Japan", "NBO", "Kyrgyzstan",
            "Cambodia", "South Korea", "Kuwait", "Kazakhstan", "Laos", "Lebanon", "Liechtenstein", "Sri Lanka", "ROB", "MSU", "Lithuania", "Luxembourg", "Latvia", "TIP",
            "CMN", "Monaco", "Moldova", "Montenegro", "TNR", "North Macedonia", "BKO", "Myanmar", "Mongolia", "Macao", "NKC", "Malta", "MRU", "Maldives",
            "LLW", "Mexico", "Malaysia", "MPM", "WDH", "NIM", "LOS", "Nicaragua", "Netherlands", "Norway", "Nepal", "New Zealand", "Oman", "Panama", "Peru",
            "Papua New Guinea", "Philippines", "Pakistan", "Poland", "Palestine", "Portugal", "Paraguay", "Romania", "Serbia", "Russia", "KGL", "Saudi Arabia", "SEZ",
            "KRT", "Sweden", "Singapore", "Slovenia", "Slovakia", "FNA", "San Marino", "DKR", "NOV", "Suriname", "TMS", "El Salvador", "Syria",
            "SHO", "NDJ", "LFW", "Thailand", "Tajikistan", "Timor", "TUN", "Turkey", "Taiwan", "DAR", "Ukraine", "EBB", "United States", "Uruguay", "Uzbekistan",
            "Vatican", "Venezuela", "Vietnam", "Yemen", "JNB", "LUN", "HRE"]

    let countries = ["Andorra", "United Arab Emirates", "Afghanistan", "Albania", "Armenia", "Angola", "Argentina", "Austria", "Australia", "Azerbaijan", "Bosnia and Herzegovina",
            "Bangladesh", "Belgium", "Burkina Faso", "Bulgaria", "Bahrain", "Burundi", "Benin", "Brunei", "Bolivia", "Brazil", "Bhutan", "Botswana", "Belarus", "Belize", "Canada",
            "Congo", "Central African Republic", "Congo", "Switzerland", "Cote d'Ivoire", "Chile", "Cameroon", "China", "Colombia", "Costa Rica", "Cuba", "Cape Verde", "Cyprus",
            "Czechia", "Germany", "Djibouti", "Denmark", "Dominican Republic", "Algeria", "Ecuador", "Estonia", "Egypt", "Eritrea", "Spain", "Ethiopia", "Finland", "France", "Gabon",
            "United Kingdom", "Georgia", "Guinea", "Ghana", "Greenland", "Gambia", "Guinea", "Equatorial Guinea", "Greece", "Guatemala", "Guinea-Bissau", "Guyana", "Hong Kong",
            "Honduras", "Croatia", "Haiti", "Hungary", "Indonesia", "Ireland", "Israel", "India", "Iraq", "Iran", "Iceland", "Italy", "Jamaica", "Jordan", "Japan", "Kenya", "Kyrgyzstan",
            "Cambodia", "South Korea", "Kuwait", "Kazakhstan", "Laos", "Lebanon", "Liechtenstein", "Sri Lanka", "Liberia", "Lesotho", "Lithuania", "Luxembourg", "Latvia", "Libya",
            "Morocco", "Monaco", "Moldova", "Montenegro", "Madagascar", "North Macedonia", "Mali", "Myanmar", "Mongolia", "Macao", "Mauritania", "Malta", "Mauritius", "Maldives",
            "Malawi", "Mexico", "Malaysia", "Mozambique", "Namibia", "Niger", "Nigeria", "Nicaragua", "Netherlands", "Norway", "Nepal", "New Zealand", "Oman", "Panama", "Peru",
            "Papua New Guinea", "Philippines", "Pakistan", "Poland", "Palestine", "Portugal", "Paraguay", "Romania", "Serbia", "Russia", "Rwanda", "Saudi Arabia", "Seychelles",
            "Sudan", "Sweden", "Singapore", "Slovenia", "Slovakia", "Sierra Leone", "San Marino", "Senegal", "Somalia", "Suriname", "Sao Tome and Principe", "El Salvador", "Syria",
            "Eswatini", "Chad", "Togo", "Thailand", "Tajikistan", "Timor", "Tunisia", "Turkey", "Taiwan", "Tanzania", "Ukraine", "Uganda", "United States", "Uruguay", "Uzbekistan",
            "Vatican", "Venezuela", "Vietnam", "Yemen", "South Africa", "Zambia", "Zimbabwe"]
    
    var svgObject = document.getElementById('svg-object').contentDocument;

    for (let i = 0, len = codes.length; i < len; i++) {
        let argmnt = codes[i]
        let argmnt2 = countries[i]
        let argmnt3 = airports[i]

        var element = svgObject.getElementById(argmnt);
        element.addEventListener("click",function(){
            for (index = 0; index < clientRows.length; index++) {
                if (clientRows[index].location == argmnt2){
                    currentCountry = clientRows[index]
                };
            };
            document.getElementById("mySidebar").style.width = "450px"
            var div = document.getElementById('mySidebar');
            div.innerHTML = `
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <div class="countrydata">
            <h2>Country selection: ${argmnt2}</h2>
            <img src="https://www.countryflags.io/${argmnt}/shiny/64.png">
            <p><b>Population: ${currentCountry.population}</b></p>
            <ul>
                <li>
                    Total Covid cases: ${currentCountry.total_cases}
                </li>
                <li>
                    New Cases in a day: ${currentCountry.new_cases}
                </li>
                <li>
                    Deaths caused by Covid: ${currentCountry.total_deaths}
                </li>
                <li>
                    New Deaths in a day: ${currentCountry.new_deaths}
                </li>
                <li>
                    New tests per 1000: ${currentCountry.new_tests_per_thousand}
                </li>
                <li>
                    percentage of tests positive: ${currentCountry.positive_rate * 100}
                </li>
                <li>
                    percentage of people vaccinated: ${currentCountry.people_vaccinated_per_hundred}
                </li>
                <li>
                    percentage of people fully vaccinated: ${currentCountry.people_fully_vaccinated_per_hundred}
                </li>
            </ul>
            <div><button onclick="getFlights('${argmnt3}')">Get flight prices!</button></div>
            <div id="flightdata"></div>
            </div>
            `
        }, false);
    }
}, false);

function closeNav() {
    document.getElementById("mySidebar").style.width = "0";
    }

function getFlights(airport) {
    const data = null;

    const xhr = new XMLHttpRequest();
    xhr.withCredentials = true;

    xhr.addEventListener("readystatechange", function () {
        if (this.readyState === this.DONE) {
            console.log(this.responseText);
            flights = JSON.parse(this.responseText);
            document.getElementById("flightdata").innerHTML =`
            <ul>
                <li>
                    Flights starting from: ${flights.Quotes[0].MinPrice} EUR.
                </li>
                <li>
                    Destination airport: ${flights.Places[0].Name}
                </li>
            <ul>

             `
        }
    });

    xhr.open("GET", "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/FI/EUR/en-US/HEL-sky/" + airport + "-sky/2021-10-01?inboundpartialdate=2021-12-01");
    xhr.setRequestHeader("x-rapidapi-host", "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com");
    xhr.setRequestHeader("x-rapidapi-key", "006842a517msh5988660874c4abcp169e35jsn679c4ff253f2");

    xhr.send(data);
}