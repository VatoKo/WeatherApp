//
//  Fetcher.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 17.08.21.
//

import Foundation

class Fetcher<ResponseObject: Decodable> {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch(completion: @escaping (_ result: Result<ResponseObject, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(NoDataError()))
                return
            }
            if let response = try? JSONDecoder().decode(ResponseObject.self, from: data) {
                completion(.success(response))
            } else {
                completion(.failure(ParsingError()))
            }
        }

        task.resume()
    }
    
    
}

struct NoDataError: Error {
    
}

struct ParsingError: Error {
    
}
