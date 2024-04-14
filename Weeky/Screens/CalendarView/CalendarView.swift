//
//  CalendarView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI
import ElegantCalendar


//struct CalendarView: View, /*Equatable,*/ ElegantCalendarDelegate, ElegantCalendarDataSource {
////        @Binding var isCalendarViewShowed : Bool
//    
//    @ObservedObject private var calendarManager: ElegantCalendarManager
//
////    let coldSoresByDay: [Date: [ColdSore]]
//   
//    
//    @State private var calendarTheme: CalendarTheme = CalendarTheme(primary: Color(#colorLiteral(red: 0, green: 0.9658375382, blue: 0.7308886647, alpha: 1)))
//
//    init() {
//        
//        
////        let sortedsores = coldSoreObjects.sorted(by: { $0.date < $1.date })
////        var startDate : Date
////        var endDate : Date
////        var initMonth : Date
//        
////        if (sortedsores.count >= 1){
////            startDate = sortedsores[0].date
////            initMonth = sortedsores[0].date
////            
////            if (sortedsores.count == 1){
////                endDate = startDate
////            } else {
////                endDate = sortedsores[sortedsores.count-1].date
////                initMonth = sortedsores[sortedsores.count-1].date
////            }
//            
//        let startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36)))
//        let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
//            
////        } else {
////            startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-2 * 36)))
////            endDate = Date()
////            initMonth = Date()
////        }
////        
////        if (endDate > Date()){
////            endDate = Date()
////        }
//
//        let configuration = CalendarConfiguration(startDate: startDate,
//            endDate: endDate)
//
//        calendarManager = ElegantCalendarManager(
//            configuration: configuration)
//
////        coldSoresByDay = Dictionary(grouping: coldsores, by: { currentCalendar.startOfDay(for: $0.date) })
//
//        calendarManager.datasource = self
//        calendarManager.delegate = self
//    }
//
//    var body: some View {
//        ZStack {
//            ElegantCalendarView(calendarManager: calendarManager)
//                .theme(calendarTheme)
//        }
//    }
//    
//   /* static func == (lhs: Self, rhs: Self) -> Bool {
//        return (lhs.coldSoresByDay as NSDictionary).isEqual(to: rhs.coldSoresByDay)
//      
//    }
//    */
//  
//    
//}
//
//struct ColdSoreCalendar_Previews: PreviewProvider {
//    static var previews: some View {
////        let coldsores = [ColdSore(date: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * ( -3 * 36))), reason: reasons[4]), ColdSore(date: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * ( -1 * 36))), reason: reasons[2])]
//        CalendarView()
//    }
//}


//MARK: - commit above

//struct CalendarView: View {
//    @Binding var isCalendarViewShowed : Bool
//    @ObservedObject var calendarManager : ElegantCalendarManager
//    
//    init(isCalendarViewShowed: Binding<Bool>) {
//        let startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36)))
//        let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
//        
//        let configuration = CalendarConfiguration(startDate: startDate, endDate: endDate)
//        
//        self.calendarManager = ElegantCalendarManager(configuration: configuration)
//        _isCalendarViewShowed = isCalendarViewShowed
//    }
//    
//    var body: some View {
//        ElegantCalendarView(calendarManager: calendarManager)
//    }
//
//}
//
//
//
//struct Previews_Container: PreviewProvider {
//    struct Container: View {
//        @State var show = true
//        
//        var body: some View {
//            CalendarView(isCalendarViewShowed: $show)
//        }
//    }
//
//    static var previews: some View {
//        Container()
//    }
//}
//


struct CalendarView: View {
    @Binding var isCalendarViewShowed : Bool
    @Binding var date : Date
    
    var body: some View {
        DatePicker("j", selection: $date)
            .datePickerStyle(GraphicalDatePickerStyle())
    }
}
