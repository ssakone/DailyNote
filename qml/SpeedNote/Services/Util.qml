pragma Singleton
import QtQuick

QtObject {
	
	function forEachListModel(model, callback) {
	    for (var i = 0; i < model.count; i++) {
	        callback(model.get(i))
	    }
	}

	function forEach(model, callback) {
	    for (var i = 0; i < model.length; i++) {
	        callback(model[i])
	    }
	}

	function createComponent(componentName,parent,sub={}) {
	    var component = Qt.createComponent(componentName);
	    var sprite = component.createObject(parent,sub);
	    return sprite;
	}

	function createQmlObject(name, parent) {
	    return Qt.createQmlObject('import QtQuick; '+name+' {}', parent);
	}

	function createQmlObjectSrc(src, parent) {
	    return Qt.createQmlObject(src,parent);
	}


	function assert (condition) {
	    try {
	        return !condition ? false : true
	    } catch(e){
	        return false
	    }
	}

    property var toInt: (value) => parseInt(value.toString().replace(" ",""))

	function formatNumber(value){
	    return Number(value).toLocaleString(Qt.locale('fr_FR')).split(",")[0]
	}

	function formatDate(value, format = "yyyy-MM-dd"){
	    return new Date(value).toLocaleString(Qt.locale('fr_FR'), format)
	}

	function debug(obj) {
	    if(typeof(obj) === typeof({}))
	        console.log("[DEBUG] %1".arg(JSON.stringify(obj)))
	    else console.log("[DEBUG] %1".arg(obj))
	}



}
