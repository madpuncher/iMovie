//
//  SelectedMovieViewModel.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 04.09.2021.
//

import Foundation

class SelectedMovieViewModel {
    
    private var casts = [CastMovie]()
    private var networkManager = NetworkingManager.shared
    
    func getData(id: String, completion: @escaping () -> ()) {
        networkManager.fetchMovieCast(id: id) { [weak self] response in
            switch response {
            case .success(let casts):
                self?.casts = casts
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numbersOfRows() -> Int {
        return casts.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CastMovie {
        return casts[indexPath.item]
    }
}
