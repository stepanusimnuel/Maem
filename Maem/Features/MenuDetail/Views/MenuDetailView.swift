//
//  MenuDetailView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI
import SwiftData

struct MenuDetailView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel: MenuDetailViewModel
    
    @State
    private var showAlert: Bool = false
    
    @State var navigateToTenant: Bool = false

    @State var navigateToSimilarMenus: Bool = false

    init(menu: Menu) {

        _viewModel = State(
            initialValue: MenuDetailViewModel(
                menu: menu
            )
        )

    }

    var body: some View {

        ZStack {
            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 24
                ) {

                    MenuHeroImage(
                        imageName: viewModel.menu.imageName
                    )

                    content

                }

            }
            .safeAreaInset(edge: .bottom) {
                saveButton
            }
            .navigationBarBackButtonHidden()
            .toolbar {

                toolbarContent

            }
            .task {

                viewModel.load(
                    context: modelContext
                )

            }
            
            if showAlert {
                VStack {
                    SaveSuccessAlert(isPresented: $showAlert)
                    Spacer()
                }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(100)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showAlert = false
                            }
                        }
                    }
                    .padding(.top, 56)
            }
        }
        .ignoresSafeArea(edges: [.top, .bottom]) 
        .navigationDestination(for: Menu.self) { selectedMenu in
            MenuDetailView(menu: selectedMenu)
        }
        .toolbar(.hidden, for: .tabBar)

    }

}

private extension MenuDetailView {

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {

        ToolbarItem(
            placement: .topBarLeading
        ) {

            Button {

                dismiss()

            } label: {

                Image(systemName: "chevron.left")

            }

        }

    }

}

private extension MenuDetailView {

    var content: some View {

        VStack(
            alignment: .leading,
            spacing: 24
        ) {

            headerSection

            tagSection

            descriptionSection

            HorizontalMenuSection(

                title:
                    "Menu Tenant Ini",

                menus: viewModel.otherMenus

            ) {
                if viewModel.menu.tenant != nil {
                    navigateToTenant = true
                }
            } onBookmarkTapped: { clickedMenu in
                clickedMenu.isBookmarked.toggle()
                if clickedMenu.isBookmarked {
                    withAnimation(.spring()) {
                        showAlert = true
                    }
                }
            }

            if !viewModel.similarMenus.isEmpty {

                HorizontalMenuSection(

                    title: "Menu Serupa",

                    menus: viewModel.similarMenus

                ) {

                    navigateToSimilarMenus = true

                } onBookmarkTapped: { clickedMenu in
                    clickedMenu.isBookmarked.toggle()
                    if clickedMenu.isBookmarked {
                        withAnimation(.spring()) {
                            showAlert = true
                        }
                    }
                }

            }

        }
        .padding(.horizontal)
        .navigationDestination(isPresented: $navigateToTenant) {
            if let tenant = viewModel.menu.tenant {
                TenantView(tenant: tenant)
            }
        }
        .navigationDestination(isPresented: $navigateToSimilarMenus) {
            if let foodCourt = viewModel.menu.tenant?.foodCourt {
                ResultView(mode: .similar(viewModel.menu), foodCourt: foodCourt)
            }
        }

    }

}

private extension MenuDetailView {

    var headerSection: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(
                viewModel.menu.name
            )
            .font(
                AppFont.title2(
                    weight: .bold
                )
            )

            HStack (alignment:.top, spacing: 8) {
                Image(systemName: "storefront.circle")
                    .frame(width: 22, height: 22)
                
                VStack(alignment:.leading, spacing: 8) {
                    Text(
                        viewModel.menu.tenant?.name
                        ?? ""
                    )
                    .font(
                        AppFont.body(weight: .semibold)
                    )
                    .foregroundStyle(
                        AppColor.neutralBlack
                    )
                    
                    if let tenant = viewModel.menu.tenant {
                        Text(tenant.foodCourt?.fcDescription ?? "Foodcourt Description")
                        Text(tenant.detailLocation ?? "")
                    }
                    
                }
            }

        }

    }

}

private extension MenuDetailView {

    var tagSection: some View {

        FlowLayout(
            spacing: 6
        ) {

            ForEach(
                viewModel.menu.tags.displayTags,
                id: \.self
            ) { tag in

                TagChip(
                    tag: tag
                )

            }

        }


    }

}

private extension MenuDetailView {
    var saveButton: some View {
        Button {
            if !viewModel.menu.isBookmarked {
                viewModel.menu.isBookmarked = true
                withAnimation(.spring()) {
                    showAlert = true
                }
            } else {
                viewModel.menu.isBookmarked = false
                withAnimation {
                    showAlert = false
                }
            }
        } label: {
            VStack(spacing: 10) {
                Text(viewModel.menu.tenant?.name ?? "")
                    .font(AppFont.body(weight: .semibold))
                    .foregroundStyle(AppColor.neutralBlack)
                
                HStack(spacing: 4) {
                    if viewModel.menu.isBookmarked {
                        Image(systemName: "checkmark")
                        Text("Tersimpan")
                    } else {
                        Image(systemName: "bookmark")
                        Text("Simpan menu")
                    }
                    
                }
                .font(AppFont.callout(weight: .bold))
                .foregroundStyle(AppColor.neutralWhite)
                .padding()
                .frame(maxWidth:.infinity)
                .background(viewModel.menu.isBookmarked ? AppColor.red300 : AppColor.red700)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .shadow(color: AppColor.red50.opacity(0.25), radius: 10, x: 0, y: 1)
            }
            .frame(maxWidth:.infinity)
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 30)
            .background(AppColor.neutralWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.1), radius: 24, x: 0, y: -8)
            
        }
    }
}

private extension MenuDetailView {

    var descriptionSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Deskripsi")
                .font(
                    AppFont.body(
                        weight: .bold
                    )
                )

            Text(viewModel.menu.menuDescription)
                .font(AppFont.body())
                .foregroundStyle(AppColor.neutralBlack)
            .font(
                AppFont.body()
            )

        }

    }

}
