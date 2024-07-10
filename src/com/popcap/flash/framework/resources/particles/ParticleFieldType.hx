package com.popcap.flash.framework.resources.particles;

import com.popcap.flash.framework.utils.CEnum;

class ParticleFieldType extends CEnum {
	public static final ACCELERATION:ParticleFieldType = new ParticleFieldType();

	public static final FRICTION:ParticleFieldType = new ParticleFieldType();

	public static final ATTRACTOR:ParticleFieldType = new ParticleFieldType();

	public static final CIRCLE:ParticleFieldType = new ParticleFieldType();

	public static final GROUND_CONSTRAINT:ParticleFieldType = new ParticleFieldType();

	public static final INVALID:ParticleFieldType = new ParticleFieldType();

	public static final VELOCITY:ParticleFieldType = new ParticleFieldType();

	public static final SHAKE:ParticleFieldType = new ParticleFieldType();

	public static final POSITION:ParticleFieldType = new ParticleFieldType();

	public static final AWAY:ParticleFieldType = new ParticleFieldType();

	public static final MAX_VELOCITY:ParticleFieldType = new ParticleFieldType();

	public static final SYSTEM_POSITION:ParticleFieldType = new ParticleFieldType();

	public function new() {
		super();
		// super();
	}

	public static function fromUInt(param1:UInt):ParticleFieldType {
		switch (param1) {
			case 0:
				return INVALID;
			case 1:
				return FRICTION;
			case 2:
				return ACCELERATION;
			case 3:
				return ATTRACTOR;
			case 4:
				return MAX_VELOCITY;
			case 5:
				return VELOCITY;
			case 6:
				return POSITION;
			case 7:
				return SYSTEM_POSITION;
			case 8:
				return GROUND_CONSTRAINT;
			case 9:
				return SHAKE;
			case 10:
				return CIRCLE;
			case 11:
				return AWAY;
			default:
				return null;
		}
	}

	public static function fromString(param1:String):ParticleFieldType {
		switch (param1) {
			case "Friction":
				return FRICTION;
			case "Acceleration":
				return ACCELERATION;
			case "Attractor":
				return ATTRACTOR;
			case "MaxVelocity":
				return MAX_VELOCITY;
			case "Velocity":
				return VELOCITY;
			case "Position":
				return POSITION;
			case "SystemPosition":
				return SYSTEM_POSITION;
			case "GroundConstraint":
				return GROUND_CONSTRAINT;
			case "Shake":
				return SHAKE;
			case "Circle":
				return CIRCLE;
			case "Away":
				return AWAY;
			default:
				throw new haxe.Exception ("Unknown ParticleFieldType " + param1);
		}
	}

	public static function toUInt(param1:ParticleFieldType):UInt {
		if (param1 == INVALID) {
			return 0;
		}
		if (param1 == FRICTION) {
			return 1;
		}
		if (param1 == ACCELERATION) {
			return 2;
		}
		if (param1 == ATTRACTOR) {
			return 3;
		}
		if (param1 == MAX_VELOCITY) {
			return 4;
		}
		if (param1 == VELOCITY) {
			return 5;
		}
		if (param1 == POSITION) {
			return 6;
		}
		if (param1 == SYSTEM_POSITION) {
			return 7;
		}
		if (param1 == GROUND_CONSTRAINT) {
			return 8;
		}
		if (param1 == SHAKE) {
			return 9;
		}
		if (param1 == CIRCLE) {
			return 10;
		}
		if (param1 == AWAY) {
			return 11;
		}
		throw new Error("How did I get here?");
	}

	public function toString():String {
		return name;
	}

	static final ___init = {
		{
			CEnum.InitEnumConstants(ParticleFieldType);
		}
		null;
	};
}
