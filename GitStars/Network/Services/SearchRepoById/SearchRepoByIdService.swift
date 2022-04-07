//
//  SearchRepoService.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

typealias CompletionRepository = (Result<Any, RepoError>) -> Void

class SearchRepoByIdService: SearchRepoByIdServiceProtocol {
    
    let session = URLSession.shared
    
    func execute(id: Int, datasource: Datasource, handler: @escaping CompletionRepository) {
        
        switch datasource {
        case .coreData:
            getFromCoreData(id: id, handler: handler)
        case .api:
            getFromApi(id: id, handler: handler)
        }
    }
    
    private func getFromApi(id: Int, handler: @escaping CompletionRepository) {
        
        let request: Request = .searchRepoById(id: id)
        
        if var baseUrl = URLComponents(string: "\(request.baseURL)/\(request.path)/\(id)") {
            baseUrl.query = request.queryParams
            
            guard let url = baseUrl.url else { return }
            
            var requestUrl = URLRequest(url: url)
            requestUrl.httpMethod = request.method.name
            
            let dataTask = session.dataTask(with: requestUrl) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                if httpResponse.statusCode == 200 {
                    
                    guard let jsonData = data else { return handler(.failure(.noProcessData)) }
                    
                    let decoder = JSONDecoder()
                    
                    if let responseData = try? decoder.decode(Repo.self, from: jsonData) {
                        
                        handler(.success(responseData))
                    }
                    
                } else if httpResponse.statusCode == 409 {
                    handler(.failure(.urlInvalid))
                }
            }
            
            dataTask.resume()
        }
    }
    
    private func getFromCoreData(id: Int, handler: @escaping CompletionRepository) {
        
        guard let repository = ManagedObjectContext.shared.getRepositoryById(id) else {
            return handler(.failure(.noDataAvailable))
        }
        
        handler(.success(repository))
        
    }
}
