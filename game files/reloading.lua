local composer = require( "composer" )
local _overlay = require( "gameoveroverlay" )
local _level01 = require("level01")
local scene = composer.newScene()

local loadText
local params


local function restartLevel (event)
	storyboard.removeScene(params.levelNum)
	storyboard.gotoScene (params.levelNum, {time=500, effect= "fade"})
end



function scene:createScene( event )
	local group = self.view
	myStaticgroup = self.view

params = event.params
print(params.levelNum)

loadText = display.newText("Restarting ", 0, 0 , "Helvetica", 50)
loadText.x = centerX
loadText.y = centerY
group:insert (loadText)

end


function scene:enterScene( event )
	local group = self.view
	myStaticgroup = self.view

	loadText.alpha = 1.0
	transition.to( loadText, {time=250, alpha = 0.0, onComplete=restartLevel} )

end



function scene:exitScene( event )
local group = self.view
myStaticgroup = self.view
end


function scene:destroyScene( event )
	local group = self.view
	myStaticgroup = self.view

end



scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
