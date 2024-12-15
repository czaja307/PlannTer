//
//  LocalFileManager.swift
//  PlannTer
//
//  Created by Anna Sidor on 15/12/2024.
//

import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    let dirName = "PlannTer"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager.default.urls(
                for: .cachesDirectory,
                in: .userDomainMask)
                .first?
                .appendingPathComponent(dirName)
                .path
            else {
                return
            }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating dir: \(error)")
            }
        }
        
    }
    
    func getPathFor(name: String) -> URL? {
        guard
            let path = FileManager.default.urls(
                for: .cachesDirectory,
                in: .userDomainMask)
                .first?
                .appendingPathComponent(dirName)
                .appendingPathComponent("\(name).png") else {
            print("Error creating path")
            return nil
        }
        return path
    }
    
    func saveImage(image: UIImage, name: String) {
        guard
            let data = image.pngData(),
            let path = getPathFor(name: name)
            else {
                print ("ERROR creating image data")
                return
            }
        
        
        do {
            try data.write(to: path)
            print("Great success")
        } catch {
            print("Error saving")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathFor(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) {
        guard
            let path = getPathFor(name: name),
            FileManager.default.fileExists(atPath: path.path)
        else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("Image successfully deleted")
        } catch {
            print("Error deleting image")
        }
    }
}
