http = require 'http'

server = http.createServer (req, res) ->

  if req.url is '/favicon.png?v=1.4'
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
  <link rel="shortcut icon" href="/favicon.png?v=1.4">
  <title>Picurial . the smallest social network</title>
  <style>

    body,a{
      color: #1a1a1a }
    .b0{
      background: #FFF}

    .logo .slice{
      color: #333 }
    .logo .slice{
      background: #FFF }
    .logo .eq1,
    .logo .eq2,
    .logo .circle{
      background: #1a1a1a }
    a:hover .logo .eq1,
    a:hover .logo .eq2,
    a:hover .logo .circle{
      background: #357eeb }
    a:hover{
      color: #357eeb }

    .b1,.b1 .logo .slice,.b1 a{
      color: #FFF }
    .b1 a:hover{
      color: #357eeb }
    body,.b1,.b1 .logo .slice,.b1 a{
      background: #1a1a1a }
    .b1 .logo .eq1,
    .b1 .logo .eq2,
    .b1 .logo .circle{
      background: #FFF }

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



    .logo{
      padding-bottom: 24px;
      padding-left: 2px }
    .logo.p{
      padding-bottom: 12px;
      padding-left: 1px }
    .logo .circle{
      width: 42px; height: 42px;
      border-radius: 42px }
    .logo.p .circle{
      width: 21px; height: 21px }
    .logo .slice{
      width: 24px;
      height: 8px;
      margin-left: -40px;
      margin-right: 20px;
      transform: rotate(325deg);
      -webkit-transform: rotate(325deg);
      border-radius: 6px 0 8px 0px;
      margin-bottom: 10px;
      z-index: 2 }
    .logo.p .slice{
      width: 12px;
      height: 4px;
      margin-left: -20px;
      margin-right: 10px;
      border-radius: 2px 0 4px 0;
      margin-bottom: 5px }
    .logo .eq1,.logo .eq2{
      width: 4px;
      height: 40px;
      margin-right: -12px;
      margin-bottom: -16px;
      z-index: 3 }
    .logo.p .eq1, .logo.p .eq2{
      width: 2px;
      height: 20px;
      margin-right: -6px;
      margin-bottom: -8px }
    .logo .eq2{
      margin-left: 16px;
      z-index: 1 }
    .logo.p .eq2{
      margin-left: 8px }



    p{
      font-size: 15px;
      line-height: 24px;
      letter-spacing: .5px;}
    .p2{
      font-size: 10px }
    .r{
      text-align: right }
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
  <div class="b0">
    <div class="p1 m0 b0">
      <div class="w60">
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
      <div class="w40 r v0">
        <a href="/sign-up">
          <p>sign up</p>
        </a>
        <span class="spacer"></span>
        <p>.</p>
        <span class="spacer"></span>
        <a href="/log-in">
          <p>log in</p>
        </a>
      </div>
    </div>
    <div class="p1 m1">
      <p>
        Some stuff will go here ...
      </p>
    </div>
  </div>
  <div class="p1 b1 m0">
    <div class="w60">
      <a href="/">
        <span class="logo p">
          <div class="eq1"></div>
          <div class="eq2"></div>
          <div class="circle"></div>
          <div class="slice"></div>
        </span>
        <h2>icurial</h2>
        <p class="p2">
          <span class="spacer"></span>.<span class="spacer"></span>the smallest social network
        </p>
      </a>
    </div>
    <div class="w40 r">
      <a href="/sign-up">
        <p class="p2">sign up</p>
      </a>
      <span class="spacer"></span>
      <p class="p2">.</p>
      <span class="spacer"></span>
      <a href="/log-in">
        <p class="p2">log in</p>
      </a>
    </div>
  </div>
</body>

"""
  console.log "index \x1B[32mserved\x1B[39m"

server.listen 8000

console.log "Server running at http://localhost:8000"
