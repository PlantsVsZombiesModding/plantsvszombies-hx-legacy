package com.popcap.flash.framework.states;

import com.popcap.flash.framework.graphics.Graphics2D;

class CStateManager implements IStateManager {
	var states:ASObject;

	var stack:Array<ASAny>;

	public function new() {
		// super();
		this.states = new ASObject();
		this.stack = new Array<ASAny>();
	}

	public function popState() {
		var _loc2_:IState = null;
		if (this.stack.length == 0) {
			return;
		}
		var _loc1_ = ASCompat.dynamicAs(this.stack.pop(), IState);
		_loc1_.onExit();
		if (this.stack.length > 0) {
			_loc2_ = ASCompat.dynamicAs(this.stack[this.stack.length - 1], IState);
			_loc2_.onPop();
		}
	}

	public function changeState(param1:String) {
		var _loc5_:IState = null;
		var _loc2_ = ASCompat.dynamicAs(this.states[param1], IState);
		if (_loc2_ == null) {
			throw new haxe.Exception ("ID " + param1 + " is unbound, cannot change states.");
		}
		var _loc3_ = this.stack.length;
		var _loc4_ = _loc3_ - 1;
		while (_loc4_ >= 0) {
			(_loc5_ = ASCompat.dynamicAs(this.stack[_loc4_], IState)).onExit();
			_loc4_--;
		}
		this.stack = new Array<ASAny>();
		this.stack.push(_loc2_);
		_loc2_.onEnter();
	}

	public function draw(param1:Graphics2D) {
		var _loc4_:IState = null;
		var _loc2_ = this.stack.length;
		var _loc3_ = 0;
		while (_loc3_ < _loc2_) {
			(_loc4_ = ASCompat.dynamicAs(this.stack[_loc3_], IState)).draw(param1);
			_loc3_++;
		}
	}

	public function bindState(param1:String, param2:IState) {
		this.states[param1] = param2;
	}

	public function pushState(param1:String) {
		var _loc3_:IState = null;
		var _loc2_ = ASCompat.dynamicAs(this.states[param1], IState);
		if (_loc2_ == null) {
			throw new haxe.Exception ("ID " + param1 + " is unbound, cannot push onto stack.");
		}
		if (this.stack.length > 0) {
			_loc3_ = ASCompat.dynamicAs(this.stack[this.stack.length - 1], IState);
			_loc3_.onPush();
		}
		this.stack.push(_loc2_);
		_loc2_.onEnter();
	}

	public function update() {
		var _loc1_ = this.stack.length - 1;
		if (_loc1_ < 0) {
			return;
		}
		var _loc2_ = ASCompat.dynamicAs(this.stack[_loc1_], IState);
		_loc2_.update();
	}
}
