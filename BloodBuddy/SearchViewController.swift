//
//  SearchViewController.swift
//  BloodBuddy
//
//  Created by Adeesh Parvathaneni on 10/22/17.
//  Copyright © 2017 Adeesh Parvathaneni. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftyUserDefaults

class SearchViewController: UIViewController {

    @IBOutlet weak var hashBox: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendHash(_ sender: Any) {
        print(hashBox.text)
        Defaults[.hashValue] = hashBox.text
        
        performSegue(withIdentifier: "toInfo", sender: nil)
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
