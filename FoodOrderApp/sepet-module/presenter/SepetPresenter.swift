//
//  SepetPresenter.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation

class SepetPresenter: ViewToPresenterSepetProtocol {
    var sepetInteractor: PresenterToInteractorSepetProtocol?
    
    var sepetView: PresenterToViewSepetProtocol?
    
    func siparisleriGetir() {
        sepetInteractor?.tumSiparisleriGetir()
    }
    
    func toplamUrunHesapla(sepet: [SepetYemekler]) {
        sepetInteractor?.toplamUrunHesaplama(sepet: sepet)
    }
    
    func toplamTutarHesapla(sepet: [SepetYemekler]) {
        sepetInteractor?.toplamTutarHesaplama(sepet: sepet)
    }
    
    func silme(sepetId: String) {
        sepetInteractor?.siparisSilme(sepetId: sepetId)
    }
}


extension SepetPresenter: InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(urunToplam: Int) {
        sepetView?.vieweVeriGonder(urunToplam: urunToplam)
    }
    
    func presenteraVeriGonder(tutarToplam: Int) {
        sepetView?.vieweVeriGonder(tutarToplam: tutarToplam)
    }
    
    func presenteraVeriGonder(sepetListesi: Array<SepetYemekler>) {
        sepetView?.vieweVeriGonder(sepetListesi: sepetListesi)
    }
}
