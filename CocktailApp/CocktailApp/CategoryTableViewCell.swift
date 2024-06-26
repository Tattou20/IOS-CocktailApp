//
//  CategoryTableViewCell.swift
//  CocktailApp
//
//  Created by user238581 on 4/19/24.
//

import UIKit

class CategoryTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class CategoryTableViewCell: UITableViewCell {
    static let identifier = "CategoryTableViewCell"
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .light)
        return label
    }()
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(categoryTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(categoryImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryTitleLabel.frame = CGRect(x: 10, y:0, width: contentView.frame.size.width - 170, height: 70)
        subtitleLabel.frame = CGRect(x: 10, y:70, width: contentView.frame.size.width - 170, height: contentView.frame.size.height/2)
        categoryImageView.frame = CGRect(x: contentView.frame.size.width-150, y:5, width: 140, height: contentView.frame.size.height - 10)    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryTitleLabel.text = nil
        subtitleLabel.text = nil
        categoryImageView.image = nil
    }
    
    func configure(with viewModel: CategoryTableViewCellViewModel){
        categoryTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        //Image
        if let data = viewModel.imageData {
            categoryImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.categoryImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

