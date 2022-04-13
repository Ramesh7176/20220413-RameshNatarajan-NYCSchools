//
//  SchoolResults.swift
//  20220412-RameshNatarajan-NYCSchools
//
//  Created by RAMESH NATARAJAN on 4/12/22.
//

import Foundation

struct SchoolResults: Codable {
    var SchoolData: SchoolDeatils?
}

struct SchoolDeatils: Codable {
    var schoolName: String
    var scoreDetail: [ScoreData]
   
}

struct ScoreData: Codable {
    var reading: String
    var writing: String
    var math: String
}
