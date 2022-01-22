//
//  UsedCarsViewModelTests.swift
//  UsedCarListingsTests
//
//  Created by Rupika Sompalli on 2022-01-22.
//

import XCTest
import Combine
@testable import UsedCarListings

class UsedCarsViewModelTests: XCTestCase {
    
    var viewModel: UsedCarsViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UsedCarsViewModel(service: UsedCarServiceMock(), imageLoader: ImageLoaderServiceMock())
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_viewModelInitialState() {
        XCTAssertNil(viewModel.listings)
        XCTAssertNil(viewModel.error)
        XCTAssertNil(viewModel.filterType)
    }
    
    func test_fetchCars() {
        let expectation = self.expectation(description: "fetch_cars")
        viewModel.fetchCars()
        viewModel
            .$listings
            .sink { _ in
                expectation.fulfill()
            }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(viewModel.listings?.count ?? 0 > 0)
    }
    
    func test_downloadCarImage() {
        let expectation = self.expectation(description: "get_car_image")
        let car = mockUsedCar()
        var carImage: UIImage?
        viewModel.getCarImage(for: car) { image in
            carImage = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(carImage)
    }
    
    func mockUsedCar() -> UsedCar {
        UsedCar(
            images: mockUsedCarImages(),
            year: 2020,
            make: "Toyota",
            model: "Camry",
            trim: "2.4L AWD",
            listPrice: 24567,
            currentPrice: 23678,
            mileage: 156000,
            dealer: mockDealer()
        )
    }
    
    func mockUsedCarImages() -> UsedCarImages {
        UsedCarImages(large: ["test"], medium: ["test"], small: ["test"])
    }
    
    func mockDealer() -> Dealer {
        Dealer(dealerId: "", name: "", address: "", phone: "", state: "", zip: "", avgRating: 4)
    }
}
