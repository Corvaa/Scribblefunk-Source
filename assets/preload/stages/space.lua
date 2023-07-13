function onCreate()
    makeLuaSprite('sky', 'bgs/sky', -400, -200)
    setLuaSpriteScrollFactor('sky', 1, 1)
    scaleObject('sky',3, 3)
    addLuaSprite('sky', false)
    setProperty('sky.antialiasing', false)

    makeLuaSprite('stars', 'bgs/stars', -225, -100)
    setLuaSpriteScrollFactor('stars', 0.5, 0.5)
    scaleObject('stars',2.25, 2.25)
    addLuaSprite('stars', false)
    setProperty('stars.antialiasing', false)

    makeLuaSprite('planet', 'bgs/planet', 0, 0)
    setLuaSpriteScrollFactor('planet', 0.85, 0.85)
    scaleObject('planet',2, 2)
    addLuaSprite('planet', false)

    makeLuaSprite('ufo', 'bgs/ufo', 0, 0)
    setLuaSpriteScrollFactor('ufo', 0.85, 0.85)
    scaleObject('ufo',2, 2)
    addLuaSprite('ufo', false)

    makeLuaSprite('satelite', 'bgs/satelite', 1550, 250)
    setLuaSpriteScrollFactor('satelite', 0.85, 0.85)
    scaleObject('satelite',2, 2)
    addLuaSprite('satelite', false)
    setProperty('sky.antialiasing', false)

    makeLuaSprite('overlay', 'bgs/overlay', -200, -205)
    setLuaSpriteScrollFactor('overlay', 1, 1)
    scaleObject('overlay',4, 2.25)
    addLuaSprite('overlay', true)
    setProperty('overlay.antialiasing', true)
end

function onCreatePost()
    setBlendMode('overlay', 'lighten')
    doTweenAlpha('overlayalpha', 'overlay', 0.5, 0.1, 'linear')
    doTweenAngle("sateliteangle", "satelite", 360, 500, 'quadOut')
    doTweenX("ufoMove", "ufo", -400, 400, 'quadOut')
end

