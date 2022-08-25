//
//  NewsController.swift
//  News App
//
//  Created by Islomiddin on 24/08/22.
//

import UIKit
import SafariServices

class NewsController: UIViewController {
    
    let _view = NewsView()
    
    private var articles = [Article]()
    
    let refreshControl = UIRefreshControl()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        navigationItem.title = "News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightItemHandler))
        
        _view.tableView.delegate = self
        _view.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlHandler), for: .valueChanged)
        createSearchBar()
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchTopStories()
    }
    
    private func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
            
            switch result {
            case .success(let articles):
                self.articles = articles
                self._view.viewModels = articles.compactMap({
                    NewsViewModel(title: $0.title,
                                  subtitle: $0.description ?? "No description",
                                  imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                DispatchQueue.main.async {
                    self._view.tableView.reloadData()
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    @objc func rightItemHandler() {
        navigationController?.pushViewController(SettingsController(), animated: true)
    }
    
    @objc func refreshControlHandler() {
        fetchTopStories()
    }
}

extension NewsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension NewsController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        APICaller.shared.search(with: text) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.articles = articles
                self._view.viewModels = articles.compactMap({
                    NewsViewModel(title: $0.title,
                                  subtitle: $0.description ?? "No description",
                                  imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                DispatchQueue.main.async {
                    self._view.tableView.reloadData()
                    self.searchVC.dismiss(animated: true)
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    
}
