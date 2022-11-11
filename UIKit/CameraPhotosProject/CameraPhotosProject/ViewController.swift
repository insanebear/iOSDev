//
//  ViewController.swift
//  CameraPhotosProject
//
//  Created by Jayde Jeong on 2022/11/11.
//

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate {
    
    var stackView: UIStackView!
    var imageView: UIImageView!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    func setViews() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.borderWidth = 1
        
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        button = UIButton()
        button.setTitle("Add a photo", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTappedButton(_:)), for: .touchUpInside)
        
        stackView = UIStackView(arrangedSubviews: [
            imageView, button
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        self.view.addSubview(stackView)
    }
    
    func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
        ])
    }
    
    @objc func didTappedButton(_ sender: UITapGestureRecognizer) {
        
        // display action sheet alerts
        var actions: [(String, UIAlertAction.Style)] = []
        actions.append(("Take a photo", UIAlertAction.Style.default))
        actions.append(("Choose from Gallery", UIAlertAction.Style.default))
        actions.append(("Cancel", UIAlertAction.Style.cancel))
        
        Alerts.showActionsheet(viewController: self,
                               title: "Edit Image",
                               message: "Select a menu getting a photo",
                               actions: actions) { (index) in
            switch index {
            case 0:
                self.openCamera()
            case 1:
                self.openPHPicker()
            default:
                fatalError("Error: Cannot open camera or photo picker")
            }
        }
    }
    
    /// open camera
    func openCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    /// open photo picker
    func openPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared()) // fully shared
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // set the image taken with the camera
        self.imageView.image = image
    }
    
    // MARK: - PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
