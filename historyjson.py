import json
import requests


#This is helper-script, that makes the history.json file


url = 'https://api.exchangerate.host/timeseries?start_date=2021-01-01&end_date=2021-09-08'
response = requests.get(url)
data = response.json()


with open('history.json', 'w') as file:
    json.dump(data, file)