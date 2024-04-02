//
//  UIImage+Extension.swift
//  MovieAppExample
//
//  Created by Ensar on 30.11.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String?) {
        guard let urlString = url,let imageURL = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
