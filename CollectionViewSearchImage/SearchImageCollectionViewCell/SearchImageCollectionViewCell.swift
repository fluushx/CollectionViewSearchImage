//
//  SearchImageCollectionViewCell.swift
//  CollectionViewSearchImage
//
//  Created by Felipe Ignacio Zapata Riffo on 01-08-21.
//

import UIKit

class SearchImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
 
        imageView.clipsToBounds = true
        // Initialization code
    }

}
