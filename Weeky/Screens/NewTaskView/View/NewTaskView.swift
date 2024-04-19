//
//  NewTascView.swift
//  Weeky
//
//  Created by namerei on 12.04.24.
//

import SwiftUI

struct NewTaskView: View {
    @Binding var dateFromCalendar: Date
    @State private var task = Task()
    @State private var taskColor: Color = Color("Blue xlight")
    @EnvironmentObject var viewModel : HomeViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - set my Colors
    let availableColors: [Color] = [Color("Blue dark"), Color("Blue xlight"), Color("Orange dark"), Color("Orange light"), Color("Yellow dark"), Color("Yellow light")]
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            backToHomeView()
                        }, label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                        })
                    }
                }
                //            Spacer()
                
                Text("Edit Task")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                //MARK: - color picker
                //            ColorPicker("Select Color", selection: $selectedColor)
                CustomColorPicker(selectedColor: $taskColor, colors: availableColors)
                    .padding(.bottom, 20)
                
                DatePickerView()
                
                TextField("описание задачи", text: $task.title)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
                
                Button(action: {
                    task.dateString = dateFromCalendar.toString()
                    task.colorName = taskColor.description.extractedName
                    print(taskColor.description.extractedName)
                    if viewModel.taskAdded(task) {
                        backToHomeView()
                    }
                }, label: {
                    Text("Save Task")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            }
            .padding()
        }
        
    }
    
    func backToHomeView() {
        withAnimation(.smooth) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func DatePickerView()->some View {
        return DatePicker("Select Date", selection: $dateFromCalendar, displayedComponents: [.date, .hourAndMinute])
            .padding(.bottom, 20)
    }
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
        let colors: [Color]
        
        var body: some View {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .stroke(Color(.gray), lineWidth: selectedColor == color ? 3 : 0)
                        )
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
        }
}
