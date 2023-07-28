import QtQuick
import QtQuick.Controls
import QuickFlux

Middleware {
    filterFunctionEnabled: true

    property var stack;

    function navigateTo(message) {
        stack.push(message.item,message.properties);
    }

    function navigateBack(message) {
        stack.pop();
    }

//    function dispatch(type, message) {
//        if (type === ActionTypes.navigateTo) {
//            navigateTo(message)
//            return;
//        } else if(type === ActionTypes.navigateBack) {
//            navigateBack(message)
//        }

//        next(type, message);
//    }

}
