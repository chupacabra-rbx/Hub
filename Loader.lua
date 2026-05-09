--quick test

repeat task.wait() until game:IsLoaded()

local Supported_Games = {
    ["https://api.jnkie.com/api/v1/luascripts/public/fd4ffb80c5bd243f73a7e6962bbed5ac0ba2c44657892dc14e3abcda54c7e624/download"] = {9476339275,12529881925}, -- Double Down
    ["https://api.jnkie.com/api/v1/luascripts/public/f126b12c3ea427a9663d6eb469a2f6866c780d7bf9e4d032850c97e4551a2e68/download"] = {71706515477118} -- +1 Jump Evolve Tower
}

for i,v in pairs(Supported_Games) do if table.find(v,game.PlaceId) then loadstring(game:HttpGet(i))() end end
