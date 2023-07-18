function onCreate()
    time = 0
    originY = getCharacterY('bf')
    runTimer('time', 0.01, 0)
end
function onTimerCompleted(tags, loops, loopsLeft)
    time = time + 1
    setCharacterY('bf', originY + math.sin(time / 50) * 50)
    --debugPrint(time)
    runTimer('time', 0.01, 0)
    if focusOnMaxwell == 1 then
        cameraSetTarget('bf')
    end
end
function onMoveCamera(focus)
    if focus == 'bf' then
        focusOnMaxwell = 1
    else
        focusOnMaxwell = 0
    end
end