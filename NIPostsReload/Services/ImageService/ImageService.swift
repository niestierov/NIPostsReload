//
//  ImageService.swift
//  NearestPlaces
//
//  Created by Denys Niestierov on 20.11.2023.
//

import UIKit
import Kingfisher

final class ImageService {
    
    // MARK: - Properties -
    
    static let shared = ImageService()
    
    // MARK: - Init -
    
    private init() { }
    
    // MARK: - Internal -
    
    func setImage(
        with url: URL,
        for imageView: UIImageView,
        placeholder: UIImage?,
        completion: (() -> Void)? = nil
    ) {
        imageView.kf.setImage(with: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    imageView.image = value.image
                case .failure(_):
                    imageView.image = placeholder
                }
                completion?()
            }
        }
    }
    
    func setImage(
        string: String,
        for imageView: UIImageView,
        placeholder: UIImage? = nil,
        completion: (() -> Void)? = nil
    ) {
        guard let url = URL(string: string) else {
            imageView.image = placeholder
            completion?()
            return
        }
        
        setImage(with: url, for: imageView, placeholder: placeholder, completion: completion)
    }
}
