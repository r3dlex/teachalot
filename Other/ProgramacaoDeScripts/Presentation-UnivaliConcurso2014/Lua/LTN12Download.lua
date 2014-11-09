local http = require("socket.http")
local ltn12 = require("ltn12")

host = "http://www.w3.org"
file = "/TR/REC-html32.html"

function download(h, f)
  local t = {}
  local d_url = h .. f
  local r, c, d_ans = http.request{
    url = d_url,
    sink = ltn12.sink.table(t)
  }
  return r, c, t
end

r, c, t = download(host, file)
print(table.concat(t))
