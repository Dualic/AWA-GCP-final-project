from typing import final
from google.cloud import bigquery

client = bigquery.Client()

def dialogfunction(request):
    import json
    try:

        content_type = request.headers['content-type']
        if content_type == 'application/json':
            request_json = request.get_json(silent=True)
            geocountry = request_json['queryResult']['parameters']['geo-country']
            datetime = request_json['queryResult']['parameters']['date-time']

        query = f"SELECT per100k FROM `loppuprojekti-325208.ML_test_1.ML_global_forecast_results_with_per100k` WHERE location = '{geocountry}' AND forecast_timestamp = TIMESTAMP_TRUNC('{datetime}', DAY) LIMIT 1"
        query_job = client.query(query) 
        for row in query_job:
            myresp = str(round(row[0],2))

        query2 = f"SELECT travel_index FROM `loppuprojekti-325208.ML_test_1.forecast_and_index_table_for_prod` WHERE location = '{geocountry}' AND date = TIMESTAMP_TRUNC('{datetime}', DAY) LIMIT 1"
        query_job2 = client.query(query2)

        for row in query_job2:
            myresp2 = row[0]
        recommendation = "recommendation failed"
        if myresp2 < 0.45:
            recommendation = "definitely not recommended"
        elif myresp2 < 0.6:
            recommendation = "probably not recommended"
        elif myresp2 < 0.75:
            recommendation = "mildly recommended"
        else:
            recommendation = "highly recommended"
            
        finalresponse = f"The forecast for new COVID cases in {geocountry} on {datetime[:10]} is {myresp} per 100 000 people. By our safety index it is {recommendation} to go there."
        
    except:
        finalresponse = "Sorry, I couldn't find the information. Try with a country name and a close by date."
    return json.dumps({'fulfillmentText': finalresponse})