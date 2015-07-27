//
//  ViewController.swift
//  MovieSample
//
//  Created by inkenkun on 2015/05/22.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit
import AVFoundation
import Photos;


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var myCollectionView : UICollectionView!
    
    var photoAssetsImg : [UIImage] = []
    var photoAssets : [AVPlayerItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.getAllPhotosInfo()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSizeMake(100, 100)
        
        //layout.sectionInset = UIEdgeInsetsMake(self.navigationController!.navigationBar.frame.size.height + UIApplication.sharedApplication().statusBarFrame.height + 10 ,0,0,0)

        layout.sectionInset = UIEdgeInsetsMake(10,0,0,0)

        layout.headerReferenceSize = CGSizeMake(200,0)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        self.view.addSubview(myCollectionView)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.myCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        println("Num: \(indexPath.row)")
        
        let playViewController = PlayViewController()
        playViewController.assets = self.photoAssets[indexPath.row]
        self.navigationController!.pushViewController(playViewController , animated: true)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoAssetsImg.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! CollectionViewCell
        //cell.textLabel?.text = indexPath.row.description
        cell.img.image = self.photoAssetsImg[indexPath.row]
        
        
        return cell
    }
    
    private func getAllPhotosInfo() {
        
        // 画像をすべて取得
        var assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Video, options: nil)
        assets.enumerateObjectsUsingBlock { (obj, index, stop) -> Void in
            //self.photoAssets.append(asset as! PHAsset)
            
            
            let asset:PHAsset = obj as! PHAsset;
            
            
            let phimgr:PHImageManager = PHImageManager();
            phimgr.requestImageForAsset(asset,
                targetSize: CGSize(width: 100, height: 100),
                contentMode: .AspectFill, options: nil) {
                    image, info in
                    
                    self.photoAssetsImg.append(image)
                    
            }
            
            phimgr.requestPlayerItemForVideo(asset, options: nil, resultHandler: {
                playerItem, info in

                self.photoAssets.append(playerItem)
            })
            
            if index == 2 {
                stop.initialize(true)
            }
        }
        //println(photoAssets)
    }
    
    func reloadcell(){
        self.myCollectionView.reloadData()
        println("呼ばれたよ")
    }
    
}


