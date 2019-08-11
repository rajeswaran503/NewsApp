//
//  UIImageViewExtension.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func loadImageFromUrl(_ URLString: String, placeHolder: UIImage?) {
        
        
       guard let imageUrl = URL(string: URLString) else { return  }
        
        
        let cache = URLCache.shared
        
        let request = URLRequest(url: imageUrl)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
                return
            }
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            //print("RESPONSE FROM API: \(response)")
            if error != nil {
                print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    let cachedData = CachedURLResponse(response: response!, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    
                    if let downloadedImage = UIImage(data: data) {
                        //imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                        self.image = downloadedImage
                    }
                }
            }
        }).resume()
        
      
    }
}
