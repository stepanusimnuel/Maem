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
            imageName: "hokben"
        )

        let solaria = Tenant(
            name: "Solaria",
            imageName: "solaria"
        )

        foodCourts[0].tenants.append(hokben)
        foodCourts[0].tenants.append(solaria)

        hokben.foodCourt = foodCourts[0]
        solaria.foodCourt = foodCourts[0]

        // AEON Food Court

        let yoshinoya = Tenant(
            name: "Yoshinoya",
            imageName: "yoshinoya"
        )

        let bakmiGM = Tenant(
            name: "Bakmi GM",
            imageName: "bakmigm"
        )

        foodCourts[1].tenants.append(yoshinoya)
        foodCourts[1].tenants.append(bakmiGM)

        yoshinoya.foodCourt = foodCourts[1]
        bakmiGM.foodCourt = foodCourts[1]

        // ITC

        let gacoan = Tenant(
            name: "Mie Gacoan",
            imageName: "gacoan"
        )

        let baksoSolo = Tenant(
            name: "Bakso Solo",
            imageName: "bakso"
        )

        foodCourts[2].tenants.append(gacoan)
        foodCourts[2].tenants.append(baksoSolo)

        gacoan.foodCourt = foodCourts[2]
        baksoSolo.foodCourt = foodCourts[2]

        // Intermoda

        let soto = Tenant(
            name: "Soto Ayam Pak Haji",
            imageName: "soto"
        )

        let warteg = Tenant(
            name: "Warteg Nusantara",
            imageName: "warteg"
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
