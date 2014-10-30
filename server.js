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

app.use(function(req, res, next){
  res.iframe = function(url){
    res.send('\
    <!doctype html>\
    <style type="text/css">\
      html,body,iframe{ position: absolute;\
      display: block; width: 100%; height: 100%;\
      top: 0; left: 0; right: 0; bottom: 0;\
      border: 0; margin: 0; padding: 0;}\
    </style>\
    <iframe src="'+url+'"></iframe>\
    ')
  }
  next()
})

app.get('/', function(req, res, next){
  var h = req.host

  if(h.match(/(htmelf.com|localhost)/)){
    res.sendFile(__dirname + '/public/index.html')
  }else{
    client.get('domain:'+h,function(err, domain_reply){
      if(blowup(err,res)){ return }
      if(domain_reply){
        client.get('contents:'+domain_reply,function(err, contents_reply){
          if(blowup(err, res)){ return }
          res.send(contents_reply || "")
          if(contents_reply){
            client.zincrby('views', 1, domain_reply, function(){})
          }
        })
      }else{
        req.session.host_to_edit = h
        res.redirect('/admin')
      }
    })
  }
})


app.get('/admin', function(req, res){
  var h = req.host
  client.get('domain:'+h,function(err, domain_reply){
    if(blowup(err,res)){ return }
    if(domain_reply){
      res.iframe('/'+domain_reply+'/edit')
    }else{
      req.session.host_to_edit = req.host
      res.iframe('/new')
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
          client.set("session:"+w,req.sessionID,function(){})
          if(req.session.host_to_edit){
            client.set("domain:" + req.session.host_to_edit, w, function(){})
            req.session.host_to_edit = false
          }
        }
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
      var w = generate_url(reply)
      if(req.session.fork_contents){
        client.set("contents:" + w, req.session.fork_contents || " ", function(err, reply){
          if(blowup(err,res)){ return }
          delete req.session.fork_contents
          req.session.save(function(){
            res.redirect("/" + w + "/edit")
          })
        })
      }else{
        res.redirect("/" + w + "/edit")
      }
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
app.post('/:which/save-temp', function(req, res){
  var w = req.params.which
  req.session.fork_contents = req.body.contents
  req.session.save(function(){
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
