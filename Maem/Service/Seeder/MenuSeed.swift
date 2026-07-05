//
//  MenuSeed.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation

enum MenuSeed {

    static func attach(
        tenants: [Tenant]
    ) {

        guard tenants.count == 8 else {
            return
        }

        // MARK: - HokBen

        tenants[0].menus = [

            Menu(
                name: "Chicken Teriyaki",
                price: 52000,
                imageName: "chicken-teriyaki",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.carrot],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.soft],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Ayam Gugugaga",
                price: 45000,
                imageName: "AyamGugugaga",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.carrot],
                    animalProtein: [.shrimp],
                    plantProtein: nil,
                    toppings: [.tomato_sauce],
                    spicy: false,
                    texture: [.crispy, .soft],
                    allergens: [.seafood],
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Nasi Imut",
                price: 30000,
                imageName: "NasiImut",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.carrot],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.soft],
                    allergens: nil,
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )

        ]

        // MARK: - Solaria

        tenants[1].menus = [

            Menu(
                name: "Nasi Goreng Seafood",
                price: 48000,
                imageName: "nasi-goreng-seafood",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.shrimp, .egg],
                    plantProtein: nil,
                    toppings: [.chili_sauce],
                    spicy: true,
                    texture: [.dry],
                    allergens: [.seafood, .egg],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Chicken Cordon Bleu",
                price: 65000,
                imageName: "cordon-bleu",
                tags: MenuTags(
                    carbs: [.potato],
                    veggies: [.carrot],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.tomato_sauce],
                    spicy: false,
                    texture: [.crispy],
                    allergens: [.milk],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Mie Ayam",
                price: 38000,
                imageName: "mie-ayam",
                tags: MenuTags(
                    carbs: [.noodle],
                    veggies: [.spinach],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.dry],
                    allergens: [.gluten],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )

        ]

        // MARK: - Yoshinoya

        tenants[2].menus = [

            Menu(
                name: "Beef Bowl",
                price: 54000,
                imageName: "beef-bowl",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.soft],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Chicken Bowl",
                price: 47000,
                imageName: "chicken-bowl",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.soft],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Black Pepper Beef",
                price: 62000,
                imageName: "blackpepper-beef",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: true,
                    texture: [.soft],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )

        ]

        // MARK: - Bakmi GM

        tenants[3].menus = [

            Menu(
                name: "Bakmi Ayam",
                price: 43000,
                imageName: "bakmi-ayam",
                tags: MenuTags(
                    carbs: [.noodle],
                    veggies: [.spinach],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.dry],
                    allergens: [.gluten],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Pangsit Kuah",
                price: 36000,
                imageName: "pangsit-kuah",
                tags: MenuTags(
                    carbs: nil,
                    veggies: [.spinach],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: nil,
                    spicy: false,
                    texture: [.soupy],
                    allergens: [.gluten],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Bakso Kuah",
                price: 42000,
                imageName: "bakso-kuah",
                tags: MenuTags(
                    carbs: nil,
                    veggies: [.spinach],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.soupy],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )
        ]
            
        // MARK: - Mie Gacoan

        tenants[4].menus = [

            Menu(
                name: "Mie Suit",
                price: 15000,
                imageName: "mie-suit",
                tags: MenuTags(
                    carbs: [.noodle],
                    veggies: nil,
                    animalProtein: nil,
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.dry],
                    allergens: [.gluten],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Mie Hompimpa",
                price: 17000,
                imageName: "mie-hompimpa",
                tags: MenuTags(
                    carbs: [.noodle],
                    veggies: nil,
                    animalProtein: nil,
                    plantProtein: nil,
                    toppings: [.chili_oil],
                    spicy: true,
                    texture: [.dry],
                    allergens: [.gluten],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Udang Rambutan",
                price: 19000,
                imageName: "udang-rambutan",
                tags: MenuTags(
                    carbs: nil,
                    veggies: nil,
                    animalProtein: [.shrimp],
                    plantProtein: nil,
                    toppings: [.chili_sauce],
                    spicy: false,
                    texture: [.crispy],
                    allergens: [.seafood],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )

        ]

        // MARK: - Bakso Solo

        tenants[5].menus = [

            Menu(
                name: "Bakso Urat",
                price: 30000,
                imageName: "bakso-urat",
                tags: MenuTags(
                    carbs: nil,
                    veggies: [.spinach],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.soupy],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Bakso Telur",
                price: 32000,
                imageName: "bakso-telur",
                tags: MenuTags(
                    carbs: nil,
                    veggies: [.spinach],
                    animalProtein: [.beef, .egg],
                    plantProtein: nil,
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.soupy],
                    allergens: [.egg],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Mie Ayam Bakso",
                price: 35000,
                imageName: "mie-ayam-bakso",
                tags: MenuTags(
                    carbs: [.noodle],
                    veggies: [.spinach],
                    animalProtein: [.chicken, .beef],
                    plantProtein: nil,
                    toppings: [.soy_sauce],
                    spicy: false,
                    texture: [.soupy],
                    allergens: [.gluten],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )

        ]

        // MARK: - Soto Ayam Pak Haji

        tenants[6].menus = [

            Menu(
                name: "Soto Ayam",
                price: 28000,
                imageName: "soto-ayam",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.soupy],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Soto Betawi",
                price: 45000,
                imageName: "soto-betawi",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.soupy],
                    allergens: [.milk],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Soto Daging",
                price: 40000,
                imageName: "soto-daging",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.soupy],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )

        ]

        // MARK: - Warteg Nusantara

        tenants[7].menus = [

            Menu(
                name: "Ayam Goreng",
                price: 27000,
                imageName: "ayam-goreng",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.chili_sauce],
                    spicy: false,
                    texture: [.crispy],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Sayur Asem",
                price: 18000,
                imageName: "sayur-asem",
                tags: MenuTags(
                    carbs: nil,
                    veggies: [.spinach, .carrot, .tomato],
                    animalProtein: nil,
                    plantProtein: [.bean],
                    toppings: nil,
                    spicy: false,
                    texture: [.soupy],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Tempe Orek",
                price: 15000,
                imageName: "tempe-orek",
                tags: MenuTags(
                    carbs: nil,
                    veggies: nil,
                    animalProtein: nil,
                    plantProtein: [.tempeh],
                    toppings: [.soy_sauce],
                    spicy: true,
                    texture: [.dry],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            )

        ]

        // MARK: - Relationship

        for tenant in tenants {

            for menu in tenant.menus {

                menu.tenant = tenant

            }

        }

    }

}
