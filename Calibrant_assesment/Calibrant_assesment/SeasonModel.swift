//
//  SeasonModel.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 04/06/21.
//

import Foundation

// MARK: - Name
struct Season: Codable {
    let id: Int
    let name: String
    let episodeOrder: Int

    enum CodingKeys: String, CodingKey {
        case id, name, episodeOrder
    }
}

typealias Seasons = [Season]
