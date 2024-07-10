package com.popcap.flash.framework.resources.particles;

import com.popcap.flash.framework.graphics.Graphics2D;

class ParticleSystem {
	public var mDontUpdate:Bool = false;

	public var mDead:Bool = false;

	public var mParticleDef:ParticleDefinition;

	public var mEmitterList:Array<ASAny>;

	public function new() {
		// super();
		this.mEmitterList = new Array<ASAny>();
	}

	public function die() {
		var emitter:ParticleEmitter = null;
		for (_tmp_ in this.mEmitterList) {
			emitter = _tmp_;
			emitter.deleteAll();
		}
		this.mEmitterList = new Array<ASAny>();
		this.mDead = true;
	}

	public function update() {
		var aEmitter:ParticleEmitter = null;
		if (this.mDontUpdate) {
			return;
		}
		var aEmitterAlive = false;
		for (_tmp_ in this.mEmitterList) {
			aEmitter = _tmp_;
			aEmitter.update();
			if (aEmitter.mEmitterDef.mCrossFadeDuration.isSet()) {
				if (aEmitter.mParticleList.length > 0) {
					aEmitterAlive = true;
				}
			} else if (!aEmitter.mDead) {
				aEmitterAlive = true;
			}
		}
		if (!aEmitterAlive) {
			this.mDead = true;
		}
	}

	public function setPosition(x:Float, y:Float) {
		var aEmitter:ParticleEmitter = null;
		for (_tmp_ in this.mEmitterList) {
			aEmitter = _tmp_;

			aEmitter.setPosition(x, y);
		}
	}

	public function initFromDef(def:ParticleDefinition) {
		var aEmitterDef:ParticleEmitterDefinition = null;
		var aEmitter:ParticleEmitter = null;
		this.mParticleDef = def;
		this.mEmitterList = new Array<ASAny>();
		var aEmitterDefCount = def.mEmitterDefs.length;
		for (i in 0...aEmitterDefCount) {
			aEmitterDef = def.mEmitterDefs[i];
			if (!aEmitterDef.mCrossFadeDuration.isSet()) {
				if (aEmitterDef.mParticleFlags.hasFlags(ParticleFlags.DIE_IF_OVERLOADED) && false) {
					this.die();
					return;
				}
				aEmitter = new ParticleEmitter();
				aEmitter.initFromDef(aEmitterDef, this);
				this.mEmitterList.push(aEmitter);
			}
		}

		this.mDontUpdate = false;
		this.mDead = false;
	}

	public function draw(g:Graphics2D) {
		var aEmitter:ParticleEmitter = null;
		for (_tmp_ in this.mEmitterList) {
			aEmitter = _tmp_;

			aEmitter.draw(g);
		}
	}
}
