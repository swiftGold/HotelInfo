import UIKit

class CustomVC: UIViewController {
    func setupNavBar(titleName: String) {
        customNavBarTitle(titleName: titleName)
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .customNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.topItem?.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupNavBarWithoutTitle() {
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .customNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    func customNavBarTitle(titleName: String) {
        let label = UILabel()
        label.text = titleName
        label.font = UIFont(name: Fonts.sfProDisplayMedium,
                            size: Constants.customNavBarTitleFontSize
        )
        label.textColor = .customNavBar
        navigationItem.titleView = label
    }
    
    enum Constants {
        static let customNavBarTitleFontSize: CGFloat = 18
    }
}
