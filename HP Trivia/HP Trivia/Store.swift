//
//  Store.swift
//  HP Trivia
//
//  Created by Alvin on 2/12/25.
//

import Foundation
import StoreKit

enum BookStatus: Codable {
    case active
    case inactive
    case locked
}

@MainActor
// ObservableObject, so published properties can be observed and changed upon update based upon
class Store: ObservableObject {
    @Published var books: [BookStatus] = [.active, .active, .inactive, .locked, .locked, .locked, .locked]
    
    @Published var products: [Product] = []
    
    // Set requires that everything in there is unique
    @Published var purchasedIDs = Set<String>()
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    private var updates: Task<Void, Never>? = nil
    
    private let savePath = FileManager.documentsDirectory.appending(path: "SavedBookStatus")
    
    init() {
        // Prevents multiple purchases from elsewhere
        updates = watchForUpdates()
    }
    
    func loadProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Couldn't fetch those products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            // Purchase was successful, need to verify receipt, ex. hackers, etc.
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified(let signedType, let verificationError):
                    print("Error on \(signedType): \(verificationError)")
                    
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                }
                
            // User cancelled or parent disapproved child's purchase request
            case .userCancelled:
                break
                
            // Waiting for approval
            case .pending:
                break
                
            @unknown default:
                break
            }
        } catch {
            print("Couldn't purchase that product: \(error)")
        }
    }
    
    func saveStatus() {
        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: savePath)
        } catch {
            print("Unable to save data.")
        }
    }
    
    func loadStatus() {
        do {
            let data = try Data(contentsOf: savePath)
            books = try JSONDecoder().decode([BookStatus].self, from: data)
        } catch {
            print("Couldn't load books statuses.")
        }
    }
    
    private func checkPurchased() async {
        for product in products {
            // Accepts .success state
            guard let state = await product.currentEntitlement else { return }
            
            switch state {
                case .unverified(let signedType, let verificationError):
                    print("Error on \(signedType): \(verificationError)")
                    
                case .verified(let signedType):
                // Not revoked purchase, not a refund
                if (signedType.revocationDate == nil) {
                    purchasedIDs.insert(signedType.productID)
                } else {
                    purchasedIDs.remove(signedType.productID)
                }
            }
        }
    }
    
    // Watch for updates outside of the app, like other App Stores
    private func watchForUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                await checkPurchased()
            }
        }
    }
}
