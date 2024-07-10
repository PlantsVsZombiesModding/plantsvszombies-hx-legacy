package com.popcap.flash.framework.parsers.desc;

class ListDataElement extends DataElement {
	public var mElements:Array<ASAny>;

	public function new() {
		super();
		// super();
		this.mElements = new Array<ASAny>();
	}

	public function toString():String {
		return "[" + this.mElements + "]";
	}
}
