const {BigQuery} = require('@google-cloud/bigquery');
const options = {
    keyFilename: 'secrets.json',
    projectId: 'loppuprojekti-325208',
  };
const bigquery = new BigQuery(options);
async function query() {
  // Queries the U.S. given names dataset for the state of Texas.

  const query = `SELECT name
    FROM \`testidata.covid_data_machine_learning\`
    WHERE state = 'TX'
    LIMIT 10`;

  // For all options, see https://cloud.google.com/bigquery/docs/reference/rest/v2/jobs/query
  const options = {
    query: query,
    // Location must match that of the dataset(s) referenced in the query.
    location: 'US',
  };

  // Run the query as a job
  const [job] = await bigquery.createQueryJob(options);
  console.log(`Job ${job.id} started.`);

  // Wait for the query to finish
  const [rows] = await job.getQueryResults();

  // Print the results
  console.log('Rows:');
  rows.forEach(row => console.log(row));
}