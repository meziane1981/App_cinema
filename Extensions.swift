//
//  Color+extensions.swift
//  SwiftUICourse
//
//  Created by Hugo Saynac on 23/06/2020.
//  Copyright © 2020 Danilo Santana. All rights reserved.
//

import SwiftUI

extension Color {
    // Quiz
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
    static let redStart = Color(red: 142 / 255, green: 14 / 255, blue: 0 / 255)
    static let redEnd = Color(red: 31 / 255, green: 28 / 255, blue: 24 / 255)
    static let greenStart = Color(red: 82 / 255, green: 194 / 255, blue: 52 / 255)
    static let greenEnd = Color(red: 6 / 255, green: 23 / 255, blue: 0 / 255)
    
    // Profile
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    // Profile
    static let profileOnlineIndicatorGradient = LinearGradient(gradient: Gradient(colors: [
        Color(.green),
        Color(red: 0.0, green: 0.4, blue: 0.0)
    ]), startPoint: .top, endPoint: .bottom)
    static let profileOfflineIndicatorGradient = LinearGradient(gradient: Gradient(colors: [
        Color(red: 0.3, green: 0.3, blue: 0.3),
        Color(.gray)
    ]), startPoint: .top, endPoint: .bottom)
    
}

// Hex to Color
extension Color {
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


