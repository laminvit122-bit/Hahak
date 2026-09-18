-- АВТО-ДИАГНОСТИКА КОМАНД v2
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

print("========== АВТО-ДИАГНОСТИКА ==========")

-- 1. Атрибуты моего персонажа
local function GetAttributes(obj)
    local attrs = {}
    if obj then
        for name, value in pairs(obj:GetAttributes()) do
            table.insert(attrs, name .. "=" .. tostring(value))
        end
    end
    return attrs
end

print("Мой персонаж: " .. (LP.Character and LP.Character.Name or "нет"))
if LP.Character and LP.Character.Parent then
    print("Лежит в: " .. LP.Character.Parent:GetFullName())
end

print("--- Мои атрибуты персонажа: ---")
local myAttrs = GetAttributes(LP.Character)
if #myAttrs == 0 then print("  (нет атрибутов)") end
for _, a in ipairs(myAttrs) do print("  " .. a) end

-- 2. Что внутри моего персонажа
if LP.Character then
    print("--- Что внутри моего персонажа: ---")
    for _, child in ipairs(LP.Character:GetChildren()) do
        print("  " .. child.Name .. " | " .. child.ClassName)
    end
end

-- 3. Инфа по всем игрокам
print("--- Все игроки: ---")
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LP then
        local char = p.Character
        local location = "нет персонажа"
        if char and char.Parent then
            location = char.Parent.Name
        end
        print(p.Name .. " | в: " .. location)
        if char then
            local attrs = GetAttributes(char)
            for _, a in ipairs(attrs) do
                print("    атрибут: " .. a)
            end
        end
    end
end

-- 4. Содержимое папок команд
local chars = workspace:FindFirstChild("Characters")
if chars then
    print("--- Папки в Characters: ---")
    for _, child in ipairs(chars:GetChildren()) do
        if child:IsA("Folder") then
            print(child.Name .. ": " .. #child:GetChildren() .. " объектов")
            for _, sub in ipairs(child:GetChildren()) do
                print("    -> " .. sub.Name .. " | " .. sub.ClassName)
            end
        end
    end
end

print("========================================")
