package com.popcap.flash.framework.resources.reanimator;

import com.popcap.flash.framework.AppBase;
import flash.utils.ByteArray;
import com.XMLC;

class XMLReanimDescriptor implements ReanimDescriptor {
	var mLastTrans:ReanimTransform;

	var mXML:XMLC;

	var mApp:AppBase;

	var mBytes:ByteArray;

	public function new(bytes:ByteArray) {
		// super();
		this.mBytes = bytes;
	}

	function parseTransform(xml:XMLC):ReanimTransform {
		var transform = new ReanimTransform();
		var xStr = Std.string(xml.x);
		if (xStr.length > 0) {
			transform.tX = ASCompat.toNumber(xStr);
		}
		var yStr = Std.string(xml.y);
		if (yStr.length > 0) {
			transform.tY = ASCompat.toNumber(yStr);
		}
		var kxStr = Std.string(xml.kx);
		if (kxStr.length > 0) {
			transform.kX = -2 * Math.PI * ASCompat.toNumber(kxStr) / 360;
		}
		var kyStr = Std.string(xml.ky);
		if (kyStr.length > 0) {
			transform.kY = -2 * Math.PI * ASCompat.toNumber(kyStr) / 360;
		}
		var sxStr = Std.string(xml.sx);
		if (sxStr.length > 0) {
			transform.sX = ASCompat.toNumber(sxStr);
		}
		var syStr = Std.string(xml.sy);
		if (syStr.length > 0) {
			transform.sY = ASCompat.toNumber(syStr);
		}
		var fStr = Std.string(xml.f);
		if (fStr.length > 0) {
			transform.frame = ASCompat.toNumber(fStr);
		}
		var aStr = Std.string(xml.a);
		if (aStr.length > 0) {
			transform.alpha = ASCompat.toNumber(aStr);
		}
		var imageStr = Std.string(xml.i);
		if (imageStr.length > 0) {
			transform.image = this.mApp.imageManager.getImageInst(imageStr);
		}
		transform.fillInFrom(this.mLastTrans);
		return transform;
	}

	function parseDefinition(xml:XMLC):ReanimDefinition {
		var aTrack:ReanimTrack = null;
		var def = new ReanimDefinition();
		def.fps = xml.fps;
		var len = 0; // xml.track.length();
		for (i in 0...len) {
			aTrack = this.parseTrack(xml.track[i]);
			def.tracks.push(aTrack);
			def.trackNameMap[aTrack.name] = aTrack;
			++def.numTracks;
		}
		return def;
	}

	function parseTrack(xml:XMLC):ReanimTrack {
		var aTrans:ReanimTransform = null;
		var track = new ReanimTrack();
		track.name = xml.name;
		this.mLastTrans = null;
		var len = 0; // xml.t.length();
		for (i in 0...len) {
			aTrans = this.parseTransform(xml.t[i]);
			track.transforms.push(aTrans);
			++track.numTransforms;
			this.mLastTrans = aTrans;
		}
		return track;
	}

	public function createReanimData(app:AppBase):ReanimDefinition {
		this.mApp = app;
		this.mBytes.position = 0;
		this.mXML = new XMLC(ASCompat.toNumber(this.mBytes.readUTFBytes(this.mBytes.length)));
		return this.parseDefinition(this.mXML);
	}
}
