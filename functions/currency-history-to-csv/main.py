import json
from google.cloud import storage
import os
import ndjson
import json



#This function is triggered by the finalization of "currency-history.json" file in currency-raw-data-json bucket.
#This is helper-function, that makes the first history.csv from the history.json

def history(event, context):
    newfilename = event['name']  
    listen_for_file = "currency-history.json"
    # if statement makes sure that correct file is listened to:
    if context.event_type == 'google.storage.object.finalize' and newfilename == listen_for_file: 

        client = storage.Client()
        bucket1 = client.get_bucket('currency-raw-data-json')
        jsonFile = bucket1.get_blob('currency-history.json')

        json_data_string = jsonFile.download_as_string()
        data = ndjson.loads(json_data_string)

        #list of currencies
        cur_names = ["AED","AFN","ALL","AMD","ANG","AOA","ARS","AUD","AWG","AZN","BAM","BBD","BDT","BGN","BHD","BIF","BMD","BND","BOB","BRL","BSD","BTC","BTN","BWP","BYN","BZD","CAD","CDF","CHF","CLF","CLP","CNH","CNY","COP","CRC","CUC","CUP","CVE","CZK","DJF","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","GBP","GEL","GGP","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL","HRK","HTG","HUF","IDR","ILS","IMP","INR","IQD","IRR","ISK","JEP","JMD","JOD","JPY","KES","KGS","KHR","KMF","KPW","KRW","KWD","KYD","KZT","LAK","LBP","LKR","LRD","LSL","LYD","MAD","MDL","MGA","MKD","MMK","MNT","MOP","MRO","MRU","MUR","MVR","MWK","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","RWF","SAR","SBD","SCR","SDG","SEK","SGD","SHP","SLL","SOS","SRD","SSP","STD","STN","SVC","SYP","SZL","THB","TJS","TMT","TND","TOP","TRY","TTD","TWD","TZS","UAH","UGX","USD","UYU","UZS","VES","VND","VUV","WST","XAF","XAG","XAU","XCD","XDR","XOF","XPD","XPF","XPT","YER","ZAR","ZMW","ZWL"]
        
        #set_date = "2021-09-08" #select the currencies for further use that are in this date's data.


        #write header row
        with open("/tmp/historyTEST.csv", "w") as file:
            #1.row "date", usd, eur, etc"
            file.write("date")
            for cur in cur_names:  
                file.write(",") 
                file.write(cur) 
            file.write("\n")

        #write day-to-day currency data
        with open("/tmp/historyTEST.csv", "a") as file:
            for date in data[0]["rates"]:
                file.write(date)
                help_index = 0
                for name in cur_names:
                    if name == "date":
                        pass
                    elif name in data[0]["rates"][date]:
                        file.write(",")
                        file.write(str(data[0]["rates"][date][name]))
                    else:
                        file.write(",")
                        file.write("")
                file.write("\n")

        #upload 
        destination_blob_name = "history.csv"
        bucket_name = 'currency_csv_bucket'

        storage_client = storage.Client()
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(destination_blob_name)

        print("upload startes")
        blob.upload_from_filename("/tmp/historyTEST.csv")

        print("upload ok")
