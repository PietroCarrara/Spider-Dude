package entities;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Character extends FlxSprite {
	private static inline var GRAVITY_SCALE = 40;

	public var canJump:Bool = false;

	public var maxJumpForce(default, null) = 15 * GRAVITY_SCALE;
	public var gravity(default, null) = 9.8 * GRAVITY_SCALE;
	public var lastPlatform(default, null):Platform;

	// Used to bounce on platforms:
	// We keep track of the last record of the velocity, 
	// because on a collision, it gets set to 0, so we 
	// can't invert it.
	// TODO: Make the collide method do not touch the velocity
	private var lastXVelocity:Float = 0;

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

		this.lastXVelocity = this.velocity.x;
	}

	public function getCenter():FlxPoint {
		return new FlxPoint(this.x + this.width / 2, this.y + this.height / 2);
	}

	public function snap(p:Platform):Bool {

		if (!this.isTouching(FlxObject.DOWN)) {
			trace("AYYY");
			if (this.isTouching(FlxObject.LEFT)) {
				trace("going right");
				this.velocity.x = Math.abs(lastXVelocity);
			} else if (this.isTouching(FlxObject.RIGHT)) {
				trace("going left");
				this.velocity.x = -Math.abs(lastXVelocity);
			}
			return false;
		}

		// Doesn't matter what platform you land,
		// you should be able to jump and stop moving
		canJump = true;
		acceleration.y = 0;
		this.velocity.set();

		if (p == lastPlatform) {
			return false;
		}

		lastPlatform = p;

		PlayState.camTarget.y = this.y + this.height - FlxG.width / 2;

		return true;
	}
}
