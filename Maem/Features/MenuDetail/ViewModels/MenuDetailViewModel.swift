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

    var similarMenusIsRelaxed = false

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

            let similarResult = try repository.getSimilarMenus(
                to: menu
            )

            similarMenus = Array(similarResult.items.prefix(7))
            similarMenusIsRelaxed = similarResult.isRelaxed

        }

        catch {

            print(error.localizedDescription)

        }

    }

}
