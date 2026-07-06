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

    var body: some View {

        NavigationStack {

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
                                )

                            }
                            .buttonStyle(.plain)

                        }

                    }
                    .padding()
                }
                

            }
            .padding()
            .padding(.top, 42)
            .background(AppColor.red50)
            .task {

                loadBookmarks()

            }
            .ignoresSafeArea()

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
