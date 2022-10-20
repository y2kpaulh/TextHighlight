//
//  ContentView.swift
//  TextHighlight
//
//  Created by Inpyo Hong on 2022/10/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    @State private var isPresentPopup = false

    func VerseListView() -> ScrollView<some View> {
        return ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(Array(zip(0..<viewModel.dataSource.count, viewModel.dataSource)), id: \.0) { index, item in
                    VStack(alignment: .leading) {
                        Text(item.text)
                            .background(viewModel.dataSource[index].color)
                            .multilineTextAlignment(.leading)
                            .underline(viewModel.dataSource[index].selected, pattern: .dashDotDot, color: .black)
                            .lineSpacing(2)
                    }
                    .onTapGesture {
                        //print("index: \(index), item: \(item)")
                        viewModel.dataSource[index].selected = !viewModel.dataSource[index].selected

                        if !isPresentPopup {
                            isPresentPopup.toggle()
                        }
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
                
                VerseListView()
            }
            
            if isPresentPopup {
                VStack {
                    ColorPickerView(isPresent: $isPresentPopup)
                        .environmentObject(viewModel)
                    Spacer()
                }
            }
        }
        .onChange(of: viewModel.dataSource, perform: { newValue in
           // print(newValue)
            if viewModel.dataSource.filter({ $0.selected == true }).count == 0 {
                viewModel.resetSelectedItem()
                isPresentPopup = false
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
