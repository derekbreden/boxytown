http = require("http")

server = http.createServer (req, res) ->

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
  <style>
    *{
      position: relative;
      box-sizing: border-box;
      display: inline-block;
      margin: 0; padding: 0;
      font-family: PT Sans, Open Sans, Arial;
      font-weight: normal;
      font-size: 0 }
    head,script,style{
      display: none }
    body,a{
      color: #231f20 }
    body{
      background: #faf3f7 }
    .p1{
      padding: 20px 40px;
      border-top: 1px solid #231f20 }
    .c{
      text-align: center }
    .w80{
      width: 80% }
    .w20{
      width: 20% }
    .w100,body,div{
      width: 100% }
    h1,.h1,.h1-sub *{
      font-size: 36px }
    p{
      font-size: 14px;
      letter-spacing: .5px }
    .logo .circle{
      width: .48em; height: .53em;
      border-radius: .48em/.53em;
      background: #231f20 }
    .logo .slice{
      width: .3em;
      height: .057em;
      background: #fff;
      margin-left: -.5em;
      margin-right: .25em;
      transform: rotate(325deg);
      -webkit-transform: rotate(325deg);
      border-radius: .1em;
      margin-bottom: .14em;
      z-index: 2 }
    .logo .eq1,.logo .eq2{
      width: .03em;
      height: .5em;
      background: #231f20;
      margin-right: -.094em;
      margin-bottom: -.2em;
      z-index: 3 }
    .logo .eq2{
      margin-left: .128em;
      z-index: 1 }
    .b0{
      background: #FFF
    }
    .b1,.b1 .logo .slice,.b1 a{
      background: #231f20;
      color: #fff }
    .b1 .logo .eq1,.b1 .logo .eq2,.b1 .logo .circle{
      background: #FFF }
    p{
      font-size: 16px;
      line-height: 24px;
      letter-spacing: 1px }
    .r{
      text-align: right }
    .m1{
      min-height: 200px }
  </style>
</head>
<body>
  <div class="b0">
    <div class="p1 b1">
      <a href="/">
      <span class="logo h1-sub">
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
    <div class="p1 b1">
      <p>
        Curate up some pics.
      </p>
    </div>
  </div>
</body>

"""

server.listen 8000

console.log "Server running at http://localhost:8000"
