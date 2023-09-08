//
//  SelfSizingCollectionView.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 03.09.2023.
//
import UIKit

class SelfSizingCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
