//
//  PhotoModelCacheManager.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/08/24.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 1024 * 2 * 100
        cache.countLimit = 100
        return cache
    } ()
    
    private init() {}
    
    func save(image: UIImage, imgName: String) {
        photoCache.setObject(image, forKey: imgName as NSString )
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
    
    func remove(name: String ) {
        photoCache.removeObject(forKey: name as NSString)
    }
}
