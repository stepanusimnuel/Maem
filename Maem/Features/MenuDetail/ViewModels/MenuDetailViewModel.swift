//
//  MenuDetailViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class MenuDetailViewModel {

    let menu: Menu

    var otherMenus: [Menu] = []

    var similarMenus: [Menu] = []

    init(menu: Menu) {

        self.menu = menu

    }

    func load(
        context: ModelContext
    ) {

        let repository = MenuRepository(
            context: context
        )

        do {

            otherMenus = try repository.getMenus(
                from: menu.tenant,
                excluding: menu
            )

            similarMenus = try repository.getSimilarMenus(
                to: menu
            )

        }

        catch {

            print(error.localizedDescription)

        }

    }

}
