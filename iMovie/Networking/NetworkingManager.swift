//
//  NetworkingManager.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import Foundation
import SystemConfiguration

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private var cache = URLCache.shared
    private var timeOut: TimeInterval = 3600

    private init() {}
    
    struct Constants {
        static let urlMovies = "https://api.themoviedb.org/3/discover/movie?"
        static let urlTV = "https://api.themoviedb.org/3/discover/tv?"
        static let apiKey = "api_key=31631b72026494daeff5cfeb814438e7"
    }
    
    ///Check connectiont state
    public func isConnectedToNetwork() -> Bool {
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        address.sin_family = sa_family_t(AF_INET)
        
        guard let defaultReach = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultReach, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }
        
        let isReach = flags.contains(.reachable)
        let connect = flags.contains(.connectionRequired)
        
        return (isReach && !connect)
    }
        
    func fetchMoviesData(completion: @escaping ((Result<[Movie], Error>)) -> Void) {
        guard let url = URL(string: "\(Constants.urlMovies)\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: timeOut)
        
        if let cashedRequest = cache.cachedResponse(for: request),
           let time = cashedRequest.userInfo?.first(where: { $0.key as? String == "date" })?.value as? Date,
           time.addingTimeInterval(3600) < Date() {
            cache.removeAllCachedResponses()
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(MovieResponse.self, from: data)
                if let cachedResponse = self.cache.cachedResponse(for: request) {
                    self.cache.storeCachedResponse(cachedResponse, for: request)
                } else {
                    self.cache.storeCachedResponse(CachedURLResponse(response: response!, data: data, userInfo: ["date": Date()], storagePolicy: .allowed), for: request)
                }
                DispatchQueue.main.async {
                    completion(.success(movies.results))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchTVData(completion: @escaping (Result<[Series], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.urlTV)\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: timeOut)
        
        if let cashedRequest = cache.cachedResponse(for: request),
           let time = cashedRequest.userInfo?.first(where: { $0.key as? String == "date" })?.value as? Date,
           time.addingTimeInterval(3600) < Date() {
            cache.removeAllCachedResponses()
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }

            
            do {
                let series = try JSONDecoder().decode(SeriesResponse.self, from: data)
                if let cachedResponse = self.cache.cachedResponse(for: request) {
                    self.cache.storeCachedResponse(cachedResponse, for: request)
                } else {
                    self.cache.storeCachedResponse(CachedURLResponse(response: response!, data: data, userInfo: ["date": Date()], storagePolicy: .allowed), for: request)
                }
                DispatchQueue.main.async {
                    completion(.success(series.results))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchMovieDetail(id: String, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }

            
            do {
                let series = try JSONDecoder().decode(MovieDetailsResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(series))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchSerialDetail(id: String, completion: @escaping (Result<SerialDetailResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)?\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }
            
            do {
                let series = try JSONDecoder().decode(SerialDetailResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(series))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchMovieCast(id: String, completion: @escaping (Result<[CastMovie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }
            
            do {
                let casts = try JSONDecoder().decode(MovieCasts.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(casts.cast))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchSerialCast(id: String, completion: @escaping (Result<[CastSerial], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)/credits?\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }
            
            do {
                let casts = try JSONDecoder().decode(SerialCasts.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(casts.cast))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    //MARK: VIDEO
    func fetchMovieVideo(id: String, completion: @escaping (Result<String?, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/watch/providers?\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }

            
            do {
                let video = try JSONDecoder().decode(MovieVideo.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(video.results.us.link))
                }
                
            } catch let error {
                print(error.localizedDescription)
                completion(.success(""))
            }
        }
        .resume()
    }
    
    func fetchSerialVideo(id: String, completion: @escaping (Result<String?, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)/watch/providers?\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
 
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, self.dataHandle(response: response, error: error) else {
                completion(.failure(ErrorTypes.badServerResponse))
                return
            }

            
            do {
                let video = try JSONDecoder().decode(SerieVideo.self, from: data)
           
                DispatchQueue.main.async {
                    completion(.success(video.results.us.link))
                }
                
            } catch let error {
                print(error.localizedDescription)
                completion(.success(""))
            }
        }
        .resume()
    }

    ///CHECKER && HANDLER FOR ERROR AND RESPONSE
    private func dataHandle(response: URLResponse?, error: Error?) -> Bool {
        guard
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("ERROR URL RESPONSE")
            return false
        }
        return true
    }
}

enum ErrorTypes: Error {
    case badURL
    case badServerResponse
}
