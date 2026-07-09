//
//  TenantViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import SwiftUI
import Combine

@MainActor
class TenantViewModel: ObservableObject {
    let tenant: Tenant
    let segmentedControlOptions = ["Anak", "Semua Menu"]
    
    @Published var userOption: String = "Anak"
    @Published var showAlert: Bool = false
    
    init(tenant: Tenant) {
        self.tenant = tenant
    }
    
    var filteredMenus: [Menu] {
        if userOption == "Anak" {
            return tenant.menus.filter { $0.tags.portion == .kids }
        } else {
            return tenant.menus
        }
    }
    
    func handleMenuBookmark(for menu: Menu) {
        guard menu.isBookmarked else { return }
        
        withAnimation(.spring()) {
            showAlert = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                self.showAlert = false
            }
        }
    }
}
