//
//  CreateSubmissionPart2ViewController.swift
//  BloodBuddy
//
//  Created by Adeesh Parvathaneni on 10/22/17.
//  Copyright © 2017 Adeesh Parvathaneni. All rights reserved.
//

import UIKit
import QRCode
class CreateSubmissionPart2ViewController: UIViewController {

    @IBOutlet weak var qrCodeImage: UIImageView!
    var hashVal: String! = ""
    
    @IBOutlet weak var hashLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let newHash = hashVal{
            print("hash:")
            print(newHash)
            let qrCode = QRCode(newHash)!
            qrCodeImage.image = qrCode.image
            hashLabel.text = newHash
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
