package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.group.FlxGroup;
import entities.Character;
import entities.Platform;

class PlayState extends FlxState {
	var char:Character;
	var platforms:FlxGroup;

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
		platforms.add(new Platform(-90, -50, 60, 20));
		platforms.add(new Platform(0, 200, 20, 20));

		add(platforms);

		add(new entities.JumpIndicator(char, 70));

		FlxG.worldBounds.set(camTarget.x-FlxG.width/2, camTarget.y-FlxG.height/2, FlxG.width, FlxG.height);
	}

	override function update(dt:Float):Void {
		super.update(dt);

		FlxG.collide(char, platforms, snap);
	}

	function snap(char:Character, platform:Platform) {
		char.snap(platform);
	}
}
