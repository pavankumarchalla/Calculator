//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by Pavan Kumar C on 16/08/18.
//  Copyright © 2018 pavan. All rights reserved.
//

import WatchKit
import Foundation

enum modes {
    case NOT_SET
    case ADDITION
    case SUBTRACTION
}

class InterfaceController: WKInterfaceController {

    var labelString = "0"
    var currentMode = modes.NOT_SET
    var savedNum: Int64 = 0
    var lastButtonWasMode = false

    @IBOutlet var displayLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    // IBAction methods
    @IBAction func tappedPlus() {
        changeMode(newMode: modes.ADDITION)
    }

    @IBAction func tappedMinus() {
        changeMode(newMode: modes.SUBTRACTION)
    }

    @IBAction func tappedClear() {
        savedNum = 0
        labelString = "0"
        displayLabel.setText(labelString)
        currentMode = modes.NOT_SET
        lastButtonWasMode = false
    }

    @IBAction func tappedEquals() {
        guard let num = Int64(labelString) else {
            return
        }

        if currentMode == modes.NOT_SET || lastButtonWasMode {
            return
        }

        if currentMode == modes.ADDITION {
            savedNum += num
        } else if currentMode == modes.SUBTRACTION {
            savedNum -= num
        }

        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }

    @IBAction func tapped0() { tappedNumber(num: 0) }
    @IBAction func tapped1() { tappedNumber(num: 1) }
    @IBAction func tapped2() { tappedNumber(num: 2) }
    @IBAction func tapped3() { tappedNumber(num: 3) }
    @IBAction func tapped4() { tappedNumber(num: 4) }
    @IBAction func tapped5() { tappedNumber(num: 5) }
    @IBAction func tapped6() { tappedNumber(num: 6) }
    @IBAction func tapped7() { tappedNumber(num: 7) }
    @IBAction func tapped8() { tappedNumber(num: 8) }
    @IBAction func tapped9() { tappedNumber(num: 9) }

    // MARK: - Custom methods
    private func tappedNumber(num: Int) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString = labelString.appending("\(num)")
        updateText()
    }

    private func updateText() {
        guard let labelInt = Int64(labelString) else {
            displayLabel.setText("number is too large.")
            return
        }

        savedNum = currentMode == modes.NOT_SET ? labelInt : savedNum

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let intNum = NSNumber(value: labelInt)
        let str = formatter.string(from: intNum)!

        displayLabel.setText("\(str)")
    }

    private func changeMode(newMode: modes) {
        if savedNum == 0 {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
}
