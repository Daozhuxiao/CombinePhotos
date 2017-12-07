//
//  CPAssetsGroup.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/7.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

class CPAssetsGroup {
    private let assetCollection: PHAssetCollection
    private let fetchResult: PHFetchResult<PHAsset>
    
    init(assetCollection: PHAssetCollection, fetchOptions: PHFetchOptions) {
        self.assetCollection = assetCollection
        self.fetchResult = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
    }
    
    func albumName() -> String {
        return assetCollection.localizedTitle ?? "相册"
    }
    
    func numberOfAssets() -> Int {
        return fetchResult.count
    }
    
    func posterImage(size: CGSize) -> UIImage? {
        var posterImage: UIImage?
        if let asset = fetchResult.lastObject {
            let requestOption = PHImageRequestOptions()
            requestOption.isSynchronous = true
            requestOption.resizeMode = .exact
            CPAssetsManager.sharedInstance.cachingImageManager.requestImage(for: asset, targetSize: CGSize(width: size.width * UIScreen.main.scale, height: size.height * UIScreen.main.scale), contentMode: .aspectFill, options: requestOption, resultHandler: { (image, info) in
                posterImage = image
            })
        }
        return posterImage
    }
    
    func enumerateAsset(handle: (CPAsset?) -> Void) -> Void {
        for index in 0 ..< fetchResult.count {
            let asset = fetchResult[index]
            handle(CPAsset(asset: asset))
        }
        
        handle(nil)
    }
}
