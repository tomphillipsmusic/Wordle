//
//  TextLimiter.swift
//  Wordle
//
//  Created by Tom Phillips on 1/29/22.
//

import Foundation
import SwiftUI

struct TextLimiter {
    private let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    var value = "" {
        didSet {
            if value.count > limit {
                value = String(value.prefix(limit))
                hasReachedLimit = true
            } else {
                hasReachedLimit = false
            }
        }
    }
    
    var hasReachedLimit = false
}
