//
//  ContentView.swift
//  TODOList3
//
//  Created by user on 11/11/23.
//

import SwiftUI

struct WeekPageView: View {
    
    @ObservedObject var viewModel = WeekPageViewModel()
    @State var name = ""
    
    var body: some View {
        NavigationView {
            VStack {
              
              Text("Список задач")
              .padding(.all, 30)
              .foregroundColor(Color("Blue dark"))
              .font(.system(.title, design: .monospaced))
              
              
                TextField("Новая задача", text: $name)
                .padding(.all)
                    .onSubmit {
                        viewModel.add(name: name)
                        name = ""
                      
                    }
                    .border(Color("Orange dark"))
                    .frame(width: 360, height: 20)
                    .background(Color("Yellow xlight"))
                    .padding(.bottom, 20)


                List {
                    ForEach(viewModel.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Button {
                                viewModel.completeItem(item: item)
                            } label: {
                                Image(systemName: item.isCompleted ? "checkmark" : "square")
                                .foregroundColor(Color("Blue dark"))

                            }
                            .background(Color("Yellow xlight"))

                            
                        }
                      
                    }
                    .onDelete(perform: viewModel.delete(index:))
                }
              
            }


            .background(Color("Yellow xlight"))

        }
    }
}


#Preview {
    WeekPageView()
}
