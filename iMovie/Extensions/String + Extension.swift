//
//  String + Extension.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.09.2021.
//

import Foundation

extension String {
    
    func convertDate() -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let showDate = inputFormatter.date(from: self) else { return "2020-02-02"}
        
        inputFormatter.dateFormat = "yyyy"
        
        let resultString = inputFormatter.string(from: showDate)
        
        return resultString
    }
}
