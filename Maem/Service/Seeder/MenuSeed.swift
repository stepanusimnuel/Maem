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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: true
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: true
                )
            )
        ]
            
        // MARK: - Salt n Sweet

        tenants[4].menus = [

            Menu(
                name: "Puding Cokelat",
                menuDescription: "Puding dengan cokelat impor dari Jepang sehingga rasanya sangat memanjakan lidah Anda.",
                price: 15000,
                imageName: "puding-cokelat",
                tags: MenuTags(
                    carbs: nil,
                    veggies: nil,
                    animalProtein: nil,
                    plantProtein: nil,
                    toppings: nil,
                    spicy: false,
                    texture: [.soft],
                    allergens: [.egg],
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: true, isSnack: false
                )
            )

        ]

        // MARK: - Ayam Bu Tini

        tenants[5].menus = [

            Menu(
                name: "Nasi Ayam Kecap",
                menuDescription: "Ayam kecap berbumbu rempah dengan tekstur renyah di luar dan lembut di dalam.",
                price: 40000,
                imageName: "nasi-ayam-kecap",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.tomato],
                    animalProtein: [.chicken],
                    plantProtein: [.bean],
                    toppings: [.chili_sauce],
                    spicy: false,
                    texture: [.soft],
                    allergens: [.peanut],
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            ),

            Menu(
                name: "Fried Chicken",
                menuDescription: "Ayam goreng khas Bu Tini. Resep turun temurun yang sudah dijaga selama lebih dari 50 tahun lamanya.",
                price: 25000,
                imageName: "fried-chicken-bu-tini",
                tags: MenuTags(
                    carbs: [.rice, .potato],
                    veggies: [.carrot, .tomato],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.crispy],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: true,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            ),
            
            Menu(
                name: "Ayam Kremes Hebat",
                menuDescription: "Dimasak oleh orang yang dipercaya oleh Bu Tini langsung sehingga dijamin rasanya tidak akan mengecewakan",
                price: 28000,
                imageName: "ayam-kremes-hebat",
                tags: MenuTags(
                    carbs: [.rice, .potato],
                    veggies: [.carrot, .tomato],
                    animalProtein: [.chicken],
                    plantProtein: [.tempeh, .tofu],
                    toppings: [.crackers],
                    spicy: false,
                    texture: [.crispy],
                    allergens: [.gluten],
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            )

        ]

        // MARK: - RM Padang Jaya

        tenants[6].menus = [

            Menu(
                name: "Nasi Padang",
                menuDescription: "Paket nasi andalan yang mencakup perkedel, daun singkong, ayam bakar, bola ubi, serta sambal free refill.",
                price: 30000,
                imageName: "nasi-padang",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.spinach],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.chili_sauce],
                    spicy: true,
                    texture: [.dry],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            )

        ]
        
        tenants[7].menus = [

            Menu(
                name: "Ayam Mak Dura",
                menuDescription: "Ayam dengan bumbu hitam khas Madura yang dimasak seharian sehingga sangat lembut dan meresap.",
                price: 30000,
                imageName: "ayam-mak-dura",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.carrot, .tomato],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.chili_sauce, .tomato_sauce],
                    spicy: true,
                    texture: [.soft],
                    allergens: nil,
                    portion: .reguler,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            )

        ]
        
        tenants[8].menus = [

            Menu(
                name: "Soto Ayam",
                menuDescription: "Soto ayam yang disajikan dengan suwiran ayam yang melimpah, boleh refill koya.",
                price: 28000,
                imageName: "soto-ayam",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.carrot, .tomato, .soup],
                    animalProtein: [.chicken],
                    plantProtein: nil,
                    toppings: [.crackers, .soy_sauce],
                    spicy: false,
                    texture: [.soft, .soupy],
                    allergens: nil,
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            ),
            
            Menu(
                name: "Soto Daging Sapi",
                menuDescription: "Soto daging yang disajikan dengan daging yang melimpah, boleh refill koya.",
                price: 36000,
                imageName: "soto-ayam",
                tags: MenuTags(
                    carbs: [.rice],
                    veggies: [.carrot, .tomato, .soup],
                    animalProtein: [.beef],
                    plantProtein: nil,
                    toppings: [.crackers, .soy_sauce],
                    spicy: false,
                    texture: [.soft, .soupy],
                    allergens: nil,
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            )

        ]
        
        tenants[9].menus = [

            Menu(
                name: "Bubur Ayam Polos",
                menuDescription: "Menu andalan Pak Agus, sudah pernah di review Nex Carlos.",
                price: 20000,
                imageName: "bubur-ayam-polos",
                tags: MenuTags(
                    carbs: [.porridge],
                    veggies: [.carrot, .tomato],
                    animalProtein: [.chicken],
                    plantProtein: [.bean],
                    toppings: [.crackers, .soy_sauce],
                    spicy: false,
                    texture: [.soft, .soupy],
                    allergens: [.peanut],
                    portion: .kids,
                    isInstant: false,
                    isContainPork: false,
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
                )
            )

        ]
        

        // MARK: - Warteg Nusantara

        tenants[10].menus = [

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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: false
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
                    isContainAlcohol:false,
                    isDrink: false,
                    isDessert: false, isSnack: true
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
