

import SwiftUI
import SwiftData

struct CategoryView: View {
    
    @Query(animation: .snappy) private var allCategories: [Category]
    
    @Environment(\.modelContext) private var context
    
    @State private var addCategory: Bool = false
    @State private var categoryName: String = ""
    @State private var deleteRequest: Bool = false
    @State private var requestedCategory: Category?
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(allCategories.sorted(by: { cat1, cat2 in
                    (cat1.expenses?.count ?? 0) > (cat2.expenses?.count ?? 0)
                })) { category in
                    DisclosureGroup {
                        if let expenses = category.expenses, !expenses.isEmpty {
                            ForEach(expenses) { expense in
                                ExpenseCardView(expense: expense)
                            }
                        } else {
                            ContentUnavailableView {
                                Label("No Expenses", systemImage: "tray.fill")
                            }
                        }
                    } label : {
                        Text(category.categoryName)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button{
                            deleteRequest.toggle()
                            requestedCategory = category
                        } label : {
                            Image(systemName:  "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("Categories")
            .overlay(content: {
                if allCategories.isEmpty {
                    ContentUnavailableView{
                        Label("No Categories", systemImage: "tray.fill")
                    }
                }
            })
            .toolbar {
                ToolbarItem( placement: .topBarTrailing) {
                    Button{
                        addCategory.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $addCategory) {
                categoryName = ""
            } content: {
                NavigationStack {
                    List {
                        Section("Title"){
                            TextField("General", text: $categoryName)
                        }
                    }
                    .navigationTitle("Category Name")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                addCategory = false
                            }
                            .tint(.red)
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Add") {
                                let category = Category(categoryName: categoryName)
                                context.insert(category)
                                categoryName = ""
                                addCategory = false
                            }
                            .disabled(categoryName.isEmpty)
                        }
                    }
                }
                .presentationDetents([.height(180)])
                .presentationCornerRadius(20)
                .interactiveDismissDisabled()
            }

        }
        .alert("If you delete a categor, all the associated expenses will be deleted too.", isPresented: $deleteRequest) {
            Button(role: .destructive) {
                if let requestedCategory {
                    context.delete(requestedCategory)
                    self.requestedCategory = nil
                }
            } label: {
                Text("Delete")
            }
            
            Button(role: .cancel) {
                requestedCategory = nil
            } label: {
                Text("Cancel")
            }
        }
    }
}

#Preview {
    CategoryView()
}
