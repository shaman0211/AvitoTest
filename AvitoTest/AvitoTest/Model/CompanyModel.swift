//
//  CompanyModel.swift
//  AvitoTest
//
//  Created by Artem  on 07.09.2021.
//

import Foundation

struct Companies: Decodable {
    var company: Company
}

struct Company: Decodable {
    var name: String
    var employees: [Employee]
}

struct Employee: Decodable {
    var name: String
    var phoneNumber: String
    var skills: [String]
}
