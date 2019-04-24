//
//  CarListViewControllerSpec.swift
//  QuickAndNimbleDemoTests
//
//  Created by Ashraf on 4/22/19.
//  Copyright © 2019 BS23. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import QuickAndNimbleDemo

class CarListViewControllerSpec: QuickSpec {
    var vc: CarListViewController!
    
    override func spec() {
        describe("Car List ViewController") {
            
            context("TableView DataSource") {
                beforeEach {
                   self.vc = CarListViewController()
                   let window = UIWindow(frame: UIScreen.main.bounds)
                   window.makeKeyAndVisible()
                   window.rootViewController = self.vc
                    _ = self.vc.view
                    RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
                }
                
                //Creates a mock data for first row
                let response: CarListResponse = StubHelper.fromJSON(StubType.carList.rawValue)!
                let indexPath = IndexPath(row: 0, section: 0)
                let cellViewModel = CarViewModel(car: response.data[0])
                
                it("Number of rows must be equal to number of viewModels"){
                    let numberOfRows = response.data.count
                    expect(self.vc.tableView.numberOfRows(inSection: 0)).to(equal(numberOfRows))
                }
                
                it("Car title must not be nil") {
                    let cell = self.vc.tableView.dequeue(CarCell.self, for: indexPath)
                    cell.viewModel = cellViewModel
                    expect(cell.carTitleLabel).notTo(beNil())
                }
                
                it("Details Button Should Contain Proper title") {
                    let cell = self.vc.tableView.dequeue(CarCell.self, for: indexPath)
                    cell.viewModel = cellViewModel
                    expect(cell.seeDetailsButton.titleLabel?.text).to(equal("See Details"))
                }
                
                it("Sold ribbon label must be hidden if the car is sold") {
                    let cell = self.vc.tableView.dequeue(CarCell.self, for: indexPath)
                    cell.viewModel = cellViewModel
                    expect(cell.soldRibbonLabel.isHidden).to(equal(!cellViewModel.isSold))
                }
                
                it("Buy ribbon label must not be hidden if the car is sold") {
                    let cell = self.vc.tableView.dequeue(CarCell.self, for: indexPath)
                    cell.viewModel = cellViewModel
                    expect(cell.buyButton.isHidden).to(equal(cellViewModel.isSold))
                }
            }
        }
    }
}
