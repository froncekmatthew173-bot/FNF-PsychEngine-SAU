package states.stages;

import flixel.addons.display.FlxRuntimeShader;

class Space extends SauStageBase
{
	var shagRock:FlxSprite;
	var bfRock:FlxSprite;
	var asteroidNames:Array<String> = ['rock 1', 'rock 2', 'rock 3', 'rock 3 bigger', 'rock 4', 'rock 5'];
	var asteroids:Array<FlxSprite> = [];
	var asteroidCount:Int = 0;
	var asteroidPoolReady:Bool = false;

	override function create():Void
	{
		add(makeSprite('stages/sau/god shag/god shag bg', -1782, -1082, 1.75, 1.75, 0.05, 0.05, true));
		shagRock = makeSprite('stages/sau/god shag/god shag bg', 577, 1074, 1, 1, 1, 1, true);
		bfRock = makeSprite('stages/sau/god shag/god shag bg', 2746, 595, 1, 1, 1, 1, true);
	}

	override function createPost():Void
	{
		insertBefore(dadGroup, shagRock);
		insertBefore(boyfriendGroup, bfRock);
		PlayState.instance.comboGroup.x += 1800;
		for (character in [dad, boyfriend])
		{
			var shader:FlxRuntimeShader = loadShader('charSplit');
			setShaderValue(shader, 'overlayColor', [0.0, 0.0, 0.0, 1.0]);
			setShaderValue(shader, 'satinColor', [0.8, 0.8, 0.9, 1.0]);
			setShaderValue(shader, 'innerShadowColor', [0.7, 0.7, 0.7, 0.3]);
			setShaderValue(shader, 'innerShadowAngle', Math.PI / 2);
			setShaderValue(shader, 'innerShadowDistance', 25.0);
			setShaderValue(shader, 'flipSplit', -1.0);
			character.shader = shader;
		}
	}

	override function beatHit():Void
	{
		super.beatHit();
		if(curBeat % 8 == 0)
		{
			var x:Float = FlxG.random.bool(50) ? -1200 : 5500;
			makeAsteroid(x, FlxG.random.float(-500, 1000), FlxG.random.float(0.65, 1.4));
		}
	}

	function makeAsteroid(x:Float, y:Float, scroll:Float):Void
	{
		var asteroid:FlxSprite;
		if(asteroidPoolReady)
		{
			asteroid = asteroids[asteroidCount % asteroids.length];
			asteroid.setPosition(x, y);
			asteroid.scrollFactor.set(scroll, scroll);
			asteroid.scale.set(FlxG.random.float(0.4, 0.8), FlxG.random.float(0.4, 0.8));
			asteroid.updateHitbox();
			asteroid.animation.play('a', true);
		}
		else
		{
			asteroid = new FlxSprite(x, y);
			asteroid.frames = Paths.getSparrowAtlas('stages/sau/god shag/god shag bg');
			asteroid.animation.addByPrefix('a', asteroidNames[FlxG.random.int(0, asteroidNames.length - 1)], 24, false);
			asteroid.animation.play('a');
			asteroid.scrollFactor.set(scroll, scroll);
			asteroid.scale.set(FlxG.random.float(0.4, 0.8), FlxG.random.float(0.4, 0.8));
			asteroid.updateHitbox();
			asteroid.antialiasing = ClientPrefs.data.antialiasing;
			if(scroll < 1)
				insertBefore(dadGroup, asteroid);
			else
				add(asteroid);
			asteroids.push(asteroid);
		}

		asteroid.velocity.x = x <= -1000 ? FlxG.random.float(400, 900) : FlxG.random.float(-900, -400);
		asteroid.velocity.y = FlxG.random.float(-200, 200);
		asteroid.angularVelocity = FlxG.random.float(-50, 50);
		asteroidCount++;
		if(asteroidCount > 50) asteroidPoolReady = true;
	}
}
