//
//  MovieViewModel.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import Foundation

class MovieViewModel {
    
    private var movies = [Movie]()
    private var networkManager = NetworkingManager.shared
    
    func getData(completion: @escaping () -> ()) {
        networkManager.fetchMoviesData { [weak self] response in
            switch response {
            case .success(let moviesResponse):
                self?.movies = moviesResponse
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numbersOfRows() -> Int {
        return movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return movies[indexPath.item]
    }
}
