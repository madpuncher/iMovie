//
//  ImageDownloadManager.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import UIKit

class ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
    
    private init() {}
        
    func imageLoader(with url: URL, completion: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            completion(image)
            
        }
        .resume()
    }
}
