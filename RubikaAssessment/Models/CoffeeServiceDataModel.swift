//
//  CoffeeServiceDataModel.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import Foundation

struct CoffeeServiceDataModel: Codable {
    let id: String
    let types: [CoffeeType]
    let sizes: [CoffeeSize]
    let extras: [CoffeeExtra]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case types, sizes, extras
    }
}

struct CoffeeType: Codable {
    let id: String
    let name: String
    let sizes: [String]
    let extras: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, sizes, extras
    }
}

struct CoffeeSize: Codable {
    let id: String
    let name: String
    let v: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case v = "__v"
    }
}

struct CoffeeExtra: Codable {
    let id: String
    let name: String
    let subselections: [CoffeeExtraSubselectoin]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, subselections
    }
}

struct CoffeeExtraSubselectoin: Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
