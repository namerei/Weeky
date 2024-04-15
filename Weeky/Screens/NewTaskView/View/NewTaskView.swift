//
//  NewTascView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 12.04.24.
//

import SwiftUI

struct NewTaskView: View {
//    @State private var selectedColor: Color = .blue
//    @State private var selectedDate = Date()
//    @State private var taskName = ""
//    @State private var isImportant = false
    
    @State private var task = Task(title: "", date: Date())
    
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - set my Colors
    let availableColors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        withAnimation(.smooth) {
                            presentationMode.wrappedValue.dismiss()
                        }
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
                .padding(.bottom, 20)
            
            //MARK: - color picker
//            ColorPicker("Select Color", selection: $selectedColor)
//                .padding(.bottom, 20)
            CustomColorPicker(selectedColor: $task.color, colors: availableColors)
//                            .padding(.bottom, 20)
            
            DatePicker("Select Date", selection: $task.date, displayedComponents: .date)
                .padding(.bottom, 20)
            
            TextField("Описание задачи", text: $task.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            
//            Toggle("Is Important", isOn: $isImportant)
//                .padding(.bottom, 20)
            
            Button(action: {
                print(task)
                // Add action to save the task
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
//        Spacer()
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



//struct EditTaskView: View {
//    @State private var selectedColor: Color = .blue
//    let availableColors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Edit Task")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.bottom, 20)
//
//            CustomColorPicker(selectedColor: $selectedColor, colors: availableColors)
//                .padding(.bottom, 20)
//
//            // Остальной код...
//        }
//        .padding()
//    }
//}


struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
