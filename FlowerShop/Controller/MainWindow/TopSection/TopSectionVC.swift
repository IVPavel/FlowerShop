//
//  TopSectionVCViewController.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/31/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class TopSectionVC: UIViewController {
    
    var images = ["0", "1", "2", "3"]

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }
    
    func setup() {
        //register Cell
        let nibCell = UINib(nibName: "TopCVCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "TopCVCell")
    }
    
    func style() {
        //size Cell
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width - 60, height: collectionView.frame.size.height)
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.8
        layout.spacingMode = .fixed(spacing: 1.0)
        collectionView.collectionViewLayout = layout
        
        pageControl.numberOfPages = images.count
    }
}

extension TopSectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCVCell", for: indexPath) as! TopCVCell
        
        let im = images[indexPath.item]
        cell.image.image = UIImage(named: im)
        
        return cell
    }
}

extension TopSectionVC: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // temporary solution (284)
        let pageNumber = scrollView.contentOffset.x / 284
        pageControl.currentPage = Int(pageNumber)
    }
}
