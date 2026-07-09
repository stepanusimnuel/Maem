//
//  TenantView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import SwiftUI

struct TenantView: View {
    @StateObject private var viewModel: TenantViewModel
    
    init(tenant: Tenant) {
        _viewModel = StateObject(wrappedValue: TenantViewModel(tenant: tenant))
    }
    
    var body: some View {
        ZStack (alignment:.top) {
            AppColor.red50.ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 0) {
                Text("Menu Tenant Ini")
                    .font(AppFont.title(weight: .bold))
                    .padding()
                
                TenantInfoCard(tenant: viewModel.tenant)
                
                Picker("Pilih", selection: $viewModel.userOption) {
                    ForEach(viewModel.segmentedControlOptions, id: \.self) { op in
                        Text(op).tag(op)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                if viewModel.filteredMenus.isEmpty {
                    HStack(alignment: .center) {
                        Spacer()
                        NotFound(title: "Makanan belum tersedia", subtitle: "Silahkan coba lagi nanti")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredMenus) { menu in
                                NavigationLink {
                                    MenuDetailView(menu: menu)
                                } label: {
                                    MenuListCard(menu: menu) {
                                        viewModel.handleMenuBookmark(for: menu)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                    Spacer()
                }
                Spacer()
            }
            
            if viewModel.showAlert {
                VStack {
                    SaveSuccessAlert(isPresented: $viewModel.showAlert)
                        .padding(.top, 16)
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(100)
            }
        }
        .onAppear {
            setupSegmentedControlAppearance()
        }
    }
    
    private func setupSegmentedControlAppearance() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}

#Preview {
    TenantView(tenant: Tenant(name: "Test", imageName: "category-rice", tenantImages: ["tenant-image-1", "tenant-image-2"], openDay: 1, closeDay: 6, openTime: "12.00", closeTime: "00.00", detailLocation: "Testing detial location", isHalal: true))
}
