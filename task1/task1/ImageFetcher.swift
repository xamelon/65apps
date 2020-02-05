//
//  ImageFetcher.swift
//  task1
//
//  Created by Body Block on 05/02/2020.
//  Copyright © 2020 Body Block. All rights reserved.
//

import UIKit

class ImageFetcher: NSObject {
    
    let cache = NSCache<AnyObject, UIImage>()
    
    var tasks: [URL: URLSessionDataTask] = [:]
    
    let operationQueue = OperationQueue()
    
    func downloadImage(withURL URL: URL, completionBlock: @escaping (UIImage?, RequestError?) -> Void) {
        if let imageFromCache = cache.object(forKey: URL as AnyObject) {
            print("get image from cache: \(URL)")
            completionBlock(imageFromCache, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL) { [unowned self] (data, response, error) in
            if let error = error {
                let requestError: RequestError
                switch error {
                case URLError.notConnectedToInternet:
                    requestError = .noInternetConnection
                default:
                    requestError = .unknownError(description: error.localizedDescription)
                }
                completionBlock(nil, requestError)
                return
            }
            
            if let data = data,
                let image = UIImage(data: data) {
                completionBlock(image, nil)
                self.cache.setObject(image, forKey: URL as AnyObject)
            } else {
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 404 {
                    completionBlock(nil, .notFound)
                } else {
                    completionBlock(nil, .unknownError(description: "Invalid response"))
                }
                    
            }
        }
        task.resume()
        tasks[URL] = task
    }
    
    func cancelTask(forURL URL: URL) {
        guard let task = tasks[URL] else { return }
        task.cancel()
        tasks.removeValue(forKey: URL)
    }
    
    
}
