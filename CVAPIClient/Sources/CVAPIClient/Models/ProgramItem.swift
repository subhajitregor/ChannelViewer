//
// ProgramItem.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ProgramItem: Codable {

    public var startTime: String?
    public var recentAirTime: RecentAirTime?
    public var length: Int?
    public var name: String?

    public init(startTime: String? = nil, recentAirTime: RecentAirTime? = nil, length: Int? = nil, name: String? = nil) {
        self.startTime = startTime
        self.recentAirTime = recentAirTime
        self.length = length
        self.name = name
    }


}