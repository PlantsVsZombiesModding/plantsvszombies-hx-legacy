package com.popcap.flash.framework.render;

import com.popcap.flash.framework.graphics.Graphics2D;

class RenderManager {
	var mItems:Array<ASAny>;

	public function new() {
		// super();
		this.mItems = new Array<ASAny>();
	}

	public function add(renderable:Renderable) {
		var item:Renderable = null;
		var len = this.mItems.length;
		var depth = renderable.getDepth();
		for (i in 0...len) {
			item = this.mItems[i];
			if (item.getDepth() > depth) {
				this.mItems.insert(i, renderable);
				return;
			}
		}
		this.mItems.push(renderable);
	}

	function depthCompare(a:Renderable, b:Renderable):Float {
		return a.getDepth() - b.getDepth();
	}

	public function draw(g:Graphics2D) {
		var anItem:Renderable = null;
		var aNumItems = this.mItems.length;
		for (i in 0...aNumItems) {
			anItem = this.mItems[i];
			if (!anItem.getIsDisposable()) {
				if (anItem.getIsVisible()) {
					anItem.draw(g);
				}
			}
		}
	}

	public function update() {
		var anItem:Renderable = null;
		var aNumItems = this.mItems.length;
		for (i in 0...aNumItems) {
			anItem = this.mItems[i];
			if (!anItem.getIsDisposable()) {
				anItem.update();
			}
		}
		this.mItems = this.mItems.filter(this.isAliveFilter);
	}

	function isAliveFilter(item:ASAny, index:Int, array:Array<ASAny>):Bool {
		var aRenderable = ASCompat.dynamicAs(item, Renderable);
		return !aRenderable.getIsDisposable();
	}
}
