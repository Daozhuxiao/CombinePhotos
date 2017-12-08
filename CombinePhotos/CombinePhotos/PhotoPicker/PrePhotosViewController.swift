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
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.size.width * CGFloat(previewAssets.count), height: 0)
        scrollView.isPagingEnabled = true
        loadPreviewPhoto()
    }

    func loadPreviewPhoto() -> Void {
        DispatchQueue.main.async {
            for index in 0 ..< self.previewAssets.count {
                let asset = self.previewAssets[index]
                let _ = asset.requestPreviewImage(completion: { (image, info) in
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    imageView.frame = self.scrollView.bounds.offsetBy(dx: CGFloat(index) * self.scrollView.bounds.size.width, dy: 0)
                    self.scrollView.addSubview(imageView)
                })
            }
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
