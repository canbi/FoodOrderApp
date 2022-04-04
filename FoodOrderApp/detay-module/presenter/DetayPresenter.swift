//
//  DetayPresenter.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation

class DetayPresenter: ViewToPresenterDetayProtocol {
    var detayInteractor: PresenterToInteractorDetayProtocol?
    
    func siparis(siparis: Yemekler, adet: Int) {
        detayInteractor?.siparisKayit(siparis: siparis, adet: adet)
    }
    
}
