--!nocheck

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local VoiceChatServiceManager = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local FFlagDebugDefaultChannelStartMuted = game:DefineFastFlag("DebugDefaultChannelStartMuted", true)

local GetFFlagEnableVoiceChatErrorToast = require(RobloxGui.Modules.Flags.GetFFlagEnableVoiceChatErrorToast)

local log = require(RobloxGui.Modules.InGameChat.BubbleChat.Logger)(script.Name)

local function initializeDefaultChannel()
	local VoiceChatService = VoiceChatServiceManager:getService()

	if not VoiceChatService then
		return nil
	end

	log:info("Joining default channel")

	return VoiceChatService:JoinByGroupIdToken("default", FFlagDebugDefaultChannelStartMuted)
end

if not Players.LocalPlayer.Character then
	Players.LocalPlayer.CharacterAdded:Wait()
	log:debug("Player character loaded")
else
	log:debug("Player character already loaded")
end

VoiceChatServiceManager:asyncInit():andThen(function()
	local joinInProgress = initializeDefaultChannel()
	if GetFFlagEnableVoiceChatErrorToast() and joinInProgress == false then
		VoiceChatServiceManager:InitialJoinFailedPrompt()
	end
end):catch(function()
	-- If voice chat doesn't initialize, silently halt rather than throwing
	-- a unresolved promise error.
	log:info("VoiceChatServiceManager did not initialize")
end)
