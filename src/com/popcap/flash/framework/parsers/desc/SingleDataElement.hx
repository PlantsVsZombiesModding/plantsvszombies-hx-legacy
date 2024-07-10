package com.popcap.flash.framework.parsers.desc;

class SingleDataElement extends DataElement {
	public var mValue:DataElement;

	public var mString:String = "";

	public function new() {
		super();
		// super();
	}

	public function toString():String {
		return this.mString;
	}
}
