//
//  RSSArticleView.swift
//  qBitControl
//

import SwiftUI

struct RSSArticleView: View {
    let article: RSSFeed.Article
    @State private var isTorrentAddSheet: Bool = false
    
    var body: some View {
        Button { isTorrentAddSheet.toggle() } label: {
            VStack {
                HStack { 
                    Text(article.title ?? "No Title")
                        .lineLimit(2)
                    Spacer() 
                }
                if let description = article.description {
                    HStack(spacing: 3) {
                        Text(description)
                        Spacer()
                    }
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .lineLimit(1)
                }
            }
            .foregroundColor(.primary)
        }
        .sheet(isPresented: $isTorrentAddSheet) {
            if let urlString = article.torrentURL ?? article.link,
               let url = URL(string: urlString) {
                TorrentAddView(torrentUrls: .constant([url]))
            } else {
                // Handle invalid URL case - show error message
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundColor(.orange)
                    
                    Text("Invalid Torrent URL")
                        .font(.headline)
                    
                    if let urlString = article.torrentURL ?? article.link {
                        Text(urlString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    } else {
                        Text("No URL available for this article")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Close") {
                        isTorrentAddSheet = false
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .presentationDetents([.height(200)])
            }
        }
    }
}
