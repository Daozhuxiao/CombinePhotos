//
//  CPAssetsManager.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/7.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

enum CPAlbumAuthorizationStatus {
    case CPAlbumAuthorizationStatusNotDetermined
    case CPAlbumAuthorizationStatusAuthorized
    case CPAlbumAuthorizationStatusDenied
}

class CPAssetsManager: NSObject {
    let cachingImageManager = PHCachingImageManager()
    static let sharedInstance: CPAssetsManager = {
        let instance = CPAssetsManager()
        //setup code
        return instance
    }()
    private override init() {}
    
    // MARK: - 相册权限相关
    class func albumAuthorizaion() -> CPAlbumAuthorizationStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .restricted || status == .denied {
            return .CPAlbumAuthorizationStatusDenied
        } else if status == .notDetermined {
            return .CPAlbumAuthorizationStatusNotDetermined
        } else {
            return .CPAlbumAuthorizationStatusAuthorized
        }
    }
    
    class func requestAlbumAuthorization(handle: @escaping (CPAlbumAuthorizationStatus) -> Void) -> Void {
        PHPhotoLibrary.requestAuthorization { (phStatus) in
            var cpStatus = CPAlbumAuthorizationStatus.CPAlbumAuthorizationStatusAuthorized
            if phStatus == PHAuthorizationStatus.authorized {
                cpStatus = .CPAlbumAuthorizationStatusAuthorized
            } else if phStatus == PHAuthorizationStatus.denied {
                cpStatus = CPAlbumAuthorizationStatus.CPAlbumAuthorizationStatusDenied
            } else {
                cpStatus = CPAlbumAuthorizationStatus.CPAlbumAuthorizationStatusNotDetermined
            }
            handle(cpStatus)
        }
    }
    
    // MARK: - 取照片相关
    func mainAlbum() -> CPAssetsGroup? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %i", PHAssetMediaType.image.rawValue)
        
        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        if fetchResult.count == 1 {
            return CPAssetsGroup(assetCollection: fetchResult.firstObject!, fetchOptions: fetchOptions)
        } else {
            return nil
        }
    }
    
    func enumberateAllAlbums(showEmptyAlbum: Bool, handle: ((CPAssetsGroup?) -> Void)) -> Void {
        var albumsArray = [PHAssetCollection]()
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %i", PHAssetMediaType.image.rawValue)
        
        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        for index in 0 ..< fetchResult.count {
            let collection = fetchResult[index]
            if collection.isMember(of: PHAssetCollection.self) {
                let assetFetchResult = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                if assetFetchResult.count > 0 || showEmptyAlbum {
                    if collection.assetCollectionSubtype == PHAssetCollectionSubtype.smartAlbumUserLibrary {
                        albumsArray.insert(collection, at: 0)
                    } else {
                        albumsArray.append(collection)
                    }
                }
            } else {
                assert(false, "不是 PHAssetCollection 类型")
            }
        } // for
        
        let userCollectionFetchResult = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        for index in 0 ..< userCollectionFetchResult.count {
            let userCollection = userCollectionFetchResult[index]
            if userCollection.isMember(of: PHAssetCollection.self) {
                let assetFetchResult = PHAsset.fetchAssets(in: userCollection as! PHAssetCollection, options: fetchOptions)
                if assetFetchResult.count > 0 || showEmptyAlbum {
                    albumsArray.append(userCollection as! PHAssetCollection)
                }
            }
        }
        
        for index in 0 ..< albumsArray.count {
            handle(CPAssetsGroup(assetCollection: albumsArray[index], fetchOptions: fetchOptions))
        }
        
        handle(nil)
    }
}
