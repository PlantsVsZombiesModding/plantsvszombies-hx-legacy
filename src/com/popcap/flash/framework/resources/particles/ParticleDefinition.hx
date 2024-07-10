package com.popcap.flash.framework.resources.particles;

class ParticleDefinition {
	public var mFilename:String;

	public var mEmitterDefs:Array<ASAny>;

	public function new() {
		// super();
		this.mEmitterDefs = new Array<ASAny>();
	}
}
