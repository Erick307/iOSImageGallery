//
//  DashboardPresenter.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation

class DashboardPresenter {
    
    let api: RestApi
    
    var dashboardView: DashboardView?
    
    init(restApi : RestApi) {
        api = restApi
    }
    
    public func attach(view:DashboardView){
        dashboardView = view
    }
    
    public func detach(){
        dashboardView = nil
    }
    
    public func getAlbums(){
        api.getAlbums(onError: { (error) in
            self.dashboardView?.showError(error: error)
        }) { (status, response) in
            if let albums = Album.getAlbums(jsonArray: response) {
                self.dashboardView?.updateAlbums(albums: albums)
            }else{
                self.dashboardView?.showError(error: "parse error")
            }
        }
    }
}

protocol DashboardView {
    func showError(error:String)
    func updateAlbums(albums:[Album])
}
