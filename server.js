var express = require('express')
var app = express()

app.use(express["static"](__dirname + '/public'))

app.all('/u', function(req, res) {
  var cp, ps
  cp = require('child_process')
  ps = cp.spawn('git', ['pull'], {
    cwd: __dirname
  })
  ps.stdout.on('data', function(data) {
    return console.log('OUT', data.toString())
  })
  ps.stderr.on('data', function(data) {
    return console.log('ERR', data.toString())
  })
  return res.send("OK")
})

var port = process.env.PORT || process.env.HTTP_PORT || 8000

app.listen(port)
