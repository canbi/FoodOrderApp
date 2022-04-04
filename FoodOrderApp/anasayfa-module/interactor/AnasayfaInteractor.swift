//
//  AnasayfaInteractor.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation
import Alamofire

class AnasayfaInteractor: PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriAl(filterType: FoodCategory) {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(Foods.self, from: data)
                    if let gelenListe = cevap.yemekler {
                        var filteredListe = gelenListe
                        
                        if filterType != .hepsi {
                            filteredListe = gelenListe.filter({ yemek in
                                let foodEnum = Food(rawValue: yemek.yemek_resim_adi!)!
                                return foodEnum.category == filterType
                            })
                        }
                        
                        self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: filteredListe)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        } 
    }
}
