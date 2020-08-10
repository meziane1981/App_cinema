//
//  Data.swift
//  App_cinema
//
//  Created by Henry Franceschi on 03/08/2020.
//  Copyright © 2020 William Paparone. All rights reserved.
//

import SwiftUI
import os.log

// For decoding a json file as long as it coforms to Decodable
func loadJSON<T: Decodable>(_ fileName: String) -> T {
    
    // Attempt to find file
    guard let file = Bundle.main.url(forResource: fileName, withExtension: ".json") else {
        fatalError("failed to find JSON file")
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

func writeJSON<T: Codable>(_ data: T) -> String {
    let fileContents: Data
    do {
        fileContents = try JSONEncoder().encode(data)
    } catch {
        fatalError("failed to encode JSON file")
    }
    
    guard let returnValue = String(data: fileContents, encoding: .utf8) else {
        fatalError("failed to convert encoded value to String")
    }
    return returnValue
}

final class ImageStore {
    private var storedImages: Dictionary<String, CGImage> = [:]
    
    public private(set) static var instance = ImageStore()
    
    func getImage(imageName key: String) -> Image? {
        // if the image is not currently stored
        guard let image = storedImages[key] else {
            guard let rawImage = loadImage(fileName: key) else {
                return nil
            }
            return Image(rawImage, scale: 1, label: Text("some kind of image"))
        }
        // Return the image
        return Image(image, scale: 1, label: Text("some kind of image"))
    }
    
    // Needs to be rewritten as it was written with profile images in mind
    func getCGImage(imageName key: String) -> CGImage? {
        guard let image = storedImages[key] else {
            // If the image is not currently stored we try to load it
            guard let rawImage = loadImage(fileName: key) else {
                // If it is missing we return nil
                return nil
            }
            // If not we return the CGImage.
            return rawImage
        }
        // return the image
        return image
    }
    
    private func loadImage(fileName: String) -> CGImage? {
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "png"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
            else {
                os_log("Failed to load image %@", log: .default, type: .fault, fileName)
                return nil
            }
        return image
    }
}

enum ImageSize: String {
    case small = "_small"
    case medium = "_medium"
    case large = "_large"
}

