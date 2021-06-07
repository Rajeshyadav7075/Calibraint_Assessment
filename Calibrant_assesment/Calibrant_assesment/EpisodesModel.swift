//
//  EpisodesModel.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 02/06/21.
//

import Foundation

// MARK: - Name
struct Episode: Codable {
    let id: Int
    let name: String
    let runtime: Int?
}

typealias Episodes = [Episode]

