local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui", math.huge)

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local UIBlox = require(CorePackages.UIBlox)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local StyleConstants = UIBlox.App.Style.Constants
local DarkTheme = StyleConstants.ThemeName.Dark
local Gotham = StyleConstants.FontName.Gotham

local ExperienceChat = require(CorePackages.Packages.ExperienceChat)
local App = ExperienceChat.App

local themes = {
	Dark = {
		themeName = DarkTheme,
		fontName = Gotham,
	},
}

local root = Roact.createElement(AppStyleProvider, {
	style = themes["Dark"],
}, {
	Child = Roact.createElement(
		App, {
			isDefaultChatEnabled = true,
			isChatWindowEnabled = true,
			isChatInputBarEnabled = true,
		}
	),
})

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExperienceChat"
screenGui.Parent = CoreGui

Roact.mount(root, screenGui, "ExperienceChat")
