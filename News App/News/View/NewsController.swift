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
        fetchTopStories()
    }
    
    private func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?._view.viewModels = articles.compactMap({
                    NewsViewModel(title: $0.title,
                                  subtitle: $0.description ?? "No description",
                                  imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                DispatchQueue.main.async {
                    self?._view.tableView.reloadData()
                }
            case .failure(let error): print(error)
            }
        }
        print(_view.viewModels.count)
    }
    
    @objc func rightItemHandler() {
        navigationController?.pushViewController(SettingsController(), animated: true)
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
