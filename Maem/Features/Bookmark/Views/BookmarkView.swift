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
            
            ZStack(alignment: .top) {
                
                AppColor.neutralWhite.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Menu Tersimpan")
                        .font(AppFont.title2(weight: .bold))
                        .padding(.horizontal)
                    
                    if viewModel.bookmarkedMenus.isEmpty {
                        
                        NotFound(title: "Belum ada menu", subtitle: "Tambahkan menu favoritmu, yuk!")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else {
                        
                        ScrollView {
                            
                            LazyVStack(spacing: 12) {
                                
                                ForEach(viewModel.bookmarkedMenus) { menu in
                                    
                                    NavigationLink {
                                        MenuDetailView(menu: menu)
                                    } label: {
                                        MenuListCard(menu: menu, needDetailLocation: true) { tappedMenu in
                                            tappedMenu.isBookmarked.toggle()
                                            if tappedMenu.isBookmarked {
                                                withAnimation(.spring()) {
                                                    showAlert = true
                                                }
                                            }
                                        }
                                    }
                                    .buttonStyle(.plain)
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            
                            
                        }
                    }
                    
                    
                }
                
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
            .task {
                loadBookmarks()
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
