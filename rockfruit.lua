repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players")
repeat wait() until game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

math.randomseed(tick())
local Services = setmetatable({}, {__index = function(Self, Index)
    return game:GetService(Index)
end})

local Data = {}

local Workspace1 = Services.Workspace
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local hmr = plr.Character:FindFirstChild("HumanoidRootPart")

--local function xyzabc()

    _G.Settings = {
        Main = {
            -- Auto Farm Mob
            ["Select Mob"] = "Bacon",
            ["Farm Mob"] = false,
            -- Auto Farm Boss
            ["Select Boss"] = "Turbo Granny",
            ["Auto Boss"] = false,
            -- Config Dungeon
            ["Distance DG"] = 25,
            ["Safe Mode DG"] = 20,
            -- Farm Dungeon
            ["Auto Dungeon"] = false,
            ["Fully Dungeon"] = false,
        },
        Tele = {
            -- Auto Stat
            ["Select Stat"] = "Defense",
            ["Amount Point"] = 1,
            ["Auto Stat"] = false,
            -- Select NPC,Map
            ["Select NPC"] = nil,
            ["Select Map"] = nil,
            -- Fake (Number)
            ["Num Stack"] = 100,
        },
        Misc = {
            -- Auto Store
            ["Black List"] = "Combat",
            ["Auto Store"] = false,
            -- Auto Item
            ["Select Item"] = "Demon Man",
            ["Click Item"] = false,
            -- Misc 1
            ["Auto Miner"] = false,
            ["Ramdom Chest"] = false,
            -- Auto Equip Accessories
            ["Select Accessories"] = nil,
            ["Equip Accessories"] = false,
            -- Misc 2
            ["Collect Fruit"] = false,
            ["Delete Effect"] = false,
        },
        Web = {
            --  Webhook Player
            ["Webhook Player"] = "hihi",
            ["Delay Send"] = 120,
            ["Auto Send 1"] = false,
            -- Webhook Raid
            ["Webhook Raid"] = "hihi",
            ["Auto Send 2"] = false,
            -- JobId Tab
            ["Job Id"] = "hihi",
        },
        Config = {
            -- Main Setting
            ["Select Weapon"] = "Melee",
            ["Select Method"] = "Upper",
            ["Distance Farm"] = 8,
            -- Misc Setting
            ["Doge Skill Cid"] = false,
            ["Auto Freeze"] = false,
            -- Multi Equip Weapon
            ["Hold to Change"] = 2,
            ["Multi Weapon"] = false,
            ["Melee"] = false,
            ["Sword"] = false,
            ["Power"] = false,
            ["Special"] = false,
            -- Auto Skill
            ["Auto Skill"] = false,
            ["Z"] = true, ["X"] = true,
            ["C"] = true, ["V"] = true,
            ["F"] = true,
        },
    }

local NG = "Rock Fruit"

function LoadSettings()
    if _G.LoadDefault == nil or _G.LoadDefault == true then
        if readfile and writefile and isfile and isfolder then
            if not isfolder("ELGATO HUB") then
                makefolder("ELGATO HUB")
            end
            if not isfolder("ELGATO HUB/" .. NG .. "/") then
                makefolder("ELGATO HUB/" .. NG .. "/")
            end
            if not isfile("ELGATO HUB/" .. NG .. "/" .. plr.Name .. ".json") then
                writefile("ELGATO HUB/" .. NG .. "/" .. plr.Name .. ".json", game:GetService("HttpService"):JSONEncode(_G.Settings))
            else
                local Decode = game:GetService("HttpService"):JSONDecode(readfile("ELGATO HUB/" .. NG .. "/" .. plr.Name .. ".json"))
                for i, v in pairs(Decode) do
                    _G.Settings[i] = v
                end
            end
        else
            return warn("Status : Undetected Executor")
        end
    end
end

function SaveSettings()
    if _G.LoadDefault == nil or _G.LoadDefault == true then
        if readfile and writefile and isfile and isfolder then
            if not isfile("ELGATO HUB/" .. NG .. "/" .. plr.Name .. ".json") then
                LoadSettings()
            else
                local Decode = game:GetService("HttpService"):JSONDecode(readfile("ELGATO HUB/" .. NG .. "/" .. plr.Name .. ".json"))
                local Array = {}
                for i, v in pairs(_G.Settings) do
                    Array[i] = v
                end
                writefile("ELGATO HUB/" .. NG .. "/" .. plr.Name .. ".json", game:GetService("HttpService"):JSONEncode(Array))
            end
        else
            return warn("Status : Undetected Executor")
        end
    end
end


LoadSettings()

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Settings.Main["Farm Mob"]
                or _G.Settings.Main["Auto Dungeon"]
                or (_G.Settings.Main["Fully Dungeon"] and Data[tostring(plr.UserId)])
                or _G.Settings.Misc["Auto Miner"]
                or _G.Settings.Misc["Click Item"]
                or _G.Settings.Main["Auto Boss"] then
                if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local Noclip = Instance.new("BodyVelocity")
                    Noclip.Name = "BodyClip"
                    Noclip.Parent = plr.Character.HumanoidRootPart
                    Noclip.MaxForce = Vector3.new(100000, 100000, 100000)
                    Noclip.Velocity = Vector3.new(0, 0, 0)
                end
            else
                if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    plr.Character.HumanoidRootPart.BodyClip:Destroy()
                end
                _G.AutoSkill = false
            end
        end)
    end)
end)

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Settings.Main["Farm Mob"]
                or _G.Settings.Main["Auto Dungeon"]
                or (_G.Settings.Main["Fully Dungeon"] and Data[tostring(plr.UserId)])
                or _G.Settings.Misc["Auto Miner"]
                or _G.Settings.Misc["Click Item"]
                or _G.Settings.Main["Auto Boss"] then
                for _, v in pairs(plr.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Config["Auto Freeze"] 
                and (_G.Settings.Main["Farm Mob"]
                or _G.Settings.Main["Auto Dungeon"]
                or _G.Settings.Main["Fully Dungeon"] and Data[tostring(plr.UserId)]
                or _G.Settings.Misc["Auto Miner"]
                or _G.Settings.Misc["Click Item"]
                or _G.Settings.Main["Auto Boss"]) then
                if plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                    plr.Character.HumanoidRootPart.Anchored = true
                else
                    plr.Character.HumanoidRootPart.Anchored = false
                end
            else
                if plr.Character:FindFirstChild("HumanoidRootPart") then
                    plr.Character.HumanoidRootPart.Anchored = false
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            local Raid = _G.Settings.Config["Distance DG"]
            local Farm = _G.Settings.Config["Distance Farm"]
            if _G.Settings.Config["Select Method"] == "Behind" then
                MethodFarm = CFrame.new(0, 0, Farm)
                MethodRaid = CFrame.new(0, 0, Raid)
            elseif _G.Settings.Config["Select Method"] == "Below" then
                MethodFarm = CFrame.new(0, -Farm, 0) * CFrame.Angles(math.rad(90), 0, 0)
                MethodRaid = CFrame.new(0, -Raid, 0) * CFrame.Angles(math.rad(90), 0, 0)
            elseif _G.Settings.Config["Select Method"] == "Upper" then
                MethodFarm = CFrame.new(0, Farm, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                MethodRaid = CFrame.new(0, Raid, 0) * CFrame.Angles(math.rad(-90), 0, 0)
            else
                MethodFarm = CFrame.new(0, 0, 0)
                MethodRaid = CFrame.new(0, 0, 0)
            end
        end)
    end
end)

