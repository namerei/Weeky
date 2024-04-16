//
//  NewTascView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 12.04.24.
//

import SwiftUI

struct NewTaskView: View {
    @Binding var dateFromCalendar: Date
    @State private var task = Task()
    @State private var taskColor: Color = Color(.green)
    @EnvironmentObject var viewModel : HomeViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - set my Colors
    let availableColors: [Color] = [Color("Blue dark"), .blue, .green, .yellow, .orange, .purple]
    
    var body: some View {
        
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
                task.date = dateFromCalendar
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
//        Spacer()
    }
    
    func backToHomeView() {
        withAnimation(.smooth) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func DatePickerView()->some View {
//        print("DATE")
//        print("\(task.date)")
//        task.title = "her"
//        print("Task title: \(task.title)")
//        if dateFromCalendar != nil {
//            print("NOT NIL")
//            task.date = dateFromCalendar!
//        }
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


//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskView(dateFromCalendar: <#Date#>)
//    }
//}
