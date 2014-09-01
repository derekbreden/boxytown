http = require("http")

server = http.createServer (req, res) ->
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
      font-family: Arial;
      font-weight: normal;
      font-size: 0 }
    head,script,style{
      display: none }
    body{
      color: #FFF;
      background: #222 }
    .p1{
      padding: 20px 40px }
    .c{
      text-align: center }
    .b1{
      color: #222;
      background: #FFF }
    .w80{
      width: 80% }
    .w20{
      width: 20% }
    .w100,body,div{
      width: 100% }
    h1,.h1,.h1-sub *{
      font-size: 96px }
    h2,.h2,.h2-sub *{
      font-size: 64px }
    h3,.h3,.h3-sub *{
      font-size: 36px }
    p{
      font-size: 14px;
      letter-spacing: .5px }
    .logo .circle{
      width: .48em; height: .53em;
      border-radius: .48em/.53em;
      background: #FFF;
    }
    .logo .slice{
      width: .3em;
      height: .057em;
      background: #222;
      margin-left: -.5em;
      margin-right: .25em;
      transform: rotate(325deg);
      border-radius: .05em;
      margin-bottom: .14em;
      z-index: 2;
    }
    .logo .eq1,.logo .eq2{
      width: .03em;
      height: .5em;
      background: #FFF;
      margin-right: -.094em;
      margin-bottom: -.2em;
      border-radius: .1em;
      z-index: 3;
    }
    .logo .eq2{
      margin-left: .128em;
      z-index: 1;
    }
  </style>
</head>
<body>
  <div class="p1">
    <div class="w80 c">
      <span class="logo h3-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
      <h3>iqual</h3>
    </div>
    <div class="w20 c">
      <span class="logo h3-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
    </div>
  </div>
  <div class="p1">
    <div class="w80 c">
      <span class="logo h2-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
      <h2>iqual</h2>
    </div>
    <div class="w20 c">
      <span class="logo h2-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
    </div>
  </div>
  <div class="p1">
    <div class="w80 c">
      <span class="logo h1-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
      <h1>iqual</h1>
    </div>
    <div class="w20 c">
      <span class="logo h1-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
    </div>
  </div>
</body>

"""

server.listen 8000

console.log "Server running at http://localhost:8000"
