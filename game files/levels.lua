-- requires
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require ("widget")
local sounds = require ("soundsfile")

levels =
{
1, 2, 2, 2 , 2,  --1 means level is open to be played
2, 2, 2, 2, 2,   --2 means level is locked
2, 2, 2, 2, 2
}

images ={
	{ getFile = "images/leveliconnotpressed.png", types = "play"   },
	{ getFile = "images/levellocked.png", types = "locked"}

}

local function btnTap(event)
	playSFX(audioclick)
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

	local levelIndex =0
		for i=0,1 do
			for j=1,5 do
				tablePlace =   i*5 + j
				levelIndex = levelIndex + 1
					local imagesId = levels[levelIndex]
						levelImg = display.newImageRect (images[imagesId].getFile , 70, 70)
						levelImg.x = 10 + (j* 80)
						levelImg.y  = 140 + (i* 90)
						group:insert(levelImg)

						if images[imagesId].types == "play" then
						leveltxt = display.newText("LVL "..tostring(tablePlace), 0,0, "Helvetica", 20)
						leveltxt.x = 70 + (j*20)
						leveltxt.y = 140+ (i*60)
						leveltxt:setTextColor (250, 255, 251)
						group:insert (leveltxt)
						levelImg.destination = "level0"..tostring(tablePlace)
						levelImg:addEventListener("tap", btnTap)
						end

end

end

	local title= display.newImageRect ("images/levelstitle.png", 200, 50)
	title.x = centerX
	title.y  = topScrn + title.height
	group:insert(title)

	backbtn = display.newImageRect ("images/reloadbutton.png", 50,50)
	playSFX(audioclick)
	backbtn.y = heightScrn - 0.6 * backbtn.height
	backbtn.x = .6 * backbtn.width
	backbtn.destination = "start"
	backbtn:addEventListener("tap", btnTap)
	group:insert(backbtn)

end


function start(event)
	if event.phase == "began" then
		storyboard.gotoScene("level0", "fade", 100 )
	end
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
