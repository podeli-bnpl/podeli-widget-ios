//
//  UIFont+Registration.swift
//  podeliWidget
//
//  Created by Николай Малофеев on 16.11.2022.
//

import UIKit
extension UIFont {
    private static func registerFont(withName name: String, fileExtension: String) {
        let frameworkBundle = Bundle(for: PodeliWidgetView.self)
        let pathForResourceString = frameworkBundle.path(forResource: name, ofType: fileExtension)
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>? = nil

        if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
            print("Error registering font")
        }
    }

    public static func loadFonts() {
        registerFont(withName: "Styrene B LC-Medium", fileExtension: "otf")

    }
}
