//
//  AlbumTableViewController.swift
//  CombinePhotos
//
//  Created by xiaozr on 2017/12/6.
//  Copyright © 2017年 xiaozr. All rights reserved.
//

import UIKit
import Photos

class AlbumModel {
    let album: PHAssetCollection
    let coverImage: UIImage
    let photoCount: Int
    init(album: PHAssetCollection, coverImage: UIImage, photoCount: Int) {
        self.album = album
        self.coverImage = coverImage
        self.photoCount = photoCount
    }
}

class AlbumTableViewController: UITableViewController {
    var albumFetchResult: PHFetchResult<PHAssetCollection>?
    var albumModels = [AlbumModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadAlbum()
    }
    
    func loadAlbum() -> Void {
        albumFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        guard albumFetchResult != nil else {
            print("albumFetchResult = nil")
            return
        }
        
        for index in 0 ..< albumFetchResult!.count {
            let collection = albumFetchResult![index]
            let assetFetchResult = PHAsset.fetchAssets(in: collection, options: nil)
            if assetFetchResult.count > 0 {
                
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let albumFetchResult = albumFetchResult {
            return albumFetchResult.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
        let asset = allAssets[indexPath.row].firstObject
        //cell.reloadCell(coverImage: <#T##UIImage#>, albumName: <#T##String#>, photoCount: <#T##Int#>)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelButtonDidClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
