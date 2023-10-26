//
//  LazyImageView.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit

class LazyImageView: UIImageView {
    
    var task: URLSessionTask?
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(url: URL) {
        
        DispatchQueue.main.async {
            self.image = nil
        }
        
        if let task = task {
            task.cancel()
        }
        
        if let imageForCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = imageForCache
            }
            return
        }
        
        task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("Couldn't load image from url: \(url)")
                return
            }
            self?.imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self?.image = newImage
            }
        }
        task?.resume()
    }

}
