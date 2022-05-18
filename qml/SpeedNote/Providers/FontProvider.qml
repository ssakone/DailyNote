import QtQuick

Item {
    // Montserrat

    property alias rR: robotoRegular

    FontLoader { source: Fonts.montserratBlack }
    FontLoader { source: Fonts.montserratBold }
    FontLoader { source: Fonts.montserratExtraBold }
    FontLoader { source: Fonts.montserratExtraLight }
    FontLoader { source: Fonts.montserratItalic }
    FontLoader { source: Fonts.montserratLight }
    FontLoader { source: Fonts.montserratMedium }
    FontLoader { source: Fonts.montserratRegular }
    FontLoader { source: Fonts.montserratThin }
    FontLoader { source: Fonts.montserratThinItalic }
     // Roboto Condensed
    FontLoader { source: RobotoFonts.robotoCondensedBold }
    FontLoader { source: RobotoFonts.robotoCondensedBoldItalic }
    FontLoader { source: RobotoFonts.robotoCondensedItalic }
    FontLoader { source: RobotoFonts.robotoCondensedLight }
    FontLoader { source: RobotoFonts.robotoCondensedLightItalic }
    FontLoader { source: RobotoFonts.robotoCondensedRegular }

    // Roboto
    FontLoader { source: RobotoDefaultFonts.robotoBlack }
    FontLoader { source: RobotoDefaultFonts.robotoBlackItalic }
    FontLoader { source: RobotoDefaultFonts.robotoBold }
    FontLoader { source: RobotoDefaultFonts.robotoBoldItalic }
    FontLoader { source: RobotoDefaultFonts.robotoItalic }
    FontLoader { source: RobotoDefaultFonts.robotoLight }
    FontLoader { source: RobotoDefaultFonts.robotoMedium }
    FontLoader { source: RobotoDefaultFonts.robotoMediumItalic }
    FontLoader { source: RobotoDefaultFonts.robotoRegular }
    FontLoader { source: RobotoDefaultFonts.robotoThin }
    FontLoader { source: RobotoDefaultFonts.robotoThinItalic }

   
    FontLoader { id: robotoRegular; source: "qrc:/Qaterial/Fonts/Roboto/Roboto-Regular.ttf" }

}
