//
//  ViewModel.swift
//  RxMVVM
//
//  Created by Dishank Narang on 5/18/18.
//  Copyright © 2018 B0200969. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import RxDataSources

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
    
    let url = "http://localhost:3004/users"
    
    let sections = Variable<[SectionModel<Section, User>]>([])
    
//    let items = Observable.just([
//        SectionModel(model: "First section", items: [
//            1.0,
//            2.0,
//            3.0
//            ]),
//        SectionModel(model: "Second section", items: [
//            1.0,
//            2.0,
//            3.0
//            ]),
//        SectionModel(model: "Third section", items: [
//            1.0,
//            2.0,
//            3.0
//            ])
//        ])

    lazy var items = self.sections.asObservable()
    
    init() {
        
    }
    
    func refreshData() {
        sections.value = []
        Alamofire.request(url)
            .validate(contentType: ["application/json"])
            .responseJSON { [weak self] (res) in
            print(res)
            if let resArr = res.result.value as? [[AnyHashable: Any]] {
                let tempArray = resArr.map(Section.init(dict:))
                    .map { SectionModel.init(model: $0, items: $0.users) }
                self?.sections.value = tempArray
            }
        }
    }
    
}
