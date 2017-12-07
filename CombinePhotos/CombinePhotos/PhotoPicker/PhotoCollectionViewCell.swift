//
//  PhotoCollectionViewCell.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/7.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var chooseStatusButton: UIButton!
    private var isChoose = false
    func reloadData(contentImage: UIImage?, isChoose: Bool) -> Void {
        thumbnailImageView.image = contentImage
        self.isChoose = isChoose
        chooseStatusButton.setBackgroundImage(isChoose ? #imageLiteral(resourceName: "select") : #imageLiteral(resourceName: "unselect"), for: .normal)
    }
    
    @IBAction func chooseButtonDidClicked(_ sender: UIButton) {
        isChoose = !isChoose
        chooseStatusButton.setBackgroundImage(isChoose ? #imageLiteral(resourceName: "select") : #imageLiteral(resourceName: "unselect"), for: .normal)
    }
}
