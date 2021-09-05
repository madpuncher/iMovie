//
//  NetworkingManager.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import Foundation

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    struct Constants {
        static let urlMovies = "https://api.themoviedb.org/3/discover/movie?"
        static let urlTV = "https://api.themoviedb.org/3/discover/tv?"
        static let apiKey = "api_key=31631b72026494daeff5cfeb814438e7"
    }
    
    func fetchMoviesData(completion: @escaping ((Result<[Movie], Error>)) -> Void) {
        guard let url = URL(string: "\(Constants.urlMovies)\(Constants.apiKey)") else {
            completion(.failure(ErrorTypes.badURL))
            print("ERROR GET URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(MovieResponse.self, from: data)
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
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
                return
            }
            
            do {
                let series = try JSONDecoder().decode(SeriesResponse.self, from: data)
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
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
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
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
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
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
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
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
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
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
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
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorTypes.badServerResponse))
                print("ERROR URL RESPONSE")
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

}

enum ErrorTypes: Error {
    case badURL
    case badServerResponse
}
