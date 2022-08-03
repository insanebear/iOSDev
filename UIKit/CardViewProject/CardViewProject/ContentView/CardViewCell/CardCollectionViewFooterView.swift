//
//  CardCollectionViewFooterView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/10.
//

import UIKit
import Combine

class CardCollectionViewFooterView: UICollectionReusableView {
    static let reuseIdentifier = "cardCollectionViewFooterView"
    
    private var pagingInfoToken: AnyCancellable?
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray6
        pageControl.currentPageIndicatorTintColor = .systemGray4
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: self.topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with count: Int) {
        pageControl.numberOfPages = count
    }
    
    func subscribeTo(subject: PassthroughSubject<PagingInfo, Never>, for section: Int) {
        pagingInfoToken = subject
            .filter { $0.sectionIndex == section }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pagingInfo in
                self?.pageControl.currentPage = pagingInfo.currentPage
            }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pagingInfoToken?.cancel()
        pagingInfoToken = nil
    }
}
