//
//  AlbumVC.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import UIKit

class AlbumVC: UIViewController {
    

    static func getViewController(album: Album) -> UIViewController {
        let vc = AlbumVC()
        return vc
    }
    
    let presenter = AlbumPresenter(restApi: RestApi.shared)
    var photos : [Photo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.attach(view: self)
        getPhotos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.detach()
    }
    
    func getPhotos(){
        
    }
    
    func setupView(){
        
    }
}


extension AlbumVC : AlbumView {
    func showError(error: String) {
    }
    
    func updatePhotos(photos: [Photo]) {
        self.photos = photos
        
    }
}
