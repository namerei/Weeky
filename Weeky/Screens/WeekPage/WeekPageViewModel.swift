//
//  MainPageViewViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation


class WeekPageViewModel: ObservableObject {
    @Published var items: [Item] = [Item(name: "Заполнить анкету")]
  

    func add(name: String) {
        let newItem = Item(name: name)
        items.append(newItem)
    }
    
    func completeItem(item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items[index].isCompleted.toggle()
    }
    
    func delete(index: IndexSet) {
        items.remove(atOffsets: index)
    }
}

