//
//  Document.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import Foundation
import UIKit

extension String {
  static let appExtension: String = "ptk"
  static let versionKey: String = "Version"
  static let photoKey: String = "Photo"
  static let thumbnailKey: String = "Thumbnail"
}

private extension String {
  static let dataKey: String = "Data"
  static let metadataFilename: String = "photo.metadata"
  static let dataFilename: String = "photo.data"
}

typealias PhotoEntry = (mainImage: UIImage?, thumbnailImage: UIImage?)

class Document: UIDocument {
    // 1
    override var description: String {
      return fileURL.deletingPathExtension().lastPathComponent
    }

    // 2
    var fileWrapper: FileWrapper?

    // 3
    lazy var photoData: PhotoData = {
        //1
        guard
          fileWrapper != nil,
          let data = decodeFromWrapper(for: .dataFilename) as? PhotoData
          else {
            return PhotoData()
        }
        return data
    }()

    lazy var metadata: PhotoMetadata = {
        guard
          fileWrapper != nil,
          let data = decodeFromWrapper(for: .metadataFilename) as? PhotoMetadata
          else {
            return PhotoMetadata()
        }
        return data
    }()

    // 4
    var photo: PhotoEntry? {
      get {
        return PhotoEntry(mainImage: photoData.image, thumbnailImage: metadata.image)
      }
      
      set {
        photoData.image = newValue?.mainImage
        metadata.image = newValue?.thumbnailImage
      }
    }

    private func encodeToWrapper(object: NSCoding) -> FileWrapper {
      let archiver = NSKeyedArchiver(requiringSecureCoding: false)
      archiver.encode(object, forKey: .dataKey)
      archiver.finishEncoding()
      
      return FileWrapper(regularFileWithContents: archiver.encodedData)
    }
      
    override func contents(forType typeName: String) throws -> Any {
      let metaDataWrapper = encodeToWrapper(object: metadata)
      let photoDataWrapper = encodeToWrapper(object: photoData)
      let wrappers: [String: FileWrapper] = [.metadataFilename: metaDataWrapper,
                                             .dataFilename: photoDataWrapper]
      
      return FileWrapper(directoryWithFileWrappers: wrappers)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
      guard let contents = contents as? FileWrapper else { return }
      fileWrapper = contents
    }

    func decodeFromWrapper(for name: String) -> Any? {
      guard
        let allWrappers = fileWrapper,
        let wrapper = allWrappers.fileWrappers?[name],
        let data = wrapper.regularFileContents
        else {
          return nil
        }
      
      do {
        let unarchiver = try NSKeyedUnarchiver.init(forReadingFrom: data)
        unarchiver.requiresSecureCoding = false
        return unarchiver.decodeObject(forKey: .dataKey)
      } catch let error {
        fatalError("Unarchiving failed. \(error.localizedDescription)")
      }
    }

}
