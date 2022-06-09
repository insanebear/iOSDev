//
//  CardPageViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/09.
//

import UIKit

class CardPageViewController: UIViewController {
    let imageScrollView = CardScrollView(width: 300, ratio: 0.7, dataList: MyData.myDataList)
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray6
        pageControl.currentPageIndicatorTintColor = .systemGray4
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = MyData.myDataList.count
        return pageControl
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        imageScrollView.delegate = self
        
        self.view.addSubview(pageControl)
        self.view.addSubview(imageScrollView)
        
        NSLayoutConstraint.activate([
            imageScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageScrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            pageControl.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: imageScrollView.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}

extension CardPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = imageScrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / pageWidth)
    }
}
