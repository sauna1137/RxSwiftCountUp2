//
//  ViewController.swift
//  RxSwiftCountUp2
//
//  Created by KS on 2021/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var countDownButton: UIButton!


    private let count: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    private let dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindButtonToValue()
        bindCountToText()
        bindCountDownButtonToValue()
    }

    private func bindButtonToValue() {
        button.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.increment()})
            .disposed(by: dispose)
    }

    private func bindCountDownButtonToValue() {
        countDownButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.downCount()})
            .disposed(by: dispose)
    }

    private func increment() {
         count.accept(count.value + 1)
     }

    private func downCount() {
        count.accept(count.value - 1)
    }

    private func bindCountToText() {
        count.asObservable()
            .subscribe(onNext: {[weak self] count in
                self?.label.text = String(count) })
            .disposed(by: dispose)
    }
}
