//
//  ContentView.swift
//  ExpenseTrackerApp
//
//  Created by Sofiane Khedim 2/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab:String = "expenses"
    var body: some View {
        TabView(selection: $currentTab) {
            ExpensesView(currentTab: $currentTab).tag("expenses").tabItem {
                Image(systemName: "creditcard")
                Text("expenses")
            }
            
            CategoryView()
                .tag("categories")
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Categories")
                }
        }
    }
}

#Preview {
    ContentView()
}

