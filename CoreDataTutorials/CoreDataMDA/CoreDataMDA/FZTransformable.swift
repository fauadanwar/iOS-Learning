//
//  FZTransformable.swift
//  CoreDataMDA
//
//  Created by Fauad Anwar on 27/06/23.
//

import UIKit

@objc(FZTransformable) class FZTransformable: ValueTransformer {

    override class func allowsReverseTransformation() -> Bool {
        true
    }
    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }
    override func transformedValue(_ value: Any?) -> Any? {
        if  let image = value as? UIImage
        {
            return image.pngData()
        }
        return nil
    }
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        if  let data = value as? Data
        {
            return UIImage(data: data)
        }
        return nil
    }
}
