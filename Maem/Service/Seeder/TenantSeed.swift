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

        let gacoan = Tenant(
            name: "Mie Gacoan",
            imageName: "category-snack",
            openDay: 0,
            closeDay: 6,
            openTime: "00.00",
            closeTime: "23.59",
            detailLocation: "Di ujung kanan dari pintu masuk foodcourt"
        )

        let baksoSolo = Tenant(
            name: "Bakso Solo",
            imageName: "category-drink",
            openDay: 0,
            closeDay: 4,
            openTime: "12.30",
            closeTime: "21.00",
            detailLocation: "Di sebelah Mie Gacoan persis"
        )

        foodCourts[2].tenants.append(gacoan)
        foodCourts[2].tenants.append(baksoSolo)

        gacoan.foodCourt = foodCourts[2]
        baksoSolo.foodCourt = foodCourts[2]

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

                gacoan,
                baksoSolo,

                soto,
                warteg

            ]
        )

    }

}
