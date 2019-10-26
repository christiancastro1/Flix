//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Christian Alexander Valle Castro on 10/24/19.
//  Copyright © 2019 valle.co. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    //Mark : properties
    var movie: [String:Any]!

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = movie["title"] as? String
        movieTitleLabel.sizeToFit() // to make it fit so it doesnt get cut off
        movieDescriptionLabel.text = movie["overview"] as? String
        movieDescriptionLabel.sizeToFit()
        
        let posterBaseUrl = "http://image.tmdb.org/t/p/w780"
         if let posterPath = movie["poster_path"] as? String {
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            posterView.af_setImage(withURL: posterUrl!)
        }
        else {
            posterView.image = nil
        }
        let backdropPath = movie["backdrop_path"] as? String
        let backdropUrl = URL(string: posterBaseUrl + backdropPath!)
        backdropView.af_setImage(withURL: backdropUrl!)
    }
    

}
