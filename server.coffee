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
      color: #0a0b0c;
      background: #f7f7f7 }
    .p1{
      margin: 20px 0;
      padding: 20px 40px;
      border-top: 1px solid #0a0b0c}
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
      background: #0a0b0c;
    }
    .logo .slice{
      width: .3em;
      height: .057em;
      background: #f7f7f7;
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
      background: #0a0b0c;
      margin-right: -.094em;
      margin-bottom: -.2em;
      z-index: 3;
    }
    .logo .eq2{
      margin-left: .128em;
      z-index: 1;
    }
    .b2{
      background: #0a0b0c;
      color: #f7f7f7;
    }
    p{
      font-size: 16px;
      line-height: 24px;
      letter-spacing: 1px;
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
  <div class="p1 b2 c">
    <p>
      Church-key McSweeney's food truck salvia vegan Portland drinking vinegar hashtag Odd Future, small batch fap roof party Blue Bottle before they sold out. Trust fund flannel dreamcatcher yr Austin beard, farm-to-table DIY four loko. Artisan meh put a bird on it, semiotics pork belly pop-up VHS Carles occupy hoodie lomo shabby chic American Apparel dreamcatcher viral. Bicycle rights pug Marfa yr, cardigan Truffaut selfies Etsy roof party direct trade polaroid tofu swag. Sartorial Truffaut drinking vinegar, butcher crucifix DIY Pinterest Carles ugh forage. McSweeney's kitsch craft beer you probably haven't heard of them. Locavore pickled biodiesel McSweeney's fanny pack.
    </p>
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
