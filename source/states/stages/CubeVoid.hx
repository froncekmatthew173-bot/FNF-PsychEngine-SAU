package states.stages;

class CubeVoid extends SauStageBase
{
	var backPillar:FlxSprite;
	var main:FlxSprite;
	var leftFore:FlxSprite;
	var rightFore:FlxSprite;
	var cubes:Array<FlxSprite> = [];
	var cubeIndex:Int = 0;
	var spawnTimer:Float = 0;

	override function create():Void
	{
		add(makeSprite('stages/sau/og shag/sky', -3500, -1800, 1, 1, 0.01, 0.01));
		backPillar = makeSprite('stages/sau/og shag/og shag bg', 3000, 800, 1, 1, 0.9, 0.9, true);
		add(backPillar);
		main = makeSprite('stages/sau/og shag/og shag bg', 0, 0, 1, 1, 1, 1, true);
		leftFore = makeSprite('stages/sau/og shag/og shag bg', 1000, 2500, 1, 1, 1.2, 1.2, true);
		rightFore = makeSprite('stages/sau/og shag/og shag bg', 6500, 2500, 1, 1, 1.2, 1.2, true);
		PlayState.instance.camZooming = true;
	}

	override function createPost():Void
	{
		for (index in 0...100)
		{
			var cube:FlxSprite = new FlxSprite();
			cube.makeGraphic(1, 1, FlxColor.WHITE);
			cube.setGraphicSize(100);
			cube.updateHitbox();
			cube.visible = false;
			cubes.push(cube);
			insertBefore(backPillar, cube);
		}
		insertBefore(boyfriendGroup, main);
		insertBefore(gfGroup, leftFore);
		insertBefore(gfGroup, rightFore);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		var hitPlayerSection:Bool = curSection >= 0 && curSection < PlayState.SONG.notes.length && PlayState.SONG.notes[curSection].mustHitSection;
		defaultCamZoom = hitPlayerSection ? 0.5 : 0.3;

		spawnTimer += elapsed;
		if(spawnTimer < 0.1 || cubes.length == 0) return;
		spawnTimer -= 0.1;

		var cube:FlxSprite = cubes[cubeIndex];
		cube.setPosition(2500 + FlxG.random.int(-3000, 3000), 3000);
		cube.visible = true;
		cube.velocity.set();
		cube.acceleration.set(FlxG.random.float(-100, 100), FlxG.random.float(-800, -700));
		cube.angle = FlxG.random.float(-45, 45);
		var scroll:Float = FlxG.random.float(0.2, 0.9);
		cube.scrollFactor.set(scroll, scroll);
		cube.setGraphicSize(Std.int(100 * FlxG.random.float(0.7, 1.8) * scroll));
		cube.updateHitbox();
		cubeIndex = (cubeIndex + 1) % cubes.length;
	}
}
