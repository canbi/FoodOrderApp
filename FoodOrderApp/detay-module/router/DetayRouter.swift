//
//  DetayRouter.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation


class DetayRouter: PresenterToRouterDetayProtocol {
    static func createModule(ref: DetayVC) {
        ref.detayPresenterNesnesi = DetayPresenter()
        ref.detayPresenterNesnesi?.detayInteractor = DetayInteractor()
    }
}
