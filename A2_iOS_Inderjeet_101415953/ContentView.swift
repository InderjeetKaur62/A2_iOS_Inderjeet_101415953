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
                
                NavigationLink("Add New Product", destination: AddProductView())
                    .padding()
            }
            .navigationTitle("Product Catalog")
        }
    }
}

struct ProductListView: View {
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)]
    ) var products: FetchedResults<Product>
    
    var body: some View {
        List(products) { product in
            VStack(alignment: .leading) {
                Text(product.name ?? "Unknown")
                    .font(.headline)
                Text(product.descriptionText ?? "No description")
                    .font(.subheadline)
            }
        }
        .navigationTitle("Product List")
    }
}
struct ProductDetailView: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(product.name ?? "Unknown")
                .font(.title)

            Text(product.descriptionText ?? "No description")
                .font(.body)
            Text("Price: $\(product.price, specifier: "%.2f")")
            Text("Provider: \(product.provider ?? "Unknown")")
        }
        .padding()
    }
}
struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name = ""
    @State private var descriptionText = ""
    @State private var price = ""
    @State private var provider = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Product Details")) {
                TextField("Name", text: $name)
                TextField("Description", text: $descriptionText)
                TextField("Price", text: $price)
                    .keyboardType(.decimalPad)
                TextField("Provider", text: $provider)
            }
            
            Button("Add Product") {
                addProduct()
            }
        }
        .navigationTitle("Add Product")
    }
    
    private func addProduct() {
        let newProduct = Product(context: viewContext)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.descriptionText = descriptionText
        newProduct.price = Double(price) ?? 0.0
        newProduct.provider = provider
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving product: \(error)")
        }
    }
    
    
}
