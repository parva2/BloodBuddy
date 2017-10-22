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

extension DefaultsKeys {
    static let medicalHistory = DefaultsKey<[String]?>("medicalHistory")
    static let locationHistory = DefaultsKey<[String]?>("locationHistory")
}

class BloodInfoViewController: UIViewController {

    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var riskFactorLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var drawnDateLabel: UILabel!
    @IBOutlet weak var ageRangeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let hashValue = Defaults[.hashValue]!
        print("hash: \(hashValue)")
        
        Alamofire.request("https://bloodbuddy-blurjoe.c9users.io:8080/api/bloodQuery?hash=\(hashValue)").responseJSON { response in
            print(response)
            if let json = response.result.value {
                print("JSON: \(json)")
                if let dictionary = json as? [String: Any] {
                    self.bloodTypeLabel.text = dictionary["bloodType"]! as! String
                    self.amountLabel.text =
                        String(dictionary["amount"]! as! Int) + " mL"
                    self.ageRangeLabel.text = dictionary["ageRange"]! as! String
                    var unixTime = dictionary["date"]! as! Int
                    let date = NSDate(timeIntervalSince1970: TimeInterval(unixTime))
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM. dd, yyyy"
                    let dateString = dateFormatter.string(from:date as Date)
                    self.drawnDateLabel.text = dateString
                    self.sexLabel.text = dictionary["sex"]! as! String
                    self.riskFactorLabel.text =
                        String(dictionary["riskFactor"]! as! Int) + " %"
                    
                    var medicalHistory = dictionary["medicalHistory"]! as! String
                    print(medicalHistory)
                    var newArray = medicalHistory
                    newArray = newArray.replacingOccurrences(of: "[", with: "")
                    newArray = newArray.replacingOccurrences(of: "]", with: "")
                    let fullname : [String] = newArray.components(separatedBy: ",")
                    Defaults[.medicalHistory] = fullname
                    
                    var locationArray = dictionary["locationHistory"]! as! String
                    print(locationArray)
                    var newArray1 = locationArray
                    newArray1 = newArray1.replacingOccurrences(of: "[", with: "")
                    newArray1 = newArray1.replacingOccurrences(of: "]", with: "")
                    let fullname1 : [String] = newArray1.components(separatedBy: ",")
                    Defaults[.locationHistory] = fullname1
                    print(locationArray)
                }
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
