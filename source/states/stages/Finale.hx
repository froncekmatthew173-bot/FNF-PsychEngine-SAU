package states.stages;

import flixel.addons.display.FlxRuntimeShader;
import flixel.system.FlxAssets.FlxShader;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.FlxTweenType;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.utils.Assets;
import openfl.utils.AssetType;

class Finale extends BaseStage
{
	var eye:Array<Float> = [0, 0, -1, 0];
	var lookAt:Array<Float> = [0, 0, 1, 0];
	var up:Array<Float> = [0, 1, 0, 0];
	var right:Array<Float> = [1, 0, 0, 0];
	var upVector:Array<Float> = [0, 1, 0, 0];
	var forward:Array<Float> = [0, 0, 1, 0];
	var perspectiveMatrix:Array<Float>;
	var viewMatrix:Array<Float> = [];
	var perspectiveObjects:Array<{sprite:FlxSprite, shader:FlxRuntimeShader}> = [];
	var barrierObjects:Array<FlxSprite> = [];
	var cameos:Array<FlxSprite> = [];
	var cameoOrder:Array<Int> = [];
	var timers:Array<FlxTimer> = [];
	var tweens:Array<FlxTween> = [];
	var elapsedTime:Float = 0;
	var cameoTimer:Float = 0;
	var showCameo:Bool = false;
	public var debugCam:Bool = false;
	var yaw:Float = 0;
	var pitch:Float = 0;

	override function create()
	{
		var fov:Float = 90 * (Math.PI / 180);
		var focalLength:Float = 1.0 / Math.tan(fov * 0.5);
		perspectiveMatrix = [
			focalLength, 0, 0, 0,
			0, focalLength, 0, 0,
			0, 0, 1.0, 1.0,
			0, 0, 0, 0
		];
	}

	override function createPost()
	{
		var floor:FlxSprite = new FlxSprite(400, 800);
		floor.makeGraphic(1, 1, 0xFF777777);
		applyPerspective(floor, 0);
		setVertexOffsets(floor.shader, [-2000, 2000, -2000, 2000], [0, 0, 0, 0], [-10000, -10000, 200000, 200000]);
		insert(0, floor);

		var leftBarrier:FlxSprite = makeBarrier([-2000, -2000, -2000, -2000], [0, -5000, 0, -5000]);
		barrierObjects.push(leftBarrier);
		insert(1, leftBarrier);

		var rightBarrier:FlxSprite = makeBarrier([2000, 2000, 2000, 2000], [0, -5000, 0, -5000]);
		barrierObjects.push(rightBarrier);
		insert(2, rightBarrier);

		var ceiling:FlxSprite = makeBarrier([-2000, 2000, -2000, 2000], [-5000, -5000, -5000, -5000]);
		barrierObjects.push(ceiling);
		insert(3, ceiling);

		var leftDoors:FlxSprite = makeDoorway(-1600, -3800);
		insert(5, leftDoors);
		var rightDoors:FlxSprite = makeDoorway(2400, -3800);
		insert(3, rightDoors);

		addCameo('stages/sau/finale/epicdemigodcomic', 0, 900, 16000);
		addCameo('stages/sau/finale/green', 0, 900, 19000);
		addCameo('stages/sau/finale/red', 0, 900, 21000);
		addCameo('stages/sau/finale/zephyrus', 0, 400, 12000);
		updateViewMatrix();
	}

