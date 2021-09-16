import pygal
from readcodes import makedict
from makelinks import identifier
from pygal.style import Style
custom_style = Style(colors=('#CCCCFF', '#9FE2BF', '#DFFF00', '#DE3163', '#EAECEE'),
                    tooltip_font_size='11',
                    no_data_font_size='11',
                    value_font_size='11',
                    value_label_font_size='11',
                    label_font_size='11',
                    major_label_font_size='11'
                    )

file = 'countries.txt'
a_dictionary, b_dictionary, c_dictionary, d_dictionary, e_dictionary= makedict(file)

worldmap_chart = pygal.maps.world.World(style=custom_style)
worldmap_chart.title = 'Cases per 1 000 000 people in the last day, click on a country for more info.'
worldmap_chart.add('Low no. cases', a_dictionary)
worldmap_chart.add('Medium no. cases', b_dictionary)
worldmap_chart.add('High no. cases', c_dictionary)
worldmap_chart.add('Extreme no. cases', d_dictionary)
worldmap_chart.add('No data', e_dictionary)
worldmap_chart.render_to_file('covidmap.svg')
identifier('covidmap.svg')