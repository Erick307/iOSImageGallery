//
//  ImageView.swift
//  ImageGallery
//
//  Created by Erick Silva on 9/30/19.
//  Copyright © 2019 ericksilva. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImageUsingUrl(_ urlString: String, placeholder:UIImage?){
        
        if let p = placeholder {
            image = p
        }else{
            image = UIImage()
        }
        
        imageUrlString = urlString
        
        if let u = URL(string: urlString) {
            let session = URLSession.shared
            
            if let imageCached = imageCache.object(forKey: NSString(string: urlString)){
                self.image = imageCached
                return
            }
            
            session.dataTask(with: u) { (data, response, error) in
                if error != nil {
                    print("TA error al cargar la imagen: \(urlString)")
                    return
                }
                DispatchQueue.main.async {
                    
                    let imageToCache = UIImage(data: data!)
                    if let i = imageToCache{
                        imageCache.setObject(i, forKey: NSString(string: urlString))
                    }
                    
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                }
                }.resume()
        }
    }
    
}
