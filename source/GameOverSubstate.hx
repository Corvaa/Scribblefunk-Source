package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	var book:FlxSprite; // IM SO LAZY
	var book2:FlxSprite;
	var book3:FlxSprite;
	var book4:FlxSprite;
	var book5:FlxSprite;

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	public static var instance:GameOverSubstate;

	var blackScreen:FlxSprite;

	public static function resetVariables() {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);
		FlxG.camera.zoom = 0.65;

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		book = new FlxSprite().loadGraphic(Paths.image('bgs/sky')); // im too lazy to rename the vars, can you belive?
		book.antialiasing = ClientPrefs.globalAntialiasing;
		book.scale.set(3,3);
		book.alpha = 0.85;
		add(book);

		book2 = new FlxSprite().loadGraphic(Paths.image('bgs/stars'));
		book2.antialiasing = ClientPrefs.globalAntialiasing;
		book2.scale.set(2.25,2.25);
		book2.alpha = 0.85;
		book2.scrollFactor.set(0.5, 0.5);
		add(book2);

		book3 = new FlxSprite().loadGraphic(Paths.image('bgs/planet'));
		book3.antialiasing = ClientPrefs.globalAntialiasing;
		book3.scale.set(2,2);
		book3.alpha = 0.85;
		book3.scrollFactor.set(0.85, 0.85);
		add(book3);

		book4 = new FlxSprite().loadGraphic(Paths.image('bgs/ufo'));
		book4.antialiasing = ClientPrefs.globalAntialiasing;
		book4.scale.set(2,2);
		book4.alpha = 0.85;
		book4.scrollFactor.set(0.85, 0.85);
		add(book4);

		book5 = new FlxSprite().loadGraphic(Paths.image('bgs/satbutfull')); // IM EVEN MORE LAZY OK
		book5.antialiasing = ClientPrefs.globalAntialiasing;
		book5.scale.set(2,2);
		book5.alpha = 0.85;
		book5.scrollFactor.set(0.85, 0.85);
		add(book5);

		boyfriend = new Boyfriend(x, y, characterName);
		boyfriend.x += boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1];
		add(boyfriend);

		blackScreen = new FlxSprite().makeGraphic(Std.int(FlxG.width * 7), Std.int(FlxG.height * 7), FlxColor.BLACK);
		blackScreen.screenCenter();
		blackScreen.alpha = 0;
		add(blackScreen);

		if(PlayState.diedByExplosion == true)
			{
				blackScreen.alpha = 1;
				FlxG.camera.filtersEnabled = false;
			}

		camFollow = new FlxObject(400,150); //i REALLY Have no idea why i did this, it doesn't matter anyway + no one but us 3 will look at this code lol!
		FlxG.camera.follow(camFollow);

		FlxG.sound.play(Paths.sound(deathSoundName));
		Conductor.changeBPM(100);

		boyfriend.playAnim('firstDeath');
	}

	var isFollowingAlready:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			WeekData.loadTheFirstEnabledMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new MainMenuState());
			else
				MusicBeatState.switchState(new MainMenuState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if (boyfriend.animation.curAnim != null && boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				if (PlayState.SONG.stage == 'tank')
				{
					playingDeathSound = true;
					coolStartDeath(0.2);
					
					var exclude:Array<Int> = [];
					//if(!ClientPrefs.cursing) exclude = [1, 3, 8, 13, 17, 21];

					FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + FlxG.random.int(1, 25, exclude)), 1, false, null, true, function() {
						if(!isEnding)
						{
							FlxG.sound.music.fadeIn(0.2, 1, 4);
						}
					});
				}
				else
				{
					coolStartDeath();
				}
				boyfriend.startedDeath = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
