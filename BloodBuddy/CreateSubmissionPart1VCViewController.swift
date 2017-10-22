//
//  CreateSubmissionPart1VCViewController.swift
//  BloodBuddy
//
//  Created by Adeesh Parvathaneni on 10/21/17.
//  Copyright © 2017 Adeesh Parvathaneni. All rights reserved.
//

import UIKit
import Eureka
import Alamofire

class CreateSubmissionPart1VCViewController: FormViewController {

    var sendingHash: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Patient Information")
            <<< AlertRow<String>("bloodType") {
                $0.title = "Blood Type"
                $0.selectorTitle = "Pick a type"
                $0.options = ["O+","A+","B+","AB+","O-","A-","B-", "AB-"]
                $0.value = "O+"    // initially selected
                
            }
            <<< IntRow("amount"){
                $0.title = "Amount (mL)"
                $0.value = 200
            }
            
            <<< AlertRow<String>("sex") {
                $0.title = "Sex of Donor"
                $0.selectorTitle = "Sex of Donor"
                $0.options = ["Male", "Female", "Transgender"]
                $0.value = "Female"    // initially selected
                
            }
            <<< AlertRow<String>("ageRange") {
                $0.title = "Age Range"
                $0.selectorTitle = "Age Range"
                $0.options = ["16-20","21-30","31-40","41-50","51-60","61-70","71+"]
                $0.value = "21-30"    // initially selected
                
            }
            
            
            <<< DateRow("date"){
                $0.title = "Date of donation"
                $0.value = Date()
            }
            
            +++ Section("Disease history ")
            <<< MultipleSelectorRow<String>("medicalHistory") {
                $0.title = "Disease History"
                $0.selectorTitle = "Pick a Disease"
                $0.options = ["HIV","Malaria","Viral Hepatitis","None"]
                //$0.value = "None"    // initially selected
            }
        
        
            /**
            +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                                   header: "Concerning Patient History",
                                   footer: "") {
                                    $0.addButtonProvider = { section in
                                        return ButtonRow(){
                                            $0.title = "Add New Information"
                                        }
                                    }
                                    $0.multivaluedRowToInsertAt = { index in
                                        return NameRow() {
                                            $0.placeholder = ""
                                        }
                                    }
                                    $0 <<< NameRow() {
                                        $0.placeholder = ""
                                    }
        }
 **/
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextPressed(_ sender: Any) {
        
        
        let valuesDictionary : Dictionary! = form.values()
        print(valuesDictionary)
        
        let bloodType = valuesDictionary["bloodType"]!
        let sex = valuesDictionary["sex"]!
        let ageRange = valuesDictionary["ageRange"]!
        var date = valuesDictionary["date"]! as! NSDate
        let amount = valuesDictionary["amount"]!
        let medicalHistory = valuesDictionary["medicalHistory"]!
        
       var unixDate = date.timeIntervalSince1970
        let rand = arc4random_uniform(100)
        
        let locationArray : Set = ["Sands Expo Center", "Orange County Blood Bank"]
        let parameters: Parameters = [
            "bloodType": bloodType!,
            "sex": sex!,
            "ageRange": ageRange!,
            "date": unixDate,
            "amount": amount!,
            "medicalHistory": medicalHistory!,
            "riskFactor": rand,
            "locationHistory": locationArray
        ]
        print(parameters)
        Alamofire.request("https://bloodbuddy-blurjoe.c9users.io:8080/api/createBlood", method: .post, parameters: parameters).responseString { response in
            print(response)
            self.sendingHash = response.result.value!
            self.performSegue(withIdentifier: "toSecond", sender: nil)
        }
}
        
    
    
    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSecond") {
        let destinationVC = segue.destination as! CreateSubmissionPart2ViewController
        destinationVC.hashVal = sendingHash
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
