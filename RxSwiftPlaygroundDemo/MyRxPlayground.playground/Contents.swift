//: Playground - noun: a place where people can play

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import RxSwift

let users = Variable<[String]>([])

users.value = ["Nikhil"]

users.asObservable()
//    .throttle(0.5, scheduler: MainScheduler.instance)
    .filter({
        value in
        return value.count >= 1
    })
    .map({
        value in
        return "users: \(value)"
    })
    .subscribe(onNext: {
        value in
        print(value)
    })

users.value = ["Vivek", "Saurabh"]
users.value = ["Akshit"]


DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
    users.value.append("Shivam")
})







