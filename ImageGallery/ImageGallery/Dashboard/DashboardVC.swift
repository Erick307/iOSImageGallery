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
    
    lazy var  collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let c = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        c.delegate = self
        c.dataSource = self
        c.refreshControl = UIRefreshControl()
        c.refreshControl?.addTarget(self, action: #selector(DashboardVC.getAlbums), for: .valueChanged)
        c.backgroundColor = UIColor.white
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(AlbumCell.self, forCellWithReuseIdentifier: "albumcell")
        return c
    }()
    
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
    
    func albumSelected(_ album: Album){
        
        let vc = AlbumVC.getViewController(album: album)
        navigationController?.pushViewController(vc, animated: true)
    }

    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}


extension DashboardVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albums?[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumcell", for: indexPath) as! AlbumCell
        cell.setAlbum(album: album)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let album = albums?[indexPath.row] {
            albumSelected(album)
        }
    }
}

extension DashboardVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: AlbumCell.recomendedHeight)
    }
}


extension DashboardVC : DashboardView {
    
    func showError(error:String){

    }
    
    func updateAlbums(albums:[Album]){
        self.albums = albums
        self.collectionView.reloadData()
        self.collectionView.refreshControl?.endRefreshing()
    }
}

