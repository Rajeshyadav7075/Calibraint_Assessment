//
//  DetailViewController.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 02/06/21.
//

import UIKit

class DetailViewController: UIViewController {

    var netflix: Netflix?
    let apiCall = APICallManager()
    var seasons: [Season] = []
    var episodes: [Episode] = []
    var selected: Bool = false
    
   // http://api.tvmaze.com/shows/49449/seasons
    // http://api.tvmaze.com/seasons/112397/episodes
    
    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var seriesSummary: UILabel!
    
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var episodesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodesTableView.tableFooterView = UIView()
        dropDownTableView.tableFooterView = UIView()
        
        setupUI()
    }
    
    @IBAction func onClickingDropDown(_ sender: UIButton) {
        
        if dropDownTableView.isHidden {
            hideTableView(toggle: true)
        }
        else {
            hideTableView(toggle: false)
        }
    }
    
    func setupUI() {
        
        dropDownTableView.isHidden = true
    
        guard let netflix = netflix else {
            
            return
        }

        let url = URL(string: netflix.show.image.medium)
        thumbNail.loadImage(imageURL: url!)
        self.getDataFromAPI(type: Seasons.self, url: "http://api.tvmaze.com/shows/\(netflix.show.id)/seasons", table: dropDownTableView)
        
        seriesName.text = netflix.show.name
        seriesSummary.text = GlobalAccess.removeTags(summary: netflix.show.summary)
        
        dropDownButton.setTitle("Select Season", for: .normal)
        dropDownTableView.rowHeight = 40
    }
    
    func hideTableView(toggle: Bool) {
        
        if toggle {
            
            UIView.animate(withDuration: 0.1) {
                self.dropDownTableView.isHidden = false
            }
        }
        else {
            
            UIView.animate(withDuration: 0.1) {
                self.dropDownTableView.isHidden = true
            }
        }
    }
    
    func getDataFromAPI<G: Decodable>(type: G.Type = G.self,url: String,table: UITableView) {
        
        apiCall.fetchDataFromServer(type: G.self, url: url) { [weak self]
            (result) in
            
            switch result {
            
            case .success(let list):
               
                if type.self == Seasons.self {

                    self?.seasons = list as! [Season]
                }

                else {

                    self?.episodes = list as! [Episode]
                }
                DispatchQueue.main.async {

                    table.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == dropDownTableView {
            
            hideTableView(toggle: false)
            dropDownButton.setTitle("Season \(indexPath.row + 1)", for: .normal)
    
            self.getDataFromAPI(type: Episodes.self, url: "http://api.tvmaze.com/seasons/\(seasons[indexPath.row].id)/episodes", table: episodesTableView)
            
        }
        else {
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == dropDownTableView {
            
            return seasons.count
        }
        else {
            
            return episodes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == dropDownTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "dropDownCell", for: indexPath) as! DropDownTableViewCell
            
            cell.dropDown.text = "Season \(indexPath.row + 1)"
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodesTableViewCell
            
            cell.episodeNumber.text = "\(episodes[indexPath.row].name)"
            cell.episodeRunTime.text = "Runtime \(episodes[indexPath.row].runtime ?? 0)"
            
            return cell
        }
    }
}

