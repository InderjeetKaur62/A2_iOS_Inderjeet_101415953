import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)]
    ) var products: FetchedResults<Product>
    
    @State private var searchText = ""
    @State private var currentIndex = 0
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false || $0.descriptionText?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search products...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                if !filteredProducts.isEmpty {
                    ProductDetailView(product: filteredProducts[currentIndex])
                    HStack {
                        Button(action: {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.largeTitle)
                        }
                        .disabled(currentIndex == 0)
                        
                        Button(action: {
                            if currentIndex < filteredProducts.count - 1 {
                                currentIndex += 1
                            }
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.largeTitle)
                        }
                        .disabled(currentIndex >= filteredProducts.count - 1)
                    }
                    .padding()
                } else {
                    Text("No products available")
                }
                NavigationLink("View All Products", destination: ProductListView())
                    .padding()


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
