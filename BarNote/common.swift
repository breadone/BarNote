//
//  common.swift
//  BarNote
//
//  Created by Pradyun Setti on 29/01/21.
//

import Foundation
import SwiftUI

struct common {
    
    static var colours = [
        "blue",
        "yellow",
        "red",
        "green",
        "orange",
        "purple"
    ]
    static var colourDict = [
        "blue": Color.blue,
        "yellow": Color.yellow,
        "red": Color.red,
        "green": Color.green,
        "orange": Color.orange,
        "purple": Color.purple
    ]
    
    
    static func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM, hh:mm"
        return formatter1.string(from: date)
    }
    
}
