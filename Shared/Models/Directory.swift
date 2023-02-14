//
//  Directory.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

struct Directory: Codable, Identifiable, Equatable {
    
    let id: String
    let parentId: String
    let name: String
    let isDir: Bool // TODO: Improve variable name to isDirectory
    let modificationDate: Date
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.formattedDate
        return dateFormatter.string(from: modificationDate)
    }
    
    var systemImageName: String {
        isDir ? "folder" : "photo"
    }
}
