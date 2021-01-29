//
//  common.swift
//  BarNote
//
//  Created by Pradyun Setti on 29/01/21.
//

import Foundation
import SwiftUI

struct common {
    static func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM, hh:mm"
        return formatter1.string(from: date)
    }
    
}
