//
//  NewsCell.swift
//  News App
//
//  Created by Islomiddin on 24/08/22.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let identifier = "NewsCellIdentifier"
    
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()

    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(newsImageView)
        mainStack.addArrangedSubview(textStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            newsImageView.heightAnchor.constraint(equalToConstant: 140),
            newsImageView.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func configure(with viewModel: NewsViewModel) {
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                
                guard let data = data, error == nil else { return }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}
