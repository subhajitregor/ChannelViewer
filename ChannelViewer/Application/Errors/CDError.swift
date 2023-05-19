//
//  CDError.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/05/23.
//

import Foundation

enum CDError<T>: Error {
    case noData(for: T)
}

extension CDError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData(let T):
            return "CoreDataService: No Data Found for - \(T.self)"
        }
    }
}
