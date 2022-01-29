//
//  String+Extension.swift
//  Wordle
//
//  Created by Tom Phillips on 1/29/22.
//

import Foundation

extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}
