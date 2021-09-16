// Load Node modules
var express = require('express');
const ejs = require('ejs');
// Initialise Express
var app = express();
// Render static files
app.use(express.static('public'));
// Set the view engine to ejs
app.set('view engine', 'ejs');
// Port website will run on
app.listen(1230);

// *** GET Routes - display pages ***
// Root Route
app.get('/', function (req, res) {
    const {BigQuery} = require('@google-cloud/bigquery');
    const options = {
        keyFilename: 'secrets.json',
        projectId: 'loppuprojekti-325208',
    };
    const bigquery = new BigQuery(options);
    async function query() {
    // Queries the U.S. given names dataset for the state of Texas.

    const today = new Date()
    const yesterday = new Date(today)

    yesterday.setDate(yesterday.getDate() - 1)

    isotoday = today.toDateString()
    isodate = yesterday.toISOString().split('T')[0]

    const query = `SELECT *
        FROM \`testidata.coviddata\`
        WHERE date = '${isodate}'
        ORDER BY location`;

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

    return rows
    }

    query().then(rows => {
        res.render("pages/index", {rows: JSON.stringify(rows)}) });
//    res.render('pages/index', {
//        rows: query()
//      });
});

app.get('/about', function(req, res) {
    res.render('pages/about');
});