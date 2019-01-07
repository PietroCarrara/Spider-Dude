package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Character extends FlxSprite {
	private var maxJumpForce = 600;

	function new(?x:Float, ?y:Float) {
		super(x, y);
		this.loadGraphic("assets/images/char.png");
		this.scale = new flixel.math.FlxPoint(10, 10);
		this.updateHitbox();
	}

	override function update(dt:Float) {
		super.update(dt);

		if (FlxG.swipes.length > 0) {
			var swipe = FlxG.swipes[0];

			// Screen point to world point
			swipe.endPosition.x += this.x - FlxG.width / 2;
			swipe.endPosition.y += this.y - FlxG.height / 2;

			var angle = flixel.math.FlxAngle.angleBetweenPoint(this, swipe.endPosition);

			trace("angle", angle);
			trace("cos", Math.cos(angle));
			trace("sin", Math.sin(angle));

			// The touch was below the character, so its ok
			if (angle > 0) {
				var force = Math.min(swipe.distance, maxJumpForce);

				this.velocity.x = -Math.cos(angle) * force;
				this.velocity.y = -Math.sin(angle) * force;

				this.acceleration.y = maxJumpForce / 2;
			}
		}
	}
}
