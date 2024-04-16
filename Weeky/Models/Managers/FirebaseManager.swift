//
//  FirebaseManager.swift
//  Weeky
//
//  Created by namerei on 16.04.24.
//

import SwiftUI
import Firebase
import FirebaseCore

class FirebaseManager: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var fetchedData: [String: Any]? = nil
    @Published var error: Error? = nil
    
    func fetchData() {
        print(db)
        db.collection("data").document("exampleDocument").getDocument { (document, error) in
            if let document = document, document.exists {
                self.fetchedData = document.data()
                self.error = nil
            } else {
                self.error = error
            }
        }
    }
    
    func uploadData(data: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection("data").document("exampleDocument").setData(data) { error in
            completion(error)
        }
    }
}
