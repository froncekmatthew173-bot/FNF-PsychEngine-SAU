package states.stages;

import flixel.addons.display.FlxRuntimeShader;

class Boat extends SauStageBase
{
	var boat:FlxSprite;
	var flag:FlxSprite;
	var mirror:FlxRuntimeShader;
	var wiggle:FlxRuntimeShader;
	var elapsedTime:Float = 0;

	override function create():Void
	{
		var background:FlxSprite = makeSprite('stages/sau/toge/bg', -1500, -700, 2, 2, 0.1, 0.1);
		add(background);
		boat = makeSprite('stages/sau/toge/boat', -2400, -1300, 3, 3);
		flag = makeSprite('stages/sau/toge/flag', -1100, -2200, 3, 3);

		mirror = loadShader('mirrorRepeat');
		setShaderValue(mirror, 'x', 0.0);
		setShaderValue(mirror, 'y', 0.0);
		setShaderValue(mirror, 'angle', 0.0);
		setShaderValue(mirror, 'zoom', 1.0);
		background.shader = mirror;

		wiggle = loadShader('wiggle');
		setShaderValue(wiggle, 'effectType', 0);
		setShaderValue(wiggle, 'uSpeed', 0.5);
		setShaderValue(wiggle, 'uFrequency', 10.0);
		setShaderValue(wiggle, 'uWaveAmplitude', 0.01);
		flag.shader = wiggle;
	}

	override function createPost():Void
	{
		insertBefore(gfGroup, boat);
		insertBefore(gfGroup, flag);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		elapsedTime += elapsed;
		setShaderValue(wiggle, 'uTime', elapsedTime);
		setShaderValue(mirror, 'x', -elapsedTime * 0.01);
		camGame.angle = Math.sin(elapsedTime * 0.25) * 5;
	}
}