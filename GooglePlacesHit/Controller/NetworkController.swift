//
//  NetworkController.swift
//  GooglePlacesHit
//
//  Created by Appinventiv on 26/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

class NetworkController{
    
    //MARK:--> GET Request
    func getRequest(_ url: String,_ headers: [String:String],_ success: @escaping ([String:Any])->Void){
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler:{ (data, response, error) in
            if error != nil{
                print(error as Any)
            }
            else {
                //                let httpResponse = response as? HTTPURLResponse
                //                print(httpResponse as Any)
            }
            do{
                guard let data = data else{return}
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                success(json)
            }
            catch(let error){
                print(error)
            }
        })
        dataTask.resume()
    }
}
