//
//  ContentViewModel.swift
//  TextHighlight
//
//  Created by Inpyo Hong on 2022/10/20.
//

import Foundation
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    var verseList: [String]
    
    @Published var dataSource: [VerseRow] = []
    let colorItems: [Color] = [.orange, .cyan, .mint]

    init(verseList: [String]) {
        self.verseList = verseList
        for item in verseList {
            self.dataSource.append(VerseRow(text: item, selected: false, color: .clear))
        }
    }
    
    func resetSelectedItem() {
        for index in dataSource.indices {
            dataSource[index].selected = false
        }
    }
}


