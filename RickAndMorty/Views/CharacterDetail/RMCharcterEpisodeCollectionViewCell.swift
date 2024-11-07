//
//  RMCharcterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by  Ghadi on 30/10/2024.
//

import UIKit

final class RMCharcterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharcterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.font = .systemFont(ofSize: 20, weight: .semibold)
          return label
      }()
    private let nameLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.font = .systemFont(ofSize: 22, weight: .regular)
          return label
      }()
    private let airDateLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.font = .systemFont(ofSize: 18, weight: .light)
          return label
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        setUpLayer()
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        setUpConstrats()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpLayer() {
           contentView.layer.cornerRadius = 8
           contentView.layer.borderWidth = 2
       }

    override func prepareForReuse() {
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    private func setUpConstrats(){
        NSLayoutConstraint.activate([
                  seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                  seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                  seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                  seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

                  nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
                  nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                  nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                  nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),

                  airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                  airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                  airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                  airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
              ])
          }
    public func configure(with viewModel: RMCharcterEpisodeCollectionViewCellViewModel){
        viewModel.registerForData {[weak self] data in
            self?.nameLabel.text = data.name
            self?.seasonLabel.text = "Episode "+data.episode
            self?.airDateLabel.text = "Aired on "+data.air_date
        }
        viewModel.fetchEpisode()
        contentView.layer.borderColor = viewModel.borderColor.cgColor

    }
}
