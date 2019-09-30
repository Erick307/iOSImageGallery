//
//  AlbumCell.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import UIKit

class AlbumCell: UICollectionViewCell {
    
    public static let recomendedHeight : CGFloat = 100
    
    let background: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.init(white: 0.2, alpha: 1)
        v.layer.cornerRadius = 5
        return v
    }()
    
    let lblTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.white
        lbl.numberOfLines = 2
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAlbum(album: Album?){
        lblTitle.text = album?.title
        lblTitle.sizeToFit()
    }
    
    func setupView(){
        self.addSubview(background)
        background.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        background.addSubview(lblTitle)
        lblTitle.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
    }
}
