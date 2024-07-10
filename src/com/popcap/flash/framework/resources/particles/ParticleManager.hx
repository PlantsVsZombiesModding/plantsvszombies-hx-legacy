package com.popcap.flash.framework.resources.particles;

import com.popcap.flash.framework.AppBase;

class ParticleManager {
	var mApp:AppBase;

	public function new(app:AppBase) {
		// super();
		this.mApp = app;
	}

	public function spawnParticleSystem(id:String):ParticleSystem {
		var aTmp:ParticleDefinition = null;
		var aDesc = ASCompat.dynamicAs(this.mApp.resourceManager.getResource(id), ParticleDescriptor);
		if (aDesc != null) {
			aTmp = aDesc.createData(this.mApp);
			this.mApp.resourceManager.setResource(id, aTmp);
		}
		var aData = ASCompat.dynamicAs(this.mApp.resourceManager.getResource(id), ParticleDefinition);
		if (aData == null) {
			throw new Error("Particle type \'" + id + "\' is not loaded!");
		}
		var particle = new ParticleSystem();
		particle.initFromDef(aData);
		return particle;
	}
}
