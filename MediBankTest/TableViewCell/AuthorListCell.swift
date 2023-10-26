//
//  AuthorListCell.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit

class AuthorListCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let thumbnailImageView: LazyImageView = {
        let imageView = LazyImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print("Awake from NIB called")
    }
    
    // Type 1 of setting Constraint
    fileprivate func setupTitleLabelConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
    }
    
    fileprivate func setupDescriptionLabelConstraint() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
    }
    
    fileprivate func setupAuthorLabelConstraint() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 20).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
     }
    
    // Type 2 of Setting Constraint
    private func setupImageViewConstraint() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: self.frame.height),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: self.frame.width / 4)
            
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(authorLabel)
        self.addSubview(thumbnailImageView)
        setupTitleLabelConstraint()
        setupDescriptionLabelConstraint()
        setupAuthorLabelConstraint()
        setupImageViewConstraint()
    }
    
    func setupViewsData(title: String, description: String, author: String, thumbnail: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        authorLabel.text = author
        if let url = URL(string: thumbnail) {
            self.thumbnailImageView.loadImage(url: url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
