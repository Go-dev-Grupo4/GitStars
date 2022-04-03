//
//  SearchRepoService.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

typealias Completion = (Result<GitResponse, RepoError>) -> Void

class SearchRepoService: SearchRepoServiceProtocol {
    let session = URLSession.shared
    
    func execute(language: String, handler: @escaping Completion) {
        let request: HomeRequest = .searchRepo(language)
        
        if var baseUrl = URLComponents(string: "\(request.baseURL)/\(request.path)") {
            baseUrl.query = request.queryParams
            
            guard let url = baseUrl.url else { return }
            
            var requestUrl = URLRequest(url: url)
            requestUrl.httpMethod = request.method.name
            
            let dataTask = session.dataTask(with: requestUrl) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                if httpResponse.statusCode == 200 {
                    
                    do {
                        guard let jsonData = data else { return handler(.failure(.noProcessData)) }
                        
                        let decoder = JSONDecoder()
                        
                        let responseData = try decoder.decode(GitResponse.self, from: jsonData)
                        
                        handler(.success(responseData))
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                    
                } else if httpResponse.statusCode == 409 {
                    handler(.failure(.urlInvalid))
                }
            }
            
            dataTask.resume()
        }
    }
}