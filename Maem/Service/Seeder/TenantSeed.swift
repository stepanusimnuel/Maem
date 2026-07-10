//
//  TenantSeed.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation

enum TenantSeed {

    static func attach(
        to foodCourts: [FoodCourt]
    ) {

        guard foodCourts.count == 4 else {
            return
        }

        // AEON Food Carnival

        let hokben = Tenant(
            name: "HokBen",
            imageName: "category-rice",
            tenantImages: ["tenant-image-1", "tenant-image-2"],
            openDay: 0,
            closeDay: 5,
            openTime: "06.00",
            closeTime: "20.00",
            detailLocation: "Sebelah kanan eskalator utama."
        )

        let solaria = Tenant(
            name: "Solaria",
            imageName: "category-noodle",
            tenantImages: ["tenant-image-1", "tenant-image-2"],
            openDay: 0,
            closeDay: 6,
            openTime: "08.00",
            closeTime: "16.00",
            detailLocation: "30m dari wastafel barat"
        )

        foodCourts[0].tenants.append(hokben)
        foodCourts[0].tenants.append(solaria)

        hokben.foodCourt = foodCourts[0]
        solaria.foodCourt = foodCourts[0]

        // AEON Food Court

        let yoshinoya = Tenant(
            name: "Yoshinoya",
            imageName: "ayam-bu-tini",
            tenantImages: ["tenant-image-1", "tenant-image-2"],
            openDay: 0,
            closeDay: 4,
            openTime: "09.00",
            closeTime: "15.00",
            detailLocation: "Seberang toilet"
        )

        let bakmiGM = Tenant(
            name: "Bakmi GM",
            imageName: "category-soupy",
            openDay: 0,
            closeDay: 5,
            openTime: "06.00",
            closeTime: "18.00",
            detailLocation: "Tepat di pintu masuk foodcourt"
        )

        foodCourts[1].tenants.append(yoshinoya)
        foodCourts[1].tenants.append(bakmiGM)

        yoshinoya.foodCourt = foodCourts[1]
        bakmiGM.foodCourt = foodCourts[1]

        // ITC

        let saltNSweet = Tenant(
            name: "Salt n Sweet",
            imageName: "category-snack",
            openDay: 0,
            closeDay: 5,
            openTime: "09.30",
            closeTime: "19.30",
            detailLocation: "Di ujung kanan dari pintu masuk foodcourt"
        )

        let RMPadangJaya = Tenant(
            name: "RM Padang Jaya",
            imageName: "category-rice",
            openDay: 6,
            closeDay: 4,
            openTime: "11.00",
            closeTime: "21.00",
            detailLocation: "Di sebelah saltNSweet persis"
        )
        
        let ayamBuTini = Tenant(
            name: "Ayam Bu Tini",
            imageName: "ayam-bu-tini",
            openDay: 0,
            closeDay: 4,
            openTime: "08.00",
            closeTime: "17.00",
            detailLocation: "Di sebelah kanan eskalator utama"
        )
        
        let serbaJawaTimur = Tenant(
            name: "Serba Jawa Timur",
            imageName: "serba-jawa-timur",
            openDay: 0,
            closeDay: 4,
            openTime: "08.00",
            closeTime: "17.00",
            detailLocation: "Berada di dekat tangga Ramayana"
        )
        
        let sotoBalapan = Tenant(
            name: "Soto Balapan",
            imageName: "soto-balapan",
            openDay: 0,
            closeDay: 6,
            openTime: "08.00",
            closeTime: "17.00",
            detailLocation: "Soto yang paling ramai di Foodcourt ITC BSD"
        )
        
        let buburPakAgus = Tenant(
            name: "Bubur Pak Agus",
            imageName: "bubur-pak-agus",
            openDay: 0,
            closeDay: 6,
            openTime: "08.00",
            closeTime: "12.00",
            detailLocation: "Dekat lift foodcourt"
        )

        foodCourts[2].tenants.append(saltNSweet)
        foodCourts[2].tenants.append(RMPadangJaya)
        foodCourts[2].tenants.append(ayamBuTini)
        foodCourts[2].tenants.append(serbaJawaTimur)
        foodCourts[2].tenants.append(sotoBalapan)
        foodCourts[2].tenants.append(buburPakAgus)

        saltNSweet.foodCourt = foodCourts[2]
        RMPadangJaya.foodCourt = foodCourts[2]
        ayamBuTini.foodCourt = foodCourts[2]
        serbaJawaTimur.foodCourt = foodCourts[2]
        sotoBalapan.foodCourt = foodCourts[2]
        buburPakAgus.foodCourt = foodCourts[2]

        // Intermoda

        let soto = Tenant(
            name: "Soto Ayam Pak Haji",
            imageName: "category-soupy",
            openDay: 0,
            closeDay: 6,
            openTime: "08.00",
            closeTime: "17.00",
            detailLocation: "Di tengah ruangan foodcourt"
        )

        let warteg = Tenant(
            name: "Warteg Nusantara",
            imageName: "cateory-rice",
            openDay: 0,
            closeDay: 5,
            openTime: "06.00",
            closeTime: "21.30",
            detailLocation: "Tidak jauh dari pintu masuk foodcourt"
        )

        foodCourts[3].tenants.append(soto)
        foodCourts[3].tenants.append(warteg)

        soto.foodCourt = foodCourts[3]
        warteg.foodCourt = foodCourts[3]

        // Menu

        MenuSeed.attach(
            tenants: [

                hokben,
                solaria,

                yoshinoya,
                bakmiGM,

                saltNSweet,
                ayamBuTini,
                RMPadangJaya,
                serbaJawaTimur,
                sotoBalapan,
                buburPakAgus,
                
                warteg

            ]
        )

    }

}
