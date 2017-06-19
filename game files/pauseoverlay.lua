
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
local level01 = require("level01")
local params

local function btnTap(event)
	event.target.xScale = 0.95
	event.target.yScale = 0.95
	storyboard.gotoScene (  event.target.destination, { params ={levelNum = params.levelNum}, time=800, effect = "fade"} )
	return true
end

 function catchBackgroundOverlay(event)
	return true
end


function scene:createScene( event )
	local group = self.view

local backgroundOverlay = display.newRect (group, leftScrn-5, topScrn-5, withScrn+5, heightScrn+5)
				backgroundOverlay:setFillColor( black )
				backgroundOverlay.alpha = 0.6
				backgroundOverlay.isHitTestable = true
				backgroundOverlay:addEventListener ("tap", catchBackgroundOverlay)
				backgroundOverlay:addEventListener ("touch", catchBackgroundOverlay)


local overlay = display.newImage ("images/overlayv2.png",0.5,0.5)
				overlay.x = centerX
				overlay.y = centerY
				group:insert (overlay)

local levelBtn = display.newImageRect ("images/levelBtn.png", 50, 50 )
				levelBtn.x = centerX
				levelBtn.y = centerY + overlay.height/2.2
				levelBtn.destination = "levels"
				levelBtn:addEventListener("tap", btnTap)
				group:insert(levelBtn)

local playBtn = display.newImageRect ("images/playBtn.png", 50,50)
				playBtn.x = centerX - overlay.width / 3
				playBtn.y = centerY + overlay.height/2.2
				local function hideOverlay(event)
					storyboard.hideOverlay("fade", 800)
				end
				playBtn:addEventListener ("tap", hideOverlay)
				group:insert(playBtn)

reloadBtn = display.newImageRect ("images/reloadbutton.png" ,50,50)
				reloadBtn.x = centerX + overlay.width / 3
				reloadBtn.y = centerY + overlay.height/2.2
				params = event.params
				reloadBtn.destination = "reloading"
				reloadBtn:addEventListener ("tap", btnTap)
				group:insert (reloadBtn)
end



function scene:enterScene( event )
	local group = self.view
end



function scene:exitScene( event )
	local group = self.view
end


function scene:destroyScene( event )
	local group = self.view
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene
