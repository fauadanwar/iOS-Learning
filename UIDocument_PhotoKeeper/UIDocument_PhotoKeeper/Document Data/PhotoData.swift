//
//  PhotoData.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import Foundation
import UIKit
class PhotoData: NSObject, NSCoding {
  var image: UIImage?
  
  init(image: UIImage? = nil) {
    self.image = image
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(1, forKey: .versionKey)
    guard let photoData = image?.pngData() else { return }
    
    aCoder.encode(photoData, forKey: .photoKey)
  }
  
  required init?(coder aDecoder: NSCoder) {
    aDecoder.decodeInteger(forKey: .versionKey)
    guard let photoData = aDecoder.decodeObject(forKey: .photoKey) as? Data else {
      return nil
    }
    
    self.image = UIImage(data: photoData)
  }
}
