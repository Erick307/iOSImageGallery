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
        
    }
}

protocol AlbumView {
    func showError(error:String)
    func updatePhotos(photos:[Photo])
}
