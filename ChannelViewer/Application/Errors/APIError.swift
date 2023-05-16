//
//  APIError.swift
//  ChannelViewer
//
//  Created by subhajit halder on 16/05/23.
//

import Foundation

enum APIError: Error {
    case unknown
    case noData
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .unknown:
            return "Unknown error occured while fetching api."
        case .noData:
            return "Absence of data where expected."
        }
    }
}
