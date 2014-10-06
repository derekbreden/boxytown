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

app.get '/edit/:whom', (req, res) ->
  res.setHeader 'Content-Type', 'text/html'
  res.write """
  <!doctype html>
  <head>
    <link rel="shortcut icon" href="/images/favicon.png?v=2.0">
    <title>BoxyTown . Professional simple websites</title>
    <link rel="stylesheet" href="/style.css">
  </head>
  <body>
    <div>
      <div class="m2">
        <a href="/" class="logo">
          <span class="a"></span><span class="b"></span><span class="c"></span>
        </a>
        <h1>#{req.params.whom}</h1>
      </div>
      <hr>
      <div class="m1 c">
          <div class="ace-container" id="ace-container"></div>
          <div class="r">
            <input class="i2" type="button" value="cancel" disabled>
            <input class="i2" type="button" value="save" disabled>
            <span class="m3"></span>
          </div>
      </div>
      <div class="m1 c">
        <div class="frame-container">
          <iframe id="frame-container"
            src="http://#{req.params.whom}.boxy.town"></iframe>
        </div>
      </div>
    </div>
  </body>
  """
  res.end()


port = process.env.PORT or process.env.HTTP_PORT or 8000
app.listen port
console.log "Server running at http://localhost:#{port}"
