//
//  PrePhotosViewController.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/8.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

class PrePhotosViewController: UIViewController {
    var previewAssets = [CPAsset]()
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "1 / \(previewAssets.count)"
        
        loadPreviewPhoto()
    }

    func loadPreviewPhoto() -> Void {
        if let asset = previewAssets.first {
            let _ = asset.requestPreviewImage(completion: { (image, info) in
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    imageView.frame = self.scrollView.bounds
                    self.scrollView.addSubview(imageView)
                }
            })
        }
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
