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

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PhotoCollectionViewCellDelegate {
    var assetGroup: CPAssetsGroup?
    var allAssets = [CPAsset]()
    var selectAssetIndexPaths = [IndexPath]()
    var selectAssets = [CPAsset]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var previewButton: UIBarButtonItem!
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
    

    // MARK: - UICollectionViewDataSource
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
                cell.reloadData(contentImage: image, isChoose: self.selectAssetIndexPaths.contains(indexPath), indexPath: indexPath)
            } else {
                print("***************** 高清 *****************")
                //let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
                //cell.thumbnailImageView.image = image
            }
        }
        cell.delegate = self
        return cell
    }

    // MARK: - PhotoCollectionViewCellDelegate
    func photoCollectionCell(_ cell: PhotoCollectionViewCell, choosedIndex indexPath: IndexPath) {
        let asset = allAssets[indexPath.row]
        if let index = selectAssetIndexPaths.index(of: indexPath) {
            selectAssetIndexPaths.remove(at: index)
            selectAssets.remove(at: index)
        } else {
            selectAssetIndexPaths.append(indexPath)
            selectAssets.append(asset)
        }
        updateToolBarUI()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewPhoto" {
            let vc = segue.destination as! PrePhotosViewController
            vc.previewAssets = sender as! [CPAsset]
        }
    }
    
    
    @IBAction func dismissVC(_ sender: UIBarButtonItem) {
        let navigationVC = self.navigationController as! PhotoPickerNavigationController
        navigationVC.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func previewButtonDidClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "previewPhoto", sender: selectAssets)
    }
    
    func updateToolBarUI() -> Void {
        if selectAssetIndexPaths.count > 0 {
            sendButton.isEnabled = true
            previewButton.isEnabled = true
            sendButton.title = "发送（\(selectAssetIndexPaths.count)）"
        } else {
            sendButton.isEnabled = false
            previewButton.isEnabled = false
        }
    }
}
