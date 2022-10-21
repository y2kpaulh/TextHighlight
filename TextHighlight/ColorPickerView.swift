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
        HStack(spacing: 20) {
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
                    print("tap trash btn")
                    
                } label: {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                        .overlay {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.white)
                        }
                    // .shadow(radius: 2)
                }

                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(viewModel.colorList.enumerated()), id: \.offset) { colorIndex, colorItem in
                            Button {
                                print("tap index: \(colorIndex), item: \(colorItem) btn")
                                
                                for (index, item) in viewModel.dataSource.enumerated() {
                                    if item.selected {
                                        viewModel.dataSource[index].color = viewModel.colorItems[colorIndex]
                                        
                                        if selectedColor == viewModel.colorItems[colorIndex] {
                                            viewModel.dataSource[index].color = .clear
                                        }

                                    }
                                }
                                
                                viewModel.resetSelectedItem()
                            } label: {
                                Rectangle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(viewModel.colorItems[colorIndex])
                                    .cornerRadius(30/2)
                                    //.shadow(radius: 2)
                            }
                            .overlay {
                                if selectedColor == viewModel.colorItems[colorIndex] {
                                    Image(systemName: "checkmark")
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
        }
        .onAppear() {
            if viewModel.dataSource[selectedIndex].color != .clear {
                selectedColor = viewModel.dataSource[selectedIndex].color
            }
        }
        .onDisappear(){
            viewModel.resetSelectedItem()
        }
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
