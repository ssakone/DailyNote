pragma Singleton

import QtQuick
import QuickFlux

KeyTable {
    id: actionTypes;

    property string pickPhoto

    property string previewPhoto

    property string navigateTo: 'navigateTo'

    property string navigateBack
}
