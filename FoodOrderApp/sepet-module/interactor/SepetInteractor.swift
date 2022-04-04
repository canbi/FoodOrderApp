//
//  SepetInteractor.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation
import Alamofire

class SepetInteractor: PresenterToInteractorSepetProtocol {
    var sepetPresenter: InteractorToPresenterSepetProtocol?
    
    func tumSiparisleriGetir() {
        guard let kullanici_adi = UserDefaults.standard.string(forKey: "kullanici_adi") else { return }
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",
                   method: .post,
                   parameters: ["kullanici_adi": kullanici_adi]).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(Sepet.self, from: data)
                    
                    if let gelenListe = cevap.sepet_yemekler {
                        self.sepetPresenter?.presenteraVeriGonder(sepetListesi: gelenListe)
                    }
                } catch {
                    print(String(describing: error))
                    print(error.localizedDescription)
                    self.sepetPresenter?.presenteraVeriGonder(sepetListesi: [])
                }
            }
        }
    }
    
    func toplamUrunHesaplama(sepet: [SepetYemekler]) {
        let toplam = sepet.map({Int($0.yemek_fiyat!)!}).reduce(0, +)
        sepetPresenter?.presenteraVeriGonder(urunToplam: toplam)
    }
    
    func toplamTutarHesaplama(sepet: [SepetYemekler]) {
        let toplam =  sepet.map({Int($0.yemek_siparis_adet!)!}).reduce(0, +)
        sepetPresenter?.presenteraVeriGonder(tutarToplam: toplam)
    }
    
    func siparisSilme(sepetId: String) {
        guard let kullanici_adi = UserDefaults.standard.string(forKey: "kullanici_adi") else { return }
        let params: Parameters = ["sepet_yemek_id": sepetId, "kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
       
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(json)
                    }
                } catch {
                    print(String(describing: error))
                    print(error.localizedDescription)
                }
            }
        }
        
        tumSiparisleriGetir()
    }
}
