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
      font-family: PT Sans, Open Sans;
      font-weight: normal;
      font-size: 0 }
    head,script,style{
      display: none }
    body{
      color: #231f20;
      background: #fff }
    .p1{
      margin-bottom: 40px;
      padding: 20px 40px;
      border-top: 1px solid #231f20}
    .c{
      text-align: center }
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
      background: #231f20;
    }
    .logo .slice{
      width: .3em;
      height: .057em;
      background: #fff;
      margin-left: -.5em;
      margin-right: .25em;
      transform: rotate(325deg);
      border-radius: .1em;
      margin-bottom: .14em;
      z-index: 2;
    }
    .logo .eq1,.logo .eq2{
      width: .03em;
      height: .5em;
      background: #231f20;
      margin-right: -.094em;
      margin-bottom: -.2em;
      z-index: 3;
    }
    .logo .eq2{
      margin-left: .128em;
      z-index: 1;
    }
    .b2,.b2 .logo .slice{
      background: #231f20;
      color: #fff;
    }
    .b2 .logo .eq1,.b2 .logo .eq2,.b2 .logo .circle{
      background: #FFF
    }
    p{
      font-size: 16px;
      line-height: 24px;
      letter-spacing: 1px;
    }
    .r{
      text-align: right
    }
  </style>
</head>
<body>
  <div class="p1 b2">
    <div class="w80">
      <span class="logo h3-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
      <h3>iqual</h3>
    </div>
    <div class="w20 r">
      <span class="logo h3-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
    </div>
  </div>
  <div class="p1">
    <p class="w80">
      Church-key McSweeney's food truck salvia vegan Portland drinking vinegar hashtag Odd Future, small batch fap roof party Blue Bottle before they sold out. Trust fund flannel dreamcatcher yr Austin beard, farm-to-table DIY four loko. Artisan meh put a bird on it, semiotics pork belly pop-up VHS Carles occupy hoodie lomo shabby chic American Apparel dreamcatcher viral.
    </p>
  </div>
  <div class="p1 b2 r">
    <p class="w80">
      Church-key McSweeney's food truck salvia vegan Portland drinking vinegar hashtag Odd Future, small batch fap roof party Blue Bottle before they sold out. Trust fund flannel dreamcatcher yr Austin beard, farm-to-table DIY four loko. Artisan meh put a bird on it, semiotics pork belly pop-up VHS Carles occupy hoodie lomo shabby chic American Apparel dreamcatcher viral.
    </p>
  </div>
  <div class="p1">
    <div class="w80">
      <span class="logo h1-sub">
        <div class="eq1"></div>
        <div class="eq2"></div>
        <div class="circle"></div>
        <div class="slice"></div>
      </span>
      <h1>iqual</h1>
    </div>
    <div class="w20 r">
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
