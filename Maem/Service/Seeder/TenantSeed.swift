//
//  TenantSeed.swift
//  Maem
//

import Foundation

enum TenantSeed {

    static func attach(
        to foodCourts: [FoodCourt]
    ) {

        guard foodCourts.count == 4 else {
            return
        }

        foodCourts[0].tenants = []
        foodCourts[1].tenants = []
        foodCourts[2].tenants = []

        let iv_ayambutini = Tenant(name: "Ayam Bu Tini", imageName: "tenant-ayam-bu-tini", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_ayambutini)
        iv_ayambutini.foodCourt = foodCourts[3]
        let iv_bubursotonusantara = Tenant(name: "Bubur & Soto Nusantara", imageName: "tenant-bubur-soto-nusantara", halalStatus: .belumSertifikasi)
        foodCourts[3].tenants.append(iv_bubursotonusantara)
        iv_bubursotonusantara.foodCourt = foodCourts[3]
        let iv_seafoodmantap = Tenant(name: "Seafood Mantap", imageName: "tenant-seafood-mantap", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_seafoodmantap)
        iv_seafoodmantap.foodCourt = foodCourts[3]
        let iv_miedimsumcorner = Tenant(name: "Mie & Dimsum Corner", imageName: "tenant-mie-dimsum-corner", halalStatus: .belumSertifikasi)
        foodCourts[3].tenants.append(iv_miedimsumcorner)
        iv_miedimsumcorner.foodCourt = foodCourts[3]
        let iv_pojokvegetarian = Tenant(name: "Pojok Vegetarian", imageName: "tenant-pojok-vegetarian", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_pojokvegetarian)
        iv_pojokvegetarian.foodCourt = foodCourts[3]
        let iv_porkcorner = Tenant(name: "Pork Corner", imageName: "tenant-pork-corner", halalStatus: .nonHalal)
        foodCourts[3].tenants.append(iv_porkcorner)
        iv_porkcorner.foodCourt = foodCourts[3]
        let iv_esmanis = Tenant(name: "Es & Manis", imageName: "tenant-es-manis", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_esmanis)
        iv_esmanis.foodCourt = foodCourts[3]
        let iv_nasipadangsederhana = Tenant(name: "Nasi Padang Sederhana", imageName: "tenant-nasi-padang-sederhana", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_nasipadangsederhana)
        iv_nasipadangsederhana.foodCourt = foodCourts[3]
        let iv_baksoboedjangan = Tenant(name: "Bakso Boedjangan", imageName: "tenant-bakso-boedjangan", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_baksoboedjangan)
        iv_baksoboedjangan.foodCourt = foodCourts[3]
        let iv_geprekpenyetcorner = Tenant(name: "Geprek & Penyet Corner", imageName: "tenant-geprek-penyet-corner", halalStatus: .belumSertifikasi)
        foodCourts[3].tenants.append(iv_geprekpenyetcorner)
        iv_geprekpenyetcorner.foodCourt = foodCourts[3]
        let iv_nasiudukbetawihjsiti = Tenant(name: "Nasi Uduk Betawi Hj. Siti", imageName: "tenant-nasi-uduk-betawi-hj-siti", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_nasiudukbetawihjsiti)
        iv_nasiudukbetawihjsiti.foodCourt = foodCourts[3]
        let iv_satenusantara = Tenant(name: "Sate Nusantara", imageName: "tenant-sate-nusantara", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_satenusantara)
        iv_satenusantara.foodCourt = foodCourts[3]
        let iv_chinesefoodkohaseng = Tenant(name: "Chinese Food Koh Aseng", imageName: "tenant-chinese-food-koh-aseng", halalStatus: .nonHalal)
        foodCourts[3].tenants.append(iv_chinesefoodkohaseng)
        iv_chinesefoodkohaseng.foodCourt = foodCourts[3]
        let iv_pecellelemantap = Tenant(name: "Pecel Lele Mantap", imageName: "tenant-pecel-lele-mantap", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_pecellelemantap)
        iv_pecellelemantap.foodCourt = foodCourts[3]
        let iv_healthycorner = Tenant(name: "Healthy Corner", imageName: "tenant-healthy-corner", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_healthycorner)
        iv_healthycorner.foodCourt = foodCourts[3]
        let iv_nasicampurbalikuning = Tenant(name: "Nasi Campur Bali & Kuning", imageName: "tenant-nasi-campur-bali-kuning", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_nasicampurbalikuning)
        iv_nasicampurbalikuning.foodCourt = foodCourts[3]
        let iv_jajananpasarmbahwongso = Tenant(name: "Jajanan Pasar Mbah Wongso", imageName: "tenant-jajanan-pasar-mbah-wongso", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_jajananpasarmbahwongso)
        iv_jajananpasarmbahwongso.foodCourt = foodCourts[3]
        let iv_rotibakarsnackcorner = Tenant(name: "Roti Bakar & Snack Corner", imageName: "tenant-roti-bakar-snack-corner", halalStatus: .belumSertifikasi)
        foodCourts[3].tenants.append(iv_rotibakarsnackcorner)
        iv_rotibakarsnackcorner.foodCourt = foodCourts[3]

        MenuSeed.attach(
            tenants: [

                iv_ayambutini,
                iv_bubursotonusantara,
                iv_seafoodmantap,
                iv_miedimsumcorner,
                iv_pojokvegetarian,
                iv_porkcorner,
                iv_esmanis,
                iv_nasipadangsederhana,
                iv_baksoboedjangan,
                iv_geprekpenyetcorner,
                iv_nasiudukbetawihjsiti,
                iv_satenusantara,
                iv_chinesefoodkohaseng,
                iv_pecellelemantap,
                iv_healthycorner,
                iv_nasicampurbalikuning,
                iv_jajananpasarmbahwongso,
                iv_rotibakarsnackcorner
            ]
        )

    }

}
