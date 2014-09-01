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
      font-family: Helvetica;
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
    .w100,body,div{
      width: 100% }
    h1,.h1{
      font-size: 400px;
      letter-spacing: 1px }
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
      margin-right: -.095em;
      margin-bottom: -.2em;
      border-radius: .05em;
      z-index: 3;
    }
    .logo .eq2{
      margin-left: .13em;
      z-index: 1;
    }
  </style>
</head>
<body>
  <div class="p1 c">
    <span class="logo">
      <div class="eq1 h1"></div>
      <div class="eq2 h1"></div>
      <div class="circle h1"></div>
      <div class="slice h1"></div>
    </span>
    <h1>iqual</h1>
  </div>
</body>

"""

server.listen 8000

console.log "Server running at http://localhost:8000"
