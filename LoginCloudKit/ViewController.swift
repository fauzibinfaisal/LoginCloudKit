//
//  ViewController.swift
//  LoginCloudKit
//
//  Created by Fauzi Fauzi on 14/08/19.
//  Copyright © 2019 fauzify. All rights reserved.

import UIKit
import CloudKit

class ViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var idSearchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func saveRecord() {
        // MARK: - CloudKit - saveRecord
        let userRecordID = CKRecord.ID(recordName: idTextField.text ?? "123")
        let userRecord = CKRecord(recordType: "UserData", recordID: userRecordID)
        userRecord["email"] = emailTextField.text! as NSString
        userRecord["pass"] = passwordTextField.text! as NSString
        userRecord["name"] = nameTextField.text! as NSString
        
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase
        
        publicDatabase.save(userRecord) {
            (record, error) in
            if let error = error {
                print("LogErrorDB \(error)")
                return
            }
            print("Data saved")
        }
    }
    
    func loadRecord() {
        let userRecordID = CKRecord.ID(recordName: idSearchTextField.text ?? "123")
        let myContainer = CKContainer.default()
        let publicDatabase = myContainer.publicCloudDatabase
        let artworkRecord = CKRecord.init(recordType: "UserData", recordID: userRecordID)
        
        publicDatabase.fetch(withRecordID: userRecordID) { (dataRecord, error) in
            if let data = dataRecord{
                self.nameLabel.text = data.value(forKey: "name") as? String
                self.emailLabel.text = data.value(forKey: "email") as? String
            }
        }
    }

    @IBAction func saveButton(_ sender: UIButton) {
        saveRecord()
    }
    
    @IBAction func loadButton(_ sender: UIButton) {
        loadRecord()
    }
}

