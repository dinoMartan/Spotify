//
//  LibraryPageViewController.swift
//  Spotify
//
//  Created by Dino Martan on 13/04/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class LibraryPageViewController: UIPageViewController {
    
    //MARK: - Private properties
    
    private var myViewControllers: [UIViewController]? = {
        guard let libraryViewController = UIStoryboard.Storyboard.library.viewController as? LibraryMyPlaylistsViewController else { return nil }
        guard let profileViewController = UIStoryboard.Storyboard.profile.viewController as? ProfileViewController else { return nil }
        return [libraryViewController, profileViewController]
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        configurePageView()
        delegate = self
        dataSource = self
        setFirstViewController()
    }
    
    private func configurePageView() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setFirstViewController() {
        guard let firstViewController = myViewControllers?.first else { return }
        title = firstViewController.title
        setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
    }

}

extension LibraryPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewControllerIndex = myViewControllers?.firstIndex(of: viewController), let myViewControllers = myViewControllers else { return nil }
        let previousIndex = currentViewControllerIndex - 1
        guard previousIndex >= 0, myViewControllers.count > previousIndex else { return nil }
        title = myViewControllers[previousIndex].title
        return myViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewControllerIndex = myViewControllers?.firstIndex(of: viewController), let myViewControllers = myViewControllers else { return nil }
        let nextIndex = currentViewControllerIndex + 1
        guard nextIndex != myViewControllers.count, nextIndex < myViewControllers.count else { return nil }
        title = myViewControllers[nextIndex].title
        return myViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        guard let numberOfViewControllers = myViewControllers?.count else { return 0 }
        return numberOfViewControllers
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = myViewControllers?.first,
              let firstViewControllerIndex = myViewControllers?.firstIndex(of: firstViewController)
        else { return 0 }
        return firstViewControllerIndex
    }
    
}

extension LibraryPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        title = pendingViewControllers.first?.title
    }
    
}
