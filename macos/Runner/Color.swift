//
//  Color.swift
//  Runner
//
//  Created by Davide Agostini on 20/06/22.
//

import Foundation
import Cocoa

extension NSColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = Double((hexNumber >> 16) & 0xFF) / 255
                    g = Double((hexNumber >> 8) & 0xFF) / 255
                    b = Double(hexNumber & 0xFF) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }

        return nil
    }
}
