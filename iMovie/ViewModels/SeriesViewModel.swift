//
//  SeriesViewModel.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import Foundation

class SeriesViewModel {
    
    private var series = [Series]()
    private var networkManager = NetworkingManager.shared
    
    func getData(completion: @escaping () -> ()) {
        networkManager.fetchTVData { [weak self] response in
            switch response {
            case .success(let seriesResponse):
                self?.series = seriesResponse
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numbersOfRows() -> Int {
        return series.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Series {
        return series[indexPath.item]
    }
}
