//
//  Color+Extension.swift
//  Wordle
//
//  Created by Tom Phillips on 1/28/22.
//

import SwiftUI

extension Color {
    public static var wrongLocation: Color {
        return Color("WrongLocation", bundle: nil)
    }
    
    public static var notUsed: Color {
        return Color("NotUsed", bundle: nil)
    }
    
    public static var correct: Color {
        return Color("Correct", bundle: nil)
    }
}
