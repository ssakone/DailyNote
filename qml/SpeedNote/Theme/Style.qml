pragma Singleton
import QtQuick
import SpeedNote.Theme as ThemeData

QtObject {
	enum Theme {
		Light,
		Dark
	}

    property int theme: Theme.Style.Theme.Light

    property BaseColorTheme lightColorTheme: ThemeData.LightColorTheme {}
    property BaseColorTheme darkColorTheme: ThemeData.DarkColorTheme {}


    property string primaryColorLight: lightColorTheme.primary
    property string primaryForegroundColorLight: lightColorTheme.primaryText
    property string primaryColorDark: darkColorTheme.primary
    property string primaryForegroundColorDark: darkColorTheme.primaryText
	
    property string accentColorLight: lightColorTheme.accent
    property string accentForegroundColorLight: lightColorTheme.accentText
    property string accentColorDark: darkColorTheme.accent
    property string accentForegroundColorDark: darkColorTheme.accentText

    property string secondaryColorLight: lightColorTheme.secondary
    property string secondaryColorDark: darkColorTheme.secondary
    property string secondaryForegroundColorLight: lightColorTheme.secondaryText
    property string secondaryForegroundColorDark: darkColorTheme.secondaryText

    property string secondaryContainerColorLight: lightColorTheme.secondaryContainer
    property string secondaryContainerColorDark: darkColorTheme.secondaryContainer
    property string secondaryContainerForegroundColorLight: lightColorTheme.secondaryContainerText
    property string secondaryContainerForegroundColorDark: darkColorTheme.secondaryContainerText

    property string backgroundColorLight: lightColorTheme.background
    property string backgroundColorDark: darkColorTheme.background
    property string backgroundForegroundColorLight: lightColorTheme.backgroundText
    property string backgroundForegroundColorDark: darkColorTheme.backgroundText

    property string surfaceVariantColorLight: lightColorTheme.surfaceVariant
    property string surfaceVariantColorDark: darkColorTheme.surfaceVariant
    property string surfaceVariantForegroundColorLight: lightColorTheme.surfaceVariantText
    property string surfaceVariantForegroundColorDark: darkColorTheme.surfaceVariantText

    property string primaryColor: theme === Style.Theme.Light ? primaryColorLight : primaryColorDark
    property string primaryTextColor: theme === Style.Theme.Light ? primaryForegroundColorLight : primaryForegroundColorDark

    property string accentColor: theme === Style.Theme.Light ? accentColorLight : accentColorDark
    property string accentTextColor: theme === Style.Theme.Light ? accentForegroundColorLight : accentForegroundColorDark

    property string secondaryColor: theme === Style.Theme.Light ? secondaryColorLight : secondaryColorDark
    property string secondaryTextColor: theme === Style.Theme.Light ? secondaryForegroundColorLight : secondaryForegroundColorDark

    property string secondaryContainerColor: theme === Style.Theme.Light ? secondaryContainerColorLight : secondaryContainerColorDark
    property string secondaryContainerTextColor: theme === Style.Theme.Light ? secondaryContainerForegroundColorLight : secondaryContainerForegroundColorDark

    property string surfaceVariantColor: theme === Style.Theme.Light ? surfaceVariantColorLight : surfaceVariantColorDark
    property string surfaceVariantTextColor: theme === Style.Theme.Light ? surfaceVariantForegroundColorLight : surfaceVariantForegroundColorDark

    property string backgroundColor: theme === Style.Theme.Light ? backgroundColorLight : backgroundColorDark
    property string backgroundTextColor: theme === Style.Theme.Light ? backgroundForegroundColorLight : backgroundForegroundColorDark

}
