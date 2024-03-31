//
//  CastCell.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import UIKit

class CastCell: UICollectionViewCell {

    //MARK: - @IBOutlet
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var chartacterNameLabel: UILabel!
    
    //MARK: - Properties
    private var viewModel: CastCellAdapter? {
        didSet {
            guard let viewModel = viewModel else {return}
            setData(from: viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImage.layer.cornerRadius = characterImage.height / 2
        characterImage.clipsToBounds = true
    }

    private func setData(from viewModel: CastCellAdapter) {
        let posterURL = URL(string: viewModel.profile_path ?? "")
        characterImage.setImage(with: posterURL)
        actorNameLabel.text = viewModel.name
        chartacterNameLabel.text = viewModel.character
    }
    
    func configuration(viewModel: CastCellAdapter){
        self.viewModel = viewModel
    }
}
