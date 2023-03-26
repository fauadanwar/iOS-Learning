//
//  Entry.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import Foundation
import UIKit

class Entry: NSObject {
  var fileURL: URL
  var metadata: PhotoMetadata?
  var version: NSFileVersion
  
  private var editDate: Date {
    return version.modificationDate ?? .distantPast
  }
  
  override var description: String {
    return fileURL.deletingPathExtension().lastPathComponent
  }
  
  init(fileURL: URL, metadata: PhotoMetadata?, version: NSFileVersion) {
    self.fileURL = fileURL
    self.metadata = metadata
    self.version = version
  }
}

extension Entry: Comparable {
  static func < (lhs: Entry, rhs: Entry) -> Bool {
    return lhs.editDate < rhs.editDate
  }
}
