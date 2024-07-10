package com.popcap.flash.framework;

import com.XMLC;

interface IAppServiceReference {
	function getProperties():XMLC;

	function getPlugin():IAppPlugin;

	function getUsingPlugins():Vector<IAppPlugin>;
}
