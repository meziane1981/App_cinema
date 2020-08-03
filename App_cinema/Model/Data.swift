//
//  Data.swift
//  App_cinema
//
//  Created by Henry Franceschi on 03/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI

func load<T: Decodable>(fileName: String) -> T {
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("failed to find file")
    }
    
    let data: Data
    do {
        data = try Data(contentsOf: file)
    }
    catch {
        fatalError("failed to load contents of file: \(error)")
    }
    do {
        return try JSONDecoder().decode(T.self, from: data)
    }
    catch {
        fatalError("failed to decode file: \(error)")
    }
}
