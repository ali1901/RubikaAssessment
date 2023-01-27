//
//  ModelObjects.swift
//  RubikaAssessment
//
//  Created by Yaas Mac on 11/5/1401 AP.
//

import Foundation


struct Response {
    var result: Any?
    var error: Bool
    var errorType: ResponseError?
}

enum ResponseError {
    case connectToServer
    case parseJson
    case nilResponse
}

struct MagicNumbers {
    static var tableViewCornerRadios: CGFloat = 5
    static var tableViewCellHight: CGFloat = 100
    static var embededTableViewCellHight: CGFloat = 50
}

struct CoffeeOrder: Codable {
    var type: String
    var size: String
    var extra: [String: String]?
}
