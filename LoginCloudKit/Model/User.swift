//
//  UserCK.swift
//  LoginCloudKit
//
//  Created by Fauzi Fauzi on 22/08/19.
//  Copyright © 2019 fauzify. All rights reserved.
//

import UIKit
import CloudKit

class User {
    var userID: CKRecord.ID!
    var email: String?
    var password: String?
    var phoneNumber: String?
    
    init(record: CKRecord) {
        userID = record.recordID
        email = record["email"]
        password = record["password"]
        phoneNumber = record["phone"]
    }
}
