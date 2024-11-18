

import SwiftUI

struct ExpenseCardView: View {
    var expense: Expense
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(expense.title)
                
                Text(expense.subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                if let categoryName = expense.category?.categoryName {
                    Text(categoryName)
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.red.gradient, in: .capsule)
                }
            }
            .lineLimit(1)
            
            Spacer(minLength: 5)
            
            Text(expense.currencyString)
                .font(.title3.bold())
        }
    }
}
//
//#Preview {
//    ExpenseCardView(expense: Expense(title: "title", subTitle: "subTitle", amount: 5, date: Date.now, category: nil))
//}
