//
//  SourcesListViewController.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit

protocol SourceListDelegate {
    func getSourceList(list: [String])
}

class SourcesListViewController: UITableViewController, UITabBarDelegate {

    var sourceData = [ArticleEntity]()
    var viewModel = SourcesListViewModel()
    var selectedSources = [String]()
    var delegate: SourceListDelegate?
    private let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sources"
        viewModel.data.bind { [weak self] data in
            self?.sourceData = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getStoredData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = self.sourceData[indexPath.row].sourceName
        cell.accessoryType = self.sourceData[indexPath.row].isSelected ? .checkmark : .none
        cell.backgroundColor = self.sourceData[indexPath.row].isSelected ? .lightGray : .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.sourceData[indexPath.row].isSelected {
            tableView.deselectRow(at: indexPath, animated: true)
            self.sourceData[indexPath.row].isSelected = false
            selectedSources = selectedSources.filter({ $0 != self.sourceData[indexPath.row].sourceName })
        } else {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            self.sourceData[indexPath.row].isSelected = true
            selectedSources.append(self.sourceData[indexPath.row].sourceName ?? "")
        }
        self.delegate?.getSourceList(list: self.selectedSources)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}


