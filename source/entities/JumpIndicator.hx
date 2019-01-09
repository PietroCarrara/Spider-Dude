package entities;

import flixel.FlxSprite;
import flixel.math.FlxAngle;

class JumpIndicator extends FlxSprite {
	private var player:Character;
	private var distance:Float;

	public function new(player:Character, distance:Float) {
		super(x, y);

		loadGraphic("assets/images/indicator.png");

		this.player = player;
		this.distance = distance;
	}

	override function update(dt:Float) {
		super.update(dt);

		var t = TouchInput.getTouch();

		if (t == null) {
			this.visible = false;
			return;
		}

		// Get the angle to the player's finger,
		// but put the indicator on the other end (+180º)
		var angle = PlayerRocket.angle + Math.PI;

		this.angle = FlxAngle.asDegrees(angle) + 90;

		this.x = player.getCenter().x;
		this.y = player.getCenter().y;

		this.x += Math.cos(angle) * distance * PlayerRocket.force;
		this.y += Math.sin(angle) * distance * PlayerRocket.force;

		this.visible = true;
	}
}
