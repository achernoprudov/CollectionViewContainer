//
//  ProfileFollowersDataSource.swift
//  Example
//
//  Created by Alexander on 8/20/20.
//  Copyright © 2020 Alexander. All rights reserved.
//

import UIKit
import Combine

class ProfileFollowersDataSource: CollectionViewDataSource {
    var delegate: CollectionViewDataSourceContainerDelegate?

    var isEnabled: Bool = true

    private let viewModel: ProfileFollowersDataSourceModel
    private  var models: [String] = []
    private var cancellable = Set<AnyCancellable>()

    init(viewModel: ProfileFollowersDataSourceModel) {
        self.viewModel = viewModel

        self.viewModel.usersUpdated.sink { [weak self] (values) in
            self?.models = values
            self?.reloadCurrentSectionIfLoaded()
        }.store(in: &cancellable)
    }

    var cellsForRegistration: [AppCollectionViewCell.Type]? {
        return [GenericCollectionViewCell<VideoItemView>.self]
    }

    var numberOfSections: Int {
        return self.isEnabled ? 1 : 0
    }

    func numberOfItems(inSection section: Int) -> Int {
        return self.models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithType(
            GenericCollectionViewCell<VideoItemView>.self,
            indexPath: indexPath
        )
        cell.customSubview.label.text = models[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}


