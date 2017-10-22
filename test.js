/**
 *
 * Script-Name: example_get_status
 */
var protobuf = require('protocol-buffers')
const fs = require('fs');
// pass a proto file as a buffer/string or pass a parsed protobuf-schema object 
var messages = protobuf(fs.readFileSync('message.proto'))

var express = require('express'); // call express
var app = express(); // define our app using express
var bodyParser = require('body-parser');
var conv = require("binstring");
//blockchain stuff
var blockchain = require('mastercard-blockchain');
var MasterCardAPI = blockchain.MasterCardAPI;
var consumerKey = "D-2aHNdzHb3Kw5l4OlTL76nG6z6pRy6LmezGEG2m8c10950b!4e3142f3fda94e9ca486669c044907f40000000000000000"; // You should copy this from "My Keys" on your project page e.g. UTfbhDCSeNYvJpLL5l028sWL9it739PYh6LU5lZja15xcRpY!fd209e6c579dc9d7be52da93d35ae6b6c167c174690b72fa
var keyStorePath = "team9-money2020-1507730923-sandbox.p12"; // e.g. /Users/yourname/project/sandbox.p12 | C:\Users\yourname\project\sandbox.p12
var keyAlias = "keyalias"; // For production: change this to the key alias you chose when you created your production key
var keyPassword = "keystorepassword"; // For production: change this to the key alias you chose when you created your production key
// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

var port = process.env.PORT || 8080; // set our port

var router = express.Router(); // get an instance of the express Router

var authentication = new MasterCardAPI.OAuth(consumerKey, keyStorePath, keyAlias, keyPassword);
MasterCardAPI.init({
    sandbox: true,
    debug: true,
    authentication: authentication
});

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get('/bloodQuery', function(req, res) {
    var requestData = {
        "hash": req.query.hash
    };

    blockchain.TransactionEntry.read("", requestData, function(error, data) {
        if (error) {
            console.error("HttpStatus: " + error.getHttpStatus());
            console.error("Message: " + error.getMessage());
            console.error("ReasonCode: " + error.getReasonCode());
            console.error("Source: " + error.getSource());
            console.error(error);

        } else {
            console.log(data.hash); //Output-->1e6fc898c0f0853ca504a29951665811315145415fa5bdfa90253efe1e2977b1
            console.log(data.slot); //Output-->1503594631
            console.log(data.status); //Output-->confirmed
            console.log(data.value); //Output-->0a0f4d41393920446f63756d656e742031
            var stuff = conv(data.value, { in: 'hex', out: 'buffer'});
            console.log(messages.BloodAsset.decode(stuff))
            //console.log(conv(data.value, { in: 'hex', out: 'utf8'}));
            //var newJson = JSON.stringify(messages.BloodAsset.decode(stuff));
            var newJson = messages.BloodAsset.decode(stuff)
            //newJson["locationHistory"] = conv(newJson["locationHistory"], { in: 'hex', out: 'binary'})
            //newJson["medicalHistory"] = conv(newJson["medicalHistory"], { in: 'hex', out: 'binary'})
            //newJson = JSON.stringify(newJson)
            //console.log(newJson);
            //newJson["locationHistory"] = 
            res.send(newJson)
        }
    });
    //res.json({ message: 'hooray! welcome to our api!' });   
});
router.post('/createBlood', function(req, res) {
    //var newValue = conv(req.query.value, { in: 'binary', out: 'base64'});
var buf = messages.BloodAsset.encode({
	sex: req.body.sex,
	bloodType: req.body.bloodType,
	ageRange: req.body.ageRange,
	date: req.body.date,
	amount: req.body.amount,
	riskFactor: req.body.riskFactor,
	medicalHistory: req.body.medicalHistory,
	locationHistory: req.body.locationHistory
})
    
    var requestData = {
  "app": "TM09",
  "encoding": "base64",
  "value": buf.toString('base64')
};
blockchain.TransactionEntry.create(requestData
, function (error, data) {
	if (error) {
		console.error("HttpStatus: "+error.getHttpStatus());
		console.error("Message: "+error.getMessage());
		console.error("ReasonCode: "+error.getReasonCode());
		console.error("Source: "+error.getSource());
		console.error(error);

	}
	else {
		console.log(data.hash);     //Output-->1e6fc898c0f0853ca504a29951665811315145415fa5bdfa90253efe1e2977b1
		console.log(data.slot);     //Output-->1503662624
		console.log(data.status);     //Output-->pending
		res.send(data.hash);
	}
});
});


router.get('/test', function(req, res) {
var buf = messages.BloodAsset.encode({
	sex: req.query.sex,
	bloodType: req.query.bloodType,
	ageRange: req.query.ageRange,
	date: Date.now(),
	amount: req.query.amount,
	riskFactor: req.query.riskFactor,
	medicalHistory: req.query.medicalHistory,
	locationHistory: req.query.locationHistory
})

console.log(buf.toString('base64'))


var obj = messages.BloodAsset.decode(buf)
console.log(obj)
});

// more routes for our API will happen here

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/api', router);

// START THE SERVER
// =============================================================================
app.listen(port);
console.log('Magic happens on port ' + port);



// You only need to do initialize MasterCardAPI once
//