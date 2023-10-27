//
//  SavedListViewController.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit

protocol SavedListViewControllerDelegate: AnyObject {
    func didTapSavedList(article: ArticleEntity)
}

class SavedListViewController: UITableViewController {

    var viewModel = SavedArticleViewModel()
    var savedArticlesData = [ArticleEntity]()
    private let reuseIdentifier = "HeadlinesListCell"
    weak var delegate: SavedListViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved"
        tableView.register(HeadlinesListCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        viewModel.savedArticles.bind { [weak self] articleData in
             self?.savedArticlesData = articleData
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getSavedArticles()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedArticlesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HeadlinesListCell {
            let title = self.savedArticlesData[indexPath.row].name ?? ""
            let description = self.savedArticlesData[indexPath.row].articleDescription ?? ""
            let author = self.savedArticlesData[indexPath.row].author ?? ""
            let thumbnailPictureURL = self.savedArticlesData[indexPath.row].imageURL ?? ""
            cell.setupViewsData(title: title, description: description, author: author, thumbnail: thumbnailPictureURL)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapSavedList(article: self.savedArticlesData[indexPath.row])
    }
     
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteSavedArticle(article: self.savedArticlesData[indexPath.row])
        }
    }
    
}
