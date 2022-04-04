//
//  SepetYemekler.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation

// MARK: - Foods
class Sepet: Codable {
    let sepet_yemekler: [SepetYemekler]?
    let success: Int?

    init(sepet_yemekler: [SepetYemekler]?, success: Int?) {
        self.sepet_yemekler = sepet_yemekler
        self.success = success
    }
}

// MARK: - Yemekler
class SepetYemekler: Codable {
    let sepet_yemek_id, yemek_fiyat, yemek_siparis_adet: String?
    let yemek_adi, yemek_resim_adi,kullanici_adi: String?

    init(sepet_yemek_id: String?,
         yemek_adi: String?,
         yemek_resim_adi: String?,
         yemek_fiyat: String?,
         yemek_siparis_adet: String?,
         kullanici_adi: String?) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
}
