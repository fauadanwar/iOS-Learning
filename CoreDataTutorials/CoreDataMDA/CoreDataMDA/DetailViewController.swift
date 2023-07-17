//
//  DetailViewController.swift
//  CoreDataMDA
//
//  Created by Fauad Anwar on 27/06/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    var location: Location?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let location
        {
            addressLabel.text = location.address
            locationImage.image = location.image as? UIImage
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
