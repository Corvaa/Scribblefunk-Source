package;

import flixel.graphics.FlxGraphic;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets as OpenFlAssets;
import editors.ChartingState;
import editors.CharacterEditorState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Note.EventNote;
import openfl.events.KeyboardEvent;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxSave;
import flixel.animation.FlxAnimationController;
import animateatlas.AtlasFrameMaker;
import Achievements;
import StageData;
import FunkinLua;
import DialogueBoxPsych;
import Conductor.Rating;
import flixel.FlxSubState;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class TypingSubstate
{
	public var words:Array<Dynamic> =
	[
		'deez',
		'caca',
		'fuck',
		'tester',
		'kill yourself'
	];

    var word:String = words[Math.floor(Math.random() * words.length)];

	public var timeToType:Int = 15;
	public var timebeforeGORGOLOZ:FlxText;

    public var win:Void->Void = null;
	public var lose:Void->Void = null;

	public var textToTypeGORGOLOZ:FlxText;

    public function new(theTimer:Int = 15)
    {
        timeToType = theTimer;
        super();

        timebeforeGORGOLOZ = new FlxText(0,0,0, Std.string(timeToType), 32);
        timebeforeGORGOLOZ.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        timebeforeGORGOLOZ.borderSize = 1.25;
        timebeforeGORGOLOZ.screenCenter(XY);
        timebeforeGORGOLOZ.y -= 25;
        add(timebeforeGORGOLOZ);

        textToTypeGORGOLOZ = new FlxText(0,0,0, word, 32);
        textToTypeGORGOLOZ.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        textToTypeGORGOLOZ.borderSize = 1.25;
        textToTypeGORGOLOZ.screenCenter(XY);
        add(timebeforeGORGOLOZ);
    }

    private function onKeyDown(e:KeyboardEvent):Void //copied from hypno's lullaby lol........
    {
        if (e.keyCode == 16 || e.keyCode == 17 || e.keyCode == 220 || e.keyCode == 27)
            return;
        else
        {
            if (e.charCode == 0)
                return;
    
            var daKey:String = String.fromCharCode(e.charCode);
            trace(daKey);

        }
    }

    override function beatHit()
    {
        super.beatHit();
    
        if(cantPress == true)
            {
                timeToType--;
                timebeforeGORGOLOZ.text = Std.string(timeToType);
                trace(timeToType);
            }
    }
}