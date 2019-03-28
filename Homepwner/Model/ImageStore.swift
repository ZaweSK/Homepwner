//
//  ImageStore.swift
//  Homepwner
//
//  Created by Peter on 18/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import Foundation
import UIKit

class ImageStore{
    
    
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
        
        //get image url
        let url = imageURL(forKey: key)
        
        print("URL: \(url)")
        //turn image into data
        if let data = image.jpegData(compressionQuality: 0.5){
            let _ = try? data.write(to: url, options: .atomic)
        }
        
    }
    
    func image(forKey key: String)->UIImage? {
        if let existingImage = cache.object(forKey: key as NSString){
            return existingImage
        }
        
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else { return nil}
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
    }
    
    func deleteImage(forKey key: String){
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do{
            try FileManager.default.removeItem(at: url)
        }catch let deleteError {
            print("Error removing the file from filesystem: \(deleteError)")
        }
        
    }
    
    func imageURL(forKey key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
}
