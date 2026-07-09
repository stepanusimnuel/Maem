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
            .ignoresSafeArea(edges: .top)
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
            }
        }

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

        ToolbarItem(
            placement: .principal
        ) {

            Text(
                viewModel.menu.tenant?.name ?? ""
            )
            .font(
                AppFont.callout(
                    weight: .bold
                )
            )

        }

        ToolbarItem(
            placement: .topBarTrailing
        ) {

            Button {

                viewModel.menu.isBookmarked.toggle()
                
                if viewModel.menu.isBookmarked {
                    withAnimation(.spring()) {
                        showAlert = true
                    }
                }

            } label: {

                Image(
                    systemName:
                        viewModel.menu.isBookmarked
                    ? "bookmark.fill"
                    : "bookmark"
                )

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
                    "Menu Lain dari \(viewModel.menu.tenant?.name ?? "")",

                menus: viewModel.otherMenus

            ) {

                

            }

            HorizontalMenuSection(

                title: "Menu Serupa",

                menus: viewModel.similarMenus

            ) {

            }

        }
        .padding(.horizontal)

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
                AppFont.largeTitle(
                    weight: .bold
                )
            )

            Text(
                viewModel.menu.tenant?.name
                ?? ""
            )
            .font(
                AppFont.callout()
            )
            .foregroundStyle(
                AppColor.neutralSystemGrey
            )

        }

    }

}

private extension MenuDetailView {

    var tagSection: some View {

        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {

            HStack(
                spacing: 20
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

}

private extension MenuDetailView {

    var descriptionSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Deskripsi")
                .font(
                    AppFont.title2(
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
