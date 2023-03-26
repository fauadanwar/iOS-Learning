//
//  PhotoKeeperCell.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import UIKit

class PhotoKeeperCell: UITableViewCell {
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var subtitleLabel: UILabel!
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    UIView.animate(withDuration: 0.1) {
      self.titleTextField.isEnabled = editing
      self.titleTextField.borderStyle = editing ? UITextField.BorderStyle.roundedRect : .none
    }
  }
}
