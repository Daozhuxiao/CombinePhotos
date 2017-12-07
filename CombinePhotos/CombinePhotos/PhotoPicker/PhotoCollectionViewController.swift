//
//  PhotoCollectionViewController.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/7.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "PhotoCollectionViewCell"

class PhotoCollectionViewController: UICollectionViewController {
    var assetGroup: CPAssetsGroup?
    var allAssets = [CPAsset]()
    var selectAsset = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        let flowLahout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLahout.minimumLineSpacing = 2
        flowLahout.minimumInteritemSpacing = 2
        let cellWidth = (UIScreen.main.bounds.size.width - CGFloat(2 * 3)) / 4.0
        flowLahout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        convertModel()
    }

    func convertModel() -> Void {
        if let assetGroup = assetGroup {
            assetGroup.enumerateAsset(handle: { (asset) in
                if asset != nil {
                    allAssets.append(asset!)
                } else {
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            })
        }
    }


    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAssets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let asset = allAssets[indexPath.row]
        let _ = asset.requestThumbnailImage(size: CGSize(width: 100, height: 100)) { (image, info) in
            if info == nil || info![AnyHashable(PHImageResultIsDegradedKey)] as! Bool == true {
                cell.reloadData(contentImage: image, isChoose: self.selectAsset.contains(asset.assetIdentify()))
            } else {
                print("***************** 高清 *****************")
                //let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
                //cell.thumbnailImageView.image = image
            }
        }
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
