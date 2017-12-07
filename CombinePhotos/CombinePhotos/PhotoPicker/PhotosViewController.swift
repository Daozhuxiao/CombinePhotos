//
//  PhotosViewController.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/7.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "PhotoCollectionViewCell"

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var assetGroup: CPAssetsGroup?
    var allAssets = [CPAsset]()
    var selectAsset = [String]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()

        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        let cellWidth = (UIScreen.main.bounds.size.width - CGFloat(2 * 3)) / 4.0
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        convertModel()
    }

    func convertModel() -> Void {
        if let assetGroup = assetGroup {
            assetGroup.enumerateAsset(handle: { (asset) in
                if asset != nil {
                    allAssets.append(asset!)
                } else {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            })
        }
    }
    

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

    @IBAction func dismissVC(_ sender: UIBarButtonItem) {
        let navigationVC = self.navigationController as! PhotoPickerNavigationController
        navigationVC.dismiss(animated: true, completion: nil)
    }
}
