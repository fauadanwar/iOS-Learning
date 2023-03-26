//
//  DetailViewController.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import UIKit
import Photos
import AssetsLibrary

protocol DetailViewControllerDelegate: AnyObject {
    func detailViewControllerDidFinish(_ viewController: DetailViewController, with photoEntry: PhotoEntry?, title: String?)
}

class DetailViewController: UIViewController {
    weak var delegate: DetailViewControllerDelegate?
    var document: Document? {
        didSet {
            guard let doc = document else { return }
            title = doc.description
        }
    }
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var fullImageView: UIImageView!
    
    private var newImage: UIImage?
    private var newThumbnailImage: UIImage?
    private var hasChanges = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined  {
            PHPhotoLibrary.requestAuthorization { _ in }
        }
        
        openDocument()
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        guard UIImagePickerController.isSourceTypeAvailable(imagePicker.sourceType) else { return }
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func openDocument() {
        if document == nil {
            showImagePicker()
        }
        else {
            document?.open() { [weak self] _ in
                self?.fullImageView.image = self?.document?.photo?.mainImage
                self?.titleTextField.text = self?.document?.description
                self?.newImage = self?.document?.photo?.mainImage
                self?.newThumbnailImage = self?.document?.photo?.thumbnailImage
            }
        }
    }
    
    @IBAction func editPhoto(_ sender: Any) {
        showImagePicker()
    }
    
    @IBAction func donePressed(_ sender: Any) {
        var photoEntry: PhotoEntry?
        
        if let newImage = newImage, let newThumb = newThumbnailImage {
            photoEntry = PhotoEntry(mainImage: newImage, thumbnailImage: newThumb)
        }
        
        // 1
        let hasDifferentPhoto = !newImage.isSame(photo: document?.photo?.mainImage)
        let hasDifferentTitle = document?.description != titleTextField.text
        hasChanges = hasDifferentPhoto || hasDifferentTitle
        
        // 2
        guard let doc = document, hasChanges else {
            delegate?.detailViewControllerDidFinish(
                self,
                with: photoEntry,
                title: titleTextField.text
            )
            dismiss(animated: true, completion: nil)
            return
        }
        
        // 3
        doc.photo = photoEntry
        doc.save(to: doc.fileURL, for: .forOverwriting) { [weak self] (success) in
            guard let self = self else { return }
            
            if !success { fatalError("Failed to close doc.") }
            
            self.delegate?.detailViewControllerDidFinish(
                self,
                with: photoEntry,
                title: self.titleTextField.text
            )
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage else {
            return
        }
        
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        options.isSynchronous = true
        
        if let imageAsset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let imageManager = PHImageManager.default()
            
            imageManager.requestImage(
                for: imageAsset,
                targetSize: CGSize(width: 150, height: 150),
                contentMode: .aspectFill,
                options: options
            ) { (result, _) in
                self.newThumbnailImage = result
            }
        }
        
        fullImageView.image = image
        let mainSize = fullImageView.bounds.size
        newImage = image.imageByBestFit(for: mainSize)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
