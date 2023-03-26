//
//  UIImage+Extensions.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import UIKit

extension UIImage {
  static var `default`: UIImage {
    return #imageLiteral(resourceName: "default")
  }
  
  func imageWith(newSize: CGSize) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: newSize)
    let image = renderer.image {_ in
      draw(in: CGRect(origin: .zero, size: newSize))
    }
    
    return image
  }
  
  func imageByBestFit(for targetSize: CGSize) -> UIImage {
    let aspectRatio = size.width / size.height
    let targetHeight = targetSize.height
    let scaledWidth = targetSize.height * aspectRatio
    
    let bestSize = CGSize(width: scaledWidth, height: targetHeight)
    return imageWith(newSize: bestSize)
  }
  
}

extension Optional where Wrapped == UIImage {
  func isSame(photo: UIImage?) -> Bool {
    switch (self, photo) {
    case (nil, nil):
      return true
    case (nil, _), (_, nil):
      return false
    case (let p1, let p2):
      return p1!.isEqual(p2)
    }
  }
}
