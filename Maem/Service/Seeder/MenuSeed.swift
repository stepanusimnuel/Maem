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
                menuDescription: "Ayam panggang dengan saus teriyaki khas Jepang yang gurih manis, disajikan bersama nasi hangat dan sayuran segar.",
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
                menuDescription: "Potongan ayam renyah berukuran kecil dengan tekstur lembut di bagian dalam, cocok untuk anak-anak.",
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
                    allergens: [.gluten],
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Nasi Imut",
                menuDescription: "Porsi nasi dengan irisan daging sapi empuk dan sayuran, dirancang khusus untuk porsi anak.",
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
                menuDescription: "Nasi goreng dengan udang dan telur, dimasak menggunakan bumbu khas Solaria yang kaya rasa.",
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
                    allergens: [.sesame, .egg],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol: false
                )
            ),

            Menu(
                name: "Chicken Cordon Bleu",
                menuDescription: "Dada ayam berlapis tepung renyah dengan isian keju lembut, disajikan bersama kentang.",
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
                menuDescription: "Mie ayam dengan topping ayam berbumbu gurih dan sayuran segar.",
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
                menuDescription: "Irisan daging sapi tipis dengan saus khas Yoshinoya di atas nasi hangat.",
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
                menuDescription: "Ayam berbumbu khas disajikan di atas nasi hangat dengan saus gurih.",
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
                menuDescription: "Daging sapi dengan saus lada hitam yang kaya rasa dan sedikit pedas.",
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
                menuDescription: "Bakmi kenyal dengan ayam cincang berbumbu khas Bakmi GM.",
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
                menuDescription: "Pangsit ayam lembut dalam kuah hangat yang gurih.",
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
                menuDescription: "Bakso sapi dengan kuah kaldu hangat yang kaya rasa.",
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
                menuDescription: "Mie gurih tanpa level pedas, cocok untuk yang ingin menikmati rasa original.",
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
                menuDescription: "Mie pedas favorit dengan bumbu khas Mie Gacoan.",
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
                menuDescription: "Udang goreng berlapis tepung renyah dengan tekstur crispy.",
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
                    allergens: [.shrimp],
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
                menuDescription: "Bakso urat sapi dengan kuah kaldu hangat dan taburan bawang goreng.",
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
                menuDescription: "Bakso sapi isi telur rebus dengan kuah gurih.",
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
                menuDescription: "Perpaduan mie ayam dan bakso sapi dalam satu mangkuk.",
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
                menuDescription: "Soto ayam dengan kuah bening, suwiran ayam, dan taburan bawang goreng.",
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
                menuDescription: "Soto Betawi dengan kuah santan gurih dan potongan daging sapi.",
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
                menuDescription: "Soto daging sapi dengan kuah hangat dan rempah khas Indonesia.",
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
                menuDescription: "Ayam goreng berbumbu rempah dengan tekstur renyah di luar dan lembut di dalam.",
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
                menuDescription: "Sayur asem segar berisi berbagai macam sayuran dengan kuah asam yang ringan.",
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
                menuDescription: "Tempe orek manis gurih yang dimasak dengan kecap dan sedikit cabai.",
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
