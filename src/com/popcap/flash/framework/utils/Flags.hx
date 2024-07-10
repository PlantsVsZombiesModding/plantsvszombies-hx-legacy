package com.popcap.flash.framework.utils;

class Flags {
	var mFlags:UInt = 0;

	public function new() {
		// super();
	}

	public function clearFlags(flags:UInt) {
		this.mFlags &= ~flags;
	}

	public function setFlags(flags:UInt) {
		this.mFlags |= flags;
	}

	public function hasFlags(testFlags:UInt):Bool {
		return (this.mFlags & testFlags) != 0;
	}
}
