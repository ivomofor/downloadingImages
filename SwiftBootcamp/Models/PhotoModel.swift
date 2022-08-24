//
//  PhotoModel.swift
//  SwiftBootcamp
//
//  Created by Ivo on 2022/08/23.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId, id: Int
    let title, url, thumbnailUrl: String
}

/*
 {
     "albumId": 1,
     "id": 1,
     "title": "accusamus beatae ad facilis cum similique qui sunt",
     "url": "https://via.placeholder.com/600/92c952",
     "thumbnailUrl": "https://via.placeholder.com/150/92c952"
   }
 */
