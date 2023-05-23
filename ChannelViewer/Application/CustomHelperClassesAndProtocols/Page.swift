//
//  Page.swift
//  ChannelViewer
//
//  Created by subhajit halder on 23/05/23.
//

import Foundation

final class Page {
    private var currentPageNo: Int = 0
    private var limit: Int = 10
    
    var isFetching: Bool = false
    var isLastPageFetched: Bool = false
    
    init(currentPageNo: Int, limit: Int, isFetching: Bool = false, isLastPageFetched: Bool = false) {
        self.currentPageNo = currentPageNo
        self.limit = limit
        self.isFetching = isFetching
        self.isLastPageFetched = isLastPageFetched
    }
    
    func setLimit(to limit: Int) {
        self.limit = limit
    }
    
    func setCurrentPage(to currentPage: Int) {
        self.currentPageNo = currentPage
    }
    
    func startFetching() {
        self.isFetching = true
    }
    
    func fetchComplete() {
        self.isFetching = false
        self.currentPageNo += 1
    }
    
    func nextPageNo() -> Int {
        self.currentPageNo
    }
    
    func maxlimit() -> Int {
        self.limit
    }
    
    func nextOffset() -> Int {
        self.currentOffset() == 0 ? 0 : self.currentOffset() + 1
    }
    
    func currentOffset() -> Int {
        self.currentPageNo * limit
    }
    
    func lastPageFetched() {
        self.isLastPageFetched = true
    }
}
