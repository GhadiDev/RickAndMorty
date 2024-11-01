//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by  Ghadi on 25/10/2024.
//

import UIKit

/// For single character cell
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let Label = UILabel()
        Label.textColor = .label
        Label.font = .systemFont(ofSize: 18, weight: .medium)
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    private let statusLabel: UILabel = {
        let Label = UILabel()
        Label.textColor = .secondaryLabel
        Label.font = .systemFont(ofSize: 16, weight: .medium)
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView,nameLabel,statusLabel)
        //for make a carve on the corner
        contentView.layer.cornerRadius = 8
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unspoorted")
    }
    
    private func addConstraints() {
        //To make a constraints
        NSLayoutConstraint.activate([
        
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor,constant: -3)

        ])
    }
    
    //For reuse the cell
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel){
        
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage {[weak self] result in
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
