//
//  Album.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation

struct Album : Codable {
    var userId:Int?
    var id:Int?
    var title:String?
    
    init(json:Data) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            self = try decoder.decode(Album.self, from: json)
        }catch{
            print("TA parse error")
        }
    }
    
    static func getAlbums(jsonArray : Data) -> [Album]?{
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let array = try decoder.decode([Album].self, from: jsonArray)
            return array
        }catch{
            return nil
        }
    }
}
