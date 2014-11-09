local http = require("socket.http")
local ltn12 = require("ltn12")

host = "http://www.w3.org"
file = "/TR/REC-html32.html"

function download(h, f)
	local d_url = h .. f
	file = io.open("./html3.2.txt", "w")
	local r, c, d_ans = http.request{
		url = d_url,
		sink = ltn12.sink.file(file)
	}
	return r, c, file
end

host = "http://www.w3.org"
file = "/TR/REC-html32.html"
download(host, file)
