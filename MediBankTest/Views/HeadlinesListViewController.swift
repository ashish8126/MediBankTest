//
//  HeadlinesListViewController.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit

protocol HeadlinesViewControllerDelegate: AnyObject {
    func didTapHeadline(article: ArticleEntity)
}

class HeadlinesListViewController: UITableViewController {

    private let reuseIdentifier = "AuthorListCell"
    
    var viewModel = HeadingListViewModel()
    var dataStorage = [ArticleEntity]()
    var selectedSources = [String]()
    var shouldUpdateList = false
    weak var delegate: HeadlinesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Headlines"
        tableView.register(AuthorListCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        viewModel.articleData.bind { [weak self] articles in
            self?.dataStorage = articles
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.isDataSaved.bind { [weak self] isDataSaved in
            if isDataSaved {
                self?.viewModel.getData()
            }
        }
        viewModel.getDataFromServer()
        
        if let viewController = self.tabBarController?.viewControllers?[1] as? UINavigationController, let sourceViewController = viewController.viewControllers.first as? SourcesListViewController { // Static added 1 because screens are constant
            sourceViewController.delegate = self
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getSelectedArticles(list: self.selectedSources, shouldUpdateList: self.shouldUpdateList)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStorage.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! AuthorListCell
        
        let title = self.dataStorage[indexPath.row].name ?? ""
        let description = self.dataStorage[indexPath.row].articleDescription ?? ""
        let author = self.dataStorage[indexPath.row].author ?? ""
        let thumbnailPictureURL = self.dataStorage[indexPath.row].imageURL ?? ""
        cell.setupViewsData(title: title, description: description, author: author, thumbnail: thumbnailPictureURL)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapHeadline(article: self.dataStorage[indexPath.row])
    }
}

extension HeadlinesListViewController: SourceListDelegate {
    func getSourceList(list: [String]) {
        shouldUpdateList = true
        self.selectedSources = list
    }
}
