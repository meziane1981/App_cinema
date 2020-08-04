//
//  Data.swift
//  App_cinema
//
//  Created by Henry Franceschi on 03/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

// For decoding a json file as long as it coforms to Decodable
func loadJSON<T: Decodable>(fileName: String) -> T {
    
    // Attempt to file file
    guard let file = Bundle.main.url(forResource: fileName, withExtension: ".json") else {
        fatalError("failed to find file")
    }
    
    // Attempt to load the contents of the file
    let fileContents: Data
    do {
        fileContents = try Data(contentsOf: file)
    } catch {
        fatalError("failed to load contents of file: \(error)")
    }
    
    // Attempt to decode the file to the type T from data
    do {
        return try JSONDecoder().decode(T.self, from: fileContents)
    } catch {
        fatalError("failed to decode file: \(error)")
    }
}

func loadImage(fileName: String) -> CGImage {
    fatalError()
}