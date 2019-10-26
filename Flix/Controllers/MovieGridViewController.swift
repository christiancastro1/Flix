//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Christian Alexander Valle Castro on 10/25/19.
//  Copyright © 2019 valle.co. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    //Mark : properties
    var movies :[[String : Any]] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 40  // space bw rows
        layout.minimumInteritemSpacing  = -6
        
        let width = (view.frame.size.width/3-layout.minimumInteritemSpacing*2)// -layout.minimumInteritemSpacing*2)/3
        layout.itemSize = CGSize(width:width, height:width*3/2)
        
        let url = URL(string:"https://api.themoviedb.org/3/movie/297762/similar?api_key=3f6186430bbbe95d64b5a19a96745d80")!
              let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
              session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
              let task = session.dataTask(with: url) { (data, respone, error)  in
              if let error = error {
                  print(error.localizedDescription)
              }
              else if let data = data,
                  let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any ]{
                 // print (dataDictionary)  comment out since we know its working
                  
                self.movies = dataDictionary["results"] as! [[String : Any]]
                self.collectionView.reloadData()
                print(self.movies)
           }
          }
              task.resume()
    }
    // Mark : data source protocal
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]  // collection contains item instead of row
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            cell.posterView.af_setImage(withURL: posterUrl!)
        }
        else {
           // No poster image. Can either set to nil (no image) or a default movie poster image
           // that you include as an asset
            cell.posterView.image = nil
        }
        

        return cell
        
     }
     
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
