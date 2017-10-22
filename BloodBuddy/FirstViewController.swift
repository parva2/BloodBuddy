//
//  FirstViewController.swift
//  BloodBuddy
//
//  Created by Adeesh Parvathaneni on 10/21/17.
//  Copyright © 2017 Adeesh Parvathaneni. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

class FirstViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.backgroundColor = UIColor.white
        form +++ Section("Patient Information")
            <<< AlertRow<String>() {
                $0.title = "Blood Type"
                $0.selectorTitle = "Pick a type"
                $0.options = ["O+","A+","B+","AB+","O-","A-","B-", "AB-"]
                $0.value = "O+"    // initially selected

           }
           
            <<< AlertRow<String>() {
                $0.title = "Sex of Donor"
                $0.selectorTitle = "Sex of Donor"
                $0.options = ["Male", "Female", "Transgender"]
                $0.value = "Female"    // initially selected
                
            }
            <<< AlertRow<String>() {
                $0.title = "Age Range"
                $0.selectorTitle = "Age Range"
                $0.options = ["16-20","21-30","31-40","41-50","51-60","61-70","71+"]
                $0.value = "Female"    // initially selected
                
            }
            
            
            <<< DateRow(){
                $0.title = "Date of donation"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
   
            +++ Section("Disease history ")
            <<< AlertRow<String>() {
                $0.title = "Disease History"
                $0.selectorTitle = "Pick a Disease"
                $0.options = ["HIV","Malaria","Viral Hepatitis","None"]
                $0.value = "None"    // initially selected
        }
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
     
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