function SkillDown(va)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, va, false, game)
end

function SkillUp(va)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, va, false, game)
end

local function useSkill(key)
    SkillDown(key)
    wait(0.1)
    SkillUp(key)
end

spawn(function()
    while wait() do
        if _G.AutoSkill then
            if plr.PlayerGui.HUD:FindFirstChild("MobileSkill") then
                for _, v in pairs(plr.PlayerGui.HUD.MobileSkill:GetChildren()) do
                    if v:IsA("ImageButton") and v.BackgroundColor3 ~= Color3.fromRGB(255, 0, 0) then
                        if (v.Name == "Z" and _G.Settings.Config["Z"]) or
                            (v.Name == "X" and _G.Settings.Config["X"]) or
                            (v.Name == "C" and _G.Settings.Config["C"]) or
                            (v.Name == "V" and _G.Settings.Config["V"]) or
                            (v.Name == "F" and _G.Settings.Config["F"]) then
                            firesignal(v.MouseButton1Click)
                        end
                    end
                end
            end
        end
    end
end)

function UnEquipWeapon(Weapon)
    if hmr then
        local char = plr.Character
        if char:FindFirstChild(Weapon) then
            _G.NotAutoEquip = true
            char[Weapon].Parent = plr.Backpack
            wait()
            _G.NotAutoEquip = false
        end
    end
end

function EquipWeapon(ToolSe)
    if hmr then
        if not _G.NotAutoEquip then
            local backpack = plr.Backpack
            if backpack:FindFirstChild(ToolSe) then
                local tool = backpack:FindFirstChild(ToolSe)
                plr.Character.Humanoid:EquipTool(tool)
            end
        end
    end
end

function TP(Pos)
    if not plr or not Pos then return end

    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then return end

    if character.Humanoid.Health > 0 then
        character.HumanoidRootPart.CFrame = Pos
    end
end

function Click()
    game:GetService'VirtualUser':CaptureController()
    game:GetService'VirtualUser':Button1Down(Vector2.new(1e4, 1e4))
    if _G.Settings.Config["Auto Skill"] then
        _G.AutoSkill = true
    else
        _G.AutoSkill = false
    end
end

function Click1()
    game:GetService'VirtualUser':CaptureController()
    game:GetService'VirtualUser':Button1Down(Vector2.new(1e4, 1e4))
end

function Fix_Bugs(vi)
    vi.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
    if vi.Humanoid:FindFirstChild("Animator") then
        vi.Humanoid.Animator:Destroy()
    end
    vi.HumanoidRootPart.CanCollide = false
    vi.Head.CanCollide = false
    vi.Humanoid.JumpPower = 0
    vi.Humanoid.WalkSpeed = 0
end

spawn(function()
    while wait() do
        local CacLo1 = _G.Settings.Config["Select Weapon"]
        if CacLo1 == "Sword" then
            WeaponFarm = plr:GetAttribute("UseSword")
        elseif CacLo1 == "Special" then
            WeaponFarm = plr:GetAttribute("UseSpecial")
        elseif CacLo1 == "Melee" then
            WeaponFarm = plr:GetAttribute("UseMelee")
        elseif CacLo1 == "DevilFruit" then
            WeaponFarm = plr:GetAttribute("UseDevilFruit")
        end
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            WeaponRamdom = "Combat"
            if RDWP == 1 then
                if _G.Settings.Config["Melee"] then
                    WeaponRamdom = plr:GetAttribute("UseMelee")
                else
                    WeaponRamdom = WeaponFarm
                end
                wait(_G.Settings.Config["Hold to Change"])
                RDWP = RDWP + 1
            elseif RDWP == 2 then
                if _G.Settings.Config["Sword"] then
                    WeaponRamdom = plr:GetAttribute("UseSword")
                else
                    WeaponRamdom = WeaponFarm
                end
                wait(_G.Settings.Config["Hold to Change"])
                RDWP = RDWP + 1
            elseif RDWP == 3 then
                if _G.Settings.Config["Power"] then
                    WeaponRamdom = plr:GetAttribute("UseDevilFruit")
                else
                    WeaponRamdom = WeaponFarm
                end
                wait(_G.Settings.Config["Hold to Change"])
                RDWP = RDWP + 1
            elseif RDWP == 4 then
                if _G.Settings.Config["Special"] then
                    WeaponRamdom = plr:GetAttribute("UseSpecial")
                else
                    WeaponRamdom = WeaponFarm
                end
                wait(_G.Settings.Config["Hold to Change"])
                RDWP = RDWP + 1
            else
                RDWP = 1
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Config["Multi Weapon"] then
                Weapon1 = WeaponRamdom
            else
                Weapon1 = WeaponFarm
            end
        end)
    end
end)

function CheckMob(Name)
    for _, v in pairs(Workspace1.Mob:GetChildren()) do
        if v.Name == Name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return true
        end
    end
    return false
end

Auto_Stat = function()
    if plr:GetAttribute("Point") >= _G.Settings.Tele["Amount Point"] then
        game:GetService("ReplicatedStorage").Remotes:WaitForChild("System"):FireServer("UpStats", _G.Settings.Tele["Select Stat"], _G.Settings.Tele["Amount Point"])
    end
end

Auto_Miner = function()
    for _, v in pairs(Workspace1.Miner:GetChildren()) do
        if plr.Backpack:FindFirstChild("Shovel") or plr.Character:FindFirstChild("Shovel") then
            TP(v.CFrame)
            EquipWeapon("Shovel")
            Fire_Proxi(v)
        else
            TP(Workspace1.Shovel.CFrame)
            Fire_Proxi(Workspace1.Shovel)
        end
    end
end

