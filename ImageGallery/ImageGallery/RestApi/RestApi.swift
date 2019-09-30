//
//  RestApi.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import Alamofire

class RestApi: NSObject {
    
    let baseUrl = "https://jsonplaceholder.typicode.com"
    let albumsEndpoint = "/albums"
    let photosEndpoint = "/photos?albumId="
    
    
    public static let shared = RestApi()
    private override init(){}
    
    public typealias Response = (_ status:Int, _ response:Data)->Void
    public typealias ErrorResponse = (_ error:String)->Void
    
    public func getAlbums(onError:@escaping ErrorResponse, onResponse: @escaping Response){
        
    }
    
    public func getPhotos(AlbumId: Int, onError:@escaping ErrorResponse, onResponse: @escaping Response){
        
    }
  
}
