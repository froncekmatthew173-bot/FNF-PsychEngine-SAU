package states.stages;

import objects.Character;

class Crack extends SauStageBase
{
	var binFront:FlxSprite;
	var doubleBin:FlxSprite;
	var boyfriendReflection:Character;

	override function create():Void
	{
		add(makeSprite('stages/sau/crack shag/CrackShaggyBGFinal', 11, -62));
		add(makeSprite('stages/sau/crack shag/bin back', 1115, 880));
		add(makeSprite('stages/sau/crack shag/bin back', 1584, 889));
		binFront = makeSprite('stages/sau/crack shag/bin', 545, 799);
		doubleBin = makeSprite('stages/sau/crack shag/doublebin', 990, 1162);
	}

	override function createPost():Void
	{
		insertBefore(gfGroup, binFront);
		insertBefore(gfGroup, doubleBin);

		if(songName == 'high-on-everything') return;
		applyCharacterShader(dad, [0.9, 0.85, 1, 1], [0.7, 0.7, 0.7, 0.3], -40, 25);
		applyCharacterShader(boyfriend, [0.9, 0.85, 1, 1], [0.7, 0.7, 0.7, 0.3], -40, 25);
		boyfriendReflection = makeReflection(boyfriend, 0.5, -0.25, 0.67, 0.35, -70);
		addBehindBF(boyfriendReflection);
		var dadReflection:Character = makeReflection(dad, 0.5, -0.25, 0.65, 0.4, -70);
		addBehindDad(dadReflection);
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if(boyfriendReflection != null)
			boyfriendReflection.alpha = boyfriend.alpha * 0.5;
	}
}
