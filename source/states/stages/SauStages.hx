package states.stages;

import backend.StageData.StageFile;

class SauStages
{
	static function sprite(name:String, x:Float, y:Float, image:String, scaleX:Float, scaleY:Float, scrollX:Float, scrollY:Float, ?animated:Bool = false):FlxSprite
	{
		var spr:FlxSprite = new SauStageSprite(name, x, y);
		if(animated)
			spr.frames = Paths.getAtlas(image);
		else
			spr.loadGraphic(Paths.image(image));

		spr.scale.set(scaleX, scaleY);
		spr.updateHitbox();
		spr.scrollFactor.set(scrollX, scrollY);
		spr.antialiasing = ClientPrefs.data.antialiasing;
		return spr;
	}

	static function stage(defaultZoom:Float, boyfriend:Array<Float>, girlfriend:Array<Float>, opponent:Array<Float>, objects:Array<Dynamic>, ?hideGirlfriend:Bool = false):StageFile
	{
		return cast {
			directory: '',
			defaultZoom: defaultZoom,
			stageUI: '',
			boyfriend: boyfriend,
			girlfriend: girlfriend,
			opponent: opponent,
			hide_girlfriend: hideGirlfriend,
			camera_boyfriend: [0, 0],
			camera_opponent: [0, 0],
			camera_girlfriend: [0, 0],
			camera_speed: 1.0,
			objects: objects
		};
	}

