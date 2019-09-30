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
        let url = baseUrl + albumsEndpoint
        makeRequestGet(url,onError,onResponse)
    }
    
    public func getPhotos(AlbumId: Int, onError:@escaping ErrorResponse, onResponse: @escaping Response){
        let url = baseUrl + photosEndpoint + String(AlbumId)
        makeRequestGet(url,onError,onResponse)
    }
    
    public func makeRequestPost(
        _ url:String,
        _ params:Parameters?,
        _ headers: HTTPHeaders?,
        _ onError: @escaping ErrorResponse,
        _ onResponse:@escaping Response){
        makeRequest(
            url: url,
            params: params,
            headers: headers,
            method: HTTPMethod.post,
            onError: onError,
            onResponse: onResponse
        )
    }
    
    public func makeRequestGet(
        _ url:String,
        _ onError: @escaping ErrorResponse,
        _ onResponse:@escaping Response){
        makeRequest(
            url: url,
            params: nil,
            headers: nil,
            method: HTTPMethod.get,
            onError: onError,
            onResponse: onResponse
        )
    }
    public func makeRequestGet(
        _ url:String,
        _ headers: HTTPHeaders,
        _ onError: @escaping ErrorResponse,
        _ onResponse:@escaping Response){
        makeRequest(
            url: url,
            params: nil,
            headers: headers,
            method: HTTPMethod.get,
            onError: onError,
            onResponse: onResponse
        )
    }
    
    public func makeRequest(
        url:String,
        params:Parameters?,
        headers:HTTPHeaders?,
        method:HTTPMethod,
        onError: @escaping ErrorResponse,
        onResponse:@escaping Response){
        
        print("TA /////////////////////////")
        print("TA URl: \(url)")
        if let p = params {
            print("TA Params: \(p)")
        }
        if let h = headers{
            print("TA Headers: \(h)")
        }
        print("TA Method: \(method.rawValue)")
        
        Alamofire.request(
            url,
            method: method,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: headers).responseJSON{ response in
                
                print("TA Receive: \(response)")
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        if let httpresponse = response.response{
                            print("TA Status Code: \(httpresponse.statusCode)")
                            if httpresponse.statusCode >= 400 {
                                onError("Error inesperado")
                                return
                            }
                        }
                        onResponse(response.response?.statusCode ?? 200, data)
                    }else{
                        onError("Error desconocido")
                    }
                    break
                case .failure(_):
                    print("TA error")
                    onError("")
                    break
                }
        }
    }
}
