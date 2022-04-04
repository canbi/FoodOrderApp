//
//  DetayVC.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import UIKit
import Alamofire

class DetayVC: UIViewController {

    @IBOutlet weak var category: UILabel!    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var toplamUrun: UILabel!
    @IBOutlet weak var toplamTutar: UILabel!
    @IBOutlet weak var fiyat: UILabel!
    @IBOutlet weak var stepperValue: UIStepper!
    
    @IBOutlet weak var buttonSepeteEkle: UIButton!
    @IBOutlet var totalSection: UIView!
    var food: Yemekler?
    var orderHistory: [SepetYemekler]?
    
    var detayPresenterNesnesi: ViewToPresenterDetayProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetayRouter.createModule(ref: self)
        
        buttonSepeteEkle.isEnabled = false
        buttonSepeteEkle.isHidden = true
        totalSection.isHidden = true
        
        if let food = food {
            let foodEnum = Food(rawValue: food.yemek_resim_adi!)!
            name.text = foodEnum.name
            category.text = foodEnum.category.rawValue
            fiyat.text = "\(food.yemek_fiyat!)₺"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.image.kf.setImage(with: url)
                }
            }
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func stepper(_ sender: UIStepper) {
        if Int(sender.value) > 0 {
            toplamUrun.text = "Toplam \(Int(sender.value)) adet"
            toplamTutar.text = "Toplam \( Int(sender.value) * Int((food?.yemek_fiyat)!)!  )₺"
            buttonSepeteEkle.isEnabled = true
            totalSection.isHidden = false
            buttonSepeteEkle.isHidden = false
        }
        else {
            toplamUrun.text = ""
            toplamTutar.text = ""
            buttonSepeteEkle.isHidden = true
            buttonSepeteEkle.isEnabled = false
            totalSection.isHidden = true
        }
    }
    
    @IBAction func sepeteEkle(_ sender: Any) {
        if let food = food {
            detayPresenterNesnesi?.siparis(siparis: food, adet: Int(self.stepperValue.value))
        }
        
        let alertController = UIAlertController(title: "Sepete Eklendi",
                                                message: "Ürünlerinizi Sepetim sekmesinden görüntüleyebilirsiniz.",
                                                preferredStyle: .alert)
        
        let tamamAction = UIAlertAction(title: "Tamam", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(tamamAction)
        
        self.present(alertController, animated: true)
    }
}
