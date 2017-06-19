
-- requires
local composer = require ("composer")
local scene = composer.newScene()
local widget = require ("widget")
local sounds = require ("soundsfile")



centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
withScrn = display.contentWidth
heightScrn = display.contentHeight
topScrn = display.screenOriginY
leftScrn = display.screenOriginX

local function btnTap(event)
	playSFX(audioclick)
	storyboard.gotoScene (  event.target.destination, {effect = "fade"} )
	return true
end

--BACKGROUND & MUSIC

function scene:createScene(event)

	local group = self.view
	playgameMusic(menumusic)


	local background = display.newImage("images/bg.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	group:insert(background)

	local title = display.newImageRect( "images/gameTitle.png",2500,1500)
	title.x = 360
	title.y  = 140
	group:insert(title)


    local city2 = display.newImage("images/city2.png")
		city2.x = 110
		city2.y = 270
		city2.speed = 1
		group:insert(city2)

	local city2 = display.newImage("images/city2.png")
		city2.x = 400
		city2.y = 280
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


	-- BUTTONS --
	local playBtn = widget.newButton
	{
	width = 140,
    height =70,
    defaultFile = "images/button_notpressed.png",
    overFile = "images/button_pressed.png",
    label="PLAY",
	labelColor = { default = { 255,255,255},
						over ={0,0,0  }},
	fontSize = "40",
	}
	playBtn.x = 100
	playBtn.y = 75
	playBtn.destination = "level01"
	playBtn:addEventListener("tap", btnTap)
	group:insert(playBtn)

	local optionsBtn = widget.newButton
	{
	width = 110,
    height = 50,
    defaultFile = "images/button_notpressed.png",
    overFile = "images/button_pressed.png",
    label="OPTIONS",
	labelColor = { default = { 255,255,255},
						over ={1,1,1  }},
	fontSize = "21",
	}
	optionsBtn.x = 100
	optionsBtn.y = 155
	optionsBtn.destination = "options"
	optionsBtn:addEventListener("tap", btnTap)
	group:insert(optionsBtn)

	local creditsBtn = widget.newButton
	{
	width = 90,
    height = 40,
    defaultFile = "images/button_notpressed.png",
    overFile = "images/button_pressed.png",
    label="CREDITS",
	labelColor = { default = { 255,255,255},
						over ={0,0,0  }},
	fontSize = "18",
	}
	creditsBtn.x = 100
	creditsBtn.y = 220
	creditsBtn.destination = "gamecredits"
	creditsBtn:addEventListener("tap", btnTap)
	group:insert(creditsBtn)



end

function start(event)
	if event.phase == "began" then
		storyboard.gotoScene("level01", "fade", 100 )
	end
end

function scene:enterScene(event)
	local group = self.view


end


function scene:exitScene(event)
	local group = self.view
end


function scene:destroyScene(event)
local group = self.view
end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene
