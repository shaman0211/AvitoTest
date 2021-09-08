//
//  NetworkService.swift
//  AvitoTest
//
//  Created by Artem  on 07.09.2021.
//

import Foundation


protocol NetworkServiceProtocol {
    func getCompanyInfo(completion: @escaping (Companies) -> Void)
}

final class NetworkService {
    
    private let session: URLSession = .shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
}

extension NetworkService: NetworkServiceProtocol {
    func getCompanyInfo(completion: @escaping (Companies) -> Void) {
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        
        guard let url = URL(string: urlString) else { return }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
               print("Network error: \(error.localizedDescription)")
               return
           }

            if let data = data {
                do {
                    let object = try self.decoder.decode(Companies.self, from: data)
                    completion(object)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
    }

}

