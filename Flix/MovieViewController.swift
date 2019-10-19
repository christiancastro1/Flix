//
//  MovieViewController.swift
//  Flix
//
//  Created by Christian Alexander Valle Castro on 10/17/19.
//  Copyright © 2019 valle.co. All rights reserved.
//

import UIKit
import AlamofireImage 


class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    //Mark - properties
    var movies: [[String : Any]] = []  // empty so its not nill
    @IBOutlet weak var tableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retriveMovies()
        tableView.delegate = self
        tableView.dataSource =  self
        


        // Do any additional setup after loading the view.
    }
    //Mark - private functions
    private func retriveMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
            self.tableView.reloadData()  // to see the data
     }
    }
        task.resume()
    }
    //Mark - tableView functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.descriptionLabel.text = overview
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            cell.movieImageView.af_setImage(withURL: posterUrl!)
        }
        else {
           // No poster image. Can either set to nil (no image) or a default movie poster image
           // that you include as an asset
           cell.movieImageView.image = nil
        }
        print(title)
        print(overview)
         
        return cell
      }
      
    

}
