//
//  RSSFeed.swift
//  qBitControl
//

import Foundation

struct RSSFeed: Decodable, Identifiable {
    let url: String?
    let uid: String?
    let isLoading: Bool?
    let title: String
    let hasError: Bool?
    let articles: [Article]
    
    // Use stable identifier: uid from API, or fallback to title
    var id: String { uid ?? title }
    
    struct Article: Decodable, Identifiable {
        let category: String?
        let title: String?
        let date: String?
        let link: String?
        let size: String?
        let torrentURL: String?
        let isRead: Bool?
        
        // Use stable identifier: torrentURL, link, or title
        // This prevents SwiftUI from recreating views when @State changes
        var id: String { torrentURL ?? link ?? title ?? UUID().uuidString }
        
        var description: String? {
            var components: [String] = []
            if let category = self.category { components.append(category) }
            if let size = self.size { components.append(size) }
            
            let result = components.joined(separator: " • ")
            return result.isEmpty ? nil : result
        }
    }
}

