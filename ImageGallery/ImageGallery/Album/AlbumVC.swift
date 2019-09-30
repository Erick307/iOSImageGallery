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
        vc.album = album
        vc.title = album.title
        return vc
    }
    
    lazy var  collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let c = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        c.delegate = self
        c.dataSource = self
        c.refreshControl = UIRefreshControl()
        c.refreshControl?.addTarget(self, action: #selector(AlbumVC.getPhotos), for: .valueChanged)
        c.backgroundColor = UIColor.white
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(Photocell.self, forCellWithReuseIdentifier: "photocell")
        return c
    }()
    
    var album : Album?
    var photos : [Photo]?
    let presenter = AlbumPresenter(restApi: RestApi.shared)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album?.title ?? "Album Title"
        self.view.backgroundColor = UIColor.red
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.attach(view: self)
        getPhotos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.detach()
    }
    
    @objc func getPhotos(){
        if let a = album {
            presenter.getPhotos(album: a)
        }
    }

    func photoSelected( index: Int){
        if let ps = photos {
            let vc = PhotoGalleryVC.getViewController(photos: ps,index: index)
            present(vc, animated: true)
        }
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


extension AlbumVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos?[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photocell", for: indexPath) as! Photocell
        cell.setPhoto(photo: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = photos?[indexPath.row] {
            photoSelected(index: indexPath.row)
        }
    }
}

extension AlbumVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width/2, height: view.safeAreaLayoutGuide.layoutFrame.width/2)
    }
}


extension AlbumVC : AlbumView {
    func showError(error: String) {
    }
    
    func updatePhotos(photos: [Photo]) {
        self.photos = photos
        collectionView.refreshControl?.endRefreshing()
        collectionView.reloadData()
    }
}
