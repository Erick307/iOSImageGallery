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
    
    }
}

protocol DashboardView {
    func showError(error:String)
    func updateAlbums(albums:[Album])
}
