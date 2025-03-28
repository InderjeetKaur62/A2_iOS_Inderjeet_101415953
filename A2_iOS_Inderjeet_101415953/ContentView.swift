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

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
