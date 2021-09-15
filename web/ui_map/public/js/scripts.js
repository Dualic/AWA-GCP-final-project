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

        var element = svgObject.getElementById(argmnt);
        element.addEventListener("click",function(){
            for (index = 0; index < clientRows.length; index++) {
                if (clientRows[index].location == argmnt2){
                    currentCountry = clientRows[index]
                };
            };
            document.getElementById("mySidebar").style.width = "850px"
            var div = document.getElementById('mySidebar');
            div.innerHTML = `
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
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
            </ul>        
            `
        }, false);
    }
}, false);

function closeNav() {
    document.getElementById("mySidebar").style.width = "0";
    }


    