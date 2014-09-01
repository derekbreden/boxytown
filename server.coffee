http = require("http")

server = http.createServer (req, res) ->
  res.writeHead 200,
    "Content-Type": "text/html"

  res.end """
<!doctype html>
<head>
  <style>
    *{
      display: inline-block;
      margin: 0; padding: 0;
    }
    head,script,style{ display: none}
  </style>
</head>
<body>
  <h1>Hello World</h1>
</body>

"""

server.listen 8000

console.log "Server running at http://localhost:8000"
