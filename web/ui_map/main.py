import pygal
from readcodes import makedict

file = 'countries.txt'
all_countries = makedict(file)

worldmap_chart = pygal.maps.world.World()
worldmap_chart.title = 'Cases per 1 000 000 people in the last month, click on a country for more info.'
worldmap_chart.add('default', all_countries)
worldmap_chart.render_to_file('covidmap.svg')