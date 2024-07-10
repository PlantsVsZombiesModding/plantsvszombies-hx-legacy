package com.popcap.flash.framework.resources.reanimator;

class ReanimDefinition {
	public var trackNameMap:ASDictionary<ASAny, ASAny>;

	public var tracks:Array<ASAny>;

	public var fps:Float = Math.NaN;

	public var numTracks:Float = Math.NaN;

	public function new() {
		// super();
		this.fps = 0;
		this.tracks = new Array<ASAny>();
		this.trackNameMap = new ASDictionary<ASAny, ASAny>();
		this.numTracks = 0;
	}
}
