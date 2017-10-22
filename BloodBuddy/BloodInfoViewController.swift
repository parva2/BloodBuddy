//
//  BloodInfoViewController.swift
//  BloodBuddy
//
//  Created by Drew Patel on 10/21/17.
//  Copyright © 2017 Adeesh Parvathaneni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyUserDefaults

class BloodInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hashValue = DefaultsKey<String>("hashValue")
        Alamofire.request("https://bloodbuddy-blurjoe.c9users.io:8080/api/bloodQuery?\(hashValue)").responseJSON { response in
            debugPrint(response)
            if let json = response.result.value {
                print("JSON: \(json)")
            }
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
