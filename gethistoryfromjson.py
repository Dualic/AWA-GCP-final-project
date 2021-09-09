
import requests
import json


#This is helper-script, that makes the first history.csv from the history.json



with open('history.json') as f:
  data = json.load(f)


set_date = "2021-09-08" #select the currencies for further use that are in this date's data.

with open("historyfromjson.csv", "w") as file:
    #1.row "date", usd, eur, etc"
    file.write("date")
    file.write(",")
    for cur in data["rates"][set_date]:  
        file.write(cur) 
        file.write(",") 
    file.write("\n")


with open("historyfromjson.csv", "r") as file:  
    row = file.read()
    cur_names = row.split(",") #cur_names: list of date + currencies


with open("historyfromjson.csv", "a") as file:
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





