local socket = require("socket")

function receber(c)
  local str = ""
  local contador = 0
  while true do
    local s, status, parte = c:receive(2^10)
    contador = contador + #(s or parte)
    if parte then str = str .. parte end 
    if status == "closed" then break end
  end
  coroutine.yield(str)
end

function download(host, arquivo)
  return
  coroutine.create(function ()
    local c = assert(socket.connect(host, 80))
    c:send("GET " .. arquivo .. 
           " HTTP/1.0\r\n\r\n")
    str = receber(c)
    c:close()
    return 1, 200, str
  end)
end

host = "www.w3.org"
downloads = {
  download(host, "/TR/REC-html32.html"),
  download(host, "/TR/html401/html40.txt") 
}

function fazerDownloads()
  local numeroDeDownloads = table.getn(downloads)
  for i = 1,numeroDeDownloads do
    local c, str = coroutine.resume(downloads[i])
    print("Bytes: " .. string.len(str))
  end
end
fazerDownloads()
