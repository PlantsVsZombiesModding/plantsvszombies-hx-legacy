package com.popcap.flash.games.pvz.logic.Zombies;

class ZombiePicker {
	public var mZombieTypeCount:Array<ASAny>;

	public var mZombieCount:Int = 0;

	public var mZombiePoints:Int = 0;

	public var mAllWavesZombieTypeCount:Array<ASAny>;

	public function new() {
		this.mZombieTypeCount = new Array<ASAny>();
		this.mAllWavesZombieTypeCount = new Array<ASAny>();
		// super();
	}
}
