
--- requires
local composer = require( "composer" )
local scene = composer.newScene()
local sounds = require ("soundsfile")


local sheetInfo = require("platformSheet")
local myPlatformSheet = graphics.newImageSheet( "images/platformsheet.png", sheetInfo:getSheet() )

-- Physics --

local physics = require("physics")
local physicsData = (require "platformshapes").physicsData(1.0)
physics.start()
--physics.setDrawMode( "hybrid" )



local function btnTap(event)

	event.target.xScale = 0.95
	event.target.yScale = 0.95
	--
	storyboard.showOverlay( "pauseoverlay" ,{effect = "fade"  ,  params ={levelNum = "level01"}, isModal = true} )

	return true
end




function scene:createScene( event )

	downspeed = 2

	local group = self.view
	myStaticgroup = self.view
	playgameMusic(gamebgmusic)

	local background = display.newImage("images/bg1.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	group:insert(background)

	doublescore = 0

	score = 0
	scoreText = display.newText(score, 10, 10, native.systemFontBold, 25)
	group:insert(scoreText)

	ceiling = display.newImage("images/explosion.png")
    ceiling:setReferencePoint(display.BottomLeftReferencePoint)
    ceiling.x = 0
    ceiling.y = 0
    physics.addBody(ceiling, "static", {density=.1, bounce=0.1, friction=.2})
    group:insert(ceiling)

    theFloor = display.newImage("images/explosion.png")
    theFloor:setReferencePoint(display.BottomLeftReferencePoint)
    theFloor.x = 0
    theFloor.y = 365
    physics.addBody(theFloor, "static", {density=.1, bounce=0.1, friction=.2})
    group:insert(theFloor)

	city1 = display.newImage("images/city1.png")
    city1:setReferencePoint(display.BottomLeftReferencePoint)
    city1.x = 0
    city1.y = 320
    city1.speed = 1/downspeed
    group:insert(city1)

    city2 = display.newImage("images/city1.png")
    city2:setReferencePoint(display.BottomLeftReferencePoint)
    city2.x = 480
    city2.y = 320
    city2.speed = 1/downspeed
    group:insert(city2)

    city3 = display.newImage("images/city2.png")
    city3:setReferencePoint(display.BottomLeftReferencePoint)
    city3.x = 0
    city3.y = 320
    city3.speed = 2/downspeed
    group:insert(city3)

    city4 = display.newImage("images/city2.png")
    city4:setReferencePoint(display.BottomLeftReferencePoint)
    city4.x = 480
    city4.y = 320
    city4.speed = 2/downspeed
    group:insert(city4)

    local CoinGraphicOption =
    {
    	width = 100,
    	height = 100,
    	numFrames = 10
	}
	spritedCoin = graphics.newImageSheet("images/coin.png", CoinGraphicOption)
	local CoinOptions =
	{
		name="acoin",
		start = 1,
		count = 10,
		time = 500,
		loopCount = 0,
		loopDirection = "forward"
	}
	coin = display.newSprite(spritedCoin, CoinOptions)
	coin:scale(0.3, 0.3)
	coin.x = 800
	coin.n = 1
	coin.y = math.random(30, 300)
	coin:play()
	coin.speed = math.random(2,5)/downspeed
	coin.initY = coin.y
	coin.amp = math.random(10,50)
	coin.angle = math.random(1,360)
	--physics.addBody(coin, "static", {density=.1, bounce=0.1, friction=.2, radius=5})
	group:insert(coin)



    local JetGraphicOption =
	{
		width = 50,
		height = 17,
		numFrames = 4
	}
	spritedJet = graphics.newImageSheet("images/jet.png", JetGraphicOption)

	local JetOptions =
	{
		name="rredJet",
		start=1,
		count=4,
		time=1000,
		loopCount=0,
		loopDirection = "bounce"
	}
	jet = display.newSprite(spritedJet, JetOptions)
	jet.x = -80
	jet.y = 100
	jet:play()
	jet.collided = false
	physics.addBody(jet, "static", {density=.1, bounce=0.1, friction=.2, radius=12})
	group:insert(jet)
	jetIntro = transition.to(jet, {time=2000, x=100, onComplete=jetReady})

	local JetExplosionGraphicOption =
	{
		width = 24,
		height = 23,
		numFrames = 8
	}

	spritedExplosionJet = graphics.newImageSheet("images/explosion.png", JetExplosionGraphicOption)

	local JetExplosionOptions =
	{
		name="rredJet",
		start=1,
		count=8,
		time=1000,
		loopCount=1,
		--loopDirection = "bounce"
	}

	jetExplosion = display.newSprite(spritedExplosionJet, JetExplosionOptions)
	jetExplosion.isVisible = false
	--physics.addBody(jetExplosion, "dynamic", {density=.1, bounce=0.1, friction=.2, radius=12})
	--screenGroup:insert(jetExplosion)


	mine1 = display.newImage("images/mine.png")
	mine1.x = 900
	mine1.n = 2
	mine1.y = math.random(90,220)
	mine1.speed = math.random(2,5)/downspeed
	mine1.initY = mine1.y
	mine1.amp = math.random(20,100)
	mine1.angle = math.random(1,360)
	physics.addBody(mine1, "static", {density=.1, bounce=0.1, friction=.2, radius=12})
	group:insert(mine1)

	mine2 = display.newImage("images/mine.png")
	mine2.x = 1000
	mine2.n = 2
	mine2.y = math.random(90,220)
	mine2.speed = math.random(2,5)/downspeed
	mine2.initY = mine2.y
	mine2.amp = math.random(20,100)
	mine2.angle = math.random(1,360)
	physics.addBody(mine2, "static", {density=.1, bounce=0.1, friction=.2, radius=12})
	group:insert(mine2)

	mine3 = display.newImage("images/mine.png")
	mine3.x = 1100
	mine3.n = 2
	mine3.y = math.random(60,220)
	mine3.speed = math.random(2,5)/downspeed
	mine3.initY = mine3.y
	mine3.amp = math.random(20,100)
	mine3.angle = math.random(1,360)
	physics.addBody(mine3, "static", {density=.1, bounce=0.1, friction=.2, radius=12})
	group:insert(mine3)


local pauseBtn = display.newImageRect ("images/pausebutton.png", 50,50)
	pauseBtn.y = 7+ (topScrn+ pauseBtn.height /2)
	pauseBtn.x = -7+ (withScrn - pauseBtn.width /2)
	pauseBtn.destination = "pauseBtn"
	pauseBtn:addEventListener("tap", btnTap)
    group:insert(pauseBtn)

end

function scrollCity(self,event)
	if self.x < -477 then
		self.x = 480
	else
		self.x = self.x - self.speed
	end
end

function mod (i, j)
	if (i < j) then
		return (j - i)
	else
		return (i - j)
	end
end

function moveCoin(self, even)
	if ((mod(jet.x, coin.x) < 12) and (mod(jet.y, coin.y) < 12)) then
		coin.x = 4000 + math.random(100, 4000)
		doublescore = 10
	end


	if 	self.x < -50 then
		self.x = 1200
		self.y = math.random(2000,3000)
		self.speed = math.random(2,5)/downspeed
		self.amp = math.random(20,40)
		self.angle = math.random(1,360)
	else
		self.x = self.x - self.speed
		self.angle = self.angle + .1
		self.y = self.amp * math.sin(self.angle)+self.initY
	end
end

function moveMines(self,event)

 i = 0

 	if (i == 0) then
 		if ((self.x - jet.x)<(1.9/downspeed) and (jet.x - self.x)<(1.9/downspeed) ) then
 			if (doublescore > 0) then
 				score = score + 2
 				scoreText.text = score
 				i = 1
 				doublescore = doublescore -1
 			else
 				score = score + 1
 				scoreText.text = score
 				i = 1
 			end

 		end
 	end



	if self.x < -50 then
		self.x = 500
		self.y = math.random(10,420)
		self.speed = math.random(2,6)/downspeed
		self.amp = math.random(20,100)
		self.angle = math.random(1,360)
		i = 0
	else
		self.x = self.x - self.speed
		self.angle = self.angle + .1
		self.y = self.amp * math.sin(self.angle)+self.initY
	end
end

function jetReady()
	jet.bodyType = "dynamic"
end

function activateJets(self, event)
	self:applyForce(0, -1.5, self.x, self.y)
end

function touchScreen(event)
	acc = 0
	if (event.phase == "began" and  acc == 0) then
	 acc = 1
	 jet.enterFrame = activateJets
	 Runtime:addEventListener("enterFrame", jet)
	end

	if event.phase == "ended" then
	 acc = 1
	 Runtime:removeEventListener("enterFrame", jet)
	end
end

function gameOver()
	storyboard.gotoScene( "restart" , "fade", 800 )
end

function explode()
	playSFX(audiowinsound)
  	resetMusic(gamebgmusic)
	jetExplosion.x = jet.x
	jetExplosion.y = jet.y
	jetExplosion.isVisible = true
	jetExplosion:play()
	jet.isVisible = false
	gameOver()
	--timer.performWithDelay(500, gameOver, 1)
end

function onCollision( event )
	if event.phase == "began" then
		if (event.object2.n == 1) then
			playSFX(audiowinsound)
  			resetMusic(gamebgmusic)
			doublescore = doublecore + 10
			event.object2.x = 4000 + math.random(100, 2000)
		else
			if jet.collided == false then
				jet.collided = true
				jet.bodyType = "static"
				explode()
				playSFX(audiowinsound)
  			    resetMusic(gamebgmusic)
			end
		end
	end
end


function scene:enterScene(event)

	Runtime:addEventListener("touch", touchScreen)

	--Runtime:addEventListener( "enterFrame", scoreText)

	city1.enterFrame = scrollCity
	Runtime:addEventListener("enterFrame", city1)

	city2.enterFrame = scrollCity
	Runtime:addEventListener("enterFrame", city2)

	city3.enterFrame = scrollCity
	Runtime:addEventListener("enterFrame", city3)

	city4.enterFrame = scrollCity
	Runtime:addEventListener("enterFrame", city4)

	mine1.enterFrame = moveMines
	Runtime:addEventListener("enterFrame", mine1)

	mine2.enterFrame = moveMines
	Runtime:addEventListener("enterFrame", mine2)

	mine3.enterFrame = moveMines
	Runtime:addEventListener("enterFrame", mine3)

	coin.enterFrame = moveCoin
	Runtime:addEventListener( "enterFrame", coin)

	Runtime:addEventListener("collision", onCollision)



end


function scene:exitScene(event)
	Runtime:removeEventListener("touch", touchScreen)
	Runtime:removeEventListener( "enterFrame", city1 )
	Runtime:removeEventListener( "enterFrame", city2 )
	Runtime:removeEventListener( "enterFrame", city3 )
	Runtime:removeEventListener( "enterFrame", city4 )
	Runtime:removeEventListener( "enterFrame", mine1 )
	Runtime:removeEventListener( "enterFrame", mine2 )
	Runtime:removeEventListener( "enterFrame", mine3 )
	Runtime:removeEventListener( "enterFrame", coin)
	Runtime:removeEventListener( "enterFrame", bluecoin)
	Runtime:removeEventListener("collision", onCollision)

end


function scene:destroyScene(event)

end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene
