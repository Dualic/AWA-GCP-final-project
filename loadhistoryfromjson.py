import requests
from datetime import date
import csv



#read dates to a list 

date_list = []


with open("history.csv") as file:
    for row in file:
        split = row.split(",")
        date_list.append(split[0])
        

# read currencies to a list

currencies_list = []
with open("history.csv") as file:
    for row in file:
        split = row.split(",")
        for currency in split:
            if currency != "date":
                currencies_list.append(currency)
        break

# write currencies to a file:

with open("selectedcurrencies.txt","w") as file_cur:
    for cur in currencies_list:
        file_cur.write(cur) 
        file_cur.write(",") 


# read the date

today = date.today()

base_url = 'https://api.exchangerate.host/'
final_url = base_url+str(today)  

#print(final_url)


response = requests.get(final_url)
data = response.json()


        



