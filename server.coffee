http = require("http")

server = http.createServer (req, res) ->
  res.writeHead 200,
    "Content-Type": "text/html"

  res.end """
<!doctype html>
<head>
  <style>
    *{
      box-sizing: border-box;
      display: inline-block;
      margin: 0; padding: 0;
      color: #FFF
    }
    head,script,style{ display: none}
    body{
      background: #222;
    }
    .p1{
      padding: 20px 40px;
    }
    .c{
      text-align: center;
    }
    .w100,body{
      width: 100%;
    }
  </style>
</head>
<body>
  <div class="p1 c w100">
    <h1>Hello World</h1>
  </div>
</body>

"""

server.listen 8000

console.log "Server running at http://localhost:8000"
