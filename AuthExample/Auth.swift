//
//  Auth.swift
//  AuthExample
//
//  Created by Alper KARATAŞ on 27/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

typealias NResponse = (data:Data?, response:HTTPURLResponse?, error:Error?)
func basicAuth(username:String , password:String, completion: @escaping (_ result: NResponse) -> Void){
    let loginString = String(format: "%@:%@", username, password)
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
    
    let url = URL(string: "https://httpbin.org/basic-auth/user/passwd")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    session.dataTask(with: request) {data, response, err in
        let nResponse = NResponse(data,response as? HTTPURLResponse,err)
        completion(nResponse)
        }.resume()
    
}

func getJson(data:Data) throws -> [String: Any] {
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    } catch {
        throw error
    }
}

//if let unwrappedData = resp.0{
//    do{
//        
//        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
//    }catch let error{
//        print (error)
//    }
//}
