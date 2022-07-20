//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 김윤수 on 2022/07/19.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var movieList = MovieInfo()
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath) as! SearchMovieCell
        
        cell.configurationCell(data: movieList.movie[indexPath.row])
//        cell.titleLabel.text = movieList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieList.movie.count
//     return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height / 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 120
        
    }
    
    
    


}
