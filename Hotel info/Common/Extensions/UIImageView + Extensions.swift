//
//  UIImageView + Extensions.swift
//  Block1
//
//  Created by Сергей Золотухин on 30.05.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from urlString: String, placeHolder: UIImage? = nil) {
        if let url = URL(string: urlString) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: placeHolder)
        }
    }
}
