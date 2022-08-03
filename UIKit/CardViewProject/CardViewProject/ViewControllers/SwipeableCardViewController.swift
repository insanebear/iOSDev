//
//  SwipeableCardViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/15.
//

import UIKit

class SwipeableCardViewController: UIViewController {
    private var initialCenter: CGPoint = .zero
    
    var selectedItem: [MyData] = []
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Print result", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(printResult(_:)), for: .touchUpInside)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // for a range check
        let square = UIView()
        square.backgroundColor = .red
        square.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(square)
        
        createCards()

        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            square.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            square.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            square.widthAnchor.constraint(equalToConstant: self.view.frame.width/2),
            square.heightAnchor.constraint(equalToConstant: self.view.frame.height),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func createCards() {
        for data in MyData.myDataList {
            let card = CardView(data: data, width: 250, ratio: 1.5)
            card.configure(images: [data.image],
                             title: data.title,
                             subtitle: data.author,
                             memo: data.memo)
            
            // Pan Gesture for card swiping action
            card.addGestureRecognizer(
                UIPanGestureRecognizer(target: self, action: #selector(didDragCardView(_:)))
            )
            
            self.view.addSubview(card)
            NSLayoutConstraint.activate([
                card.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                card.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
    }
    
    @objc func didDragCardView(_ sender: UIPanGestureRecognizer) {
        guard let senderView = sender.view else {
            return
        }
        
        switch sender.state {
        case .began:
            initialCenter = senderView.center
            
        case .changed:
            let translation = sender.translation(in: self.view)
            
            senderView.center = CGPoint(x: initialCenter.x + translation.x,
                                        y: initialCenter.y + translation.y)
            
            UIView.animate(withDuration: 0.2) {
                let direction = translation.x > 0 ? 1.0 : -1.0
                senderView.rotate(angle: (.pi/10) * direction)
            }
            
        case .ended, .cancelled:
            let translation = sender.translation(in: self.view)
            let width = self.view.frame.width
            
            // Moving threshold for preventing unwanted user behavior
            let threshold = (initialCenter.x - width / 4,
                             initialCenter.x + width / 4)
            let newX = initialCenter.x + translation.x // x of a new center
            
            let isValid = newX < threshold.0 || newX > threshold.1 ? true : false
            if isValid {
                UIView.animate(withDuration: 0.2, animations: {
                    // Move the card outside of the current view range
                    if newX > width / 2 {
                        // YES
                        senderView.center = CGPoint(x: width + senderView.frame.width,
                                                    y: self.initialCenter.y)
                        // Add the data to the result array
                        if let view = senderView as? CardView,
                           let data = view.data as? MyData {
                            self.selectedItem.append(data)
                        }
                    } else {
                        // NO
                        senderView.center = CGPoint(x: 0 - senderView.frame.width,
                                                    y: self.initialCenter.y)
                    }
                }, completion: { _ in
                    // Remove the card swiped out
                    senderView.removeFromSuperview()
                })
                
            } else {
                // if swipe-action is not valid, return the original status
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.7,
                               initialSpringVelocity: 0.7,
                               options: [.curveEaseOut]) {
                    senderView.center = self.initialCenter
                    senderView.rotate(angle: 0)
                }
            }
            
        default:
            break
        }
    }
    
    @objc func printResult(_ sender: UIButton) {
        for item in selectedItem {
            print(item.title, terminator: ",")
        }
        print("")
    }
}

// MARK: - UIView extension
extension UIView {
    func rotate(angle: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: angle)
    }
}
