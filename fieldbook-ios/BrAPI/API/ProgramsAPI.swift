//
// ProgramsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class ProgramsAPI {
    private let brAPIClientAPI: BrAPIClientAPI
    
    init(brAPIClientAPI: BrAPIClientAPI) {
        self.brAPIClientAPI = brAPIClientAPI;
    }
    
    /**
     Get a filtered list of breeding Programs

     - parameter commonCropName: (query) Filter by the common crop name. Exact match. (optional)
     - parameter programDbId: (query) Program filter to only return trials associated with given program id. (optional)
     - parameter programName: (query) Filter by program name. Exact match. (optional)
     - parameter abbreviation: (query) Filter by program abbreviation. Exact match. (optional)
     - parameter externalReferenceID: (query) An external reference ID. Could be a simple string or a URI. (use with &#x60;externalReferenceSource&#x60; parameter) (optional)
     - parameter externalReferenceSource: (query) An identifier for the source system or database of an external reference (use with &#x60;externalReferenceID&#x60; parameter) (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func programsGet(commonCropName: String? = nil, programDbId: String? = nil, programName: String? = nil, abbreviation: String? = nil, externalReferenceID: String? = nil, externalReferenceSource: String? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIProgramListResponse?,_ error: Error?) -> Void)) {
        programsGetWithRequestBuilder(commonCropName: commonCropName, programDbId: programDbId, programName: programName, abbreviation: abbreviation, externalReferenceID: externalReferenceID, externalReferenceSource: externalReferenceSource, page: page, pageSize: pageSize, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get a filtered list of breeding Programs
     - GET /programs

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
    }, {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
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
     - parameter commonCropName: (query) Filter by the common crop name. Exact match. (optional)
     - parameter programDbId: (query) Program filter to only return trials associated with given program id. (optional)
     - parameter programName: (query) Filter by program name. Exact match. (optional)
     - parameter abbreviation: (query) Filter by program abbreviation. Exact match. (optional)
     - parameter externalReferenceID: (query) An external reference ID. Could be a simple string or a URI. (use with &#x60;externalReferenceSource&#x60; parameter) (optional)
     - parameter externalReferenceSource: (query) An identifier for the source system or database of an external reference (use with &#x60;externalReferenceID&#x60; parameter) (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<BrAPIProgramListResponse>
     */
    open func programsGetWithRequestBuilder(commonCropName: String? = nil, programDbId: String? = nil, programName: String? = nil, abbreviation: String? = nil, externalReferenceID: String? = nil, externalReferenceSource: String? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIProgramListResponse> {
        let path = "/programs"
        let URLString = brAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "commonCropName": commonCropName, 
                        "programDbId": programDbId, 
                        "programName": programName, 
                        "abbreviation": abbreviation, 
                        "externalReferenceID": externalReferenceID, 
                        "externalReferenceSource": externalReferenceSource, 
                        "page": page?.encodeToJSON(), 
                        "pageSize": pageSize?.encodeToJSON()
        ])
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIProgramListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Add new breeding Programs to the database

     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func programsPost(body: [BrAPIProgramNewRequest]? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIProgramListResponse?,_ error: Error?) -> Void)) {
        programsPostWithRequestBuilder(body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add new breeding Programs to the database
     - POST /programs

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
    }, {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
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

     - returns: RequestBuilder<BrAPIProgramListResponse>
     */
    open func programsPostWithRequestBuilder(body: [BrAPIProgramNewRequest]? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIProgramListResponse> {
        let path = "/programs"
        let URLString = brAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIProgramListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Get a breeding Program by Id

     - parameter programDbId: (path) Filter by the common crop name. Exact match. 
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func programsProgramDbIdGet(programDbId: String, authorization: String? = nil, completion: @escaping ((_ data: BrAPIProgramSingleResponse?,_ error: Error?) -> Void)) {
        programsProgramDbIdGetWithRequestBuilder(programDbId: programDbId, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get a breeding Program by Id
     - GET /programs/{programDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "commonCropName" : "Tomatillo",
    "documentationURL" : "https://wiki.brapi.org",
    "externalReferences" : [ {
      "referenceID" : "doi:10.155454/12341234",
      "referenceSource" : "DOI"
    }, {
      "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
      "referenceSource" : "OBO Library"
    }, {
      "referenceID" : "75a50e76",
      "referenceSource" : "Remote Data Collection Upload Tool"
    } ],
    "leadPersonName" : "Bob Robertson",
    "programName" : "Tomatillo_Breeding_Program",
    "additionalInfo" : {
      "key" : "additionalInfo"
    },
    "programDbId" : "f60f15b2",
    "abbreviation" : "P1",
    "leadPersonDbId" : "fe6f5c50",
    "objective" : "Make a better tomatillo"
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
     - parameter programDbId: (path) Filter by the common crop name. Exact match. 
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<BrAPIProgramSingleResponse>
     */
    open func programsProgramDbIdGetWithRequestBuilder(programDbId: String, authorization: String? = nil) -> RequestBuilder<BrAPIProgramSingleResponse> {
        var path = "/programs/{programDbId}"
        let programDbIdPreEscape = "\(programDbId)"
        let programDbIdPostEscape = programDbIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{programDbId}", with: programDbIdPostEscape, options: .literal, range: nil)
        let URLString = brAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIProgramSingleResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Update an existing Program

     - parameter programDbId: (path) Filter by the common crop name. Exact match. 
     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func programsProgramDbIdPut(programDbId: String, body: BrAPIProgramNewRequest? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIProgramSingleResponse?,_ error: Error?) -> Void)) {
        programsProgramDbIdPutWithRequestBuilder(programDbId: programDbId, body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Update an existing Program
     - PUT /programs/{programDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "commonCropName" : "Tomatillo",
    "documentationURL" : "https://wiki.brapi.org",
    "externalReferences" : [ {
      "referenceID" : "doi:10.155454/12341234",
      "referenceSource" : "DOI"
    }, {
      "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
      "referenceSource" : "OBO Library"
    }, {
      "referenceID" : "75a50e76",
      "referenceSource" : "Remote Data Collection Upload Tool"
    } ],
    "leadPersonName" : "Bob Robertson",
    "programName" : "Tomatillo_Breeding_Program",
    "additionalInfo" : {
      "key" : "additionalInfo"
    },
    "programDbId" : "f60f15b2",
    "abbreviation" : "P1",
    "leadPersonDbId" : "fe6f5c50",
    "objective" : "Make a better tomatillo"
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
     - parameter programDbId: (path) Filter by the common crop name. Exact match. 
     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<BrAPIProgramSingleResponse>
     */
    open func programsProgramDbIdPutWithRequestBuilder(programDbId: String, body: BrAPIProgramNewRequest? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIProgramSingleResponse> {
        var path = "/programs/{programDbId}"
        let programDbIdPreEscape = "\(programDbId)"
        let programDbIdPostEscape = programDbIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{programDbId}", with: programDbIdPostEscape, options: .literal, range: nil)
        let URLString = brAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIProgramSingleResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Submit a search request for `Programs`

     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func searchProgramsPost(body: BrAPIProgramSearchRequest? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIProgramListResponse?,_ error: Error?) -> Void)) {
        searchProgramsPostWithRequestBuilder(body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Submit a search request for `Programs`
     - POST /search/programs

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
    }, {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
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

     - returns: RequestBuilder<BrAPIProgramListResponse>
     */
    open func searchProgramsPostWithRequestBuilder(body: BrAPIProgramSearchRequest? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIProgramListResponse> {
        let path = "/search/programs"
        let URLString = brAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIProgramListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Get the results of a `Programs` search request

     - parameter searchResultsDbId: (path) Unique identifier which references the search results 
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func searchProgramsSearchResultsDbIdGet(searchResultsDbId: String, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIProgramListResponse?,_ error: Error?) -> Void)) {
        searchProgramsSearchResultsDbIdGetWithRequestBuilder(searchResultsDbId: searchResultsDbId, page: page, pageSize: pageSize, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get the results of a `Programs` search request
     - GET /search/programs/{searchResultsDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
    }, {
      "commonCropName" : "Tomatillo",
      "documentationURL" : "https://wiki.brapi.org",
      "externalReferences" : [ {
        "referenceID" : "doi:10.155454/12341234",
        "referenceSource" : "DOI"
      }, {
        "referenceID" : "http://purl.obolibrary.org/obo/ro.owl",
        "referenceSource" : "OBO Library"
      }, {
        "referenceID" : "75a50e76",
        "referenceSource" : "Remote Data Collection Upload Tool"
      } ],
      "leadPersonName" : "Bob Robertson",
      "programName" : "Tomatillo_Breeding_Program",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "programDbId" : "f60f15b2",
      "abbreviation" : "P1",
      "leadPersonDbId" : "fe6f5c50",
      "objective" : "Make a better tomatillo"
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
     - parameter searchResultsDbId: (path) Unique identifier which references the search results 
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<BrAPIProgramListResponse>
     */
    open func searchProgramsSearchResultsDbIdGetWithRequestBuilder(searchResultsDbId: String, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIProgramListResponse> {
        var path = "/search/programs/{searchResultsDbId}"
        let searchResultsDbIdPreEscape = "\(searchResultsDbId)"
        let searchResultsDbIdPostEscape = searchResultsDbIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{searchResultsDbId}", with: searchResultsDbIdPostEscape, options: .literal, range: nil)
        let URLString = brAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "page": page?.encodeToJSON(), 
                        "pageSize": pageSize?.encodeToJSON()
        ])
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIProgramListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
}
