//
//  ContentView.swift
//  TextHighlight
//
//  Created by Inpyo Hong on 2022/10/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var isPresentPopup = false

    func BibleListView() -> ScrollView<some View> {
        return ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(Array(zip(0..<viewModel.dataSource.count, viewModel.dataSource)), id: \.0) { index, item in
                    VStack(alignment: .leading) {
                        Text(item)
                            .multilineTextAlignment(.leading)
                            .underline(true, pattern: .dashDotDot, color: .black)
                            .lineSpacing(2)
                    }
                    .onTapGesture {
                        print("index: \(index), item: \(item)")
                        if !isPresentPopup {
                            isPresentPopup = true
                        }
//                        viewModel.selectedItems[index] = !viewModel.selectedItems[index]
//
//                        print(viewModel.selectedItems)
//
//                        if !isPresentPopup {
//                            isPresentPopup.toggle()
//                        }
                    }
                }
            }
            .padding()
        }
    }
    
    var body: some View {
        ZStack {
            //Color.gray.ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 60)
                
                Text("Psalm 23")
                    .fontWeight(.bold)
                
                BibleListView()
            }
            
            if isPresentPopup {
                VStack {
                    ColorPickerView(isPresent: $isPresentPopup)
                        .environmentObject(viewModel)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
