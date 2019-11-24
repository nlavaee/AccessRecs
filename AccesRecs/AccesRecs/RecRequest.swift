//
//  RecRequest.swift
//  AccesRecs
//
//  Created by Amaris Sim on 11/23/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation

struct RecsResponse: Decodable{
    var response: RecsList
}

struct RecsList: Decodable{
    var reclst: [RecsDetail]
}

struct RecsDetail: Decodable {
    var feature_id: Int
    var feature_name: String
    var cat: String
    var rec_id: Int
    var rec_name:String
    var rec_num:Int
}

enum RecsError:Error{
    case noDataAvailable
    case canNotProcessData
}

struct RecsRequest {
    let resourceURL:URL
    init (featid:Int){
        let resourceString = "https://eecs495-recsys.herokuapp.com/api/get_recs/\(featid)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getRecs(completion: @escaping(Result<[RecsDetail], RecsError>) -> Void){
        let task = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let recsResponse = try decoder.decode(RecsResponse.self, from: jsonData)
                let recDetails = recsResponse.response.reclst
                completion(.success(recDetails))
            } catch{
                completion(.failure(.canNotProcessData))
            }
        }
        task.resume()
    }
}

//let session = URLSession.shared
//let url = URL(string: "https://eecs495-recsys.herokuapp.com/api/get_recs/5")!
//var rec_lst = [String]()
//
//let task = session.dataTask(with: url) { data, response, error in
//
//    if error != nil || data == nil {
//        print("Client error!")
//        return
//    }
//
//    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//        print("Server error!")
//        return
//    }
//
//    guard let mime = response.mimeType, mime == "application/json" else {
//        print("Wrong MIME type!")
//        return
//    }
//
//    do {
//        let json = try JSONSerialization.jsonObject(with: data!, options: [])
//        print(json)
//        if (json != nil){
//            guard let jsonArray = data as? [[String: Any]] else {
//                  return
//            }
//            for dic in jsonArray{
//                guard let rec = dic["rec_name"] as? String else { return }
//                rec_lst.append(rec)
//            }
//            print(rec_lst)
//        }
//
//    } catch {
//        print("JSON error: \(error.localizedDescription)")
//    }
//}
