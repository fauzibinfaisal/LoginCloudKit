//
//  RegisterViewController.swift
//  LoginCloudKit
//
//  Created by Fauzi Fauzi on 22/08/19.
//  Copyright © 2019 fauzify. All rights reserved.

import UIKit
import CloudKit

class RegisterViewController: UIViewController {

    let publicDatabase = CKContainer.default().publicCloudDatabase
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func saveRecord() {
        // MARK: - CloudKit - saveRecord
//        let userRecordID = CKRecord.ID(recordName: idTextField.text ?? "123")
        let userRecord = CKRecord(recordType: "UserData")
        userRecord["email"] = emailTF.text! as NSString
        userRecord["phone"] = phoneTF.text! as NSString
        userRecord["password"] = passwordTF.text! as NSString
        
        publicDatabase.save(userRecord) {
            (record, error) in
            if let error = error {
                print("LogErrorDB \(error)")
                DispatchQueue.main.async {
                    self.alert(message: "Failed : \(error)", title: "Error")
                }
                return
            }
            print("Data saved")
            DispatchQueue.main.async {
                self.alert(message: "Registered", title: "Alert")
            }
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if emailTF.text!.isEmpty || phoneTF.text!.isEmpty || passwordTF.text!.isEmpty {
            
            DispatchQueue.main.async {
                self.alert(message: "All text field must be filled", title: "Alert")
            }
//        } else if isValidEmail(emailID: emailTF.text!) == false {
//            DispatchQueue.main.async {
//                self.alert(message: "Please enter valid email address", title: "Alert")
//            }
        } else {
            saveRecord()
        }
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MACTHES %@", emailRegEx)
        print(" SUCCESS")
        return emailTest.evaluate(with: emailID)
    }
    
//    func isValidPassword(password:String) -> Bool {
//        let emailRegEx = "^(?=.*[A-Za-z])[A-Za-z\d]{8,}$"
//        let emailTest = NSPredicate(format:"SELF MACTHES %@", emailRegEx)
//        return emailTest.evaluate(with: password)
//    }
//
    
}


