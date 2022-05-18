pragma Singleton
import QtQuick

QtObject {

	function debug(obj) {
	    if(typeof(obj) === typeof({}))
	        console.log("[DEBUG] %1".arg(JSON.stringify(obj)))
	    else console.log("[DEBUG] %1".arg(obj))
	}

}