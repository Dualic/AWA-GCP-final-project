
import requests


#This is helper-script, that makes the first history.csv, last date set ot 


url = 'https://api.exchangerate.host/timeseries?start_date=2021-01-01&end_date=2021-09-08'
response = requests.get(url)
data = response.json()


set_date = "2021-09-08" #select the currencies for further use that are in this date's data.

with open("history.csv", "w") as file:
    #1.row "date", usd, eur, etc"
    file.write("date")
    file.write(",")
    for cur in data["rates"][set_date]:  
        file.write(cur) 
        file.write(",") 
    file.write("\n")


with open("history.csv", "r") as file:  
    row = file.read()
    cur_names = row.split(",") #cur_names: list of date + currencies


with open("history.csv", "a") as file:
    for date in data["rates"]:
        file.write(date)
        file.write(",")
        help_index = 0
        for name in cur_names:
            if name == "date":
                pass
            elif name in data["rates"][date]:
                file.write(str(data["rates"][date][name]))
                file.write(",")
            else:
                file.write("")
                file.write(",")
        file.write("\n")





