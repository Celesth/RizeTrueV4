--Main/Required
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moonerri/Rize/main/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moonerri/Rizee/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moonerri/Rizee/master/Addons/InterfaceManager.lua"))()

local currentDate = os.date("%B %d, %Y") -- Get current date
local playerCount = game.Players:GetPlayers()

------------------------------------
local Window = Fluent:CreateWindow({
    Title = "Rize",
    SubTitle = "[Rize True V4]",
    TabWidth = 120,
    Size = UDim2.fromOffset(560, 430),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({
        Title = "Main", Icon = "file-code"
    }),
    Settings = Window:AddTab({
        Title = "Settings", Icon = "settings"
    }),
    Dev = Window:AddTab({
        Title = "Developers", Icon = "cpu"
    })
}

local Options = Fluent.Options

do
Fluent:Notify({
    Title = "Rize [True V4]",
    Content = "Modules.Loading",
    SubContent = "V4", -- Optional
    Duration = 5 -- Set to nil to make the notification not disappear
})

task.wait(2)

Tabs.Main:AddParagraph({
    Title = "True V4",
    Content = "True V4 is in development Created On 9:39PM, Sunday, March 24"
})
Tabs.Dev:AddParagraph({
    Title = ("Current Date:" .. currentDate .. "Player" ..playerCount)
})


print("Current date: " .. currentDate)
print("Number of in-game players: " .. playerCount)



Tabs.Dev:AddButton({
    Title = "Iframe [Humanoid Position]",
    Description = "Gets You The Iframes Of Your Currently Position.",
    Callback = function()
    Window:Dialog({
        Title = "Iframe [Current]",
        Content = "Gives You Current Standing Location Position",
        Buttons = {
            {
                Title = "Confirm",
                Callback = function()
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:wait()
                local humanoidRootPart = character:WaitForChild('HumanoidRootPart')

                local position = humanoidRootPart.Position
                print(position) -- This would output the position in the output window.
                setclipboard(tostring(Game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position))
                end
            },
            {
                Title = "Cancel",
                Callback = function()
                print("Cancelled the dialog.")
                end
            }
        }
    })
    end
})

Tabs.Dev:AddToggle("Print", {
    Title = "Printing Button.",
    Description = "Print's On Or Off",
    Default = false,
    Callback = function(bool)
            print("on")
    end
})


local Input = Tabs.Dev:AddInput("Input", {
    Title = "Teleport[Instant]",
    Default = "",
    Placeholder = "UserName",
    Numeric = false, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(modules)
        print(modules)
    local player = game.Players.LocalPlayer
    local usernameToTeleport = modules -- Replace with the desired username

    local function teleportToPlayer()
    local targetPlayer = game.Players:FindFirstChild(usernameToTeleport)
    if targetPlayer then
    player.Character:SetPrimaryPartCFrame(targetPlayer.Character.PrimaryPart.CFrame)
    else
        print("Player not found.")
    end
    end

    teleportToPlayer()
    end
})

Input:OnChanged(function()
    print("Input updated:", Input.Value)
    end)
end

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("RizeV4")
SaveManager:SetFolder("RizeV4/modules")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

task.wait(3)

Fluent:Notify({
    Title = "Rize V4 [ Rize True V4]",
    Content = "Injected: Ready To Go.",
    Duration = 5
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
