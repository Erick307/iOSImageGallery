//
//  PhotoGalleryVC.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import UIKit

class PhotoGalleryVC: UIViewController {
    
    let btnBack : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.darkGray
        btn.setTitle("X", for: .normal)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    lazy var pageView : UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let c = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        c.backgroundColor = UIColor.white
        c.delegate = self
        c.dataSource = self
        c.isPagingEnabled = true
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(PhotoGalleryCell.self, forCellWithReuseIdentifier: "PhotoGalleryCell")
        return c
    }()
    
    let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.frame = CGRect.zero
        pc.currentPageIndicatorTintColor = UIColor.black
        pc.pageIndicatorTintColor = UIColor.lightGray
        return pc
    }()
    
    static func getViewController(photos: [Photo], index: Int) -> UIViewController {
        let vc = PhotoGalleryVC()
        vc.photos = photos
        vc.index = index
        return vc
    }
    
    var photos: [Photo]?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        btnBack.addTarget(self, action: #selector(PhotoGalleryVC.onBack), for: .touchUpInside)
        self.pageView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.pageView.scrollToItem(at: IndexPath(row: self.index ?? 0, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
        self.pageView.isHidden = false
        
        pageControl.numberOfPages = photos?.count ?? 0
        pageControl.currentPage = index ?? 0
    }
    
    func setupView(){
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(pageView)
        pageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        pageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        pageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.view.addSubview(btnBack)
        btnBack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        btnBack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 60)
        btnBack.widthAnchor.constraint(equalToConstant: 60)
        
        self.view.addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    @objc func onBack(){
        dismiss(animated: true)
    }
}


extension PhotoGalleryVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos?[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCell", for: indexPath) as! PhotoGalleryCell
        cell.setPhoto(photo: photo)
        return cell
    }
}

extension PhotoGalleryVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.width + 0.5)
    }
    
    
}
