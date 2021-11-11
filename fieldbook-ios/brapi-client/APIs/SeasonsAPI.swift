//
// SeasonsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class SeasonsAPI {
    /**
     Get the Seasons

     - parameter seasonDbId: (query) The unique identifier for a season. For backward compatibility it can be a string like &#x27;2012&#x27;, &#x27;1957-2004&#x27; (optional)
     - parameter season: (query) The term to describe a given season. Example \&quot;Spring\&quot; OR \&quot;May\&quot; OR \&quot;Planting_Time_7\&quot;. (optional)
     - parameter year: (query) The 4 digit year of a season. Example \&quot;2017\&quot; (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func seasonsGet(seasonDbId: String? = nil, season: String? = nil, year: Int? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil, completion: @escaping ((_ data: SeasonListResponse?,_ error: Error?) -> Void)) {
        seasonsGetWithRequestBuilder(seasonDbId: seasonDbId, season: season, year: year, page: page, pageSize: pageSize, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get the Seasons
     - GET /seasons

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "year" : 2018,
      "seasonName" : "Spring",
      "seasonDbId" : "Spring_2018"
    }, {
      "year" : 2018,
      "seasonName" : "Spring",
      "seasonDbId" : "Spring_2018"
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
     - parameter seasonDbId: (query) The unique identifier for a season. For backward compatibility it can be a string like &#x27;2012&#x27;, &#x27;1957-2004&#x27; (optional)
     - parameter season: (query) The term to describe a given season. Example \&quot;Spring\&quot; OR \&quot;May\&quot; OR \&quot;Planting_Time_7\&quot;. (optional)
     - parameter year: (query) The 4 digit year of a season. Example \&quot;2017\&quot; (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<SeasonListResponse> 
     */
    open class func seasonsGetWithRequestBuilder(seasonDbId: String? = nil, season: String? = nil, year: Int? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil) -> RequestBuilder<SeasonListResponse> {
        let path = "/seasons"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "seasonDbId": seasonDbId, 
                        "season": season, 
                        "year": year?.encodeToJSON(), 
                        "page": page?.encodeToJSON(), 
                        "pageSize": pageSize?.encodeToJSON()
        ])
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SeasonListResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     POST new Seasons

     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func seasonsPost(body: [Season]? = nil, authorization: String? = nil, completion: @escaping ((_ data: SeasonListResponse?,_ error: Error?) -> Void)) {
        seasonsPostWithRequestBuilder(body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     POST new Seasons
     - POST /seasons

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "year" : 2018,
      "seasonName" : "Spring",
      "seasonDbId" : "Spring_2018"
    }, {
      "year" : 2018,
      "seasonName" : "Spring",
      "seasonDbId" : "Spring_2018"
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
     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<SeasonListResponse> 
     */
    open class func seasonsPostWithRequestBuilder(body: [Season]? = nil, authorization: String? = nil) -> RequestBuilder<SeasonListResponse> {
        let path = "/seasons"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SeasonListResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Get the a single Season

     - parameter seasonDbId: (path) The unique identifier for a season. For backward compatibility it can be a string like &#x27;2012&#x27;, &#x27;1957-2004&#x27; 
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func seasonsSeasonDbIdGet(seasonDbId: String, authorization: String? = nil, completion: @escaping ((_ data: SeasonSingleResponse?,_ error: Error?) -> Void)) {
        seasonsSeasonDbIdGetWithRequestBuilder(seasonDbId: seasonDbId, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get the a single Season
     - GET /seasons/{seasonDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "year" : 2018,
    "seasonName" : "Spring",
    "seasonDbId" : "Spring_2018"
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
     - parameter seasonDbId: (path) The unique identifier for a season. For backward compatibility it can be a string like &#x27;2012&#x27;, &#x27;1957-2004&#x27; 
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<SeasonSingleResponse> 
     */
    open class func seasonsSeasonDbIdGetWithRequestBuilder(seasonDbId: String, authorization: String? = nil) -> RequestBuilder<SeasonSingleResponse> {
        var path = "/seasons/{seasonDbId}"
        let seasonDbIdPreEscape = "\(seasonDbId)"
        let seasonDbIdPostEscape = seasonDbIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{seasonDbId}", with: seasonDbIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SeasonSingleResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Update existing Seasons

     - parameter seasonDbId: (path) The unique identifier for a season. For backward compatibility it can be a string like &#x27;2012&#x27;, &#x27;1957-2004&#x27; 
     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func seasonsSeasonDbIdPut(seasonDbId: String, body: Season? = nil, authorization: String? = nil, completion: @escaping ((_ data: SeasonSingleResponse?,_ error: Error?) -> Void)) {
        seasonsSeasonDbIdPutWithRequestBuilder(seasonDbId: seasonDbId, body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Update existing Seasons
     - PUT /seasons/{seasonDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "year" : 2018,
    "seasonName" : "Spring",
    "seasonDbId" : "Spring_2018"
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
     - parameter seasonDbId: (path) The unique identifier for a season. For backward compatibility it can be a string like &#x27;2012&#x27;, &#x27;1957-2004&#x27; 
     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<SeasonSingleResponse> 
     */
    open class func seasonsSeasonDbIdPutWithRequestBuilder(seasonDbId: String, body: Season? = nil, authorization: String? = nil) -> RequestBuilder<SeasonSingleResponse> {
        var path = "/seasons/{seasonDbId}"
        let seasonDbIdPreEscape = "\(seasonDbId)"
        let seasonDbIdPostEscape = seasonDbIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{seasonDbId}", with: seasonDbIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<SeasonSingleResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
}
