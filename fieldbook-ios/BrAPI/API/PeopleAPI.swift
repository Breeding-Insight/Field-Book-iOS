//
// PeopleAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class PeopleAPI {
    private let brAPIClientAPI: BrAPIClientAPI
    
    init(brAPIClientAPI: BrAPIClientAPI) {
        self.brAPIClientAPI = brAPIClientAPI;
    }
    
    /**
     Get filtered list of People

     - parameter firstName: (query) A persons first name (optional)
     - parameter lastName: (query) A persons last name (optional)
     - parameter personDbId: (query) The unique ID of a person (optional)
     - parameter userID: (query) A systems user ID associated with this person. Different from personDbId because you could have a person who is not a user of the system. (optional)
     - parameter externalReferenceID: (query) An external reference ID. Could be a simple string or a URI. (use with &#x60;externalReferenceSource&#x60; parameter) (optional)
     - parameter externalReferenceSource: (query) An identifier for the source system or database of an external reference (use with &#x60;externalReferenceID&#x60; parameter) (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func peopleGet(firstName: String? = nil, lastName: String? = nil, personDbId: String? = nil, userID: String? = nil, externalReferenceID: String? = nil, externalReferenceSource: String? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIPersonListResponse?,_ error: Error?) -> Void)) {
        peopleGetWithRequestBuilder(firstName: firstName, lastName: lastName, personDbId: personDbId, userID: userID, externalReferenceID: externalReferenceID, externalReferenceSource: externalReferenceSource, page: page, pageSize: pageSize, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get filtered list of People
     - GET /people

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
    }, {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
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
     - parameter firstName: (query) A persons first name (optional)
     - parameter lastName: (query) A persons last name (optional)
     - parameter personDbId: (query) The unique ID of a person (optional)
     - parameter userID: (query) A systems user ID associated with this person. Different from personDbId because you could have a person who is not a user of the system. (optional)
     - parameter externalReferenceID: (query) An external reference ID. Could be a simple string or a URI. (use with &#x60;externalReferenceSource&#x60; parameter) (optional)
     - parameter externalReferenceSource: (query) An identifier for the source system or database of an external reference (use with &#x60;externalReferenceID&#x60; parameter) (optional)
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<BrAPIPersonListResponse>
     */
    open func peopleGetWithRequestBuilder(firstName: String? = nil, lastName: String? = nil, personDbId: String? = nil, userID: String? = nil, externalReferenceID: String? = nil, externalReferenceSource: String? = nil, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIPersonListResponse> {
        let path = "/people"
        let URLString = brAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "firstName": firstName, 
                        "lastName": lastName, 
                        "personDbId": personDbId, 
                        "userID": userID, 
                        "externalReferenceID": externalReferenceID, 
                        "externalReferenceSource": externalReferenceSource, 
                        "page": page?.encodeToJSON(), 
                        "pageSize": pageSize?.encodeToJSON()
        ])
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIPersonListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Get the details for a specific Person

     - parameter personDbId: (path) The unique ID of a person 
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func peoplePersonDbIdGet(personDbId: String, authorization: String? = nil, completion: @escaping ((_ data: BrAPIPersonSingleResponse?,_ error: Error?) -> Void)) {
        peoplePersonDbIdGetWithRequestBuilder(personDbId: personDbId, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get the details for a specific Person
     - GET /people/{personDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "firstName" : "Bob",
    "lastName" : "Robertson",
    "emailAddress" : "bob@bob.com",
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
    "personDbId" : "14340a54",
    "phoneNumber" : "+1-555-555-5555",
    "mailingAddress" : "123 Street Ave, City, State, Country",
    "additionalInfo" : {
      "key" : "additionalInfo"
    },
    "description" : "Bob likes pina coladas and getting caught in the rain.",
    "middleName" : "Danger",
    "userID" : "bob-23"
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
     - parameter personDbId: (path) The unique ID of a person 
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<BrAPIPersonSingleResponse>
     */
    open func peoplePersonDbIdGetWithRequestBuilder(personDbId: String, authorization: String? = nil) -> RequestBuilder<BrAPIPersonSingleResponse> {
        var path = "/people/{personDbId}"
        let personDbIdPreEscape = "\(personDbId)"
        let personDbIdPostEscape = personDbIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{personDbId}", with: personDbIdPostEscape, options: .literal, range: nil)
        let URLString = brAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIPersonSingleResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Update an existing Person

     - parameter personDbId: (path) The unique ID of a person 
     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func peoplePersonDbIdPut(personDbId: String, body: BrAPIPersonNewRequest? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIPersonSingleResponse?,_ error: Error?) -> Void)) {
        peoplePersonDbIdPutWithRequestBuilder(personDbId: personDbId, body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Update an existing Person
     - PUT /people/{personDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "firstName" : "Bob",
    "lastName" : "Robertson",
    "emailAddress" : "bob@bob.com",
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
    "personDbId" : "14340a54",
    "phoneNumber" : "+1-555-555-5555",
    "mailingAddress" : "123 Street Ave, City, State, Country",
    "additionalInfo" : {
      "key" : "additionalInfo"
    },
    "description" : "Bob likes pina coladas and getting caught in the rain.",
    "middleName" : "Danger",
    "userID" : "bob-23"
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
     - parameter personDbId: (path) The unique ID of a person 
     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)

     - returns: RequestBuilder<BrAPIPersonSingleResponse>
     */
    open func peoplePersonDbIdPutWithRequestBuilder(personDbId: String, body: BrAPIPersonNewRequest? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIPersonSingleResponse> {
        var path = "/people/{personDbId}"
        let personDbIdPreEscape = "\(personDbId)"
        let personDbIdPostEscape = personDbIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{personDbId}", with: personDbIdPostEscape, options: .literal, range: nil)
        let URLString = brAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIPersonSingleResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Create new People

     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func peoplePost(body: [BrAPIPersonNewRequest]? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIPersonListResponse?,_ error: Error?) -> Void)) {
        peoplePostWithRequestBuilder(body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Create new People
     - POST /people

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
    }, {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
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

     - returns: RequestBuilder<BrAPIPersonListResponse>
     */
    open func peoplePostWithRequestBuilder(body: [BrAPIPersonNewRequest]? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIPersonListResponse> {
        let path = "/people"
        let URLString = brAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIPersonListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Submit a search request for `People`

     - parameter body: (body)  (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func searchPeoplePost(body: BrAPIPersonSearchRequest? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIPersonListResponse?,_ error: Error?) -> Void)) {
        searchPeoplePostWithRequestBuilder(body: body, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Submit a search request for `People`
     - POST /search/people

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
    }, {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
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

     - returns: RequestBuilder<BrAPIPersonListResponse>
     */
    open func searchPeoplePostWithRequestBuilder(body: BrAPIPersonSearchRequest? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIPersonListResponse> {
        let path = "/search/people"
        let URLString = brAPIClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<BrAPIPersonListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Get the results of a `People` search request

     - parameter searchResultsDbId: (path) Unique identifier which references the search results 
     - parameter page: (query) Used to request a specific page of data to be returned.  The page indexing starts at 0 (the first page is &#x27;page&#x27;&#x3D; 0). Default is &#x60;0&#x60;. (optional)
     - parameter pageSize: (query) The size of the pages to be returned. Default is &#x60;1000&#x60;. (optional)
     - parameter authorization: (header) HTTP HEADER - Token used for Authorization   &lt;strong&gt; Bearer {token_string} &lt;/strong&gt; (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func searchPeopleSearchResultsDbIdGet(searchResultsDbId: String, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil, completion: @escaping ((_ data: BrAPIPersonListResponse?,_ error: Error?) -> Void)) {
        searchPeopleSearchResultsDbIdGetWithRequestBuilder(searchResultsDbId: searchResultsDbId, page: page, pageSize: pageSize, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get the results of a `People` search request
     - GET /search/people/{searchResultsDbId}

     - :
       - type: http
       - name: AuthorizationToken
     - examples: [{contentType=application/json, example={
  "result" : {
    "data" : [ {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
    }, {
      "firstName" : "Bob",
      "lastName" : "Robertson",
      "emailAddress" : "bob@bob.com",
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
      "personDbId" : "14340a54",
      "phoneNumber" : "+1-555-555-5555",
      "mailingAddress" : "123 Street Ave, City, State, Country",
      "additionalInfo" : {
        "key" : "additionalInfo"
      },
      "description" : "Bob likes pina coladas and getting caught in the rain.",
      "middleName" : "Danger",
      "userID" : "bob-23"
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

     - returns: RequestBuilder<BrAPIPersonListResponse>
     */
    open func searchPeopleSearchResultsDbIdGetWithRequestBuilder(searchResultsDbId: String, page: Int? = nil, pageSize: Int? = nil, authorization: String? = nil) -> RequestBuilder<BrAPIPersonListResponse> {
        var path = "/search/people/{searchResultsDbId}"
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

        let requestBuilder: RequestBuilder<BrAPIPersonListResponse>.Type = BrAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(brAPIClientAPI: brAPIClientAPI, method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
}
