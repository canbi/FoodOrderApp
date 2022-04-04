//
//  DetayProtocols.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation

protocol ViewToPresenterDetayProtocol {
    var detayInteractor: PresenterToInteractorDetayProtocol? {get set}
    func siparis(siparis: Yemekler, adet: Int)
}

protocol PresenterToInteractorDetayProtocol {
    func siparisKayit(siparis: Yemekler, adet: Int)
}

protocol PresenterToRouterDetayProtocol {
    static func createModule(ref: DetayVC)
}
