package com.popcap.flash.games.pvz.logic;

class HitResult {
	static inline final OBJECT_TYPE_PLANT = 1;

	static inline final OBJECT_TYPE_SHOVEL = 5;

	static inline final OBJECT_TYPE_PROJECTILE = 2;

	static inline final OBJECT_TYPE_COIN = 3;

	static inline final OBJECT_TYPE_NONE = 0;

	static inline final OBJECT_TYPE_SEEDPACKET = 4;

	public var mObject:ASObject;

	public var mObjectType:Int = 0;

	public function new() {
		// super();
	}
}
