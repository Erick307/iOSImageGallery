//
//  AlbumPresenter.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation

class AlbumPresenter {
    
    let api: RestApi
    
    var albumView: AlbumView?
    
    init(restApi : RestApi) {
        api = restApi
    }
    
    public func attach(view:AlbumView){
        albumView = view
    }
    
    public func detach(){
        albumView = nil
    }
    
    public func getPhotos(album:Album){
        api.getPhotos(AlbumId: album.id ?? 0, onError: { (error) in
            self.albumView?.showError(error: error)
        }) { (status, response) in
            if let photos = Photo.getPhotos(jsonArray: response) {
                self.albumView?.updatePhotos(photos: photos)
            }else{
                self.albumView?.showError(error: "parse error")
            }
        }
    }
}

protocol AlbumView {
    func showError(error:String)
    func updatePhotos(photos:[Photo])
}
