//
//  PhotoCell.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import UIKit

class Photocell: UICollectionViewCell {
    
    let background: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imgPic : ImageView = {
        let img = ImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let lblTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = UIColor.init(white: 0.2, alpha: 0.8)
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
    
    func setPhoto(photo: Photo?){
        lblTitle.text = photo?.title
        imgPic.loadImageUsingUrl(photo?.thumbnailUrl ?? "", placeholder: UIImage(named: "placeholder"))
    }
    
    func setupView(){
        self.addSubview(background)
        background.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        background.addSubview(imgPic)
        imgPic.topAnchor.constraint(equalTo: background.topAnchor).isActive = true
        imgPic.leadingAnchor.constraint(equalTo: background.leadingAnchor).isActive = true
        imgPic.trailingAnchor.constraint(equalTo: background.trailingAnchor).isActive = true
        imgPic.bottomAnchor.constraint(equalTo: background.bottomAnchor).isActive = true
        
        background.addSubview(lblTitle)
        lblTitle.bottomAnchor.constraint(equalTo: background.bottomAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: background.leadingAnchor).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: background.trailingAnchor).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}
