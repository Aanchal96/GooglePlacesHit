//
//  APIController.swift
//  GooglePlacesHit
//
//  Created by Appinventiv on 26/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

class APIController{
    func login(_ query: String,_ key: String,_ success: @escaping (Attributes) -> ()){
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "b5e25086-f75a-474e-978f-44efc5dfbb50"
        ]
        let newStr = query.replacingOccurrences(of: " ", with: "+")
        let baseURL = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(newStr)&key=\(key)"
        
        //MARK:--> Calling Network Manager
        NetworkController().getRequest(baseURL, headers){
            (data) in
            success(Attributes(data))
        }
    }
}