function Fire_Proxi(target)
    for _, v in pairs(target:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            if v.HoldDuration ~= 0 then
                v.HoldDuration = 0
            end
            v:InputHoldBegin()
            wait()
            v:InputHoldEnd()
        end
    end
end

function Fire_Click(target)
    for _, v in pairs(target:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
        end
    end
end

Click_NPC = function()
    local TargetNPC
    local IsProximity = false

    if _G.Settings.Misc["Select Item"] == "Cloak Shadow" then
        TargetNPC = Workspace1.Delta.Part
    elseif _G.Settings.Misc["Select Item"] == "Dragon Blade" then
        TargetNPC = Workspace1.Rock.Part
    elseif _G.Settings.Misc["Select Item"] == "Demon Man" then
        TargetNPC = Workspace1.npcClick.DemonMan666
        IsProximity = true
    end

    if TargetNPC then
        if IsProximity then
            TP(TargetNPC:GetPivot() * CFrame.new(0, 2, 0))
            Fire_Proxi(TargetNPC)
        else
            TP(TargetNPC.CFrame * CFrame.new(0, 2, 0))
            Fire_Click(TargetNPC)
        end
    end
end

function GetItem(va)
    local DataOrb = nil
    if plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
        if plr.Character.Humanoid.Health > 0 then
            if CheckItem(va) then
                DataOrb = 1
            else
                if CheckGui(va) then
                    DataOrb = 0
                end
            end
            if DataOrb == 0 then
                _G.AutoSkill = false
                game:GetService("ReplicatedStorage").Remotes:WaitForChild("Inventory"):FireServer(va)
                wait()
                DataOrb = 1
                wait(2)
            end
        end
    end
end

function CheckMob(Name)
    for _, v in pairs(Workspace1.Mob:GetChildren()) do
        if v.Name == Name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return true
        end
    end
    return false
end

Check_UI = function()
    if plr.PlayerGui:FindFirstChild("Dialogue") then
        local Ui = plr.PlayerGui.Dialogue.Frame:FindFirstChild("3")
        if Ui then
            local vim = game:GetService("VirtualInputManager")
            Ui.Size = UDim2.new(10, 0, -10, 0)
            if Ui.BackgroundTransparency == 0 or Ui.TextTransparency == 0 then
                Ui.TextTransparency = 1
                Ui.BackgroundTransparency = 1
            else
                mousemoveabs(100, 100)
                vim:SendMouseButtonEvent(100, 100, 0, true, game, 0)
                wait()
                vim:SendMouseButtonEvent(100, 100, 0, false, game, 0)
            end
        end
    end
end

Check_Dungeon = function()
    if plr.PlayerGui:FindFirstChild("WaveUI") and plr.PlayerGui.WaveUI.Enabled then
        local WaveUI = plr.PlayerGui.WaveUI:FindFirstChild("Wave")
        if WaveUI and (string.find(WaveUI.Text, "Please") or string.find(WaveUI.Text, "Countdown")) then
            TP(CFrame.new(Vector3.new(18518, 195, -831)))
            UnEquipWeapon(Weapon1)
            _G.AutoSkill = false
            if CheckItem("Orb Dungeon") then
                EquipWeapon("Orb Dungeon")
                Click1()
                Check_UI()
            end
        end
        return true
    else
        return false
    end
end

function CheckItem(Name)
    if plr.Backpack:FindFirstChild(Name) or plr.Character:FindFirstChild(Name) then
        return true
    else
        return false
    end
end

function CheckGui(Name)
    if plr.PlayerGui.HUD.Inventory.ScrollingFrameList:FindFirstChild(Name) then
        return true
    else
        return false
    end
end

Have_Boss = function()
    for _, v in pairs(Workspace1.Mob:GetChildren()) do
        if v.Name == "Turbo Granny" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            Fix_Bugs(v)
            repeat task.wait()
                TP(v.HumanoidRootPart.CFrame * MethodFarm)
                EquipWeapon(Weapon1)
                Click()
            until not _G.Settings.Main["Fully Dungeon"] or not v.Parent or v.Humanoid.Health <= 0 or CheckItem("Orb Dungeon")
        end
    end
end

Not_Boss = function()
    if CheckItem("Spirit Curse") then
        TP(Workspace1.NpcSpawnBoss["Turbo Granny"].Torso.CFrame)
        fireproximityprompt(Workspace1.NpcSpawnBoss["Turbo Granny"].Torso.ProximityPrompt)
        _G.AutoSkill = false
    elseif CheckGui("Spirit Curse") then
        GetItem("Spirit Curse")
    else
        for _, v in pairs(Workspace1.Mob:GetChildren()) do
            if v.Name == "Serpo Alien" then
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    Fix_Bugs(v)
                    repeat task.wait()
                        TP(v.HumanoidRootPart.CFrame * MethodFarm)
                        EquipWeapon(Weapon1)
                        Click()
                    until not _G.Settings.Main["Fully Dungeon"] or not v.Parent or v.Humanoid.Health <= 0 or CheckMob("Turbo Granny")
                end
            end
        end
    end
end

Not_Boss1 = function()
    if CheckItem("Spirit Curse") then
        TP(Workspace1.NpcSpawnBoss["Turbo Granny"].Torso.CFrame)
        fireproximityprompt(Workspace1.NpcSpawnBoss["Turbo Granny"].Torso.ProximityPrompt)
        _G.AutoSkill = false
    elseif CheckGui("Spirit Curse") then
        GetItem("Spirit Curse")
    else
        for _, v in pairs(Workspace1.Mob:GetChildren()) do
            if v.Name == "Serpo Alien" then
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    Fix_Bugs(v)
                    repeat task.wait()
                        TP(v.HumanoidRootPart.CFrame * MethodFarm)
                        EquipWeapon(Weapon1)
                        Click()
                    until not _G.Settings.Main["Auto Boss"] or not v.Parent or v.Humanoid.Health <= 0 or CheckMob("Turbo Granny")
                end
            end
        end
    end
end

Have_Boss1 = function()
    for _, v in pairs(Workspace1.Mob:GetChildren()) do
        if v.Name == "Turbo Granny" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            Fix_Bugs(v)
            repeat task.wait()
                TP(v.HumanoidRootPart.CFrame * MethodFarm)
                EquipWeapon(Weapon1)
                Click()
            until not _G.Settings.Main["Auto Boss"] or not v.Parent or v.Humanoid.Health <= 0 or CheckItem("Orb Dungeon")
        end
    end
end

Have_Boss2 = function()
    for _, v in pairs(Workspace1.Mob:GetChildren()) do
        if v.Name == "Cid" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            Fix_Bugs(v)
            if CheckItem("Orb Atomic") or CheckItem("Orb Shadow") then
                if CheckItem("Orb Atomic") then
                    EquipWeapon("Orb Atomic")
                elseif CheckItem("Orb Shadow") then
                    EquipWeapon("Orb Shadow")
                end
                Click1()
                Check_UI()
            else
                repeat task.wait()
                    if _G.Settings.Config["Doge Skill Cid"] then
                        if not v.Head:FindFirstChild("Z") then
                            TP(v.HumanoidRootPart.CFrame * MethodFarm)
                            EquipWeapon(Weapon1)
                            Click()
                        else
                            TP(Workspace1.NpcSpawnBoss:FindFirstChild("Cid").Torso.CFrame * CFrame.new(0, 100, 0))
                            UnEquipWeapon(Weapon1)
                            _G.AutoSkill = false
                        end
                    else
                        TP(v.HumanoidRootPart.CFrame * MethodFarm)
                        EquipWeapon(Weapon1)
                        Click()
                    end
                until not _G.Settings.Main["Auto Boss"] or not v.Parent or v.Humanoid.Health <= 0
            end
        end
    end
end

Not_Boss2 = function()
    if CheckItem("Orb Atomic") then
        local NPC_CID = Workspace1.NpcSpawnBoss:FindFirstChild("Cid")
        TP(NPC_CID.Torso.CFrame)
        fireproximityprompt(NPC_CID.Torso.ProximityPrompt)
        _G.AutoSkill = false
    elseif CheckGui("Orb Atomic") then
        GetItem("Orb Atomic")
    elseif CheckItem("Orb Shadow") then
        game:GetService("ReplicatedStorage").Modules.NetworkFramework:WaitForChild("NetworkEvent"):FireServer("fire", nil, "Crafting", "Orb Atomic")
        _G.AutoSkill = false
    elseif CheckGui("Orb Shadow") then
        GetItem("Orb Shadow")
    else
        for _, v in pairs(Workspace1.Mob:GetChildren()) do
            if v.Name == "Strong Garden" then
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    Fix_Bugs(v)
                    repeat task.wait()
                        TP(v.HumanoidRootPart.CFrame * MethodFarm)
                        EquipWeapon(Weapon1)
                        Click()
                    until not _G.Settings.Main["Auto Boss"]  or not v.Parent or v.Humanoid.Health <= 0 or CheckMob("Cid")
                end
            end
        end
    end
end


BOSS_NUANG = function()
    for _, v in pairs(Workspace1.Mob:GetChildren()) do
        if v.Name == "BOSS NUANG" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            Fix_Bugs(v)
            repeat task.wait()
                TP(v.HumanoidRootPart.CFrame * MethodFarm)
                EquipWeapon(Weapon1)
                Click()
            until not _G.Settings.Main["Auto Boss"] or not v.Parent or v.Humanoid.Health <= 0
        end
    end
end

Random_Fruit = function()
    if plr:GetAttribute("Diamond") >= 250 then
        game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("RandomFruit"):FireServer("Random", 5)
        task.wait(2)
    end
end

Collect_Fruit = function()
    for _, v in pairs(Workspace1.Fruits:GetChildren()) do
        if v:FindFirstChild("Handle") then
            v.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame
        end
    end
end

Auto_Equip = function()
    if not plr.Character:FindFirstChild(_G.Settings.Misc["Select Accessories"]) then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory"):FireServer(_G.Settings.Misc["Select Accessories"])
        wait(1)
    end
end

OpenDungeon = function()
    if Workspace1:FindFirstChild("DungeonRing") then
        _G.AutoSkill = false
        TP(CFrame.new(Vector3.new(-124, 34, -1138)))
    else
        if CheckItem("Orb Dungeon") then
            _G.AutoSkill = false
            TP(CFrame.new(-126, 34, -1187))
            useSkill("E")
        else
            GetItem("Orb Dungeon")
            wait()
        end
    end
end

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Main["Auto Dungeon"] and not Auto_Store() then
                if Check_Dungeon() then
                    for _, v in pairs(Workspace1.DunMob:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            Fix_Bugs(v)
                            repeat task.wait()
                                local HealthMin = plr.Character.Humanoid.MaxHealth * _G.Settings.Main["Safe Mode DG"] / 100
                                if plr.Character.Humanoid.Health <= HealthMin then
                                    TP(CFrame.new(Vector3.new(18112,69,-811)))
                                    UnEquipWeapon(Weapon1)
                                    _G.AutoSkill = false
                                else
                                    TP(v.HumanoidRootPart.CFrame * MethodRaid)
                                    EquipWeapon(Weapon1)
                                    Click()
                                end
                            until not _G.Settings.Main["Auto Dungeon"] or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    OpenDungeon()
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Main["Fully Dungeon"] and not Auto_Store() then
                if Check_Dungeon() then
                    for _, v in pairs(Workspace1.DunMob:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            Fix_Bugs(v)
                            repeat task.wait()
                                local HealthMin = plr.Character.Humanoid.MaxHealth * _G.Settings.Main["Safe Mode DG"] / 100
                                if plr.Character.Humanoid.Health <= HealthMin then
                                    TP(CFrame.new(Vector3.new(18112,69,-811)))
                                    UnEquipWeapon(Weapon1)
                                    _G.AutoSkill = false
                                else
                                    TP(v.HumanoidRootPart.CFrame * MethodRaid)
                                    EquipWeapon(Weapon1)
                                    Click()
                                end
                            until not _G.Settings.Main["Fully Dungeon"] or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    OpenDungeon()
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Misc["Click Item"] then
                Click_NPC()
            end
            if _G.Settings.Misc["Ramdom Chest"] then
                Random_Fruit()
            end
            if _G.Settings.Misc["Collect Fruit"] then
                Collect_Fruit()
            end
            if _G.Settings.Tele["Auto Stat"] then
                Auto_Stat()
            end
            if _G.Settings.Misc["Equip Accessories"] then
                Auto_Equip()
            end
            if _G.Settings.Misc["Auto Miner"] then
                Auto_Miner()
            end
            if _G.Settings.Misc["Auto Store"]
                or not _G.Settings.Main["Farm Mob"]
                or not _G.Settings.Main["Fully Dungeon"]
                or not _G.Settings.Main["Auto Boss"]
                or not _G.Settings.Main["Auto Dungeon"] then
                Auto_Store()
            end
            if _G.Settings.Web["Auto Send 1"] then
                Web1(_G.Settings.Web["Webhook Player"])
                wait(_G.Settings.Web["Delay Send"])
            end
            if _G.Settings.Web["Send Wk Raid"] then
                Web2(_G.Settings.Web["Webhook Raid"])
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Main["Auto Boss"] and not Auto_Store() then
                if _G.Settings.Main["Select Boss"] == "Turbo Granny" then
                    if CheckMob("Turbo Granny") then
                        Have_Boss1()
                    else
                        Not_Boss1()
                    end
                elseif _G.Settings.Main["Select Boss"] == "BOSS NUANG" then
                    BOSS_NUANG()
                elseif _G.Settings.Main["Select Boss"] == "Cid" then
                    if CheckMob("Cid") then
                        Have_Boss2()
                    else
                        Not_Boss2()
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Main["Fully Dungeon"] and Data[tostring(plr.UserId)] and not Auto_Store() then
                if not Check_Dungeon() and not Workspace1:FindFirstChild("DungeonRing") then
                    if not CheckItem("Orb Dungeon") and not CheckGui("Orb Dungeon") then
                        if CheckMob("Turbo Granny") then
                            Have_Boss()
                        else
                            Not_Boss()
                        end
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.Settings.Main["Farm Mob"] and not Auto_Store() then
                for _, v in pairs(Workspace1.Mob:GetChildren()) do
                    if v.Name == _G.Settings.Main["Select Mob"] and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        Fix_Bugs(v)
                        repeat task.wait()
                            TP(v.HumanoidRootPart.CFrame * MethodFarm)
                            EquipWeapon(Weapon1)
                            Click()
                        until not _G.Settings.Main["Farm Mob"] or not v.Parent or v.Humanoid.Health <= 0
                    end
                end
            end
        end)
    end
end)


local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/Library/retard/ElgatoUi.lua"))()
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/lobox920/Notification-Library/Main/Library.lua"))()

-- Create the main window
local Window = redzlib:MakeWindow({"ELGATO HUB | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, "", "elgato_rockfruit.json"})

-- Add minimize button
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://74806385470289", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 10) }
})

-- Create the tabs
local Tab1 = Window:MakeTab({"Update Log", "rbxassetid://135938100025895"})
local Tab2 = Window:MakeTab({"Farm/Boss", "rbxassetid://18718155799"})
local Tab3 = Window:MakeTab({"Stat/Teles", "rbxassetid://18718151237"})
local Tab4 = Window:MakeTab({"Misc/Item", "rbxassetid://18721836821"})
local Tab5 = Window:MakeTab({"Web/Info", "rbxassetid://18966652144"})
local Tab6 = Window:MakeTab({"  Settings", "rbxassetid://18717951749"})

Tab1:AddDiscordInvite({
    Name = "elgato hub | Community",
    Description = "Join our discord community to receive information about the next update",
    Logo = "rbxassetid://74806385470289",
    Invite = "https://discord.gg/UrkE64Mfb7"
})

Tab1:AddToggle({
    Name = "Status Text On/Off",
    Default = true,
    Callback = function(va)
        for _, v in pairs(game.CoreGui:GetChildren()) do
            if v.Name == "elgato status" then
                if v:FindFirstChild("TextLabel") then
                    v.TextLabel.Visible = va
                end
            end
        end
    end
})

Tab1:AddButton({
    Name = "Manager Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/elgato/a/Manager.lua"))()
    end
})

