produtor = coroutine.create(
  function ()
    while true do
      local produzido = produzir() 
      enviar(produzido)
    end
  end)

function enviar(x)
  coroutine.yield(x)
end

function consome()
  local status, value = coroutine.resume(produtor)
  return value
end

while true do
	local produzido = consome(prod)
end
