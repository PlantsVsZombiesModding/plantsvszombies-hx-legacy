package com.popcap.flash.framework.resources.reanimator;

import com.popcap.flash.framework.AppBase;
import flash.events.EventDispatcher;

class Reanimator extends EventDispatcher {
	var mApp:AppBase;

	public function new(app:AppBase) {
		super();
		// super();
		this.mApp = app;
	}

	public function loadReanim(id:String, reanimDesc:ReanimDescriptor) {
		var aData = reanimDesc.createReanimData(this.mApp);
		this.mApp.resourceManager.setResource(id, aData);
	}

	public function createReanimation(id:String):Reanimation {
		var aTmp:ReanimDefinition = null;
		var aDesc = ASCompat.dynamicAs(this.mApp.resourceManager.getResource(id), ReanimDescriptor);
		if (aDesc != null) {
			aTmp = aDesc.createReanimData(this.mApp);
			this.mApp.resourceManager.setResource(id, aTmp);
		}
		var aData = ASCompat.dynamicAs(this.mApp.resourceManager.getResource(id), ReanimDefinition);
		if (aData == null) {
			throw new Error("Reanimation type \'" + id + "\' is not loaded!");
		}
		return new Reanimation(aData);
	}
}
