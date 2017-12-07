//
//  CPAsset.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/7.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

class CPAsset {
    private var asset: PHAsset
    var reqestID = -1
    
    init(asset: PHAsset) {
        self.asset = asset
    }
    
    func assetIdentify() -> String {
        return asset.localIdentifier
    }
    
    // MARK: - 取图片相关
    func originImage() -> UIImage? {
        var originImage: UIImage?
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isSynchronous = true
        CPAssetsManager.sharedInstance.cachingImageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: imageRequestOptions) { (image, info) in
            originImage = image
        }
        return originImage
    }
    
    func thumbnailImage(size: CGSize) -> UIImage? {
        var thumbnailImage: UIImage?
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.resizeMode = .exact
        CPAssetsManager.sharedInstance.cachingImageManager.requestImage(for: asset, targetSize: CGSize(width: size.width * UIScreen.main.scale, height: size.height * UIScreen.main.scale), contentMode: .aspectFill, options: imageRequestOptions) { (image, info) in
            thumbnailImage = image
        }
        return thumbnailImage
    }
    
    func previewImage() -> UIImage? {
        var previewImage: UIImage?
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isSynchronous = true
        CPAssetsManager.sharedInstance.cachingImageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: imageRequestOptions) { (image, info) in
            previewImage = image
        }
        return previewImage
    }
}
