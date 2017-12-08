//
//  PhotoCollectionViewCell.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/7.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewCellDelegate: class {
    func photoCollectionCell(_ cell: PhotoCollectionViewCell, choosedIndex indexPath: IndexPath)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    weak var delegate: PhotoCollectionViewCellDelegate?
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var chooseStatusButton: UIButton!
    private var isChoose = false
    private var indexPath: IndexPath!
    func reloadData(contentImage: UIImage?, isChoose: Bool, indexPath: IndexPath) -> Void {
        thumbnailImageView.image = contentImage
        self.isChoose = isChoose
        chooseStatusButton.setBackgroundImage(isChoose ? #imageLiteral(resourceName: "select") : #imageLiteral(resourceName: "unselect"), for: .normal)
        self.indexPath = indexPath
    }
    
    @IBAction func chooseButtonDidClicked(_ sender: UIButton) {
        isChoose = !isChoose
        chooseStatusButton.setBackgroundImage(isChoose ? #imageLiteral(resourceName: "select") : #imageLiteral(resourceName: "unselect"), for: .normal)
        if let delegate = delegate {
            delegate.photoCollectionCell(self, choosedIndex: indexPath)
        }
    }
}
