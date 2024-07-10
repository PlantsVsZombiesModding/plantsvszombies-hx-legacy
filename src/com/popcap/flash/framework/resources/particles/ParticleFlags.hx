package com.popcap.flash.framework.resources.particles;

class ParticleFlags {
	public static inline final SOFTWARE_ONLY:UInt = 1024;

	public static inline final RANDOM_LAUNCH_SPIN:UInt = 1;

	public static inline final ADDITIVE:UInt = 256;

	public static inline final DIE_IF_OVERLOADED:UInt = 128;

	public static inline final SYSTEM_LOOPS:UInt = 8;

	public static inline final HARDWARE_ONLY:UInt = 2048;

	public static inline final RANDOM_START_TIME:UInt = 64;

	public static inline final PARTICLES_DONT_FOLLOW:UInt = 32;

	public static inline final ALIGN_LAUNCH_SPIN:UInt = 2;

	public static inline final PARTICLE_LOOPS:UInt = 16;

	public static inline final FULLSCREEN:UInt = 512;

	public static inline final ALIGN_TO_PIXEL:UInt = 4;

	var mFlags:UInt = 0;

	public function new() {
		// super();
	}

	public static function fromString(param1:String):UInt {
		switch (param1) {
			case "RandomLaunchSpin":
				return RANDOM_LAUNCH_SPIN;
			case "AlignLaunchSpin":
				return ALIGN_LAUNCH_SPIN;
			case "AlignToPixel":
				return ALIGN_TO_PIXEL;
			case "SystemLoops":
				return SYSTEM_LOOPS;
			case "ParticleLoops":
				return PARTICLE_LOOPS;
			case "ParticlesDontFollow":
				return PARTICLES_DONT_FOLLOW;
			case "RandomStartTime":
				return RANDOM_START_TIME;
			case "DieIfOverloaded":
				return DIE_IF_OVERLOADED;
			case "Additive":
				return ADDITIVE;
			case "FullScreen":
				return FULLSCREEN;
			case "SoftwareOnly":
				return SOFTWARE_ONLY;
			case "HardwareOnly":
				return HARDWARE_ONLY;
			default:
				throw new haxe.Exception ("Unknown ParticleFlags type \'" + param1 + "\'");
		}
	}

	public function setFlags(param1:UInt) {
		this.mFlags |= param1;
	}

	public function clearFlags(param1:UInt) {
		this.mFlags &= ~param1;
	}

	public function fromUInt(param1:UInt) {
		this.mFlags = param1;
	}

	public function toUInt():UInt {
		return this.mFlags;
	}

	public function hasFlags(param1:UInt):Bool {
		return (this.mFlags & param1) != 0;
	}

	public function toString():String {
		var _loc1_:ASAny = "[" + this.mFlags;
		if (this.hasFlags(RANDOM_LAUNCH_SPIN)) {
			_loc1_ += "|RANDOM_LAUNCH_SPIN";
		}
		if (this.hasFlags(ALIGN_LAUNCH_SPIN)) {
			_loc1_ += "|ALIGN_LAUNCH_SPING";
		}
		if (this.hasFlags(SYSTEM_LOOPS)) {
			_loc1_ += "|SYSTEM_LOOPS";
		}
		if (this.hasFlags(PARTICLE_LOOPS)) {
			_loc1_ += "|PARTICLE_LOOPS";
		}
		if (this.hasFlags(PARTICLES_DONT_FOLLOW)) {
			_loc1_ += "|PARTICLES_DONT_FOLLOW";
		}
		if (this.hasFlags(RANDOM_START_TIME)) {
			_loc1_ += "|RANDOM_START_TIME";
		}
		if (this.hasFlags(DIE_IF_OVERLOADED)) {
			_loc1_ += "|DIE_IF_OVERLOADED";
		}
		if (this.hasFlags(ADDITIVE)) {
			_loc1_ += "|ADDITIVE";
		}
		if (this.hasFlags(FULLSCREEN)) {
			_loc1_ += "|FULLSCREEN";
		}
		if (this.hasFlags(SOFTWARE_ONLY)) {
			_loc1_ += "|SOFTWARE_ONLY";
		}
		if (this.hasFlags(HARDWARE_ONLY)) {
			_loc1_ += "|HARDWARE_ONLY";
		}
		return _loc1_ + "]";
	}
}
