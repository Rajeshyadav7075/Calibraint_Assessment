//
//  ViewController.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 01/06/21.
//

import UIKit

class ShowViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var showsTableView: UITableView!
    
    @IBOutlet weak var noDataAvailable: UILabel!
    
    var search = false
    
    let apiCall = APICallManager()
    
    var netflix: [Netflix] = []
    var filtered: [Netflix] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Netflix"
        
        showsTableView.tableFooterView = UIView()
        apiCall.fetchDataFromServer(type: TVShows.self, url: "http://api.tvmaze.com/search/shows?q=netflix") { [weak self] (result) in
            
            switch result {
            
            case .success(let list):
                self?.netflix = list
                DispatchQueue.main.async {
                    self?.showsTableView.reloadData()
                }

            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

extension ShowViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if search {
        
            return filtered.count
        }
        else {
            
            return netflix.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let series = search == true ? self.filtered[indexPath.row].show : self.netflix[indexPath.row].show
        
        let url = URL(string: series.image.medium)!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath) as! SeriesTableViewCell
        
        cell.thumbNail.loadImage(imageURL: url)
        cell.seriesTitle.text = series.name
        cell.summary.text = GlobalAccess.removeTags(summary: series.summary)
        cell.episodes.tag = series.id
        cell.id = self.netflix[indexPath.row]
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension UIImageView {
    
    func loadImage(imageURL: URL) {
        
        DispatchQueue.global().async { [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension ShowViewController: CellDelegate {
    
    func cellData(id: Netflix) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.netflix = id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ShowViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        search = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        search = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        search = false
        
        searchBar.text = nil
        searchBar.resignFirstResponder()
        
        showsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = netflix.filter { $0.show.name.lowercased().contains((searchText.lowercased()))
        }

        if searchText.count >= 1 {
            search = true
        }
        else {
            search = false
        }
        
        if filtered.count == 0 {
            
            noDataAvailable.isHidden = false
        }
        else {
            
            noDataAvailable.isHidden = true
        }
    
        self.showsTableView.reloadData()
    }
}
