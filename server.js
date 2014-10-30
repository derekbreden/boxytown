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

app.get('/', function(req, res, next){
  var h = req.host
  client.get('domain:'+h,function(err, reply){
    if(blowup(err,res)){ return }
    if(reply){
      client.get('contents:'+reply,function(err, reply){
        if(blowup(err, res)){ return }
        res.send(reply || "")
        if(reply){
          client.zincrby('views', 1, w, function(){})
        }
      })
    }else{
      next()
    }
  })
})

app.use(express["static"](__dirname + '/public'))


var checkForPermission = function(req, next){
  var w = req.params.which
  client.get('session:'+w, function(err, session_reply){
    client.get('password:'+w, function(err, password_reply){
      if(
        (session_reply && req.sessionID === session_reply)
        ||
        (password_reply && req.session.password === password_reply)
        ||
        (req.body && req.body.password && password_reply && req.body.password === password_reply)
        ||
        (!session_reply)
      ){
        if(!session_reply){
          client.set("session:"+w,req.sessionID,function(){}) }
        if(req.body && req.body.password){
          req.session.password = req.body.password
        }
        next()
      }else{
        if(password_reply){
          next("not owner - password available")
        }else{
          next("not owner")
        }
      }
    })
  })
}
var checkForPermissionMiddleware = function(req, res, next){
  checkForPermission(req,function(err){
    if(err){
      res.send("NOT OK")
    }else{
      next()
    }
  })

}


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

app.all('/:which/info', function(req, res){
  checkForPermission(req, function(err){
    res.send(err || "is owner")
  })
})

app.get('/:which/edit', function(req, res){
  res.sendFile(__dirname + '/public/edit.html') })

app.get('/:which', function(req, res){
  var w = req.params.which
  client.get('contents:'+w,function(err, reply){
    if(blowup(err,res)){ return }
    res.send(reply || "")
    if(reply){
      client.zincrby('views', 1, w, function(){})
    }
  })
})

app.post('/:which/save', checkForPermissionMiddleware, function(req, res){
  var w = req.params.which
  client.set("contents:" + w, req.body.contents || " ", function(err, reply){
    if(blowup(err,res)){ return }
    res.send("OK")
  })
})
app.post('/:which/save-domain', checkForPermissionMiddleware, function(req, res){
  var w = req.params.which
  client.set("domain:" + req.body.domain, w, function(err, reply){
    if(blowup(err,res)){ return }
    res.send("OK")
  })
})
app.post('/:which/save-pass', checkForPermissionMiddleware, function(req, res){
  var w = req.params.which
  client.set("password:" + w, req.body.password, function(err, reply){
    if(blowup(err,res)){ return }
    res.send("OK")
  })
})
app.get('/home/recents', function(req, res){
  client.zrevrangebyscore("views", "+inf", "-inf", "limit", "0", "10",
    function(err, reply){
      if(blowup(err,res)){ return }
      console.warn("GOT!!", reply)
      res.send(reply)
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
