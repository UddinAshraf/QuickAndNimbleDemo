//
//  CarListViewController.swift
//  QuickAndNimbleDemo
//
//  Created by Ashraf on 4/21/19.
//  Copyright © 2019 BS23. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {
    
    var carListData: CarListResponse? {
        didSet {
            if carListData != nil, carListData?.data.count ?? 0 > 0 {
                bindViewModelData(with: carListData)
                tableView.reloadData()
            }
        }
    }
    var carViewModels: [CarViewModel] = []
    
    //Outlets
    lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.tableFooterView = UIView.init(frame: .zero)
        $0.delegate = self
        $0.dataSource = self
        $0.register(CarCell.self)
        
        return $0
    }(UITableView(frame:.zero, style: .plain))

    //MARK: Life cycle
    init() {
        self.carListData = nil
        super.init(nibName: nil, bundle: nil)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func setUpView() {
        view.addSubview(tableView)
        

        //Constraints
        NSLayoutConstraint.activate([
            {
                if #available(iOS 11, *) {
                    return tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
                } else {
                    return tableView.topAnchor.constraint(equalTo: view.topAnchor)
                }
            }(),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: UITableViewDatasource and UITableViewDelegate Methods
extension CarListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CarCell.self, for: indexPath)
        
        cell.selectionStyle = .none
        cell.contentView.clipsToBounds = true
        cell.delegate = self
        cell.viewModel = carViewModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Car List"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

//MARK: CarCellDelegate methods
extension CarListViewController: CarCellDelegate {
    func clickedOnSeeDetails(viewModel: CarViewModel) {
        print("___________________")
    }
    
    func clickedOnBuy(viewModel: CarViewModel) {
        print("___________________")
    }
    
    
}

//MARK: Service
extension CarListViewController {
    
    fileprivate func getData() {
        carListData = ServiceHelper.fromJSON("CarList")
    }
    
    fileprivate func bindViewModelData(with data: CarListResponse?) {
        
        if let carsData = data?.data {
            self.carViewModels = carsData.map{
                CarViewModel(car: $0)
            }
        }
    }
}


//HACKY!! [Data should Come from Service :D]
class ServiceHelper {
    static func fromJSON(_ fileName: String, fileExtension:String="json") -> CarListResponse? {
        let url = Bundle(for: self).url(forResource: fileName, withExtension: fileExtension)!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(CarListResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

