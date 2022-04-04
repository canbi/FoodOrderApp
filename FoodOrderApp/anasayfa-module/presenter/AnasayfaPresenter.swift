//
//  AnasayfaPresenter.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation

class AnasayfaPresenter: ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriYukle(filterType: FoodCategory) {
        anasayfaInteractor?.tumYemekleriAl(filterType: filterType)
    }
}


extension AnasayfaPresenter: InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemeklerListesi: Array<Yemekler>) {
        anasayfaView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
