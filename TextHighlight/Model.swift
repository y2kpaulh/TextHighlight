//
//  Model.swift
//  TextHighlight
//
//  Created by Inpyo Hong on 2022/10/20.
//

import Foundation
import SwiftUI

struct VerseRow: Hashable, Equatable {
    var text: String
    var selected: Bool
    var color: Color
}
