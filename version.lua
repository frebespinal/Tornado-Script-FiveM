-- Version Checker do not remove --

local CurrentVersion = '1.0.2'
local GithubResourceName = 'Tornado-Script-FiveM'
local githubUsername = 'rhys19'
local resourceName = GetCurrentResourceName()
local versionurl = "https://raw.githubusercontent.com/"..githubUsername.."/"..GithubResourceName.."/master/VERSION"
local changesurl = "https://raw.githubusercontent.com/"..githubUsername.."/"..GithubResourceName.."/master/CHANGES"

PerformHttpRequest(versionurl, function(Error, NewestVersion, Header)
	PerformHttpRequest(changesurl, function(Error, Changes, Header)
		print('\n')
		print('====================================================================')
		print('Version Checker...')
		print('')
		print('Tornado Script ('..resourceName..')')
		print('')
		print('Changelog: \n' .. Changes)
		print('Current Version: ' .. CurrentVersion)
		print('Newest Version: ' .. NewestVersion)
		io.write("")
	if CurrentVersion ~= NewestVersion and CurrentVersion < NewestVersion then
		elseif CurrentVersion > NewestVersion then
		print("Your version of "..resourceName.." seems to be higher than the current version.")
		print('')
			print('====================================================================')
		else
			print('===================')
			print('=== Up to date! ===')
			print('===================')

		end
		end
		print('\n')
end)
end)
