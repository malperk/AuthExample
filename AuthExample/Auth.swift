//
//  Auth.swift
//  AuthExample
//
//  Created by Alper KARATAŞ on 27/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

// MARK: Basic Authentication handled by user
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

// MARK: Digest Authentication handled by user is ridiculously complex for implement by user you may check example PHP code from https://gist.github.com/funkatron/949952


func getJson(data:Data) throws -> [String: Any] {
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    } catch {
        throw error
    }
}
