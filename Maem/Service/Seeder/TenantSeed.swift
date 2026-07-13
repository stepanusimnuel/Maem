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
        
        // AEON Food Carnival

        let hokben = Tenant(
            name: "HokBen",
            imageName: "category-rice",
            tenantImages: ["tenant-image-1", "tenant-image-2"],
            openDay: 0,
            closeDay: 5,
            openTime: "06.00",
            closeTime: "20.00",
            detailLocation: "Sebelah kanan eskalator utama.",
            halalStatus: .bersertifikat
        )

        let solaria = Tenant(
            name: "Solaria",
            imageName: "category-noodle",
            tenantImages: ["tenant-image-1", "tenant-image-2"],
            openDay: 0,
            closeDay: 6,
            openTime: "08.00",
            closeTime: "16.00",
            detailLocation: "30m dari wastafel barat",
            halalStatus: .bersertifikat
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
            detailLocation: "Seberang toilet",
            halalStatus: .bersertifikat
        )

        let bakmiGM = Tenant(
            name: "Bakmi GM",
            imageName: "category-soupy",
            openDay: 0,
            closeDay: 5,
            openTime: "06.00",
            closeTime: "18.00",
            detailLocation: "Tepat di pintu masuk foodcourt",
            halalStatus: .bersertifikat
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
            detailLocation: "Di ujung kanan dari pintu masuk foodcourt",
            halalStatus: .belumSertifikasi
        )

        let RMPadangJaya = Tenant(
            name: "RM Padang Jaya",
            imageName: "category-rice",
            openDay: 6,
            closeDay: 4,
            openTime: "11.00",
            closeTime: "21.00",
            detailLocation: "Di sebelah saltNSweet persis",
            halalStatus: .belumSertifikasi
        )
        
        let ayamBuTini = Tenant(
            name: "Ayam Bu Tini",
            imageName: "ayam-bu-tini",
            openDay: 0,
            closeDay: 4,
            openTime: "08.00",
            closeTime: "17.00",
            detailLocation: "Di sebelah kanan eskalator utama",
            halalStatus: .belumSertifikasi
        )
        
        let serbaJawaTimur = Tenant(
            name: "Serba Jawa Timur",
            imageName: "serba-jawa-timur",
            openDay: 0,
            closeDay: 4,
            openTime: "08.00",
            closeTime: "17.00",
            detailLocation: "Berada di dekat tangga Ramayana",
            halalStatus: .belumSertifikasi
        )
        
        let sotoBalapan = Tenant(
            name: "Soto Balapan",
            imageName: "soto-balapan",
            openDay: 0,
            closeDay: 6,
            openTime: "08.00",
            closeTime: "17.00",
            detailLocation: "Terletak di depan pintu foodcourt sebelah kiri setelah 3 tenant",
            halalStatus: .belumSertifikasi
        )
        
        let buburPakAgus = Tenant(
            name: "Bubur Pak Agus",
            imageName: "bubur-pak-agus",
            openDay: 0,
            closeDay: 6,
            openTime: "08.00",
            closeTime: "12.00",
            detailLocation: "Dekat lift foodcourt",
            halalStatus: .belumSertifikasi
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

        let iv_ayambutini = Tenant(name: "Ayam Bu Tini", imageName: "tenant-ayam-bu-tini", detailLocation: "Sebelah eskalator utama", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_ayambutini)
        iv_ayambutini.foodCourt = foodCourts[3]
        let iv_bubursotonusantara = Tenant(name: "Bubur & Soto Nusantara", imageName: "tenant-bubur-soto-nusantara", detailLocation: "Dekat wastafel di tengah foodcourt", halalStatus: .belumSertifikasi)
        foodCourts[3].tenants.append(iv_bubursotonusantara)
        iv_bubursotonusantara.foodCourt = foodCourts[3]
        let iv_seafoodmantap = Tenant(name: "Seafood Mantap", imageName: "tenant-seafood-mantap", detailLocation: "Tepat di pintu masuk sebelah kanan", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_seafoodmantap)
        iv_seafoodmantap.foodCourt = foodCourts[3]
        let iv_miedimsumcorner = Tenant(name: "Mie & Dimsum Corner", imageName: "tenant-mie-dimsum-corner", detailLocation: "Berada di ujung ruangan foodcourt", halalStatus: .belumSertifikasi)
        foodCourts[3].tenants.append(iv_miedimsumcorner)
        iv_miedimsumcorner.foodCourt = foodCourts[3]
        let iv_pojokvegetarian = Tenant(name: "Pojok Vegetarian", imageName: "tenant-pojok-vegetarian", detailLocation: "Di seberang toilet", halalStatus: .bersertifikat)
        foodCourts[3].tenants.append(iv_pojokvegetarian)
        iv_pojokvegetarian.foodCourt = foodCourts[3]
        let iv_porkcorner = Tenant(name: "Pork Corner", imageName: "tenant-pork-corner", detailLocation: "Di bagian kanan foodcourt khusus non halal", halalStatus: .nonHalal)
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
                iv_rotibakarsnackcorner,
                
                hokben,
                solaria,
                
                yoshinoya,
                bakmiGM,
                
                saltNSweet,
                ayamBuTini,
                RMPadangJaya,
                serbaJawaTimur,
                sotoBalapan,
                buburPakAgus
            ]
        )

    }

}