-- Update Log Tab
Tab1:AddParagraph({"Update Version 2.0", "+ New interface\n+ Add jobid tab\n+ add auto farm cid\n+And more..."})
Tab1:AddParagraph({"Update Version 1.5", "+ Add new boss event\n+ Add delete effect\n+ Add get better item\n+And more..."})
Tab1:AddParagraph({"Update Version 1", "+ Add Auto Dungeon (Fully change to premium)\n+ Add auto store item,Auto Equip Accessories\n+ Add Hitbox,Remake Safe Mode Dungeon\n+ add New Tab,And More..."})
Tab1:AddParagraph({"Update Version 0.5", "+ Fixed auto skill\n+ change amount 50-> 100\n+ change distance 20-100\n+ add hold to change weapon (multi weapon)"})

-- Auto Farm Tab

Tab2:AddSection({
    Name = "Auto Mobs"
})

-- Monster Dropdown
local MonNames = {}

for _, v in pairs(Workspace1.Mob:GetChildren()) do
    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
        table.insert(MonNames, v.Name)
    end
end

local MonSelect = Tab2:AddDropdown({
    Name = "Select Monsters",
    Options = MonNames,
    Default = _G.Settings.Main["Select Mob"] or nil,
    Callback = function(value)
        _G.Settings.Main["Select Mob"] = value
        SaveSettings()
    end
})

