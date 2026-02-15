//
//  RSSNodeViewModel.swift
//  qBitControl
//

import SwiftUI

class RSSNodeViewModel: ObservableObject {
    static public let shared = RSSNodeViewModel()
    
    @Published public var rssRootNode: RSSNode = .init()
    @Published public var isSheetPresented: Bool = false
    private var timer: Timer?
    
    init() {
        self.getRssRootNode()
        self.startTimer()
    }
    
    deinit {
        self.stopTimer()
    }
    
    func startTimer() { 
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            // Skip refresh when a sheet is presented to prevent view recreation
            guard !self.isSheetPresented else { return }
            self.getRssRootNode()
        }
    }
    
    func stopTimer() { 
        timer?.invalidate() 
    }
    
    func getRssRootNode() {
        qBittorrent.getRSSFeeds(completionHandler: { RSSNode in
            DispatchQueue.main.async {
                self.rssRootNode = RSSNode
            }
        })
    }
}

