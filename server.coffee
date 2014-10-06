express = require 'express'
app = express()

app.use express.static __dirname + '/public'

app.use '/ace/', express.static __dirname +
  '/node_modules/ajaxorg/ace/build/src'

app.all '/u', (req, res) ->
  cp = require 'child_process'
  ps = cp.spawn 'git', ['pull'],
    cwd: __dirname
  ps.stdout.on 'data', (data) ->
    console.log 'OUT', data.toString()
  ps.stderr.on 'data', (data) ->
    console.log 'ERR', data.toString()
  res.redirect '/'

port = process.env.PORT or process.env.HTTP_PORT or 8000
app.listen port
console.log "Server running at http://localhost:#{port}"
