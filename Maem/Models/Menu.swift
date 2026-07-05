//
//  Menu.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation
import SwiftData


@Model
final class Menu {

    @Attribute(.unique)
    var id: UUID

    var name: String

    var price: Int

    var imageName: String?

    var isBookmarked: Bool

    var tenant: Tenant?

    var tags: MenuTags

    init(
        name: String,
        price: Int,
        imageName: String? = nil,
        tags: MenuTags,
        tenant: Tenant? = nil
    ) {

        self.id = UUID()

        self.name = name

        self.price = price

        self.imageName = imageName

        self.tags = tags

        self.tenant = tenant

        self.isBookmarked = false

    }

}
