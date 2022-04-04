//
//  Foods.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import Foundation
import UIKit

enum FoodCategory: String {
    case icecek = "İçecek"
    case anaYemek = "Ana Yemek"
    case tatli = "Tatlı"
    case hepsi = "Hepsi"
}

enum Food: String {
    case ayran = "ayran.png"
    case baklava = "baklava.png"
    case fanta = "fanta.png"
    case izgaraSomon = "izgarasomon.png"
    case izgaraTavuk = "izgaratavuk.png"
    case kadayif = "kadayif.png"
    case kahve = "kahve.png"
    case kofte = "kofte.png"
    case lazanya = "lazanya.png"
    case makarna = "makarna.png"
    case pizza = "pizza.png"
    case su = "su.png"
    case sutlac = "sutlac.png"
    case tiramisu = "tiramisu.png"
    
    var color: UIColor {
        switch self.category {
        case .tatli: return .systemIndigo
        case .icecek: return .systemBlue
        case .anaYemek: return .systemPurple
        case .hepsi: return .clear
        }
    }
    
    var name: String {
        switch self {
            case .ayran: return "Ayran"
            case .baklava: return "Baklava"
            case .fanta: return "Fanta"
            case .izgaraSomon: return "Izgara Somon"
            case .izgaraTavuk: return "Izgara Tavuk"
            case .kadayif: return "Kadayıf"
            case .kahve: return "Kahve"
            case .kofte: return "Kofte"
            case .lazanya: return "Lazanya"
            case .makarna: return "Makarna"
            case .pizza: return "Pizza"
            case .su: return "Su"
            case .sutlac: return "Sütlaç"
            case .tiramisu: return "Tiramisu"
        }
    }
    
    var category: FoodCategory {
        switch self {
        case .ayran: return .icecek
        case .baklava: return .tatli
        case .fanta:  return .icecek
        case .izgaraSomon:  return .anaYemek
        case .izgaraTavuk:  return .anaYemek
        case .kadayif:  return .tatli
        case .kahve:  return .icecek
        case .kofte:  return .anaYemek
        case .lazanya: return .anaYemek
        case .makarna: return .anaYemek
        case .pizza: return .anaYemek
        case .su: return .icecek
        case .sutlac: return .tatli
        case .tiramisu: return .tatli
        }
    }
}


// MARK: - Foods
class Foods: Codable {
    let yemekler: [Yemekler]?
    let success: Int?

    init(yemekler: [Yemekler]?, success: Int?) {
        self.yemekler = yemekler
        self.success = success
    }
}

// MARK: - Yemekler
class Yemekler: Codable {
    let yemek_id, yemek_adi, yemek_resim_adi, yemek_fiyat: String?

    init(yemek_id: String?, yemek_adi: String?, yemek_resim_adi: String?, yemek_fiyat: String?) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
}
