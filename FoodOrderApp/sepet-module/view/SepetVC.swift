//
//  SepetVC.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import UIKit
import Alamofire
import Kingfisher

class SepetVC: UIViewController {
    
    @IBOutlet weak var totalUrun: UILabel!
    @IBOutlet weak var total: UILabel!
    var sepetYemekler: [SepetYemekler] = [SepetYemekler]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var sepetPresenterNesnesi: ViewToPresenterSepetProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        SepetRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sepetPresenterNesnesi?.siparisleriGetir()
    }
    
    @IBAction func siparisVer(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    private func sepettenSil(sepetId: String){
        sepetPresenterNesnesi?.silme(sepetId: sepetId)
    }
}

extension SepetVC: PresenterToViewSepetProtocol {
    func vieweVeriGonder(urunToplam: Int) {
        self.total.text = "Toplam Tutar: \(urunToplam)₺"
    }
    
    func vieweVeriGonder(tutarToplam: Int) {
        self.totalUrun.text = "Ürün Adedi: \(tutarToplam)"
    }
    
    func vieweVeriGonder(sepetListesi: Array<SepetYemekler>) {
        self.sepetYemekler = sepetListesi
        sepetPresenterNesnesi?.toplamUrunHesapla(sepet: sepetListesi)
        sepetPresenterNesnesi?.toplamTutarHesapla(sepet: sepetListesi)
        self.tableView.reloadData()
    }
}

extension SepetVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sepetYemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = sepetYemekler[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetCell", for: indexPath) as! SepetTableViewCell
        
        let foodEnum = Food(rawValue: food.yemek_resim_adi!)!
        
        cell.total.text = "Toplam \(Int(food.yemek_siparis_adet!)! * Int(food.yemek_fiyat!)!)₺"
        cell.adet.text = "\(food.yemek_siparis_adet!) Adet"
        cell.category.text = foodEnum.category.rawValue
        cell.name.text = foodEnum.name
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.cellImageView.kf.setImage(with: url)
            }
        }
        
        cell.background.backgroundColor = foodEnum.color
        cell.background.layer.shadowColor = UIColor.secondaryLabel.cgColor
        cell.background.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.background.layer.shadowRadius = 2.0
        cell.background.layer.shadowOpacity = 0.1
        cell.background.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.background.layer.cornerRadius = 10.0
        cell.background.layer.masksToBounds = true
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let food = sepetYemekler[indexPath.row]
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { (ca,v,b) in
            print("\(food.yemek_resim_adi!) silindi")
            self.sepetPresenterNesnesi?.silme(sepetId: food.sepet_yemek_id!)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
