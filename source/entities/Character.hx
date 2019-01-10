package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Character extends FlxSprite {
	private static inline var GRAVITY_SCALE = 40;

	public var canJump:Bool = false;

	public var maxJumpForce(default, null) = 15 * GRAVITY_SCALE;
	public var gravity(default, null) = 9.8 * GRAVITY_SCALE;
	public var lastPlatform(default, null):Platform;

	function new(?x:Float, ?y:Float) {
		super(x, y);

		this.loadGraphic("assets/images/char.png");
		this.scale = new flixel.math.FlxPoint(5, 5);

		this.acceleration.y = gravity;

		this.updateHitbox();
	}

	override function update(dt:Float) {
		super.update(dt);

		// Bounce on the walls
		if (this.x <= -FlxG.width / 2) {
			this.velocity.x = Math.abs(this.velocity.x);
		} else if (this.x + this.width >= FlxG.width / 2) {
			this.velocity.x = -Math.abs(this.velocity.x);
		}

		if (canJump) { // Only jump when on a platform
			PlayerRocket.update(this);
		} else { // If we're not on a platform, apply gravity
			acceleration.y = gravity;
		}
	}

	public function getCenter():FlxPoint {
		return new FlxPoint(this.x + this.width / 2, this.y + this.height / 2);
	}

	public function snap(p:Platform) {

		// Doesn't matter what platform you land,
		// you should be able to jump and stop moving
		canJump = true;
		acceleration.y = 0;
		this.velocity.set();

		if (p == lastPlatform) {
			return;
		}

		lastPlatform = p;

		PlayState.camTarget.y = this.y + this.height - FlxG.width / 2;
	}
}
