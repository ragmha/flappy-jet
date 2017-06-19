-- requires

local composer = require ("composer")
local scene = composer.newScene()
local sounds = require ("soundsfile")

centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
withScrn = display.contentWidth
heightScrn = display.contentHeight
topScrn = display.screenOriginY
leftScrn = display.screenOriginX

--Background

function scene:createScene(event)

	local group = self.view

	background = display.newImage("images/restart.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	group:insert(background)


    city2 = display.newImage("images/city2.png")
    city2:setReferencePoint(display.BottomLeftReferencePoint)
    city2.x = 0
    city2.y = 260
    city2.speed = 1
    group:insert(city2)


	clouds_jets ={
	 {getImage = "images/cloud02.png"},
	 {getImage = "images/redJet.png"},
	 {getImage = "images/cloud03.png"}
	}

	for i=0,2 do

	imagesId = math.random (1,3)
	local cloud = display.newImage(clouds_jets[imagesId].getImage)
	cloud.x = math.random (display.screenOriginX , centerX )
	cloud.y = math.random (display.screenOriginY + cloud.height, centerY)
	group:insert(cloud)
	cloud.alpha = 0.7
	transition.to( cloud, {time = math.random (30000 , 120000), x = withScrn + 300 } )

	end

end

function start(event)
	playSFX(audioclick)
	if event.phase == "began" then
		storyboard.gotoScene("level01", "fade", 100 )
	end
end

function scene:enterScene(event)

	storyboard.purgeScene( "level01" )
	background:addEventListener( "touch", start )

end


function scene:exitScene(event)
	background:removeEventListener( "touch", start )
end


function scene:destroyScene(event)

end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene
