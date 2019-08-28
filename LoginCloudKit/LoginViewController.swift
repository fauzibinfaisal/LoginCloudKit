//
//  LoginViewController.swift
//  LoginCloudKit
//
//  Created by Fauzi Fauzi on 22/08/19.
//  Copyright © 2019 fauzify. All rights reserved.
//

import UIKit
import CloudKit

class LoginViewController: UIViewController {
    
    let myContainer = CKContainer.default().publicCloudDatabase
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    var isNotRegistered = true
    
    var userRecords = [CKRecord]()
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        retrieve()
    }

    @IBAction func loginAction(_ sender: UIButton) {
        checkEmailRegistered(email: emailTF.text!)
//        search(text: emailTF.text!)
//        for user in users{
//            print(user.email as Any)
//            print(user.password as Any)
//            print(user.phoneNumber as Any)
//        }
    }
    
    func retrieve(){
        let query = CKQuery(recordType: "UserData", predicate: NSPredicate(value: true))
        
        myContainer.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {return} //Guard pasti return
            let sortRecords = records.sorted(by: {$0.creationDate! > $1.creationDate!})
//            self.userRecords = sortRecords
//            print(self.userRecords)
            
            for record in sortRecords{
                self.users.append(User(record: record))
            }
        }
    }
    
    func checkEmailRegistered(email: String) {
        let predicate = NSPredicate(format: "email ==%@", email)
        let query = CKQuery(recordType: "UserData" , predicate: predicate)
        
        
        myContainer.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                guard let records = records else {return}
                if records.count > 0 {
                    print("record count \(records.count), false")
                    self.isNotRegistered = false
                } else {
                    print("record = 0, true")
                    self.isNotRegistered = true
                }
                self.login()
            }
        }
    }
    
    func login (){
        if (isNotRegistered){
            DispatchQueue.main.async {
                self.textLabel.text = "Email Unregistered"
            }
        } else {
            let email = emailTF.text!
            let password = passwordTF.text!
            
            for user in users{
                if email == user.email! {
                    
                    if password == user.password! {
                        DispatchQueue.main.async {
                            self.textLabel.text = "Login Success"
                            self.performSegue(withIdentifier: "toDashboard", sender: self)
                        }
                        print("break...")
                    } else {
                        DispatchQueue.main.async {
                            self.textLabel.text = "Wrong Password"
                        }
                    }
                    break
                }
            }
        }
    }
    
    
//    func isEmailRegistered(email: String){
//        for record in userRecords {
//            let emailCK = record.value(forKey: "email") as? String
//            if (email == emailCK){
//
//            }
//        }
//    }
    
}
