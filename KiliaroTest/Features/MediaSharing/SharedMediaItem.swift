//
//  SharedMediaItem.swift
//  KiliaroTest
//
//  Created by Ali Baqbani on 6/24/23.
//

import Foundation

struct SharedMediaItem: Codable, Identifiable {
    let id: String
    let userId: String
    let mediaType: String
    let filename: String
    let size: Int64
    let createdAt: Date
    let takenAt: Date?
    let guessedTakenAt: Date?
    let md5sum: String
    let contentType: String
    let video: String?
    let thumbnailUrl: String
    let downloadUrl: String
    let resx: Int
    let resy: Int
}