	public static function get(name:String):Null<StageFile>
	{
		return switch (name)
		{
			case 'boat': stage(0.6, [770, 300], [-10000, 130], [100, 300], [
                var bg = new FlxSprite(-1500, -700, Paths.image('stages/sau/toge/bg'));
                bg.scale.set(2, 2);
                add(bg);
                var boat = new FlxSprite(-2400, -1300, Paths.image('stages/sau/toge/boat'));
                boat.scale.set(3, 3);
                add(boat);
                var flag = new FlxSprite(-1100, -2200, Paths.image('stages/sau/toge/flag'));
                flag.scale.set(3, 3);
                add(flag);
            ]);
			case 'cave': stage(0.6, [770, 300], [-10000, 130], [100, 300], [
                var bg = new FlxSprite(-333, -469, Paths.image('bgs/Weed/Weed sky'));
                bg.scale.set(1.2, 1.2);
                add(bg);
                var floor = new FlxSprite(-417, -392, Paths.image('bgs/Weed/Weed moon'));
                floor.scale.set(1.2, 1.2);
                add(floor);
                var forewalls = new FlxSprite(-299, -448, Paths.image('bgs/Weed/Weed background'));
                forewalls.scale.set(1.2, 1.2);
                add(forewalls);
                var sidewalls = new FlxSprite(-299, -448, Paths.image('bgs/Weed/Weed foreground'));
                sidewalls.scale.set(1.2, 1.2);
                add(sidewalls);
			]);
			case 'cliff': stage(0.7, [550, 200], [400, 130], [-250, 200], [
                var bg = new FlxSprite(-1200, -600, Paths.image('stages/sau/shag12/bg'));
                bg.scale.set(1.5, 1.5);
                add(bg);
                var sea = new FlxSprite(-1200, 600, Paths.image('stages/sau/shag12/sea'));
                sea.scale.set(1.5, 1.5);
                add(sea);
                var ground = new FlxSprite(-1200, 800, Paths.image('stages/sau/shag12/ground'));
                ground.scale.set(2, 2);
                add(ground);
			]);
			case 'crack': stage(0.7, [2345, 589], [400, 130], [1235, 750], [
                var bg = new FlxSprite(11, -62, Paths.image('stages/sau/crack shag/CrackShaggyBGFinal'));
                bg.scale.set(1, 1);
                add(bg);
                var bin = new FlxSprite(1115, 880, Paths.image('stages/sau/crack shag/bin back'));
                bin.scale.set(1, 1);
                add(bin);
                var bin2 = new FlxSprite(1584, 889, Paths.image('stages/sau/crack shag/bin back'));
                bin2.scale.set(1, 1);
                add(bin2);
                var bin3 = new FlxSprite(545, 799, Paths.image('stages/sau/crack shag/bin'));
                bin3.scale.set(1, 1);
                add(bin3);
                var doublebin = new FlxSprite(990, 1162, Paths.image('stages/sau/crack shag/doublebin')
                doublebin.scale.set(1, 1);
                add(doublebin);
			]);
			case 'cubeVoid': stage(0.3, [4650, 1950], [400, 130], [1000, -360], [
                var bg = new FlxSprite(-3500, -1800, Paths.image('stages/sau/og shag/sky'));
                bg.scale.set(1, 1);
                add(bg);
                var backpillar = new FlxSprite(3000, 800, Paths.image('stages/sau/og shag/og shag bg'));
                backpillar.scale.set(1, 1);
                add(backpillar);
                var main = new FlxSprite(0, 0, Paths.image('stages/sau/og shag/og shag bg'));
                main.scale.set(1, 1);
                add(main);
                var leftfore = new FlxSprite(1000, 2500, Paths.image('stages/sau/og shag/og shag bg'));
                leftfore.scale.set(1, 1);
                add(leftfore);
                var rightfore = new FlxSprite(6500, 2500, Paths.image('stages/sau/og shag/og shag bg')
                rightfore.scale.set(1, 1);
                add(rightfore);
			]);
			case 'elshagus': stage(0.75, [1000, 200], [-400, -400], [-250, 200], [
                var bg = new FlxSprite(-1000, -400, Paths.image('stages/sau/elshagus/bg'));
                bg.scale.set(0.8, 0.8);
                add(bg);
                var ring = new FlxSprite(-1000, 500, Paths.image('stages/sau/elshagus/boxing ring'));
                ring.scale.set(1, 1);
			]);
			case 'finale': stage(0.5, [1100, 100], [400, 130], [150, 100], []);
			case 'forest': stage(0.65, [650, 200], [400, 130], [-650, 200], [
                var bg = new FlxSprite(-1000, -700, Paths.image('stages/sau/yomama/bg'));
                bg.scale.set(1, 1);
                add(bg);
                var castle = new FlxSprite(250, 0, Paths.image('stages/sau/yomama/castle'));
                castle.scale.set(1, 1);
                add(castle);
                var groundback = new FlxSprite(-1500, 400, Paths.image('stages/sau/yomama/groundback'));
                groundback.scale.set(1, 1);
                add(groundback);
                var groundfront = new FlxSprite(-1500, 650, Paths.image('stages/sau/yomama/groundfront'));
                groundfront.scale.set(1, 1);
                add(groundfront);
                var bgstuff = new FlxSprite(-1600, -470, Paths.image('stages/sau/yomama/bgstuff'));
                bgstuff.scale.set(1, 1);
                add(bgstuff);
			], true);
			case 'hedge': stage(0.4, [850, 200], [400, 130], [-450, 200], [
                var bg = new FlxSprite(-1000, -800, Paths.image('stages/sau/tractor/bg'));
                bg.scale.set(1.5, 1.5);
                add(bg);
                var main = new FlxSprite(-1800, -800, Paths.image('stages/sau/tractor/main'));
                main.scale.set(2.5, 2.5);
                add(main);
                var pole1 = new FlxSprite(-900, -650, Paths.image('stages/sau/tractor/pole'));
                pole1.scale.set(2.5, 2.5);
                add(pole1);
                var wallLight = new FlxSprite(-1550, 350, Paths.image('stages/sau/tractor/wall light'));
                wallLight.scale.set(2.5, 2.5);
                add(wallLight);
                var pole2 = new FlxSprite(1600, -250, Paths.image('stages/sau/tractor/pole'));
                pole2.scale.set(2.5, 2.5);
                add(pole2);
			]);
			case 'paint': stage(0.6, [800, 100], [400, 130], [-400, 100], [
                var bliss = new FlxSprite(-2200, -1100, Paths.image('stages/sau/png shag/Bliss'));
                bliss.scale.set(6, 6);
                add(bliss);
                var bg = new FlxSprite(-1200, -100, Paths.image('stages/sau/png shag/PNGShagBG1'));
                bg.scale.set(1, 1);
			]);
			case 'scoobcar': stage(0.7, [1100, 150], [400, 130], [-450, 200], [
                var bg = new FlxSprite(-1500, -630, Paths.image('stages/sau/scoobcarbg'));
                bg.scale.set(1.5, 1.5);
                add(bg);
			]);
			case 'space': stage(0.4, [2926, 103], [400, 130], [1149, 586], [
                var bg = new FlxSprite(-1782, -1082, Paths.image('stages/sau/god shag/god shag bg'));
                bg.scale.set(1.75, 1.75);
                add(bg);
                var shagRock = new FlxSprite(577, 1074, Paths.image('stages/sau/god shag/god shag bg'));
                shagRock.scale.set(1, 1);
                add(shagRock);
                var bfRock = new FlxSprite(2746, 595, Paths.image('stages/sau/god shag/god shag bg'));
                bfRock.scale.set(1, 1);
                add(bfRock);
			]);
			case 'temple': stage(0.7, [1174, 1058], [400, 130], [338, 1058], [
                var bg = new FlxSprite(0, 0, Paths.image('stages/sau/snake shag/Temple Background'));
                bg.scale.set(1, 1);
                add(bg);
                var fg = new FlxSprite(-326, 181, Paths.image('stages/sau/snake shag/Temple Foreground'));
                fg.scale.set(1, 1);
                add(fg);
			]);
			case 'van': stage(0.6, [700, 200], [400, 130], [-500, 200], [
                var bg = new FlxSprite(-1500, -1000, Paths.image('stages/sau/faker shag/faker_shag_bg'));
                bg.scale.set(1, 1);
                add(bg);
                var fence = new FlxSprite(-1500, 300, Paths.image('stages/sau/faker shag/faker_shag_bg'));
                fence.scale.set(1, 1);
                add(fence);
                var ground = new FlxSprite(-1500, 300, Paths.image('stages/sau/faker shag/faker_shag_bg'));
                ground.scale.set(1, 1);
                add(ground);
                var dog = new FlxSprite(-1500, -100, Paths.image('stages/sau/faker shag/faker_van'));
                dog.scale.set(1, 1);
                add(dog);
			]);
			case 'void': stage(0.7, [1000, 100], [400, 130], [0, 100], []);
			case 'woods': stage(0.65, [550, 200], [400, 130], [-250, 200], [
                var bg = new FlxSprite(-1000, -300, Paths.image('stages/sau/bg_webiando'));
                bg.scale.set(2.3, 2.3);
                add(bg);
			]);
			default: null;
		};
	}
}

class SauStageSprite extends FlxSprite
{
	public var stageName:String;

	public function new(stageName:String, x:Float, y:Float)
	{
		super(x, y);
		this.stageName = stageName;
	}
}
