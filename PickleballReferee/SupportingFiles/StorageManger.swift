//
//  StoreManger.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/18/22.
//

import Foundation
import UIKit
import SwiftUI


class StorageManager {
    
    static let gamesBackupURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("pickleballgamesbackup.json")
    static let matchBackupURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("pickleballmatchbackup.json")
    static let matchsBackupURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("pickleballmatchsbackup.json")
    
    // TODO: - Create seed JSON files for games and match
    static let gamesBundleURL = Bundle.main.url(forResource: "SeedGames", withExtension: "json")!
    static let matchBundleURL = Bundle.main.url(forResource: "SeedMatch", withExtension: "json")!
    
//    static func retrieveMatch() -> Match {
//        var url = matchBackupURL
//        if !FileManager().fileExists(atPath: matchBackupURL.path) {
//            url = matchBundleURL
//        }
//        let decoder = JSONDecoder()
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Unable to obtain match data from url")
//        }
//        guard let matchItem = try? decoder.decode(Match.self, from: data) else {
//            fatalError("Uable to decode match data")
//        }
//        return matchItem
//    }
    
    
    static func storeMatch(match:Match) {
        
//        let encoder = JSONEncoder()
//        guard let matchJSONData = try? encoder.encode(match) else {
//            fatalError("Could not encode match data")
//        }
//        let matchJSON = String(data: matchJSONData, encoding: .utf8)!
//        do {
//            try matchJSON.write(to: matchBackupURL, atomically: true, encoding: .utf8)
//        } catch {
//            print("Could not save match file to directory: \(error.localizedDescription)")
//        }
    }
    
//    static func retrieveGames() -> [Game] {
//        var url = gamesBackupURL
//        if !FileManager().fileExists(atPath: gamesBackupURL.path) {
//            url = gamesBundleURL
//        }
//        let decoder = JSONDecoder()
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Unable to obtain games data from url")
//        }
//        guard let gameItems = try? decoder.decode([Game].self, from: data) else {
//            fatalError("Uable to decode games data")
//        }
//        return gameItems
//    }
    
    
    static func storeGames(games:[Game]) {
        
//        let encoder = JSONEncoder()
//        guard let gamesJSONData = try? encoder.encode(games) else {
//            fatalError("Could not encode games data")
//        }
//        let gamesJSON = String(data: gamesJSONData, encoding: .utf8)!
//        do {
//            try gamesJSON.write(to: gamesBackupURL, atomically: true, encoding: .utf8)
//        } catch {
//            print("Could not save games file to directory: \(error.localizedDescription)")
//        }
    }
}





enum StorageType {
    case userDefaults
    case fileSystem
}

func storeImage(image: UIImage, forKey key: String, withStoragetype storageType: StorageType) {
    
    if let pngRepresentation = image.pngData() {
        switch storageType {
        case .userDefaults:
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        case .fileSystem:
            if let filePath = filePath(forKey: key) {
                do {
                    try pngRepresentation.write(to: filePath, options: .atomic)
                } catch {
                    print("Error saving image to fileSystem: \(error.localizedDescription)")
                }
            }
        }
    }
        
}

func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage? {
    switch storageType {
    case .userDefaults:
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data {
            let image = UIImage(data: imageData)
            return image
        }
    case .fileSystem:
        if let filePath = filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path), let image = UIImage(data: fileData) {
            return image
        }
           
    }
    
    return nil
}

private func filePath(forKey key: String) -> URL? {
    let fileManger = FileManager.default
    guard let documentURL = fileManger.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
    return documentURL.appendingPathComponent(key + ".png")
}


func getScoresheetImage() -> UIImage {
    var imageToReturn = UIImage()
    let imageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("scoresheet.png")
    let matchUIImage = UIImage(contentsOfFile: imageUrl.path)
    if matchUIImage == nil {
        let sampleImageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sample_scoresheet.png")
        let sampleUIImage = UIImage(contentsOfFile: sampleImageUrl.path)
        imageToReturn = sampleUIImage!
    } else {
        imageToReturn = matchUIImage!
    }
    return imageToReturn
}



// Example calling save function
//if let buildingImage = UIImage(named: "building") {
//        DispatchQueue.global(qos: .background).async {
//            self.store(image: buildingImage,
//                        forKey: "buildingImage",
//                        withStorageType: .fileSystem)
//        }
//    }


// Example calling retreive function
//DispatchQueue.global(qos: .background).async {
//        if let savedImage = self.retrieveImage(forKey: "buildingImage",
//                                                inStorageType: .fileSystem) {
//            DispatchQueue.main.async {
//                self.savedImageDisplayImageView.image = savedImage
//            }
//        }
//    }