-- Refresh Monsters Button
Tab2:AddButton({
    Name = "Refresh Monsters",
    Callback = function()
        MonNames = {}
        for _, v in pairs(Workspace1.Mob:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                table.insert(MonNames, v.Name)
            end
        end
        MonSelect:Set(MonNames)
        NotificationLibrary:SendNotification("Success", "successful reset", 5)
    end
})

Tab2:AddToggle({
    Name = "Auto Farm Monster",
    Default = _G.Settings.Main["Farm Mob"] or false,
    Callback = function(value)
        _G.Settings.Main["Farm Mob"] = value
        SaveSettings()
    end
})

Tab2:AddSection({
    Name = "Auto Boss"
})

Tab2:AddDropdown({
    Name = "Select Boss",
    Options = {"Turbo Granny", "BOSS NUANG", "Cid"},
    Default = _G.Settings.Main["Select Boss"] or "BOSS NUANG",
    Callback = function(value)
        _G.Settings.Main["Select Boss"] = value
        SaveSettings()
    end
})

Tab2:AddToggle({
    Name = "Auto Boss",
    Default = _G.Settings.Main["Auto Boss"] or false,
    Callback = function(value)
        _G.Settings.Main["Auto Boss"] = value
        SaveSettings()
    end
})

Tab2:AddSection({
    Name = "Auto Dungeon"
})

Tab2:AddSlider({
    Name = "Distance Raid",
    Min = 0,
    Max = 100,
    Default = _G.Settings.Config["Distance DG"] or 20,
    Rounding = 1,
    Callback = function(value)
        _G.Settings.Config["Distance DG"] = value
        SaveSettings()
    end
})

Tab2:AddSlider({
    Name = "Safe Mode %",
    Min = 0,
    Max = 100,
    Default = _G.Settings.Main["Safe Mode DG"] or 20,
    Rounding = 1,
    Callback = function(value)
        _G.Settings.Main["Safe Mode DG"] = value
        SaveSettings()
    end
})

if Data[tostring(plr.UserId)] then
    Tab2:AddToggle({
        Name = "Fully Auto Dungeon",
        Default = _G.Settings.Main["Fully Dungeon"] or false,
        Callback = function(value)
            _G.Settings.Main["Fully Dungeon"] = value
            SaveSettings()
        end
    })
end

Tab2:AddToggle({
    Name = "Auto Dungeon",
    Default = _G.Settings.Main["Auto Dungeon"] or false,
    Callback = function(value)
        _G.Settings.Main["Auto Dungeon"] = value
        SaveSettings()
    end
})

-- Stat Tab
Tab3:AddSection({
    Name = "Auto Stat"
})

Tab3:AddDropdown({
    Name = "Select Stat",
    Options = {"Melee", "Defense", "Sword", "Special", "DevilFruit"},
    Default = _G.Settings.Tele["Select Stat"] or "Defense",
    Callback = function(value)
        _G.Settings.Tele["Select Stat"] = value
        SaveSettings()
    end
})

Tab3:AddSlider({
    Name = "Amount",
    Min = 0,
    Max = 500,
    Default = _G.Settings.Tele["Amount Point"] or 100,
    Rounding = 1,
    Callback = function(value)
        _G.Settings.Tele["Amount Point"] = value
        SaveSettings()
    end
})

Tab3:AddToggle({
    Name = "Auto Stat",
    Flag = "AutoStat",
    Default = _G.Settings.Tele["Auto Stat"] or false,
    Callback = function(value)
        _G.Settings.Tele["Auto Stat"] = value
        SaveSettings()
    end
})

-- Teleport Tab
Tab3:AddSection({
    Name = "TP All"
})

local MapNames1 = {}
for _, v in pairs(Workspace1.npcClick:GetChildren()) do
    table.insert(MapNames1, v.Name)
end

Tab3:AddDropdown({
    Name = "Select NPC",
    Options = MapNames1,
    Default = _G.Settings.Tele["Select NPC"] or nil,
    Callback = function(value)
        _G.Settings.Tele["Select NPC"] = value
        SaveSettings()
    end
})

Tab3:AddButton({
    Name = "TP Select",
    Callback = function()
        for _, v in pairs(Workspace1.npcClick:GetChildren()) do
            if v.Name == _G.Settings.Tele["Select NPC"] then
                if v:IsA("Model") then
                    TP(v:GetPivot())
                elseif v:IsA("Part") or v:IsA("MeshPart") then
                    TP(v.CFrame)
                end
            end
        end
    end
})

local MapNames2 = {}
for _, v in pairs(Workspace1.Island:GetChildren()) do
    table.insert(MapNames2, v.Name)
end

Tab3:AddDropdown({
    Name = "Select Map",
    Options = MapNames2,
    Default = _G.Settings.Tele["Select Map"] or nil,
    Callback = function(value)
        _G.Settings.Tele["Select Map"] = value
        SaveSettings()
    end
})

Tab3:AddButton({
    Name = "TP Select",
    Callback = function()
        for _, v in pairs(Workspace1.Island:GetChildren()) do
            if v.Name == _G.Settings.Tele["Select Map"] then
                if v:IsA("Model") then
                    TP(v:GetPivot())
                elseif v:IsA("Part") or v:IsA("MeshPart") then
                    TP(v.CFrame)
                end
            end
        end
    end
})

Tab3:AddSection({
    Name = "Fake Stack"
})

Tab3:AddSlider({
    Name = "Stack Number",
    Min = 0,
    Max = 333,
    Default = _G.Settings.Tele["Num Stack"] or 100,
    Rounding = 1,
    Callback = function(value)
        _G.Settings.Tele["Num Stack"] = value
        SaveSettings()
    end
})

Tab3:AddButton({
    Name = "Fake Stack",
    Callback = function()
        for _, v in pairs(plr.PlayerGui.HUD.Inventory.ScrollingFrameList:GetDescendants()) do
            if v:IsA("TextLabel") and v.Name == "Stack" then
                v.Text = "x" .. tostring(_G.Settings.Tele["Num Stack"])
            end
        end
    end
})

--Tab 4

Tab4:AddSection({
    Name = "Auto Store"
})

local Blacklist = {}

for _, attr in ipairs({"UseDevilFruit", "UseMelee", "UseSpecial", "UseSword"}) do
    local value = plr:GetAttribute(attr)
    if value and not table.find(Blacklist, value) then
        table.insert(Blacklist, value)
    end
end

local Backpacks = {}

for _, v in pairs(plr.Backpack:GetChildren()) do
    if not table.find(Blacklist, v.Name) then
        table.insert(Backpacks, v.Name)
    end
end

local Blacklisted = Tab4:AddDropdown({
    Name = "Blacklist Item",
    Options = Backpacks,
    Default = _G.Settings.Misc["Black List"] or nil,
    Callback = function(value)
        if not table.find(Blacklist, value) then
            table.insert(Blacklist, value)
            _G.Settings.Misc["Black List"] = Blacklist
            SaveSettings()
        end
    end
})

Tab4:AddButton({
    Name = "Refresh List",
    Callback = function()
        Backpacks = {}
        for _, v in pairs(plr.Backpack:GetChildren()) do
            if not table.find(Blacklist, v.Name) then
                table.insert(Backpacks, v.Name)
            end
        end
        Blacklisted:Set(Backpacks)
    end
})

Tab4:AddToggle({
    Name = "Auto Storage",
    Default = _G.Settings.Misc["Auto Store"] or false,
    Callback = function(value)
        _G.Settings.Misc["Auto Store"] = value
        SaveSettings()
    end
})

Auto_Store = function()
    if not _G.Settings.Misc["Auto Store"] then
        return false
    end
    if plr.PlayerGui:FindFirstChild("Dialogue") then
        local Ui = plr.PlayerGui.Dialogue.Frame:FindFirstChild("3")
        if Ui then
            local vim = game:GetService("VirtualInputManager")
            Ui.Size = UDim2.new(10, 0, -10, 0)
            if Ui.BackgroundTransparency == 0 or Ui.TextTransparency == 0 then
                Ui.TextTransparency = 1
                Ui.BackgroundTransparency = 1
            else
                mousemoveabs(100, 100)
                vim:SendMouseButtonEvent(100, 100, 0, true, game, 0)
                task.wait()
                vim:SendMouseButtonEvent(100, 100, 0, false, game, 0)
                task.wait(0.5)
            end
        end
    else
        for _, v in pairs(plr.Backpack:GetChildren()) do
            if not table.find(Blacklist, v.Name) then
                EquipWeapon(v.Name)
                Click1()
                return true
            end
        end
    end
    return false
end

Tab4:AddSection({
    Name = "Auto Equip"
})

-- Accessories Dropdown
local AccNames = {}

for _, v in pairs(game:GetService("ReplicatedStorage").Accessories:GetDescendants()) do
    if v:IsA("Accessory") then
        table.insert(AccNames, v.Name)
    end
end

Tab4:AddDropdown({
    Name = "Accessory",
    Options = AccNames,
    Default = _G.Settings.Misc["Select Accessories"] or nil,
    Callback = function(value)
        _G.Settings.Misc["Select Accessories"] = value
        SaveSettings()
    end
})

Tab4:AddToggle({
    Name = "Auto Equip",
    Default = _G.Settings.Misc["Equip Accessories"] or false,
    Callback = function(value)
        _G.Settings.Misc["Equip Accessories"] = value
        SaveSettings()
    end
})

Tab4:AddSection({
    Name = "Misc 1"
})

Tab4:AddToggle({
    Name = "Ramdom Chest",
    Default = _G.Settings.Misc["Ramdom Chest"] or false,
    Callback = function(value)
        _G.Settings.Misc["Ramdom Chest"] = value
        SaveSettings()
    end
})

Tab4:AddToggle({
    Name = "Collect Fruit",
    Default = _G.Settings.Misc["Collect Fruit"] or false,
    Callback = function(value)
        _G.Settings.Misc["Collect Fruit"] = value
        SaveSettings()
    end
})

Tab4:AddToggle({
    Name = "Delete Effect",
    Default = _G.Settings.Misc["Delete Effect"] or false,
    Callback = function(value)
        _G.Settings.Misc["Delete Effect"] = value
        if value then
            NotificationLibrary:SendNotification("Info", "If you want effect, turn off and rejoin", 10)
            for _, v in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if not v:IsDescendantOf(game:GetService("ReplicatedStorage").Animation) then
                    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                        if v.Enabled then
                          v.Enabled = false
                        end
                        v.Transparency = NumberSequence.new(1)
                    elseif v:IsA("Part") or v:IsA("MeshPart") then
                        v.Size = Vector3.new(1, 1, 1)
                        v.Transparency = 1
                        v.CanCollide = false
                    elseif v:IsA("Animation") then
                        v:Destroy()
                    end
                end
            end
        end
        SaveSettings()
    end
})

Tab4:AddSection({
    Name = "Misc 2"
})

Tab4:AddDropdown({
    Name = "Select NPC",
    Options = {"Cloak Shadow", "Dragon Balde", "Demon Man"},
    Default = _G.Settings.Misc["Select Item"] or "Cloak Shadow",
    Callback = function(value)
        _G.Settings.Misc["Select Item"] = value
        SaveSettings()
    end
})

Tab4:AddToggle({
    Name = "Auto Click",
    Default = _G.Settings.Misc["Click Item"] or false,
    Callback = function(value)
        _G.Settings.Misc["Click Item"] = value
        SaveSettings()
    end
})

Tab4:AddToggle({
    Name = "Auto Miner",
    Default = _G.Settings.Misc["Auto Miner"] or false,
    Callback = function(value)
        _G.Settings.Misc["Auto Miner"] = value
        SaveSettings()
    end
})

--Webhook Tab
Tab5:AddSection({
    Name = "Webhook Player"
})

Tab5:AddTextBox({
    Name = "Enter Webhook",
    Default = _G.Settings.Web["Webhook Player"] or "test",
    PlaceholderText = "Put your webhook",
    ClearText = true,
    Callback = function(value)
        _G.Settings.Web["Webhook Player"] = value
        SaveSettings()
    end
})

function Web1(url)
    local webhookUtil = loadstring(game:HttpGet("https://raw.githubusercontent.com/idonthaveoneatm/lua/normal/discordwebhook/src.lua"))()
    local myMessage1 = webhookUtil.createMessage({
        Url = url,
        username = "Elgato Webhook",
        content = ""
    })
    local embed2 = myMessage1.addEmbed("ID Place: " .. tostring(game.PlaceId), 0xD8BFD8, "")
    embed2.addField("Name", "||" .. tostring(plr.Name) .. " / " .. tostring(plr.DisplayName) .. "||")
    embed2.addField("Money", tostring(plr:GetAttribute("Beli") or 0) .. " / " .. tostring(plr:GetAttribute("Diamond") or 0))
    embed2.addField("JobId", tostring(game.JobId))
    embed2.addField("Weapon",
        tostring(plr:GetAttribute("UseMelee") or 0) .. " / " ..
        tostring(plr:GetAttribute("UseSword") or 0) .. "\n" ..
        tostring(plr:GetAttribute("UseSpecial") or 0) .. " / " ..
        tostring(plr:GetAttribute("UseDevilFruit") or 0))
    local response = myMessage1.sendMessage()
    if response then
        NotificationLibrary:SendNotification("Success", "Webhook sent successfully!", 5)
    else
        NotificationLibrary:SendNotification("Error", "Failed to send webhook!", 5)
    end
end

Tab5:AddSlider({
    Name = "Delay to send",
    Min = 60,
    Max = 300,
    Default = _G.Settings.Web["Delay Send"] or 60,
    Rounding = 1,
    Callback = function(value)
        _G.Settings.Web["Delay Send"] = value
        SaveSettings()
    end
})

Tab5:AddToggle({
    Name = "Send Webhook",
    Default = _G.Settings.Web["Auto Send 1"] or false,
    Callback = function(value)
        _G.Settings.Web["Auto Send 1"] = value
        SaveSettings()
    end
})

Tab5:AddButton({
    Name = "Test Webhook",
    Callback = function()
        Web1(_G.Settings.Web["Webhook Player"])
    end
})

Tab5:AddSection({
    Name = "Webhook Dungeon"
})

Tab5:AddTextBox({
    Name = "Enter Webhook",
    Default = _G.Settings.Web["Webhook Raid"] or "test",
    PlaceholderText = "Put your webhook",
    ClearText = true,
    Callback = function(value)
        _G.Settings.Web["Webhook Raid"] = value
        SaveSettings()
    end
})

function Web2(url)
    local webhookUtil = loadstring(game:HttpGet("https://raw.githubusercontent.com/idonthaveoneatm/lua/normal/discordwebhook/src.lua"))()
    local WebhookRaid = webhookUtil.createMessage({
        Url = url,
        username = "Elgato Webhook",
        content = ""
    })

    if not plr:GetAttribute("TotalWin") then
        plr:SetAttribute("TotalWin", 0)
    end

    local ItemText = plr.PlayerGui.HUD.DungeonReward.Item.ScrollingFrameList
    if plr.PlayerGui.HUD.DungeonReward.Position == UDim2.new(0.5, 0, 0.5, 0) then
        plr:SetAttribute("TotalWin", plr:GetAttribute("TotalWin") + 1)
        local embed1 = WebhookRaid.addEmbed("Victory the Raid", 0xD8BFD8, "")
        embed1.addField("Total Win", tostring(plr:GetAttribute("TotalWin")))
        embed1.addField("Name", "||" .. tostring(plr.Name) .. " / " .. tostring(plr.DisplayName) .. "||")
        embed1.addField("Money", tostring(plr:GetAttribute("Beli") or 0) .. " / " .. tostring(plr:GetAttribute("Diamond") or 0))
        embed1.addField("JobId", tostring(game.JobId))
        embed1.addField("Item Rarity",
            "Item 1: " .. tostring(ItemText["1"].TextLabel.Text) .. "\n" ..
            "Item 2: " .. tostring(ItemText["2"].TextLabel.Text) .. "\n" ..
            "Item 3: " .. tostring(ItemText["3"].TextLabel.Text))
        local response = WebhookRaid.sendMessage()
        if response then
            NotificationLibrary:SendNotification("Success", "Webhook sent successfully!", 5)
        else
            NotificationLibrary:SendNotification("Error", "Failed to send webhook!", 5)
        end
        wait(1)
        local Button = plr.PlayerGui.HUD.DungeonReward.CloseFrame.CloseButton
        firesignal(Button.MouseButton1Click)
    end
end

Tab5:AddToggle({
    Name = "Send Webhook",
    Default = _G.Settings.Web["Send Wk Raid"] or false,
    Callback = function(value)
        _G.Settings.Web["Send Wk Raid"] = value
        SaveSettings()
    end
})

Tab5:AddSection({
    Name = "JobId Game"
})

Tab5:AddTextBox({
    Name = "Enter JobId",
    Default = _G.Settings.Web["Job Id"] or "hihi",
    PlaceholderText = "Put your JobId",
    ClearText = true,
    Callback = function(value)
        _G.Settings.Web["Job Id"] = value
        SaveSettings()
    end
})

Tab5:AddButton({
    Name = "Join JobId",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local JobId = _G.Settings.Web["Job Id"]
        if JobId and JobId ~= "" then
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, plr)
        else
            NotificationLibrary:SendNotification("Error", "JobId is empty!", 5)
        end
    end
})

