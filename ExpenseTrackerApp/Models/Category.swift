


import SwiftData
import Foundation

@Model
class Category{
    var categoryName: String
    
    @Relationship(deleteRule:.cascade, inverse: \Expense.category)
    var expenses: [Expense]?
    
    init(categoryName: String, expenses: [Expense]? = nil) {
        self.categoryName = categoryName
        self.expenses = expenses
    }
}
   
