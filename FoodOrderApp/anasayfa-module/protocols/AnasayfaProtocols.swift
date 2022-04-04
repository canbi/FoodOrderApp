//
//  AnasayfaProtocols.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation

//MARK: Ana Protocols
protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView: PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle(filterType: FoodCategory)
}

protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumYemekleriAl(filterType: FoodCategory)
}


//MARK: Taşıyıcı Protocols
protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemeklerListesi: Array<Yemekler>)
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemeklerListesi: Array<Yemekler>)
}


//MARK: Router
protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref: AnasayfaVC)
}
