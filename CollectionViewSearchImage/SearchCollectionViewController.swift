//
//  ViewController.swift
//  CollectionViewSearchImage
//
//  Created by Felipe Ignacio Zapata Riffo on 01-08-21.
//

import UIKit
import SDWebImage

class SearchCollectionViewController: UIViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar?
    
    var dataImage: [ImagesResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar?.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "SearchImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchImageCollectionViewCell")
        collectionView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchImageCollectionViewCell", for: indexPath) as! SearchImageCollectionViewCell
        
        let img =  dataImage
        if let dataImg = img[indexPath.row].thumbnail{
        cell.imageView?.sd_setImage(with: URL(string: dataImg))
        }
        
        return cell
    }
    
    
    //SEARCHBAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            return
        }
        dataImage = []
        print("\(text)")
        collectionView?.reloadData()
        fetchPhotos(query: text)
      
        }
     
    //JSON
    func fetchPhotos(query:String){
        
        let urlString = "https://serpapi.com/search.json?q=\(query)&tbm=isch&ijn=0&api_key=fca737073fa8af4e7dc7cb9aa8e9d2997adb47614a6e3b4820918fc20f7195e0"
        
       guard let url = URL(string: urlString) else {
           return
       }
       let task = URLSession.shared.dataTask(with: url) { data, _, error in
           guard let data = data, error == nil else {
               return
           }
            var jsonResult:APIResponse?
           do{
               let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
               DispatchQueue.main.async {
                self.dataImage = jsonResult.imagesResults
                self.collectionView?.reloadData()
                
               // print(self.results2)
               }
             
           }
           catch {
               print(error)
           }
       }
       task.resume()
    }
}

