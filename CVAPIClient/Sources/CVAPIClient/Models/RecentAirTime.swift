//
// RecentAirTime.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct RecentAirTime: Codable {

    public var _id: Int?
    public var channelID: Int?

    public init(_id: Int? = nil, channelID: Int? = nil) {
        self._id = _id
        self.channelID = channelID
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case channelID
    }

}