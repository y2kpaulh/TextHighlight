//
//  ColorPickerView.swift
//  TextHighlight
//
//  Created by Inpyo Hong on 2022/10/20.
//

import SwiftUI

struct ColorPickerView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @Binding var isPresent: Bool
    @Binding var selectedIndex: Int
    @State private var selectedColor: Color = .clear
    
    var body: some View {
        HStack {
            Button {
                print("tap close btn")
                isPresent = false
            } label: {
//                    Rectangle()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.black)
//                        .cornerRadius(30/2)
//                        .overlay {
//                            Image(systemName: "xmark")
//                                .foregroundColor(.white)
//                        }
//                        .shadow(radius: 2)
                
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 15, height: 15)
                  
            }
            .frame(width: 30, height: 30)

            Spacer()
                .frame(width: 20)
            
            Button {
                print("tap copy btn")
                
            } label: {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .overlay {
                        Image(systemName: "doc.on.doc")
                            .resizable()
                            .frame(width: 15,height: 15)
                            .foregroundColor(.white)
                    }
                // .shadow(radius: 2)
            }

            Button {
                print("tap share btn")
                
            } label: {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .overlay {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 14,height: 16)
                            .foregroundColor(.white)
                    }
                // .shadow(radius: 2)
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(viewModel.colorList.enumerated()), id: \.offset) { colorIndex, colorItem in
                        Button {
                            print("tap index: \(colorIndex), item: \(colorItem) btn")                            
                            viewModel.changeColorList(colorIndex: colorIndex)
                            viewModel.resetSelectedItem()
                        } label: {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(viewModel.colorItems[colorIndex])
                        }
                        .overlay {
                            if colorItem.selected {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .frame(width: 110)
        }
        //.frame(width: UIScreen.main.bounds.width - 100)
        .padding(10)
        .background(.regularMaterial)
        .cornerRadius(24)
        .shadow(radius: 4)
        .onChange(of: viewModel.dataSource, perform: { _ in
            if viewModel.dataSource[selectedIndex].color != .clear {
                selectedColor = viewModel.dataSource[selectedIndex].color
            }
            
            for item in viewModel.dataSource {
                if item.selected {
                    if item.color != .clear {
                        for (colorIndex,colorItem) in viewModel.colorList.enumerated() {
                            if colorItem.color == item.color {
                                viewModel.colorList[colorIndex].selected = true
                            }
                        }
                    }
                }
            }
        })
        .onAppear() {
            if viewModel.dataSource[selectedIndex].color != .clear {
                selectedColor = viewModel.dataSource[selectedIndex].color
            }
            
            for item in viewModel.dataSource {
                if item.selected {
                    if item.color != .clear {
                        for (colorIndex,colorItem) in viewModel.colorList.enumerated() {
                            if colorItem.color == item.color {
                                viewModel.colorList[colorIndex].selected = true
                            }
                        }
                    }
                }
            }
        }
        .onDisappear(){
            viewModel.resetSelectedItem()
        }
//        .onTapGesture {
//            isPresent = false
//        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(isPresent: .constant(true), selectedIndex: .constant(0))
            .environmentObject(ContentViewModel(verseList: [
                "The Lord is my shepherd, I lack nothing.",
                "He makes me lie down in green pastures,he leads me beside quiet waters,",
                "he refreshes my soul. He guides me along the right paths for his name’s sake.",
                "Even though I walk through the darkest valley, I will fear no evil,for you are with me; your rod and your staff, they comfort me.",
                "You prepare a table before me in the presence of my enemies. You anoint my head with oil; my cup overflows.",
                "Surely your goodness and love will follow me all the days of my life, and I will dwell in the house of the Lord forever."
            ]))
    }
}
