//
//  DigestAuth.swift
//  AuthExample
//
//  Created by Alper KARATAŞ on 28/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

typealias NResponse = (data:Data?, response:HTTPURLResponse?, error:Error?)
// MARK: Authentication is handled on the system framework
class Auth:NSObject,URLSessionDataDelegate{
    // MARK:Basic and Digest Authentication
    var username:String = ""
    var password:String = ""
    func auth(urlString:String, username:String , password:String, completion: @escaping (_ result: NResponse) -> Void){
        self.username = username
        self.password = password
        let url = URL(string: urlString)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        session.dataTask(with: url) { data, response, err in
            let nResponse = NResponse(data,response as? HTTPURLResponse,err)
            completion(nResponse)
            }.resume()
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void){
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let proposedCredential = URLCredential(user: username, password: password, persistence: .forSession)
        completionHandler(.useCredential, proposedCredential)
    }
}
