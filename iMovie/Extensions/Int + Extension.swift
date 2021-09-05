//
//  Int + Extension.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.09.2021.
//

import Foundation

//MARK: CONVERT DATE
extension Int {
    
    func secondsToHoursMinutesSeconds() -> String {
        
      return "\((self % 3600) / 60) h \((self % 3600) % 60) min"
    }

}
