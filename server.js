var express = require('express')
var app = express()
var redis = require('redis')
var client = redis.createClient()

app.use(express["static"](__dirname + '/public'))

app.all('/u', function(req, res){
  var cp = require('child_process')
  var ps = cp.spawn('git', ['pull'], { cwd: __dirname })
  ps.stdout.on('data', function(data) { return console.log('OUT', data.toString()) })
  ps.stderr.on('data', function(data) { return console.log('ERR', data.toString()) })
  return res.send("OK")})

app.get('/new', function(req, res){
  client.incr("countbeans",function(err,reply){
    if(!blowup(err,res)){
      client.get("countbeans",function(err,reply){
        if(!blowup(err,res)){
          res.send("GOT! " + generate_url(reply))
        }
      })
    }
  })
})

var port = process.env.PORT || process.env.HTTP_PORT || 8000
app.listen(port)

var blowup = function(err,res){
  if(err){
    console.error('ERROR!', err)
    if(res && res.redirect){
      res.redirect('/') }
    return true
  } else { return false }}


var generate_url = function(int){
  var letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  var generated = ""
  while( int > 0){
    generated = letters[int % letters.length] + generated
    int = Math.floor(int / letters.length)
  }
  return generated }
