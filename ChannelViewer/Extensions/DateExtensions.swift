//
//  DateExtensions.swift
//  ChannelViewer
//
//  Created by subhajit halder on 23/05/23.
//

import Foundation

extension Date {
    enum Format: String {
        case hhmma = "hh:mm a"
        case MMd = "MM d"
        case fullCompact = "MM d, hh: mm a"
    }
    
    func toString(format: Format) -> String {
        let ds = DateFormatter()
        ds.locale = .current
        ds.timeZone = .current
        ds.dateFormat = format.rawValue
        ds.amSymbol = "AM"
        ds.pmSymbol = "PM"
        return ds.string(from: self)
    }
}
