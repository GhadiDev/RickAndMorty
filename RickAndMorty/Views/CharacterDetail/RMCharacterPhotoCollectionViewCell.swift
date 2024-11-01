//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by  Ghadi on 30/10/2024.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
   
    static let cellIdentifer = "RMCharacterPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setUpConstrats()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
    
        super.prepareForReuse()
        imageView.image = nil
    }
    private func setUpConstrats(){
        //To make a constraints
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel){
        viewModel.fetchImage { [weak self] result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    case .failure:
                        break
                    }
                }
            }
        }
