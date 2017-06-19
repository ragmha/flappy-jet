--requires
local composer = require( "composer" )
local scene = composer.newScene()
local backbtn


local function btnTap(event)
	event.target.xScale = 0.95
	event.target.yScale =0.95
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end


function scene:createScene( event )
	local group = self.view

	local background = display.newImage("images/bg2.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	group:insert(background)

	local title= display.newImageRect ("images/creditstitle.png", 150, 40)
	title.x = centerX
	title.y  = topScrn + title.height
	group:insert(title)

	local text = display.newText( "Mark Falkland", 0, 0, "ComicSans", 20)
	text.x=centerX
	text.y=110
	text:setTextColor( 255,255,255, 255 )
	group:insert(text)
	local text = display.newText( "Christian Peeters", 0, 0, "ComicSans", 20)
	text.x=centerX
	text.y=150
	text:setTextColor( 255,255,255, 255 )
	group:insert(text)

	local text = display.newText( "MY AMAZING BANAANI TEAM", 0, 0, "Arial", 20)
	text.x=centerX
	text.y=200
	text:setTextColor( 255,255,255, 255 )
	group:insert(text)

	backbtn = display.newImageRect ("images/reloadbutton.png", 50,50)
	backbtn.y = heightScrn - 0.6 * backbtn.height
	backbtn.x = .6 * backbtn.width
	backbtn.destination = "start"
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
