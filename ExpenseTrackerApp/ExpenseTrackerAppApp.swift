//
//  ExpenseTrackerAppApp.swift
//  ExpenseTrackerApp
//
//  Created by Sofiane Khedim on 2/11/2024.
//

import SwiftUI
import SwiftData

@main
struct ExpenseTrackerAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self, Category.self])
    }
}
