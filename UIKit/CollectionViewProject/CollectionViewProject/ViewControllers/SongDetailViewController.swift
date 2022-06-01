//
//  SongDetailViewController.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/01.
//

import UIKit

class SongDetailViewController: UIViewController {
    var song: Song
    
    private var stackView: UIStackView!
    private var trackNameLabel: UILabel!
    private var artistNameLabel: UILabel!
    private var artworkImageView: UIImageView!
    
    init(song: Song) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        let image = UIImage(systemName: "questionmark.app.dashed")
        artworkImageView = UIImageView(image: image)
        if let url = URL(string: song.artworkUrl100) {
            artworkImageView.load(url: url)
        }
        artworkImageView.layer.cornerRadius = 10
        artworkImageView.clipsToBounds = true
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artworkImageView.widthAnchor.constraint(equalToConstant: 100),
            artworkImageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        trackNameLabel = UILabel()
        trackNameLabel.text = song.trackName
        trackNameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        trackNameLabel.textColor = .black
        trackNameLabel.sizeToFit()
        
        artistNameLabel = UILabel()
        artistNameLabel.text = song.artistName
        artistNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        artistNameLabel.textColor = .black
        artistNameLabel.sizeToFit()
        
        stackView = UIStackView(arrangedSubviews: [artworkImageView, trackNameLabel, artistNameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
