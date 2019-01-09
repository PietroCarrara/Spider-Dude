package;

import flixel.FlxG;
import entities.Character;

// Contains info about the force on the player
class PlayerRocket {
	public static var angle(default, null):Float = 0;
	public static var force(default, null):Float = 0;

	public static function update(char:Character) {
		var touch = TouchInput.getTouch();
		if (touch != null) {
			var angle = flixel.math.FlxAngle.angleBetweenPoint(char, touch.position);

			// trace(angle);

			// The touch was below the character, so its ok
			if (angle > 0) {
				PlayerRocket.angle = angle;

				force = flixel.math.FlxMath.distanceToPoint(char, touch.position);

				// Your force will be at its maximum when your finger slides to the border of the screen
				force = force / (FlxG.initialWidth / 2);

				force = Math.min(1, force);

				if (touch.justReleased) {
                    trace("Jumping now!");
					char.velocity.x = -Math.cos(angle) * char.maxJumpForce * force;
					char.velocity.y = -Math.sin(angle) * char.maxJumpForce * force;
                    char.canJump = false;
				}
			}
		}
	}
}