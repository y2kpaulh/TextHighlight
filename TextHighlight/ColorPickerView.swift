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
    var isDataExist: Bool = false

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
                
                if isDataExist {
                    Button {
                        print("tap trash btn")

                    } label: {
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                            .cornerRadius(30/2)
                            .overlay {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                            }
                           // .shadow(radius: 2)
                    }
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(viewModel.colorItems.enumerated()), id: \.offset) { index, item in
                            Button {
                                print("tap index: \(index), item: \(item) btn")
                            } label: {
                                Rectangle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(viewModel.colorItems[index])
                                    .cornerRadius(30/2)
                                    //.shadow(radius: 2)

                            }
                            .overlay {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
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
        .onDisappear(){
            viewModel.resetSelectedItem()
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(isPresent: .constant(true))
            .environmentObject(ContentViewModel())
    }
}
