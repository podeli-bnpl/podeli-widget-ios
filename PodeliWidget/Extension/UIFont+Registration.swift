//
//  UIFont+Registration.swift
//  podeliWidget
//
//  Created by Николай Малофеев on 16.11.2022.
//

import UIKit
extension UIFont {
    private static func registerFont(withName fontName: String) {
            let bundle = Bundle(for: PodeliWidgetView.self)
            guard let fontURL = bundle.url(forResource: fontName, withExtension: "otf"),
            let fontData = try? Data(contentsOf: fontURL) as CFData,
            let provider = CGDataProvider(data: fontData),
            let font = CGFont(provider) else {
            return
        }
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
    public static func loadFonts() {
        registerFont(withName: "Styrene B LC-Medium")
    }
}

