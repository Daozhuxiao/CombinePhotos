//
//  AlbumTableViewCell.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/6.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumPhotoCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func reloadCell(coverImage: UIImage, albumName: String, photoCount: Int) -> Void {
        coverImageView.image = coverImage
        albumNameLabel.text = albumName
        albumPhotoCountLabel.text = String(photoCount)
    }

}
