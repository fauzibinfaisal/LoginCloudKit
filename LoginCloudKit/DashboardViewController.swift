//
//  DashboardViewController.swift
//  LoginCloudKit
//
//  Created by Fauzi Fauzi on 27/08/19.
//  Copyright © 2019 fauzify. All rights reserved.
//

import UIKit
import CloudKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var imageUploadButton: UIButton!
    
    let myContainer = CKContainer.default().privateCloudDatabase

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func imageUploadAction(_ sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "cat01"), for: UIControl.State.normal)

    }
    @IBAction func loadImageAction(_ sender: UIButton) {
        loadImage(name: "fauzi")
    }
    
    func loadImage(name: String) {
        let predicate = NSPredicate(format: "name ==%@", name)
        let query = CKQuery(recordType: "Photo", predicate: predicate)
        
        myContainer.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                DispatchQueue.main.async {
                    print("Cloud Query Error - Fetch Photo: \(String(describing: error))")
                }
                return
            }
            print("record count: \(String(describing: records?.count))")
            for record in records! {
                DispatchQueue.main.async {
                    if let asset = record["imageProfil"] as? CKAsset,
                        let data = try? Data(contentsOf: (asset.fileURL!)),
                        let image = UIImage(data: data)
                    {
                        self.photoImageView.image = image
                    }
                    print("recorddd \(record)")

                }
            }
        }
    }
}
