from google.cloud import bigquery
from google.oauth2 import service_account
import datetime

def querydata():
    credentials = service_account.Credentials.from_service_account_file(
    'secrets.json')

    project_id = 'loppuprojekti-325208'
    client = bigquery.Client(credentials= credentials,project=project_id)

    today = datetime.date.today()

    yesterday = today - datetime.timedelta(days=1)


    query_job = client.query(f"""
    SELECT location, new_cases_per_million
    FROM testidata.coviddata
    WHERE date = '{yesterday}'
    ORDER BY location
    """)

    results = [dict(row) for row in query_job]

    records = {}
    for item in results:
        records.update({item['location']:item['new_cases_per_million']})

    return dict(records)

print(querydata())