package states.stages;

import objects.Character;

class Hedge extends SauStageBase
{
	var pole2:FlxSprite;
	var bfReflection:Character;

	override function create():Void
	{
		add(makeSprite('stages/sau/tractor/bg', -1000, -800, 1.5, 1.5, 0.05, 0.05));
		add(makeSprite('stages/sau/tractor/main', -1800, -800, 2.5, 2.5));
		add(makeSprite('stages/sau/tractor/pole', -900, -650, 2.5, 2.5));
		add(makeSprite('stages/sau/tractor/wall light', -1550, 350, 2.5, 2.5));
		pole2 = makeSprite('stages/sau/tractor/pole', 1600, -250, 2.5, 2.5);
	}

	override function createPost():Void
	{
		insertBefore(gfGroup, pole2);
		applyCharacterShader(dad, [0.7, 0.8, 0.8, 1], [0.4, 0.8, 0.8, 0.3], -90, 15);
		applyCharacterShader(boyfriend, [0.7, 0.8, 0.8, 1], [0.4, 0.8, 0.8, 0.3], -90, 15);
		bfReflection = makeReflection(boyfriend, 0.3, -0.5, 0.8);
		addBehindBF(bfReflection);
		var dadReflection:Character = makeReflection(dad, 0.3, -0.5, 0.83);
		addBehindDad(dadReflection);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(bfReflection != null)
			bfReflection.alpha = boyfriend.alpha * 0.3;
	}
}
