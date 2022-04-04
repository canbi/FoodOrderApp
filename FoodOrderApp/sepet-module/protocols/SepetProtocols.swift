//
//  SepetProtocols.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation

//MARK: Ana Protocols
protocol ViewToPresenterSepetProtocol {
    var sepetInteractor: PresenterToInteractorSepetProtocol? {get set}
    var sepetView: PresenterToViewSepetProtocol? {get set}
    
    func siparisleriGetir()
    func toplamUrunHesapla(sepet: [SepetYemekler])
    func toplamTutarHesapla(sepet: [SepetYemekler])
    func silme(sepetId: String)
}

protocol PresenterToInteractorSepetProtocol {
    var sepetPresenter: InteractorToPresenterSepetProtocol? {get set}
    
    func tumSiparisleriGetir()
    func toplamUrunHesaplama(sepet: [SepetYemekler])
    func toplamTutarHesaplama(sepet: [SepetYemekler])
    func siparisSilme(sepetId: String)
}

//MARK: Taşıyıcı Protocols
protocol InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(sepetListesi: Array<SepetYemekler>)
    func presenteraVeriGonder(urunToplam: Int)
    func presenteraVeriGonder(tutarToplam: Int)
}

protocol PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepetListesi: Array<SepetYemekler>)
    func vieweVeriGonder(urunToplam: Int)
    func vieweVeriGonder(tutarToplam: Int)
}

//MARK: Router
protocol PresenterToRouterSepetProtocol {
    static func createModule(ref: SepetVC)
}
