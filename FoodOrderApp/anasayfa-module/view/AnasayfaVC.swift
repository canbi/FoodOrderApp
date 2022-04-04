//
//  AnasayfaVC.swift
//  FoodOrderApp
//
//  Created by Can Bi on 4.04.2022.
//

import UIKit
import Alamofire

class AnasayfaVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodList = [Yemekler]()
    var anasayfaPresenterNesnesi: ViewToPresenterAnasayfaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        AnasayfaRouter.createModule(ref: self)
        
        let kullanici_adi = UserDefaults.standard.string(forKey: "kullanici_adi")
        
        if kullanici_adi == nil {
            UserDefaults.standard.set(UUID().uuidString, forKey: "kullanici_adi")
        }

        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 5
        
        let genislik = self.collectionView.frame.size.width
        tasarim.itemSize = CGSize(width: (genislik - 25)/2, height: 120)
        
        collectionView.collectionViewLayout = tasarim
    }
    
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriYukle(filterType: .hepsi)
    }
    
    @IBAction func filterAnaYemek(_ sender: Any) {
        anasayfaPresenterNesnesi?.yemekleriYukle(filterType: .anaYemek)
    }
    
    @IBAction func filterTatlilar(_ sender: Any) {
        anasayfaPresenterNesnesi?.yemekleriYukle(filterType: .tatli)
    }
    
    @IBAction func filterİcecekler(_ sender: Any) {
        anasayfaPresenterNesnesi?.yemekleriYukle(filterType: .icecek)
    }
    @IBAction func filterHepsi(_ sender: Any) {
        anasayfaPresenterNesnesi?.yemekleriYukle(filterType: .hepsi)
    }
}

extension AnasayfaVC: PresenterToViewAnasayfaProtocol{
    func vieweVeriGonder(yemeklerListesi: Array<Yemekler>) {
        self.foodList = yemeklerListesi
        self.collectionView.reloadData()
    }
}

extension AnasayfaVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = foodList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! AnasayfaCollectionViewCell
        
        let foodEnum = Food(rawValue: food.yemek_resim_adi!)!
        
        cell.name.text = foodEnum.name
        cell.categoryName.text = foodEnum.category.rawValue
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.image.kf.setImage(with: url)
            }
        }
        
        cell.layer.backgroundColor = foodEnum.color.cgColor
        
        cell.layer.shadowColor = UIColor.secondaryLabel.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let food = foodList[indexPath.row]
         performSegue(withIdentifier: "toDetay", sender: food)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toDetay" {
             let food = sender as? Yemekler
             let gidilecekVC = segue.destination as! DetayVC
             
             gidilecekVC.food = food
         }
     }
}
