package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.math.FlxRandom;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import entities.Character;
import entities.Platform;

class PlayState extends FlxState {
	var char:Character;
	var platforms:FlxGroup;
	var walls:FlxTypedGroup<FlxObject>;
	var random:FlxRandom = new FlxRandom();

	public static var camTarget(default, null):FlxObject;

	override function create():Void {
		super.create();

		char = new Character();
		add(char);

		camTarget = new FlxObject();
		add(camTarget);
		camera.focusOn(camTarget.getPosition());
		camera.follow(camTarget, FlxCameraFollowStyle.LOCKON, 0.1);

		platforms = new FlxGroup();
		platforms.add(new Platform(0, 200, 20, 20));
		add(platforms);

		add(new entities.JumpIndicator(char, 70));
	}

	override function update(dt:Float):Void {
		super.update(dt);

		// Collide with platforms
		FlxG.collide(char, platforms, snap);
	}

	function snap(char:Character, platform:Platform) {
		char.snap(platform);

		var newPlat = new Platform(random.float(-FlxG.width / 2, FlxG.width / 2), camTarget.y, 50, 20);
		platforms.add(newPlat);

		FlxG.worldBounds.set(camTarget.x - FlxG.width / 2, camTarget.y - FlxG.height / 2, FlxG.width, FlxG.height);
	}
}
