//
// ProgramItemsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ProgramItemsAPI {
    /**

     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func programItemsGet(completion: @escaping ((_ data: [ProgramItem]?,_ error: Error?) -> Void)) {
        programItemsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     - GET /ProgramItems
     - 

     - examples: [{contentType=application/json, example=[ {
  "recentAirTime" : {
    "id" : 30716884,
    "channelID" : 302746
  },
  "length" : 60,
  "name" : "Hell Below: Killer Strike",
  "startTime" : "2020-07-09T03:00:00Z"
}, {
  "recentAirTime" : {
    "id" : 30716884,
    "channelID" : 302746
  },
  "length" : 60,
  "name" : "Hell Below: Killer Strike",
  "startTime" : "2020-07-09T03:00:00Z"
} ]}]

     - returns: RequestBuilder<[ProgramItem]> 
     */
    open class func programItemsGetWithRequestBuilder() -> RequestBuilder<[ProgramItem]> {
        let path = "/ProgramItems"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[ProgramItem]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}