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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RecommendCollectionViewController.identifier) as! RecommendCollectionViewController
        
        vc.movieData = movieList.movie[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(touchResetButton(_:)))
        
        tableView.rowHeight = 120
        
    }
    
    @objc func touchResetButton(_ sender: UIBarButtonItem) {
        
        // 아이폰에서는 연결된 화면이 항상 하나기 때문에 first를 써준다.
        
        // AppDelegate
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        // SceneDelegate
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = UIStoryboard(name: "Trend", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
    
    
    
    
}
