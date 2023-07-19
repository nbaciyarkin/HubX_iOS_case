//
//  DemoViewController.swift
//  HUBX
//
//  Created by Yarkın Gazibaba on 16.07.2023.
//

import Foundation
//
//  DemoViewController.swift
//  SimpleOnboardingDemo
//
//  Created by jrasmusson on 2021-01-08.
//

import UIKit

class DemoViewController: UIPageViewController {

    var pages = [UIViewController]()
    
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(Constants.close_icon, for: .normal)
        btn.backgroundColor = Constants.app_gray
        btn.titleLabel?.textAlignment = .right
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.layer.masksToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(dismissOnBoarding), for: .touchUpInside)
        return btn
    }()

    // external controls
    let nextButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Continue", for: .normal)
        btn.backgroundColor = UIColor(named: "app_green")
        btn.titleLabel?.textAlignment = .right
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.layer.masksToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        //btn.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
       
        return btn
    }()
    
    let pageControl = UIPageControl()
    let initialPage = 0

    // animations
    
    var pageControlBottomAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        
    }

}

extension DemoViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        // en başa
        
        let page1 = OnboardingViewController(headerImage: Constants.onBoardHeader_2!, centerImage: Constants.onBoardScreen_2!, cornerImage: nil)
        page1.setUI()
        
        let page2 = OnboardingViewController(headerImage: Constants.onBoardHeader_3!, centerImage: Constants.onBoardScreen_3!, cornerImage: Constants.onBoardScreen_3_corner!)
        
        page2.setGuidesSceneConstraints()
        
        let page3 = PaywallViewController()
                                            
        //let page4 = LoginViewController() buraya ödeme ekranı ekle
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
      
    }
    
    
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage


        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        
        navigationItem.hidesBackButton = true
        closeButton.isHidden = true
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
        ])
        
        // for animations
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-55)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(25)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
   
        pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2)

        
        pageControlBottomAnchor?.isActive = true
    }
}

// MARK: - DataSource

extension DemoViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap first
        }
    }
}

// MARK: - Delegates

extension DemoViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1
        if lastPage {
            hideControls()
            closeButton.isHidden = false
        }
        else {
            showControls()
            closeButton.isHidden = true
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
//        if let currentViewController = pageViewController(self, viewControllerAfter: (viewControllers?.first ?? pages.first)!) {
//                let isLastViewController = currentViewController == pages.last
//                let buttonTitle = isLastViewController ? "Get Started" : "Next"
//                nextButton.setTitle(buttonTitle, for: .normal)
//            }
    }
    
    private func hideControls() {
        pageControlBottomAnchor?.constant = -80
        nextButton.isHidden = true
        closeButton.isHidden = true
        //skipButtonTopAnchor?.constant = -80
        //nextButtonTopAnchor?.constant = -80
    }

    private func showControls() {
        pageControlBottomAnchor?.constant = 16
        //skipButtonTopAnchor?.constant = 16
        //nextButtonTopAnchor?.constant = 16
    }
}

// MARK: - Actions

extension DemoViewController {

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }

    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        animateControlsIfNeeded()
        
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }
    
    @objc func dismissOnBoarding() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extensions

extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
