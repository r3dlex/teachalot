co = coroutine.create(function ()
	for i=1,10 do
    print("co", i)
    coroutine.yield()
	end
end)

coroutine.resume(co) --> co 1
print(coroutine.status(co)) --> suspended
coroutine.resume(co) --> co 2
coroutine.resume(co) --> co 3
-- ...
coroutine.resume(co) --> co 10
coroutine.resume(co) --> imprime nada 
