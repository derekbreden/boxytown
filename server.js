var express = require('express')
var app = express()
var redis = require('redis')
var client = redis.createClient()
var compress = require('compression')
var session = require('express-session')
var RedisStore = require('connect-redis')(session)
var bodyParser = require('body-parser')

app.use(session({
  store: new RedisStore({}),
  secret: 'keyboard cat'
}))
app.use(compress())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded())
app.use(express["static"](__dirname + '/public'))

app.all('/u', function(req, res){
  var cp = require('child_process')
  var ps = cp.spawn('git', ['pull'], { cwd: __dirname })
  ps.stdout.on('data', function(data){ return console.log('OUT', data.toString()) })
  ps.stderr.on('data', function(data){ return console.log('ERR', data.toString()) })
  return res.send("OK")})

app.get('/new', function(req, res){
  client.incr("countbeans",function(err,reply){
    if(blowup(err,res)){ return }
    client.get("countbeans",function(err,reply){
      if(blowup(err,res)){ return }
      res.redirect("/" + generate_url(reply) + "/edit")
    })
  })
})

app.get('/:which/edit', function(req, res){
  res.sendFile(__dirname + '/public/edit.html') })

app.get('/:which', function(req, res){
  var w = req.params.which
  client.get('contents:'+w,function(err, reply){
    if(blowup(err,res)){ return }
    res.send(reply || "")
  })
})

app.post('/:which/save', function(req, res){
  var w = req.params.which
  client.get('session:'+w, function(err, session_reply){
    if(blowup(err,res)){ return }
    client.get('password:'+w, function(err, password_reply){
      if(blowup(err,res)){ return }
      if(
        (session_reply && req.session.sessionId === session_reply)
        ||
        (password_reply && req.session.password === password_reply)
        ||
        (!session_reply)
      ){
        client.set("contents:" + w, req.body.contents || " ", function(err, reply){
          if(blowup(err,res)){ return }
          if(!session_reply){
            client.set("session:"+w,req.session.sessionId,function(){}) }
          res.send("OK")
        })
      }else{
        res.send("NOT OK")
      }
    })
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
  var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_"
  var generated = ""
  while( int > 0){
    generated = chars[int % chars.length] + generated
    int = Math.floor(int / chars.length) }
  return generated }
