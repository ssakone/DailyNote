pragma Singleton

import QtQuick
import QtQuick.Controls
import QuickFlux

ActionCreator {

    //signal navigateTo(var item)

    function navigateTo( item,  properties = {}) {
        AppDispatcher.dispatch(ActionTypes.navigateTo, {item: item, properties: properties})
    }

    signal navigateBack()
}
