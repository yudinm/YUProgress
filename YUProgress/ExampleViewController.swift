//
//  ViewController.swift
//  YUProgress
//
//  Created by Michael Yudin on 29.11.2017.
//  Copyright © 2017 Michael Yudin. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var progressView: YUProgressView!
    var lastContentOffset:CGPoint = CGPoint.zero
    var scrolledDistance:CGFloat = 0.0
    let distanceThreshold:CGFloat = 100.0
    var pulledToRefresh:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        
        self.progressView.complition = {
            self.pulledToRefresh = true
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset:CGFloat = scrollView.contentOffset.y
        self.scrolledDistance += abs(self.lastContentOffset.y - yOffset)

        if (self.scrolledDistance > self.distanceThreshold) {
            self.scrolledDistance = 0.0;
        }
        
        if (yOffset > 0.0) { /* Тянем вверх */
//            self.cnstHeaderBannerContainerTop.constant = [self imageTopOnSqueezingWithYOffset:yOffset]; // Сдвинуть картинку вверх
//            self.cnstHeaderBannerContainerH.constant = [self imageHeightOnSqueezingWithYOffset:yOffset]; // Сжать картинку
            self.progressView.updateProgress(value: 0.0)
            self.progressView.resetProgress()
        } else { /* Тянем вниз */
//            self.cnstHeaderBannerContainerTop.constant = 0.0; // Закрепить верхний край картинки
//            self.cnstHeaderBannerContainerH.constant = [self imageHeightOnStretchingWithYOffset:yOffset]; // Растянуть картинку
            
            self.progressView.updateProgress(value: (-1*yOffset)/self.distanceThreshold )
            scrollView.zoomScale = 1.0;
        }
        
        self.lastContentOffset = scrollView.contentOffset
        
        if (scrollView.contentOffset.y == 0.0 && self.pulledToRefresh) {
//            [self reloadData];
            self.pulledToRefresh = false
            self.progressView.resetProgress()
        }
    }
    
    
}

