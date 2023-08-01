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
end

function onCreatePost()
    doTweenAngle("sateliteangle", "satelite", 360, 500, 'quadOut')
    doTweenX("ufoMove", "ufo", -400, 400, 'quadOut')

    setProperty('timeBar.color', getColorFromHex('458b94'))
    setProperty('scoreTxt.color', getColorFromHex('458b94'))

    if middlescroll == false then
        noteTweenX("NoteMove1", 0, 730, 0.01, cubeIn) --opp left
        noteTweenX("NoteMove2", 2, 955, 0.01, cubeIn) --opp up
        noteTweenX("NoteMove3", 1, 842, 0.01, cubeIn) --opp down
        noteTweenX("NoteMove4", 3, 1066, 0.01, cubeIn) --opp right
        noteTweenX("NoteMove5", 4, 100, 0.01, cubeIn) --player left
        noteTweenX("NoteMove6", 5, 212, 0.01, cubeIn) -- player down
        noteTweenX("NoteMove7", 7, 434, 0.01, cubeIn) -- player right
        noteTweenX("NoteMove8", 6, 324, 0.01, cubeIn) -- player up
    end

end
