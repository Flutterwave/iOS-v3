//
//  FlutterWave+UIPickerView.swift
//  FlutterwaveSDK
//
//  Created by Rotimi Joshua on 02/09/2020.
//
import UIKit

@available(iOS 11.0, *)
extension FlutterwavePayViewController : UITextFieldDelegate,CardSelect,UIPickerViewDelegate,UIPickerViewDataSource,FlutterwavePayWebProtocol{
    func tranasctionSuccessful(flwRef: String, responseData:FlutterwaveDataResponse?) {
        self.dismiss(animated: true) {
            self.delegate?.tranasctionSuccessful(flwRef: flwRef, responseData: responseData)
        }
    }
    
    func cardSelected(card: SavedCard?) {
        flutterwaveCardClient.selectedCard = card
        if let card =  flutterwaveCardClient.selectedCard{
            //LoadingHUD.shared.show()
            CardViewModel.sharedViewModel.sendCardOtp(cardHash: card.cardHash ?? "")
           // flutterwaveCardClient.sendOTP(card: card)
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
         if (textField == pinViewContainer.hiddenPinTextField){
             pinViewContainer.pins.forEach { (item) in
                 item.backgroundColor = .white
             }
             
             if let text = textField.text {
                 for (index, _) in text.prefix(pinViewContainer.pins.count).enumerated() {
                     pinViewContainer.pins[index].backgroundColor = .gray
                 }
                 if text.count == pinViewContainer.pins.count {
                     textField.resignFirstResponder()
                 }
             }
         }
        
         if (textField == debitCardView.cardNumberTextField){
             if let text = textField.text, text.count == 6 {
                 flutterwaveCardClient.amount = self.amount
                 flutterwaveCardClient.cardfirst6 = text
             }
         }
     }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        if textField == selectBankAccountView.otherBanksTextField{
            if let count = self.banks?.count, count > 0{
                bankPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(bankPicker, didSelectRow: 0, inComponent: 0)
            }
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let bankCode = selectedBankCode else {
            return
        }
        if textField == selectBankAccountView.otherBanksTextField {
            let colorStyle = RaveConstants.bankStyle.filter { (item) -> Bool in
                return item.code == bankCode
            }.first
            if let style = colorStyle{
                //                let isdobHidden = (style.code == "057" || style.code == "033")  ? true : true
                //                let isBvnHidden = style.code == "033" ? true : true
                showAccountFormScreen(withBackGround: style.color, imageName: style.image)
            }else if selectedBankCode != ""{
                showAccountFormScreen()
            }else {
                showSnackBarWithMessage(msg: "Please select a bank", style: .error)
            }
        }
    }
    func showAccountFormScreen(withBackGround backgroundColor:String = "#f2f2f2", imageName:String = "" ){
        accountFormContainer.isHidden = false
        
        self.selectUssdBankView.otherBanksTextField.resignFirstResponder()
        accountFormContainer.alpha = 0
        
        if selectedBankCode == "057" {
            accountFormContainer.dobTextField.isHidden = false
        }else {
            accountFormContainer.dobTextField.isHidden = true
        }
        if selectedBankCode == "033" {
            accountFormContainer.accountBvn.isHidden = false
        }else {
            accountFormContainer.accountBvn.isHidden = true
        }
        
        //selectBankAccountView
        UIView.animate(withDuration: 0.6, animations: {
            self.accountFormContainer.alpha = 1
            self.accountFormContainer.backgroundColor = UIColor(hex: "#f2f2f2")
            self.accountFormContainer.accountImageView.image = UIImage(named: imageName,in: Bundle.getResourcesBundle(), compatibleWith: nil)
            self.selectBankAccountView.alpha = 0
        }) { (succeeded) in
            self.selectBankAccountView.isHidden = true
        }
    }
    
    @objc func goBackButtonTapped(){
        self.selectBankAccountView.isHidden = false
        self.selectBankAccountView.alpha = 0
        self.accountFormContainer.accountNumberTextField.text = ""
        self.accountFormContainer.phoneNumberTextField.text = ""
        self.accountFormContainer.dobTextField.text = ""
        UIView.animate(withDuration: 0.6, animations: {
            self.accountFormContainer.alpha = 0
            
            self.selectBankAccountView.alpha = 1
        }) { (succeeded) in
            self.accountFormContainer.isHidden = true
            self.accountFormContainer.dobTextField.isHidden = true
        }
    }
    
    
    func showUssd(){
        self.confirmUssdView.isHidden = false
        self.confirmUssdView.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.confirmUssdView.alpha = 1
            self.selectUssdBankView.alpha = 0
        }) { (completed) in
            self.selectUssdBankView.isHidden = true
        }
    }
    
    
    func goBackUssdButtonTapped(){
        self.selectUssdBankView.isHidden = false
        self.selectUssdBankView.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.selectUssdBankView.alpha = 1
            self.confirmUssdView.alpha = 0
        }) { (completed) in
            self.confirmUssdView.isHidden = true
        }
    }
    
    func showBillingAddress(){
        billingAddressContainer.isHidden = false
        billingAddressContainer.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.billingAddressContainer.alpha = 1
            self.debitCardView.alpha = 0
            self.pinViewContainer.alpha = 0
        }) { (completed) in
            self.debitCardView.isHidden = true
            self.pinViewContainer.isHidden = true
        }
    }
    
    
    func showUkDetailsView(){
        ukDetailsViewContainer.isHidden = false
        ukDetailsViewContainer.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.ukDetailsViewContainer.alpha = 1
            self.ukViewContainer.alpha = 0
        }) { (completed) in
            self.ukViewContainer.isHidden = true
        }
    }
    
    
    func goBackBillingButtonTapped(){
        self.debitCardView.isHidden = false
        self.debitCardView.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.debitCardView.alpha = 1
            self.billingAddressContainer.alpha = 0
            self.pinViewContainer.alpha = 0
        }) { (completed) in
            self.billingAddressContainer.isHidden = true
            self.pinViewContainer.isHidden = true
        }
    }
    
    func showBankTransferViewTwo(){
        self.bankTransferViewTwo.isHidden = false
        
        self.bankTransferViewTwo.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.bankTransferViewTwo.alpha = 1
            self.bankTransferViewOne.alpha = 0
        }) { (completed) in
            self.bankTransferViewOne.isHidden = true
            
        }
    }
    
    func showPin(){
        pinViewContainer.isHidden = false
        pinViewContainer.alpha = 0
        debitCardView.alpha = 1
        UIView.animate(withDuration: 0.6, animations: {
            self.pinViewContainer.alpha = 1
            self.debitCardView.alpha = 0
        }) { (completed) in
            self.debitCardView.isHidden = true
            self.pinViewContainer.hiddenPinTextField.becomeFirstResponder()
        }
        
    }
    @objc func showDebitCardView(){
        debitCardView.isHidden = false
        debitCardView.alpha = 0
        saveCardContainer.alpha = 1
        UIView.animate(withDuration: 0.6, animations: {
            self.debitCardView.alpha = 1
            self.saveCardContainer.alpha = 0
        }) { (completed) in
            self.saveCardContainer.isHidden = true
        }
    }
    func showWebView(url: String?,ref:String?){
        //Collapse opened Tabs
       // self.handelCloseOrExpandSection(section: 0)
        //Show web view
        //let storyBoard = UIStoryboard(name: "Rave", bundle: nil)
        let controller = RavePayWebViewController()
        controller.flwRef = ref
        controller.url = url
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showOTP(message:String, flwRef:String, otpType:OTPType){
        self.otpContentContainer.isHidden = false
        self.accountOtpContentContainer.isHidden = false
        switch otpType {
        case .savedCard:
            
            otpContentContainer.alpha = 0
            otpContentContainer.otpMessage.text = message
            otpContentContainer.otpButton.removeTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.removeTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.addTarget(self, action: #selector(saveCardOTPButtonTapped), for: .touchUpInside)
            
            UIView.animate(withDuration: 0.6, animations: {
                self.otpContentContainer.alpha = 1
                self.pinViewContainer.alpha = 0
                self.debitCardView.alpha = 0
                self.saveCardContainer.alpha = 0
            }) { (success) in
                self.pinViewContainer.isHidden = true
                self.debitCardView.isHidden = true
                self.saveCardContainer.isHidden = true
            }
            
        case .card:
            
            otpContentContainer.alpha = 0
            otpContentContainer.otpMessage.text = message
            otpContentContainer.otpButton.removeTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.removeTarget(self, action: #selector(saveCardOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.addTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
            
            
            flutterwaveCardClient.transactionReference = flwRef
            UIView.animate(withDuration: 0.6, animations: {
                self.otpContentContainer.alpha = 1
                self.pinViewContainer.alpha = 0
                self.debitCardView.alpha = 0
            }) { (success) in
                self.pinViewContainer.isHidden = true
                self.debitCardView.isHidden = true
            }
        case .bank:
            print("")
            //            accountOtpContentContainer.alpha = 0
            //            accountOtpContentContainer.otpMessage.text = message
            //            accountOtpContentContainer.otpTextField.text = ""
            //            accountOtpContentContainer.otpButton.addTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            //            raveAccountClient.transactionReference = flwRef
            //            UIView.animate(withDuration: 0.6, animations: {
            //                self.accountOtpContentContainer.alpha = 1
            //                self.accountFormContainer.alpha = 0
            //                self.selectBankAccountView.alpha = 0
            //            }) { (success) in
            //                self.accountFormContainer.isHidden = true
            //                self.selectBankAccountView.isHidden = true
            //            }
        }
    }
    @objc func accountOTPButtonTapped(){
        self.view.endEditing(true)
        
        guard let otp = accountOtpContentContainer.otpTextField.text, otp != ""  else {
            return
        }
        LoadingHUD.shared.show()
        flutterwaveAccountClient.otp = otp
        //        raveAccountClient.validateAccountOTP()
    }
    
    @objc func cardOTPButtonTapped(){
        self.view.endEditing(true)
        
        
        let otpValid = self.otpContentContainer.otpTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "OTP"))
        
        if(otpValid){
            flutterwaveCardClient.otp = otpContentContainer.otpTextField.text
            flutterwaveCardClient.validateCardOTP()
        }
        
    }
    
    @objc func saveCardOTPButtonTapped(){
        self.view.endEditing(true)
        guard let otp = otpContentContainer.otpTextField.text, otp != ""  else {
            return
        }
       // LoadingHUD.shared.show()
        flutterwaveCardClient.otp = otp
        flutterwaveCardClient.isSaveCardCharge = "1"
        flutterwaveCardClient.saveCardPayment = "saved-card"
        flutterwaveCardClient.amount = self.amount
        flutterwaveCardClient.saveCardCharge()
    }
    @objc func pinContinueButtonTapped(){
        self.pinAction()
    }
    
 
    func pinAction(){
           self.view.endEditing(true)
           guard let pin = self.pinViewContainer.hiddenPinTextField.text else {return}
            flutterwaveCardClient.bodyParam?.merge(["authorization":
               ["mode":"pin","pin":pin]
           ])
           flutterwaveCardClient.chargeCard()
       }
    
    @objc func billAddressButtonTapped(){
        
        let zipValid = self.billingAddressContainer.zipCodeTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "zip"))
        let cityValid = self.billingAddressContainer.cityTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "city"))
        let addressValid = self.billingAddressContainer.billingAddressTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "address"))
        let countyValid = self.billingAddressContainer.countryTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "country"))
        let stateValid = self.billingAddressContainer.stateTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "state"))
        
        if (zipValid && cityValid && addressValid && countyValid && stateValid ){
            self.billAddressAction()
        }
        
        
    }
    
    func billAddressAction(){
        self.view.endEditing(true)
        guard let zip = self.billingAddressContainer.zipCodeTextField.text, let city = self.billingAddressContainer.cityTextField.text,
            let address = self.billingAddressContainer.billingAddressTextField.text, let country = self.billingAddressContainer.countryTextField.text , let state = self.billingAddressContainer.stateTextField.text else {return}
        
        flutterwaveCardClient.bodyParam?.merge(["authorization":
            ["mode":"avs_noauth","city": city,"address":address, "state":state, "country":country, "zipcode": zip]
        ])
        
        flutterwaveCardClient.chargeCard()
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let ussdBanks = getUssdBanks()
        let francophoneCountries = getFrancophoneCountries(countryCode: FlutterwaveConfig.sharedConfig().currencyCode)
//        print("Current PickerView Tag \(pickerView.tag)")
        if pickerView.tag == 12 {
//            print("Country Code logic")
            if let count = self.banks?.count{
                return count
            }else{
                return 0
            }
        }else if  pickerView.tag == 13{
            return ussdBanks.count
        }else if  pickerView.tag == 15{
            return francophoneCountries.count
        }else if  pickerView.tag == 17{
            return RaveConstants.zambianNetworks.count
        }
        else{
            return RaveConstants.ghsMobileNetworks.count
        }
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ussdBanks = getUssdBanks()
        let francophoneCountries = getFrancophoneCountries(countryCode: FlutterwaveConfig.sharedConfig().currencyCode)
        if pickerView.tag == 12 {
            //
            return self.banks?[row].name
        }else if pickerView.tag == 13 {
            return ussdBanks[row].bankName
        }
        else if pickerView.tag == 15 {
            return francophoneCountries[row].countryName
        }
        else  if pickerView.tag == 17 {
            return  RaveConstants.zambianNetworks[row]
        }
        else{
            return RaveConstants.ghsMobileNetworks[row].0
        }
        
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let ussdBanks = getUssdBanks()
        let francophoneCountries = getFrancophoneCountries(countryCode: FlutterwaveConfig.sharedConfig().currencyCode)
        if pickerView.tag == 12 {
            self.selectedBankCode = self.banks?[row].bankCode
            self.selectBankAccountView.otherBanksTextField.text = self.banks?[row].name
            self.selectBankAccountView.otherBanksTextField.sendActions(for: .editingChanged)
        } else if pickerView.tag == 13 {
            self.selectedUSSDBank = ussdBanks[row]
            self.selectedBankCode = ussdBanks[row].bankCode
            self.selectUssdBankView.otherBanksTextField.text = ussdBanks[row].bankName
            self.selectUssdBankView.otherBanksTextField.sendActions(for: .editingChanged)
        }else if pickerView.tag == 15 {
            self.selectedFrancophoneCountry = francophoneCountries[row]
            self.selectedFrancophoneCountryCode = francophoneCountries[row].countryCode
            self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.text = francophoneCountries[row].countryName
            self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.sendActions(for: .editingChanged)
            
        }
        else if pickerView.tag == 17 {
            self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.text = RaveConstants.zambianNetworks[row]
            flutterwaveMoneyZM.network = RaveConstants.zambianNetworks[row]
        }
        else{
            self.mobileMoneyContentView.mobileMoneyChooseNetwork.text = RaveConstants.ghsMobileNetworks[row].0
            self.mobileMoneyContentView.mobileMoneyTitle.text = RaveConstants.ghsMobileNetworks[row].1
            
            if (RaveConstants.ghsMobileNetworks[row].0 == "VODAFONE"){
                mobileMoneyContentView.mobileMoneyVoucher.isHidden = false
            }else{
                mobileMoneyContentView.mobileMoneyVoucher.isHidden = true
            }
            flutterwaveMobileMoney.selectedMobileNetwork = RaveConstants.ghsMobileNetworks[row].0
        }
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
}
