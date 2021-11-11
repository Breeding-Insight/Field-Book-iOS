//
// EventsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class EventsAPI {
    /**
     Get the Events

     - parameter studyDbId: (query) Filter based on study unique identifier in which the events occurred (optional)
     - parameter observationUnitDbId: (query) Filter based on an ObservationUnit unique identifier in which the events occurred (optional)
     - parameter eventDbId: (query) Filter based on an Event DbId (optional)
     - parameter eventType: (query) Filter based on an Event Type (optional)
     - parameter dateRangeStart: (query) Filter based on an Date Range (optional)
     - parameter dateRangeEnd: (query) Filter based on an Date Range (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func eventsGet(studyDbId: String? = nil, observationUnitDbId: String? = nil, eventDbId: String? = nil, eventType: String? = nil, dateRangeStart: Date? = nil, dateRangeEnd: Date? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil, completion: @escaping ((_ data: EventsResponse?,_ error: Error?) -> Void)) {
        eventsGetWithRequestBuilder(studyDbId: studyDbId, observationUnitDbId: observationUnitDbId, eventDbId: eventDbId, eventType: eventType, dateRangeStart: dateRangeStart, dateRangeEnd: dateRangeEnd, page: page, pageSize: pageSize, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get the Events
     - GET /events

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "date" : [ "2018-10-08T18:15:11Z", "2018-11-09T18:16:12Z" ],
      "eventDbId" : "8566d4cb",
      "observationUnitDbIds" : [ "8439eaff", "d7682e7a", "305ae51c" ],
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "eventDescription" : "A set of plots was watered",
      "eventParameters" : [ {
        "key" : "http://www.example.fr/vocabulary/2018#hasContact,",
        "value" : "http://www.example.fr/id/agent/marie,",
        "valueRdfType" : "http://xmlns.com/foaf/0.1/Agent,"
      }, {
        "key" : "fertilizer",
        "value" : "nitrogen"
      } ],
      "eventType" : "Watering",
      "eventTypeDbId" : "4e7d691e",
      "studyDbId" : "2cc2001f"
    }, {
      "date" : [ "2018-10-08T18:15:11Z", "2018-11-09T18:16:12Z" ],
      "eventDbId" : "8566d4cb",
      "observationUnitDbIds" : [ "8439eaff", "d7682e7a", "305ae51c" ],
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "eventDescription" : "A set of plots was watered",
      "eventParameters" : [ {
        "key" : "http://www.example.fr/vocabulary/2018#hasContact,",
        "value" : "http://www.example.fr/id/agent/marie,",
        "valueRdfType" : "http://xmlns.com/foaf/0.1/Agent,"
      }, {
        "key" : "fertilizer",
        "value" : "nitrogen"
      } ],
      "eventType" : "Watering",
      "eventTypeDbId" : "4e7d691e",
      "studyDbId" : "2cc2001f"
    } ]
  },
  "metadata" : {
    "pagination" : {
      "totalPages" : 1,
      "pageSize" : 1000,
      "currentPage" : 0,
      "totalCount" : 10
    },
    "datafiles" : [ {
      "fileDescription" : "This is an Excel data file",
      "fileName" : "datafile.xlsx",
      "fileSize" : 4398,
      "fileMD5Hash" : "c2365e900c81a89cf74d83dab60df146",
      "fileURL" : "https://wiki.brapi.org/examples/datafile.xlsx",
      "fileType" : "application/vnd.ms-excel"
    }, {
      "fileDescription" : "This is an Excel data file",
      "fileName" : "datafile.xlsx",
      "fileSize" : 4398,
      "fileMD5Hash" : "c2365e900c81a89cf74d83dab60df146",
      "fileURL" : "https://wiki.brapi.org/examples/datafile.xlsx",
      "fileType" : "application/vnd.ms-excel"
    } ],
    "status" : [ {
      "messageType" : "INFO",
      "message" : "Request accepted, response successful"
    }, {
      "messageType" : "INFO",
      "message" : "Request accepted, response successful"
    } ]
  },
  "@context" : [ "https://brapi.org/jsonld/context/metadata.jsonld" ]
}}]
     - parameter studyDbId: (query) Filter based on study unique identifier in which the events occurred (optional)
     - parameter observationUnitDbId: (query) Filter based on an ObservationUnit unique identifier in which the events occurred (optional)
     - parameter eventDbId: (query) Filter based on an Event DbId (optional)
     - parameter eventType: (query) Filter based on an Event Type (optional)
     - parameter dateRangeStart: (query) Filter based on an Date Range (optional)
     - parameter dateRangeEnd: (query) Filter based on an Date Range (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<EventsResponse> 
     */
    open class func eventsGetWithRequestBuilder(studyDbId: String? = nil, observationUnitDbId: String? = nil, eventDbId: String? = nil, eventType: String? = nil, dateRangeStart: Date? = nil, dateRangeEnd: Date? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil) -> RequestBuilder<EventsResponse> {
        let path = "/events"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "studyDbId": studyDbId, 
                        "observationUnitDbId": observationUnitDbId, 
                        "eventDbId": eventDbId, 
                        "eventType": eventType, 
                        "dateRangeStart": dateRangeStart?.encodeToJSON(), 
                        "dateRangeEnd": dateRangeEnd?.encodeToJSON(), 
                        "page": page?.encodeToJSON(), 
                        "pageSize": pageSize?.encodeToJSON()
        ])
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<EventsResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
}
