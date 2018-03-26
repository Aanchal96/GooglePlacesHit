//
//  Attributes.swift
//  GooglePlacesHit
//
//  Created by Appinventiv on 26/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

class Attributes{
    var name:[String]=[]
    var address:[String]=[]
    var rating:[NSNumber]=[]
    var imageURLS:[String]=[]
    
    init(_ parameters: [String:Any]){
        
        let results = parameters["results"] as! [[String:Any]]
        for result in results{
            for(key,value) in result {
                if key=="name" {
                    self.name.append(value as! String)
                }
                else if key == "rating"{
                    self.rating.append(value as! NSNumber)
                }
                else if key=="formatted_address" {
                    self.address.append(value as! String)
                }
                else if key == "icon" {
                    self.imageURLS.append(value as! String)
                }
            }
        }
    }
}

