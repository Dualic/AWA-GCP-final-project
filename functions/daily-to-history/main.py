#get todayscurrencydata.json
#update the data to historyfromjson.csv
import json
from google.cloud import storage
import os
import ndjson
import json
import csv
import pandas as pd

def currenttohistory(self):
  cur_names = ["date","AED","AFN","ALL","AMD","ANG","AOA","ARS","AUD","AWG","AZN","BAM","BBD","BDT","BGN","BHD","BIF","BMD","BND","BOB","BRL","BSD","BTC","BTN","BWP","BYN","BZD","CAD","CDF","CHF","CLF","CLP","CNH","CNY","COP","CRC","CUC","CUP","CVE","CZK","DJF","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","GBP","GEL","GGP","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL","HRK","HTG","HUF","IDR","ILS","IMP","INR","IQD","IRR","ISK","JEP","JMD","JOD","JPY","KES","KGS","KHR","KMF","KPW","KRW","KWD","KYD","KZT","LAK","LBP","LKR","LRD","LSL","LYD","MAD","MDL","MGA","MKD","MMK","MNT","MOP","MRO","MRU","MUR","MVR","MWK","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","RWF","SAR","SBD","SCR","SDG","SEK","SGD","SHP","SLL","SOS","SRD","SSP","STD","STN","SVC","SYP","SZL","THB","TJS","TMT","TND","TOP","TRY","TTD","TWD","TZS","UAH","UGX","USD","UYU","UZS","VES","VND","VUV","WST","XAF","XAG","XAU","XCD","XDR","XOF","XPD","XPF","XPT","YER","ZAR","ZMW","ZWL"]
  client = storage.Client()
  bucket1 = client.get_bucket('currency-raw-data-json')
  bucket2 = client.get_bucket('currency_csv_bucket')

  jsonFile = bucket1.get_blob('todayscurrencydata.json')
  historyFile = bucket2.get_blob('history.csv')
  
  # convert to blob to json (todays values):
  json_data_string = jsonFile.download_as_string()
  data = ndjson.loads(json_data_string)
  #get the date -> data is now in format [{...,}] -> access with [0]
  today = data[0]["date"] #works!



  # convert to blob to json OR CSV? (history):
  
  historyFile.download_to_filename("/tmp/historydata.csv")
  #history_data = ndjson.loads(json_histroy_data_string)
  # how to get csv from blob?

  
  try:
    with open("/tmp/historydata.csv", "a") as file:
        file.write(today)
        for name in cur_names:
            if name == "date":
                pass
            elif name in data[0]["rates"]:
                file.write(",")
                file.write(str(data[0]["rates"][name]))  
            else:
                file.write(",")
                file.write("")
        file.write("\n")
  except:
      "error"


  #upload 
  destination_blob_name = "history.csv"
  bucket_name = 'currency_csv_bucket'

  storage_client = storage.Client()
  bucket = storage_client.bucket(bucket_name)
  blob = bucket.blob(destination_blob_name)

  print("upload alkaa")
  blob.upload_from_filename("/tmp/historydata.csv")

  print("upload ok")


