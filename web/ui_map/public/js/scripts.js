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

    let airports = ["Andorra", "DXB", "SVX", "TIA", "EVN", "LAD", "AEP", "VIE", "SYD", "GYD", "SJJ",
            "DAC", "BRU", "OUA", "SOF", "BAH", "BJM", "COO", "BWN", "LPB", "GIG", "PBH", "GBE", "MSQ", "BZE", "YYZ",
            "BZV", "BGF", "BZV", "GVA", "ABJ", "SCL", "DLA", "PVG", "BOG", "SJO", "PAZ", "RAI", "LCA",
            "PRG", "FRA", "JIB", "CPH", "SDQ", "ALG", "UIO", "TLL", "CAI", "ASM", "MAD", "ADD", "HEL", "CDG", "LBV",
            "MAN", "TBS", "CKY", "ACC", "GOH", "BJL", "CKY", "SSG", "ATH", "GUA", "OXB", "GEO", "HKG",
            "SAP", "DBV", "PAP", "BUD", "CGK", "DUB", "TLV", "DEL", "LEC", "ASB", "RKV", "FCO", "MBJ", "AMM", "NRT", "NBO", "FRU",
            "PNH", "ICN", "KWI", "ALA", "VTE", "BEY", "Liechtenstein", "CMB", "ROB", "MSU", "VNO", "LUX", "RIX", "TIP",
            "CMN", "Monaco", "KIV", "TGD", "TNR", "SKP", "BKO", "RGN", "UBN", "MFM", "NKC", "MLA", "MRU", "MLE",
            "LLW", "MEX", "KUL", "MPM", "WDH", "NIM", "LOS", "MGA", "AMS", "OSL", "KTM", "AKL", "MCT", "PTY", "LIM",
            "POM", "MNL", "LHE", "WAW", "Palestine", "LIS", "ASU", "OTP", "BEG", "SVO", "KGL", "JED", "SEZ",
            "KRT", "ARN", "SIN", "LJU", "BTS", "FNA", "San Marino", "DKR", "NOV", "PBM", "TMS", "SAL", "SFQ",
            "SHO", "NDJ", "LFW", "BKK", "DYU", "DIL", "TUN", "IST", "TPE", "DAR", "KBP", "EBB", "JFK", "MVD", "TAS",
            "Vatican", "SMR", "SGN", "HRG", "JNB", "LUN", "HRE"]

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
            var div = document.getElementById('wtf');
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
            priceMin = flights.Quotes[0].MinPrice;
            
            if (flights.Places[0].Name != "Helsinki Vantaa") {
                airportName = flights.Places[0].Name;
                airportCode = flights.Places[0].IataCode;
            } else {
                airportName = flights.Places[1].Name;
                airportCode = flights.Places[1].IataCode;
            }
            
            document.getElementById("flightdata").innerHTML =`
            <ul>
                <li>
                    Flights starting from: ${priceMin} EUR.
                </li>
                <li>
                    Destination airport: ${airportName}
                </li>
            <ul>
             `
        }
    });

    xhr.open("GET", "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/FI/EUR/en-US/HEL-sky/" + airport + "-sky/2021-10-01");
    xhr.setRequestHeader("x-rapidapi-host", "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com");
    xhr.setRequestHeader("x-rapidapi-key", "006842a517msh5988660874c4abcp169e35jsn679c4ff253f2");

    xhr.send(data);
}