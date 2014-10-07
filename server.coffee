express = require 'express'
app = express()
app.use express.static __dirname + '/public'

app.all '/u', (req, res) ->
  cp = require 'child_process'
  ps = cp.spawn 'git', ['pull'],
    cwd: __dirname
  ps.stdout.on 'data', (data) ->
    console.log 'OUT', data.toString()
  ps.stderr.on 'data', (data) ->
    console.log 'ERR', data.toString()
  res.redirect '/'

app.get '/editor/:whom', (req, res) ->
  res.setHeader 'Content-Type', 'text/html'
  res.write """
  <!doctype html>
  <head>
    <style type="text/css">
      body{margin:0;padding:0;}
      #ace-container{
        height: 400px;
        width: 100% }
    </style>
  </head>
  <body>
    <div id="ace-container"></div>
    <script src="/js/ace.js" type="text/javascript" charset="utf-8"></script>
    <script>
      var editor = ace.edit("ace-container")
      editor.setTheme("ace/theme/monokai")
      editor.getSession().setMode("ace/mode/html")
      editor.getSession().setTabSize(2)
      editor.getSession().setUseSoftTabs(true)
    </script>
  </body>
  """
  res.end()

app.get '/edit/:whom', (req, res) ->
  res.setHeader 'Content-Type', 'text/html'
  res.write """
  <!doctype html>
  <head>
    <link rel="shortcut icon" href="/images/favicon.png?v=2.0">
    <title>Edit . #{req.params.whom}</title>
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
          <div class="frame-container">
            <iframe src="/editor/#{req.params.whom}"></iframe>
          </div>
          <div class="r">
            <input class="i2" type="button" value="cancel" disabled>
            <input class="i2" type="button" value="save" disabled>
            <span class="m3"></span>
          </div>
      </div>
      <div class="m1 c">
        <div class="frame-container">
          <iframe id="frame-container"
            src="/preview/#{req.params.whom}"></iframe>
        </div>
      </div>
    </div>
  </body>
  """
  res.end()


port = process.env.PORT or process.env.HTTP_PORT or 8000
app.listen port
console.log "Server running at http://localhost:#{port}"
