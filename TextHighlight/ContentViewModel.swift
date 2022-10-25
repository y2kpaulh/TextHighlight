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
    @Published var colorList: [ColorItem] = []
    let colorItems: [Color] = [.orange, .cyan, .mint]

    init(verseList: [String]) {
        self.verseList = verseList
        
        for item in verseList {
            self.dataSource.append(VerseRow(text: item, selected: false, color: .clear))
        }
        
        for item in colorItems {
            self.colorList.append(ColorItem(color: item, selected: false))
        }
    }
    
    func checkSelectedIndex() {
        for item in dataSource {
            if item.selected {
                if item.color != .clear {
                    for (colorIndex,colorItem) in colorList.enumerated() {
                        if colorItem.color == item.color {
                            colorList[colorIndex].selected = true
                        }
                    }
                }
            }
        }
    }
    
    func changeColorList(colorIndex: Int) {
        // 리스트 색상 변경
        for (index, item) in dataSource.enumerated() {
            if item.selected {
                //현재 하이라이트되지 않은 색상이면 색상 적용
                if item.color == .clear {
                    dataSource[index].color = colorList[colorIndex].color
                } //현재 하이라이트되었는데, 탭한 컬러와 동일한 색상인 경우 색상 삭제
                else if item.color == colorList[colorIndex].color {
                    dataSource[index].color = .clear
                }
                
            }
        }
    }
    
    func resetSelectedItem() {
        for index in dataSource.indices {
            dataSource[index].selected = false
        }
        
        for index in colorList.indices {
            colorList[index].selected = false
        }
    }
}


