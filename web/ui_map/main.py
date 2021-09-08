import pygal

all_countries = {}

worldmap_chart = pygal.maps.world.World()
worldmap_chart.title = 'Cases per 100 000 people in the last month, click on a country for more info.'
worldmap_chart.add('low number of cases', {'ad': 0, 'ae': 0, 'af': 0, 'al': 0, 'am': 0,
                                'ao': 0, 'aq': 0, 'ar': 0, 'at': 0, 'au': 0, 
                                'az': 0, 'ba': 0, 'bd': 0, 'be': 0, 'bf': 0, 
                                'bg': 0, 'bh': 0, 'bi': 0, 'bj': 0, 'bn': 0, 
                                'bo': 0, 'br': 0, 'bt': 0, 'bw': 0, 'by': 0, 
                                'bz': 0, 'ca': 0, 'cd': 0, 'cf': 0, 'cg': 0, 
                                'ch': 0, 'ci': 0, 'cl': 0, 'cm': 0, 'cn': 0, 
                                'co': 0, 'cr': 0, 'cu': 0, 'cv': 0, 'cy': 0, 
                                'cz': 0, 'de': 0, 'dj': 0, 'dk': 0, 'do': 0, 
                                'dz': 0, 'ec': 0, 'ee': 0, 'eg': 0, 'eh': 0, 
                                'er': 0, 'es': 0, 'et': 0, 'fi': 0, 'fr': 0, 
                                'ga': 0, 'gb': 0, 'ge': 0, 'gf': 0, 'gh': 0, 
                                'gl': 0, 'gm': 0, 'gn': 0, 'gq': 0, 'gr': 0, 
                                'gt': 0, 'gu': 0, 'gw': 0, 'gy': 0, 'hk': 0, 
                                'hn': 0, 'hr': 0, 'ht': 0, 'hu': 0, 'id': 0, 
                                'ie': 0, 'il': 0, 'in': 0, 'iq': 0, 'ir': 0, 
                                'is': 0, 'it': 0, 'jm': 0, 'jo': 0, 'jp': 0, 
                                'ke': 0, 'kg': 0, 'kh': 0, 'kp': 0, 'kr': 0, 
                                'kw': 0, 'kz': 0, 'la': 0, 'lb': 0, 'li': 0, 
                                'lk': 0, 'lr': 0, 'ls': 0, 'lt': 0, 'lu': 0, 
                                'lv': 0, 'ly': 0, 'ma': 0, 'mc': 0, 'md': 0, 
                                'me': 0, 'mg': 0, 'mk': 0, 'ml': 0, 'mm': 0, 
                                'mn': 0, 'mo': 0, 'mr': 0, 'mt': 0, 'mu': 0, 
                                'mv': 0, 'mw': 0, 'mx': 0, 'my': 0, 'mz': 0, 
                                'na': 0, 'ne': 0, 'ng': 0, 'ni': 0, 'nl': 0, 
                                'no': 0, 'np': 0, 'nz': 0, 'om': 0, 'pa': 0, 
                                'pe': 0, 'pg': 0, 'ph': 0, 'pk': 0, 'pl': 0, 
                                'pr': 0, 'ps': 0, 'pt': 0, 'py': 0, 're': 0, 
                                'ro': 0, 'rs': 0, 'ru': 0, 'rw': 0, 'sa': 0, 
                                'sc': 0, 'sd': 0, 'se': 0, 'sg': 0, 'sh': 0, 
                                'si': 0, 'sk': 0, 'sl': 0, 'sm': 0, 'sn': 0, 
                                'so': 0, 'sr': 0, 'st': 0, 'sv': 0, 'sy': 0, 
                                'sz': 0, 'td': 0, 'tg': 0, 'th': 0, 'tj': 0, 
                                'tl': 0, 'tm': 0, 'tn': 0, 'tr': 0, 'tw': 0, 
                                'tz': 0, 'ua': 0, 'ug': 0, 'us': 0, 'uy': 0, 
                                'uz': 0, 'va': 0, 've': 0, 'vn': 0, 'ye': 0, 
                                'yt': 0, 'za': 0, 'zm': 0, 'zw': 0})
worldmap_chart.render_to_file('covidmap.svg')