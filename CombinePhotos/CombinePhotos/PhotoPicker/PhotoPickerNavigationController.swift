//
//  PhotoPickerNavigationController.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/6.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

class PhotoPickerNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photosVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotosViewController") as!PhotosViewController
        photosVC.assetGroup = CPAssetsManager.sharedInstance.mainAlbum()
        self.viewControllers.append(photosVC)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
