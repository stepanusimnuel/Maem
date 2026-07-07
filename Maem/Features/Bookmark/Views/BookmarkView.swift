//
//  BookmarkView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI
import SwiftData

struct BookmarkView: View {

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel = BookmarkViewModel()
    
    @State private var showAlert = false

    var body: some View {

        NavigationStack {

            ZStack {
                ScrollView {

                    VStack(alignment: .leading) {
                        Text("Menu Tersimpan")
                            .font(AppFont.title2(weight: .bold))
                        
                        LazyVStack(
                            spacing: 12
                        ) {

                            ForEach(
                                viewModel.bookmarkedMenus
                            ) { menu in

                                NavigationLink {

                                    MenuDetailView(
                                        menu: menu
                                    )

                                } label: {

                                    MenuListCard(
                                        menu: menu
                                    ) {
                                        if menu.isBookmarked {
                                            withAnimation(.spring()) {
                                                showAlert = true
                                            }
                                        }
                                    }

                                }
                                .buttonStyle(.plain)

                            }

                        }
                        .padding()
                    }
                    

                }
                .padding()
                .padding(.top, 56)
                .background(AppColor.red50)
                .task {

                    loadBookmarks()

                }
                .ignoresSafeArea()
                
                if showAlert {
                    VStack {
                        SaveSuccessAlert(isPresented: $showAlert)
                            .padding(.top, 16)
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

}

private extension BookmarkView {

    func loadBookmarks() {

        let repository = MenuRepository(
            context: modelContext
        )

        do {

            viewModel.bookmarkedMenus =
                try repository.getBookmarkedMenus()

        } catch {

            print(error.localizedDescription)

        }

    }

}