	function makeBarrier(xOffsets:Array<Float>, yOffsets:Array<Float>):FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite(400, 800);
		sprite.makeGraphic(1, 1, FlxColor.WHITE);
		var shader:FlxRuntimeShader = applyPerspective(sprite, 0, 'barrier');
		setVertexOffsets(shader, xOffsets, yOffsets, [-10000, -10000, 200000, 200000]);
		return sprite;
	}

	function makeDoorway(x:Float, z:Float):FlxSprite
	{
		var sprite:FlxSprite = new FlxSprite(x, 800);
		sprite.loadGraphic(Paths.image('doorway'));
		sprite.setGraphicSize(800, 1200);
		sprite.color = 0xFF383838;
		sprite.updateHitbox();
		sprite.y -= sprite.height;

		var shader:FlxRuntimeShader = applyPerspective(sprite, z, 'doorwayRepeat');
		shader.data.doorWidth.value = sprite.width / 3;
		shader.data.repeatGap.value = 700.0;
		shader.data.repeatCount.value = 100.0;
		setVertexOffsets(shader, [0, -sprite.width, 0, -sprite.width], [0, 0, 0, 0], [0, 100 * ((sprite.width / 3) + 700), 0, 100 * ((sprite.width / 3) + 700)]);
		return sprite;
	}

	function addCameo(image:String, x:Float, y:Float, z:Float):Void
	{
		var sprite:FlxSprite = new FlxSprite(x, y);
		sprite.loadGraphic(Paths.image(image));
		applyPerspective(sprite, z);
		addBehindDad(sprite);
		sprite.y -= sprite.height;
		sprite.alpha = 0;
		cameos.push(sprite);
	}

	function applyPerspective(sprite:FlxSprite, z:Float, shaderName:String = 'perspective'):FlxRuntimeShader
	{
		var vertexPath:String = Paths.shaderVertex(shaderName, 'shared');
		var fragmentPath:String = Paths.shaderFragment(shaderName, 'shared');
		var vertexSource:String = Assets.exists(vertexPath, AssetType.TEXT) ? Assets.getText(vertexPath) : null;
		var fragmentSource:String = Assets.exists(fragmentPath, AssetType.TEXT) ? Assets.getText(fragmentPath) : null;
		var shader:FlxRuntimeShader = new FlxRuntimeShader(fragmentSource, vertexSource);
		shader.data.vertexXOffset.value = [0.0, 0.0, 0.0, 0.0];
		shader.data.vertexYOffset.value = [0.0, 0.0, 0.0, 0.0];
		shader.data.vertexZOffset.value = [0.0, 0.0, 0.0, 0.0];
		shader.data.perspectiveMatrix.value = perspectiveMatrix;
		shader.data.zOffset.value = z;
		sprite.shader = shader;
		perspectiveObjects.push({sprite: sprite, shader: shader});
		return shader;
	}

	function setVertexOffsets(shader:FlxShader, x:Array<Float>, y:Array<Float>, z:Array<Float>):Void
	{
		shader.data.vertexXOffset.value = x;
		shader.data.vertexYOffset.value = y;
		shader.data.vertexZOffset.value = z;
	}

	function updateViewMatrix():Void
	{
		forward = normalize([lookAt[0] - eye[0], eye[1] - lookAt[1], lookAt[2] - eye[2], 0]);
		right = normalize(cross(up, forward));
		upVector = cross(forward, right);
		var negativeEye:Array<Float> = [-eye[0], eye[1], -eye[2], -eye[3]];
		viewMatrix = [
			right[0], upVector[0], forward[0], 0,
			right[1], upVector[1], forward[1], 0,
			right[2], upVector[2], forward[2], 0,
			dot(right, negativeEye), dot(upVector, negativeEye), dot(forward, negativeEye), 1
		];

		for (entry in perspectiveObjects)
			entry.shader.data.viewMatrix.value = viewMatrix;
	}

	static function normalize(vector:Array<Float>):Array<Float>
	{
		var magnitude:Float = Math.sqrt(vector[0] * vector[0] + vector[1] * vector[1] + vector[2] * vector[2] + vector[3] * vector[3]);
		if(magnitude == 0) return vector;
		for (index in 0...vector.length)
			vector[index] /= magnitude;
		return vector;
	}

	static function cross(first:Array<Float>, second:Array<Float>):Array<Float>
	{
		return [
			first[1] * second[2] - first[2] * second[1],
			first[2] * second[0] - first[0] * second[2],
			first[0] * second[1] - first[1] * second[0],
			1
		];
	}

	static function dot(first:Array<Float>, second:Array<Float>):Float
	{
		return first[0] * second[0] + first[1] * second[1] + first[2] * second[2];
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		elapsedTime += elapsed;
		for (sprite in barrierObjects)
			cast(sprite.shader, FlxRuntimeShader).data.iTime.value = -elapsedTime;

		if(debugCam)
			updateDebugCamera(elapsed);
		updateViewMatrix();

		cameoTimer -= elapsed;
		if(cameoTimer < 0)
		{
			if(showCameo) startCameo();
			showCameo = true;
			cameoTimer = FlxG.random.float(150, 500);
		}
	}

	function updateDebugCamera(elapsed:Float):Void
	{
		camFollow.setPosition(FlxG.width * 0.5, FlxG.height * 0.5);
		camGame.targetOffset.set(0, 0);
		lookAt[0] = Math.sin(yaw);
		lookAt[1] = Math.sin(pitch);
		lookAt[2] = Math.cos(yaw) * Math.cos(pitch);

		if(FlxG.keys.pressed.LEFT) yaw -= elapsed;
		if(FlxG.keys.pressed.RIGHT) yaw += elapsed;
		if(FlxG.keys.pressed.UP) pitch -= elapsed;
		if(FlxG.keys.pressed.DOWN) pitch += elapsed;

		if(FlxG.keys.pressed.A || FlxG.keys.pressed.D)
		{
			var strafe:Array<Float> = normalize(cross(lookAt, up));
			var direction:Float = FlxG.keys.pressed.A ? 1 : -1;
			moveEye(strafe, elapsed * direction);
		}
		if(FlxG.keys.pressed.W || FlxG.keys.pressed.S)
		{
			var direction:Float = FlxG.keys.pressed.W ? -1 : 1;
			moveEye(lookAt, elapsed * direction);
		}
		lookAt[0] += eye[0];
		lookAt[1] += eye[1];
		lookAt[2] += eye[2];
	}

	function moveEye(direction:Array<Float>, amount:Float):Void
	{
		eye[0] += amount * direction[0];
		eye[1] += amount * direction[1];
		eye[2] += amount * direction[2];
	}

	function startCameo():Void
	{
		if(cameos.length == 0) return;
		if(cameoOrder.length == 0)
			for (index in 0...cameos.length)
				cameoOrder.push(FlxG.random.int(0, cameos.length - 1, cameoOrder));

		var sprite:FlxSprite = cameos[cameoOrder.shift()];
		var flipped:Bool = FlxG.random.bool(50);
		sprite.alpha = 0;
		sprite.flipX = flipped;
		sprite.x = flipped ? 2400 : -1600;
		tween(sprite, {alpha: 1.0}, 2, {ease: FlxEase.cubeOut});

		startTimer(FlxG.random.float(2, 4), function(_)
		{
			var walkTween:FlxTween = tween(sprite, {y: sprite.y + 50}, 0.5, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});
			tween(sprite, {x: FlxG.random.float(0, 800)}, 5, {ease: FlxEase.linear, onComplete: function(_)
			{
				walkTween.cancel();
				startTimer(FlxG.random.float(2, 4), function(_)
				{
					var secondWalk:FlxTween = tween(sprite, {y: sprite.y + 50}, 0.5, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});
					tween(sprite, {x: flipped ? -1600 : 2400}, 5, {ease: FlxEase.linear, onComplete: function(_)
					{
						secondWalk.cancel();
						tween(sprite, {alpha: 0.0}, 2, {ease: FlxEase.cubeOut});
					}});
				});
			}});
		});
	}

	function startTimer(duration:Float, callback:FlxTimer->Void):Void
	{
		var timer:FlxTimer = new FlxTimer();
		timers.push(timer);
		timer.start(duration, callback);
	}

	function tween(sprite:FlxSprite, values:Dynamic, duration:Float, options:Dynamic):FlxTween
	{
		var activeTween:FlxTween = FlxTween.tween(sprite, values, duration, options);
		tweens.push(activeTween);
		return activeTween;
	}

	override function destroy():Void
	{
		for (timer in timers)
			timer.cancel();
		for (activeTween in tweens)
			activeTween.cancel();
		perspectiveObjects = [];
		barrierObjects = [];
		cameos = [];
		super.destroy();
	}
}
