
local composer = require( "composer" )
local scene = composer.newScene()
local sounds = require ("soundsfile")


local function btnTap(event)
	event.target.xScale = 0.95
	event.target.yScale =0.95
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end


function scene:createScene( event )
	local group = self.view


	title= display.newImageRect ("images/optionstitle.png", 150, 40)
	title.x = centerX
	title.y  = topScrn + title.height
	group:insert(title)

	img= display.newImageRect("images/coming_soon.png",300,400)
	img.x = centerX
	img.y  = 170
	group:insert(img)



	local backbtn = display.newImageRect ("images/reloadbutton.png", 50,50)
	backbtn.y = heightScrn - 0.6 * backbtn.height
	backbtn.x = .6 * backbtn.width
	backbtn.destination = "start"
	playSFX(audioclick)
	backbtn:addEventListener("tap", btnTap)
	group:insert(backbtn)

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
