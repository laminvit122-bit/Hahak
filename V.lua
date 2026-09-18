-- АВТО-ДИАГНОСТИКА КОМАНД
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

print("========== АВТО-ДИАГНОСТИКА ==========")

-- 1. Проверяем мой Humanoid.TeamColor
local function GetHumanoidInfo(plr)
    local char = plr.Character
    if not char then return "нет персонажа" end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return "нет Humanoid" end
    return tostring(hum.TeamColor) .. " | Team=" .. tostring(hum.Team)
end

print("Мой TeamColor: " .. GetHumanoidInfo(LP))

-- 2. Проверяем атрибуты внутри персонажа
local function GetCharAttributes(plr)
    local char = plr.Character
    if not char then return {} end
    local attrs = {}
    for name, value in pairs(char:GetAttributes()) do
        table.insert(attrs, name .. "=" .. tostring(value))
    end
    return attrs
end

print("--- Мои атрибуты персонажа: ---")
for _, a in ipairs(GetCharAttributes(LP)) do
    print("  " .. a)
end

-- 3. Смотрим где лежит мой персонаж
if LP.Character and LP.Character.Parent then
    print("Мой персонаж в: " .. LP.Character.Parent:GetFullName())
end

-- 4. Проходим по всем игрокам и выводим инфу
print("--- Все игроки: ---")
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LP then
        local char = p.Character
        local location = "нет"
        local teamColor = "?"
        local attrs = ""

        if char and char.Parent then
            location = char.Parent.Name
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                teamColor = tostring(hum.TeamColor) .. " | Team=" .. tostring(hum.Team)
            end
            for name, value in pairs(char:GetAttributes()) do
                attrs = attrs .. " [" .. name .. "=" .. tostring(value) .. "]"
            end
        end

        print(p.Name .. " | в: " .. location .. " | TeamColor: " .. teamColor)
        if attrs ~= "" then
            print("    атрибуты: " .. attrs)
        end
    end
end

-- 5. Проверяем содержимое папок команд
local chars = workspace:FindFirstChild("Characters")
if chars then
    print("--- Содержимое папок команд: ---")
    for _, folder in ipairs(chars:GetChildren()) do
        if folder:IsA("Folder") then
            print(folder.Name .. ": " .. #folder:GetChildren() .. " объектов")
            for _, child in ipairs(folder:GetChildren()) do
                print("    -> " .. child.Name)
            end
        end
    end
end

print("========================================")
