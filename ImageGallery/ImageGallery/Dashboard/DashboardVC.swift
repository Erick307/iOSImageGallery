//
//  DashboardVC.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import UIKit

class DashboardVC: UIViewController {
    
    static func getViewController() -> UIViewController {
        let navVC = UINavigationController(rootViewController: DashboardVC())
        return navVC
    }
    
    let presenter = DashboardPresenter(restApi: RestApi.shared)
    var albums: [Album]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Albums"
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.attach(view: self)
        getAlbums()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.detach()
    }
    
    @objc func getAlbums(){
        presenter.getAlbums()
    }

    func setupView(){
    }
}


extension DashboardVC : DashboardView {
    
    func showError(error:String){
    }
    
    func updateAlbums(albums:[Album]){
        self.albums = albums
    }
}

