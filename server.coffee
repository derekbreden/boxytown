http = require 'http'

server = http.createServer (req, res) ->

  statics =
    'images/favicon.png': 'image/png'
    'images/mockup.png': 'image/png'

  for file, type of statics
    if req.url.match file
      path = require 'path'
      fs = require 'fs'
      filePath = path.join __dirname, file
      stat = fs.statSync filePath
      res.writeHead 200,
        'Content-Type': type
        'Content-Length': stat.size
      readStream = fs.createReadStream filePath
      readStream.pipe res
      return

  if req.url is '/u'
    cp = require 'child_process'
    ps = cp.spawn 'git', ['pull'],
      cwd: __dirname
    ps.stdout.on 'data', (data) ->
      console.log 'OUT', data.toString()
    ps.stderr.on 'data', (data) ->
      console.log 'ERR', data.toString()

  res.writeHead 200,
    "Content-Type": "text/html"

  res.end """
<!doctype html>
<head>
  <link rel="shortcut icon" href="/images/favicon.png?v=1.5">
  <title>BoxyTown . Professional simple websites</title>
  <style>

    body{
      background: #f5f4f0 }
    body,a{
      color: #1a1a1a }
    a:hover{
      color: #357eeb }

    *{
      position: relative;
      box-sizing: border-box;
      display: inline-block;
      margin: 0; padding: 0;
      font-family: Helvetica Neue;
      font-weight: normal;
      font-size: 0 }
    head,script,style{
      display: none }
    .c{
      text-align: center }
    .w80{
      width: 80% }
    .w60{
      width: 60% }
    .w40{
      width: 40% }
    .w20{
      width: 20% }
    .w100,body,div{
      width: 100% }
    h1{
      font-size: 48px }
    h2{
      font-size: 24px }



    p{
      font-size: 15px;
      line-height: 24px;
      letter-spacing: .5px;}
    .p2{
      font-size: 10px }
    .r{
      text-align: right }
    .c{
      text-align: center }
    .m1{
      min-height: 300px;
      padding: 32px }
    .m0 {
      padding: 16px 32px }
    .v0 {
      vertical-align: top }
    .spacer{
      padding: 0 0 0 16px }
  </style>
</head>
<body>
  <div class="c">
    <img src="/images/mockup.png" style="max-width:100%">
  </div>
</body>

"""
  console.log "index \x1B[32mserved\x1B[39m"

server.listen 8000

console.log "Server running at http://localhost:8000"
