//
//  Color+extensions.swift
//  SwiftUICourse
//
//  Created by Hugo Saynac on 23/06/2020.
//  Copyright © 2020 Danilo Santana. All rights reserved.
//

import SwiftUI

extension Color {
    static let darkBlueStart = Color(red: 0 / 255, green: 78 / 255, blue: 146 / 255)
    static let darkBlueEnd = Color(red: 0 / 255, green: 4 / 255, blue: 40 / 255)
	/// Helper method to initialize a `UIColor` object with a given hex String
	///
	/// - Parameter hex: String value (#RRGGBB or RRGGBB)
	public init(_ hex: String) {
		var hex = hex
		// supprime le #
		if hex.first == "#" { hex.removeFirst() }

		// Vérifier qu'on a bien 6 caractères
		guard hex.count == 6 else {
			self.init(red: 0, green: 0, blue: 0)
			return
		}

		// r -> les deux premier
		let r = hex.dropLast(4)
		// g -> les deux du milieu
		let g = hex.dropFirst(2).dropLast(2)
		// b les 2 derniers
		let b = hex.dropFirst(4)

		// Int(r, radix:16) permet de préciser qu'on est sur une base 16 pour nos entiers
		let red = Double(Int(r, radix: 16) ?? 0)
		let green = Double(Int(g, radix: 16) ?? 0)
		let blue = Double(Int(b, radix: 16) ?? 0)

		self.init(red: red/255, green: green/255, blue:blue / 255)
	}

	static var maison: Color {
		return Color("#ff33ee")
	}
}


extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .bottomTrailing, endPoint: .topLeading)
    }
}

