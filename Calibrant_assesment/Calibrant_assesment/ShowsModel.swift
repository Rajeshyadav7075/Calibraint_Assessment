//
//  ShowsModel.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 02/06/21.
//

import Foundation


struct Netflix: Codable {
    let show: Show
}
typealias TVShows = [Netflix]
// MARK: - Show
struct Show: Codable {
    let id: Int
    let name: String
    let image: Image
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case id, name,image, summary
    }
}

// MARK: - Image
struct Image: Codable {
    let medium: String
}




