//
//  MapDetailViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/12.
//

import UIKit
import MapKit

class MapDetailViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    } ()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    } ()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    } ()

    init(mapItem: MKMapItem) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = mapItem.name
        addressLabel.text = mapItem.placemark.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(addressLabel)

        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
}
