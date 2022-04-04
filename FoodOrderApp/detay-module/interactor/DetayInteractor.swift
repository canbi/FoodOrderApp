//
//  DetayInteractor.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation
import Alamofire

class DetayInteractor: PresenterToInteractorDetayProtocol {
    func siparisKayit(siparis: Yemekler, adet: Int) {
        guard let kullanici_adi = UserDefaults.standard.string(forKey: "kullanici_adi") else { return }
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",
                   method: .post,
                   parameters: ["kullanici_adi": kullanici_adi]).response {response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(Sepet.self, from: data)
                    var orderAdet = adet
                    
                    if let gelenListe = cevap.sepet_yemekler {
                        let oldOrder = self.historyCheck(gelenListe, siparis)
                        if let oldOrder = oldOrder {
                            orderAdet += Int(oldOrder.yemek_siparis_adet!)!
                            
                            //if there delete it
                            self.deleteOrder(orderId: oldOrder.sepet_yemek_id!, kullanici_adi: kullanici_adi)
                        }
                        
                        self.newOrder(adet: orderAdet, food: siparis, kullanici_adi: kullanici_adi)
                    }

                } catch {
                    print(error.localizedDescription)
                    //Anti-pattern
                    self.newOrder(adet: adet, food: siparis, kullanici_adi: kullanici_adi)
                }
            }
        }
    }
    
    private func historyCheck(_ history: [SepetYemekler], _ food: Yemekler) -> SepetYemekler? {
        if let found = history.first(where: {$0.yemek_resim_adi! == food.yemek_resim_adi!}) {
            return found
        }

        return nil
    }
    
    private func deleteOrder(orderId: String, kullanici_adi: String){
        let params: Parameters = ["sepet_yemek_id": orderId, "kullanici_adi": kullanici_adi]
        
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
    }
    
    private func newOrder(adet: Int, food: Yemekler, kullanici_adi: String){
        let params: Parameters = ["yemek_adi": food.yemek_adi!,
                                  "yemek_resim_adi": food.yemek_resim_adi!,
                                  "yemek_fiyat": food.yemek_fiyat!,
                                  "yemek_siparis_adet": String(adet),
                                  "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
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
    }
}
