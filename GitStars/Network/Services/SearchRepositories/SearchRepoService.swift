//
//  SearchRepoService.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

internal typealias Completion = (Result<GitResponse, RepoError>) -> Void

class SearchRepoService: SearchRepoServiceProtocol {
    
    let session = URLSession.shared
    
    func execute(language: String, order: String, page: Int = 1, handler: @escaping Completion) {
        session.configuration.waitsForConnectivity = false
        
        let request: Request = .searchAllRepoByLanguage(language: language, page: page, order: order)
        
        if var baseUrl = URLComponents(string: request.baseURL) {
            baseUrl.query = request.queryParams
            
            guard let url = baseUrl.url else { return }
            
            var requestUrl = URLRequest(url: url.appendingPathComponent(request.path))
            requestUrl.httpMethod = request.method.name
            
            let dataTask = session.dataTask(with: requestUrl) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else {
                    handler(.failure(.error("No response")))
                    self.session.invalidateAndCancel()
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        guard let jsonData = data else { return handler(.failure(.noProcessData)) }
                        
                        let decoder = JSONDecoder()
                        
                        let responseData = try decoder.decode(GitResponse.self, from: jsonData)
                        
                        handler(.success(responseData))
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                    
                } else {
                    handler(.failure(.urlInvalid))
                }
            }
            
            dataTask.resume()
        }
    }
}
