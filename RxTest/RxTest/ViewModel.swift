//
//  ViewModel.swift
//  RxTest
//
//  Created by Dishank Narang on 5/17/18.
//  Copyright © 2018 B0200969. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class User {
    var firstName: String!
    var lastName: String!
    
    init(first: String, last: String) {
        firstName = first
        lastName = last
    }
}

class Section {
    var title: String!
    var users: [User]!
    
    init(dict: [AnyHashable: Any]) {
        title = dict["sectionTitle"] as? String ?? ""
        users = []
        if let usersArr = dict["users"] as? [[AnyHashable: Any]] {
            for user in usersArr {
                users.append(User(first: user["firstName"] as? String ?? "", last: user["lastName"] as? String ?? ""))
            }
        }
    }
}

class ViewModel {
    
    let url = "http://localhost:3003/users"
    
    var sections: [Section]?
    let observableSections = Variable<[Section]>([])
    
    init() {
        
    }
    
}
