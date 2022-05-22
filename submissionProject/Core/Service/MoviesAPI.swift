//
//  MoviesAPI.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation

enum MoviesAPI {
    case getMovies(_ page: Int, _ type: String)
    case getMovieDetail(_ id: Int)
    case getMovieReview(_ id: Int)
}

extension MoviesAPI: EndPointType {
    
    var urlRequest: URLRequest {
        switch self {
        case .getMovies(let page, _):
            let fullURL = self.baseUrl.appendingPathComponent(self.path)
            var components =  URLComponents(string: fullURL.absoluteString)
            var params: [String: Any] = [:]
            params["api_key"] = Constant.APIKey
            params["page"] = String(page)
            params["language"] = "en-US"
            components?.queryItems = params.map { (keyAPI, value) in
                URLQueryItem(name: keyAPI, value: value as? String)
            }
            let tempComponent = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            components?.percentEncodedQuery = tempComponent
            return URLRequest(url: (components?.url!)!)
            
        case .getMovieDetail(_):
            let fullURL = self.baseUrl.appendingPathComponent(self.path)
            var components =  URLComponents(string: fullURL.absoluteString)
            var params: [String: Any] = [:]
            params["api_key"] = Constant.APIKey
            components?.queryItems = params.map { (keyAPI, value) in
                URLQueryItem(name: keyAPI, value: value as? String)
            }
            let tempComponent = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            components?.percentEncodedQuery = tempComponent
            return URLRequest(url: (components?.url!)!)
            
        case .getMovieReview(_):
            let fullURL = self.baseUrl.appendingPathComponent(self.path)
            var components =  URLComponents(string: fullURL.absoluteString)
            var params: [String: Any] = [:]
            params["api_key"] = Constant.APIKey
            components?.queryItems = params.map { (keyAPI, value) in
                URLQueryItem(name: keyAPI, value: value as? String)
            }
            let tempComponent = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            components?.percentEncodedQuery = tempComponent
            return URLRequest(url: (components?.url!)!)
        }
    }

    var baseUrl: URL {
        #if TEST
        return URL(string: "https://api.themoviedb.org/3")!
        #else
        return URL(string: "https://api.themoviedb.org/3")!
        #endif
        
    }

    var path: String {
        switch self {
        case .getMovies(_, let type):
            return "/movie/\(type)"
        case .getMovieDetail(let id):
            return "/movie/\(id)"
        case .getMovieReview(let id):
            return "/movie/\(id)/reviews"
        }
    }

}
