http = require 'http'

server = http.createServer (req, res) ->

  if req.url is '/favicon.png?v=1.3'
    path = require 'path'
    fs = require 'fs'
    filePath = path.join __dirname, 'favicon.png'
    stat = fs.statSync filePath
    res.writeHead 200,
      'Content-Type': 'image/png'
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
  <link rel="shortcut icon" href="/favicon.png?v=1.3">
  <title>Picurial - Smallest Social Network</title>
  <style>

    body,a{
      color: #333 }
    body{
      background: #333 }
    .b0{
      background: #FFF }

    .b1{
      border-bottom: 1px solid #333 }
    .b1,.b1 .logo .slice,.b1 a{
      color: #333 }
    .b1,.b1 .logo .slice,.b1 a{
      background: #FFF }
    .b1 .logo .eq1,.b1 .logo .eq2,.b1 .logo .circle{
      background: #333 }

    *{
      position: relative;
      box-sizing: border-box;
      display: inline-block;
      margin: 0; padding: 0;
      font-family: Verdana;
      font-weight: normal;
      font-size: 0 }
    head,script,style{
      display: none }
    .c{
      text-align: center }
    .w80{
      width: 80% }
    .w20{
      width: 20% }
    .w100,body,div{
      width: 100% }
    h1{
      font-size: 30px }



    .logo{
      padding-bottom: 12px;
      padding-left: 1px;
    }
    .logo .circle{
      width: 21px; height: 21px;
      border-radius: 21px }
    .logo .slice{
      width: 12px;
      height: 4px;
      margin-left: -20px;
      margin-right: 10px;
      transform: rotate(325deg);
      -webkit-transform: rotate(325deg);
      border-radius: 3px 0 4px 0px;
      margin-bottom: 5px;
      z-index: 2 }
    .logo .eq1,.logo .eq2{
      width: 2px;
      height: 20px;
      margin-right: -6px;
      margin-bottom: -8px;
      z-index: 3 }
    .logo .eq2{
      margin-left: 8px;
      z-index: 1 }



    p{
      font-size: 16px;
      line-height: 24px;
      letter-spacing: .5px;}
    .r{
      text-align: right }
    .m1{
      min-height: 300px;
      padding: 16px 32px }
    .m0{
      padding: 8px 32px }
  </style>
</head>
<body>
  <div class="b0">
    <div class="p1 b1 m0">
      <a href="/">
      <span class="logo">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
      <h1>icurial</h1>
      </a>
    </div>
    <div class="p1 m1">
      <p>
        Those curated pics though.
      </p>
    </div>
  </div>
</body>

"""

server.listen 8000

console.log "Server running at http://localhost:8000"
