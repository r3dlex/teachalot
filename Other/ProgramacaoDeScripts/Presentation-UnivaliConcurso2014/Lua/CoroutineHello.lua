co = coroutine.create(function () 
                      print("ola!") 
                    end)
print(co) --> thread: 0x11590e0
print(coroutine.status(co)) --> suspended
coroutine.resume(co) --> ola
print(coroutine.status(co)) --> dead
