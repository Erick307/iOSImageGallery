//
//  Photo.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation

struct Photo : Codable {
    
    var albumId:Int?
    var id:Int?
    var title:String?
    var url:String?
    var thumbnailUrl:String?

    init(json:Data) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            self = try decoder.decode(Photo.self, from: json)
        }catch{
            print("TA parse error")
        }
    }
    
    static func getPhotos(jsonArray : Data) -> [Photo]?{
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let array = try decoder.decode([Photo].self, from: jsonArray)
            return array
        }catch{
            return nil
        }
    }
}
