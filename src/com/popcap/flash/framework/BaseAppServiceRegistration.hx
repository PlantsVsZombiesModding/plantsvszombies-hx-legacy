package com.popcap.flash.framework;

import com.XMLC;

class BaseAppServiceRegistration implements IAppServiceRegistration {
	var mProperties:XMLC;

	var mApp:AppBase;

	var mService:ASObject;

	var mPlugin:BaseAppPlugin;

	var mClasses:Vector<String>;

	public function new(param1:AppBase, param2:BaseAppPlugin, param3:Vector<String>, param4:ASObject, param5:XMLC) {
		// super();
		this.mApp = param1;
		this.mPlugin = param2;
		this.mClasses = param3;
		this.mService = param4;
		this.mProperties = param5;
	}

	public function unregister() {
		throw new Error("Unimplemented stub method.");
	}

	public function setProperties(param1:XMLC) {
		this.mProperties = param1.copy();
	}

	public function getProperties():XMLC {
		return this.mProperties.copy();
	}

	public function getReference():IAppServiceReference {
		return new BaseAppServiceReference(this.mPlugin, this);
	}

	public function getService():ASObject {
		return this.mService;
	}
}