Tab5:AddButton({
    Name = "Copy JobId",
    Callback = function()
        local JobId = game.JobId
        if setclipboard then
            setclipboard(JobId)
            NotificationLibrary:SendNotification("Success", "JobId coppy successfully!", 5)
        end
    end
})

-- Settings Tab
Tab6:AddSection({
    Name = "Settings"
})

Tab6:AddDropdown({
    Name = "Select Weapon",
    Options = {"Melee", "Sword", "Special", "DevilFruit"},
    Default = _G.Settings.Config["Select Weapon"] or "Melee",
    Callback = function(value)
        _G.Settings.Config["Select Weapon"] = value
        SaveSettings()
    end
})

Tab6:AddDropdown({
    Name = "Select Method",
    Options = {"Behind", "Below", "Upper"},
    Default = _G.Settings.Config["Select Method"] or "Upper",
    Callback = function(value)
        _G.Settings.Config["Select Method"] = value
        SaveSettings()
    end
})

Tab6:AddSlider({
    Name = "Distance Mob",
    Min = 0,
    Max = 100,
    Default = _G.Settings.Config["Distance Farm"] or 10,
    Rounding = 1,
    Callback = function(value)
        _G.Settings.Config["Distance Farm"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Auto Freeze",
    Flag = "AutoFreeze",
    Default = _G.Settings.Config["Auto Freeze"] or false,
    Callback = function(value)
        _G.Settings.Config["Auto Freeze"] = value
        SaveSettings()
        if value then
        NotificationLibrary:SendNotification("Info", "When the self uses a skill that can move it will freeze", 5)
        end
    end
})

Tab6:AddToggle({
    Name = "Doge Skill (Cid)",
    Flag = "Doge",
    Default = _G.Settings.Config["Doge Skill Cid"] or true,
    Callback = function(value)
        _G.Settings.Config["Doge Skill Cid"] = value
        SaveSettings()
    end
})

Tab6:AddSection({
    Name = "Weapon"
})

Tab6:AddToggle({
    Name = "Multi Equip Weapon",
    Flag = "RDWP",
    Default = _G.Settings.Config["Multi Weapon"] or false,
    Callback = function(value)
        _G.Settings.Config["Multi Weapon"] = value
        SaveSettings()
    end
})

Tab6:AddSlider({
    Name = "Hold to Change",
    Min = 0,
    Max = 10,
    Default = _G.Settings.Config["Hold to Change"] or 3,
    Rounding = 1,
    Callback = function(value)
        _G.Settings.Config["Hold to Change"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Melee",
    Flag = "Melee",
    Default = _G.Settings.Config["Melee"] or false,
    Callback = function(value)
        _G.Settings.Config["Melee"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Sword",
    Flag = "Sword",
    Default = _G.Settings.Config["Sword"] or false,
    Callback = function(value)
        _G.Settings.Config["Sword"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Fruit",
    Flag = "Power",
    Default = _G.Settings.Config["Power"] or false,
    Callback = function(value)
        _G.Settings.Config["Power"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Special",
    Flag = "Specials",
    Default = _G.Settings.Config["Special"] or false,
    Callback = function(value)
        _G.Settings.Config["Special"] = value
        SaveSettings()
    end
})

Tab6:AddSection({
    Name = "Auto Skill"
})

Tab6:AddToggle({
    Name = "Auto Skill (Mobile)",
    Flag = "AutoSkill",
    Default = _G.Settings.Config["Auto Skill"] or false,
    Callback = function(value)
        _G.Settings.Config["Auto Skill"] = value
        SaveSettings()
        if not value then
            _G.AutoSkill = false
        end
    end
})

Tab6:AddToggle({
    Name = "Skill Z",
    Flag = "Z",
    Default = _G.Settings.Config["Z"] or true,
    Callback = function(value)
        _G.Settings.Config["Z"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Skill X",
    Flag = "X",
    Default = _G.Settings.Config["X"] or true,
    Callback = function(value)
        _G.Settings.Config["X"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Skill C",
    Flag = "C",
    Default = _G.Settings.Config["C"] or true,
    Callback = function(value)
        _G.Settings.Config["C"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Skill V",
    Flag = "V",
    Default = _G.Settings.Config["V"] or true,
    Callback = function(value)
        _G.Settings.Config["V"] = value
        SaveSettings()
    end
})

Tab6:AddToggle({
    Name = "Skill F",
    Flag = "F",
    Default = _G.Settings.Config["F"] or true,
    Callback = function(value)
        _G.Settings.Config["F"] = value
        SaveSettings()
    end
})

--[[
end

if getgenv().PremiumKey == nil then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeRiftH/Scripts/main/KeySystemUi/KeySystemV2.lua"))()

    local function __AFDCASFDASD()
        xyzabc()
    end

    local Window = Library:Window({
        DisplayName = "<b>elgato Luarion</b>",
        SubTitle = "Join discord for help",
        Service = "elgatohub",
        Token = "uVg4ndizbgambFRX",
        KeyPrefix = "elgato_",
        Webhook = "https://discord.com/api/webhooks/1273814794528489472/PT8OEwYMcw-S6JIqy6Z8rIy1sR6YjA5byHELQeJlN-n5PRYATeOSxFUYGj4ZiwTwJcHf",
        File = "ELGATO HUB/PandaKey.txt",
        Discord = "discord.gg/UrkE64Mfb7",
        Normal = function()
            __AFDCASFDASD()
        end,

        Premium = function()
            __AFDCASFDASD()
        end
    })

else
    local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
    local trueData = "6678ee53e412491ca5fe3afef8976a2a"
    local falseData = "4ecac25b92e645f9820c54243830a0df"

    KeyGuardLibrary.Set({
        publicToken = "bad0f4a578314fe3bcca6a7fff6561a6",
        privateToken = "70ceb8de8860445e8117379f7779cf25",
        trueData = trueData,
        falseData = falseData,
    })

    local key = getgenv().PremiumKey

    local response = KeyGuardLibrary.validatePremiumKey(key)
    if response == trueData then
        print("Valid Premium")
        Data[tostring(plr.UserId)] = true
        xyzabc()
    else
        print("Invalid")
        Data[tostring(plr.UserId)] = false
    end
end
--]]