//
//  PhotoModelFileManager.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/08/24.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard
            let url = getFolderPath(),
            FileManager.default.fileExists(atPath: url.path)
        else { return }
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            print("Created folder")
        } catch let err {
            print("Error creating folder: \(err)")
        }
    }
    
    private func getFolderPath() -> URL?{
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return path.first?.appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key)
        else { return }
        do {
            try data.write(to: url)
        } catch let err {
            print("Error saving to file Manger. \(err)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
}
