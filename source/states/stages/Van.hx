package states.stages;

import objects.Character;

class Van extends SauStageBase
{
	var bfReflection:Character;

	override function create():Void
	{
		add(makeSprite('stages/sau/faker shag/faker_shag_bg', -1500, -1000, 1, 1, 0.01, 0.01, true));
		add(makeSprite('stages/sau/faker shag/faker_shag_bg', -1500, 300, 1, 1, 0.9, 0.9, true));
		add(makeSprite('stages/sau/faker shag/faker_shag_bg', -1500, 300, 1, 1, 1, 1, true));
		add(makeSprite('stages/sau/faker shag/faker_van', -1500, -100, 1, 1, 1, 1, true));
	}

	override function createPost():Void
	{
		applyCharacterShader(dad, [0.8, 0.7, 0.9, 1], [0.7, 0.7, 0.7, 0.3], -90, 25);
		applyCharacterShader(boyfriend, [0.8, 0.7, 0.9, 1], [0.7, 0.7, 0.7, 0.3], -90, 25);
		bfReflection = makeReflection(boyfriend, 0.5, -0.5, 0.8);
		addBehindBF(bfReflection);
		var dadReflection:Character = makeReflection(dad, 0.5, -0.5, 0.75);
		addBehindDad(dadReflection);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(bfReflection != null)
			bfReflection.alpha = boyfriend.alpha * 0.5;
	}
}
