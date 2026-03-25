//
//  NewRavePayViewController.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 05/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

class Expandables{
    var isExpanded:Bool
    var section:Int
    
    init(isExpanded:Bool,section:Int) {
        self.isExpanded = isExpanded
        self.section = section
    }
}

enum OTPType {
    case card, bank, savedCard
}

public protocol  FlutterwavePayProtocol : class{
    func tranasctionSuccessful(flwRef:String?, responseData:FlutterwaveDataResponse?)
    func tranasctionFailed(flwRef:String?,responseData:FlutterwaveDataResponse?)
    func onDismiss()
}


@available(iOS 11.0, *)
public class FlutterwavePayViewController: BaseViewController {
    var howCell: UITableViewCell = UITableViewCell()
    var cardCell: UITableViewCell = UITableViewCell()
    var accountCell: UITableViewCell = UITableViewCell()
    var mpesaCell: UITableViewCell = UITableViewCell()
    var mobileMoneyGH: UITableViewCell = UITableViewCell()
    var mobileMoneyUG: UITableViewCell = UITableViewCell()
    var mobileMoneyRW: UITableViewCell = UITableViewCell()
    var mobileMoneyFR: UITableViewCell = UITableViewCell()
    var mobileMoneyZM: UITableViewCell = UITableViewCell()
    var ukAccountCell: UITableViewCell = UITableViewCell()
    var ussdCell: UITableViewCell = UITableViewCell()
    var barterCell: UITableViewCell = UITableViewCell()
    var bankTransferCell: UITableViewCell = UITableViewCell()
    
    
    
    let toolbar = UIToolbar()
    let disposeBag = DisposeBag()
    var pin = ""
    
    
    let navBarHeight:CGFloat = UIApplication.bottomSafeAreaHeight
    
    
    
    var expandables = [Expandables(isExpanded: true, section: 0),Expandables(isExpanded: false, section: 1),Expandables(isExpanded: false, section: 2),Expandables(isExpanded: false, section: 3),Expandables(isExpanded: false, section: 4),Expandables(isExpanded: false, section: 5),Expandables(isExpanded: false, section: 6),Expandables(isExpanded: false, section: 7),Expandables(isExpanded: false, section: 8),Expandables(isExpanded: false, section: 9),Expandables(isExpanded: false, section: 10),Expandables(isExpanded: false, section: 11),Expandables(isExpanded: false, section: 12), Expandables(isExpanded: false, section: 13)]
    
    var headers = [FlutterwaveHeaderView?]()
    public weak var delegate: FlutterwavePayProtocol?
    lazy var howView: HowView = {
        let b = HowView()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    lazy var  debitCardContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ukContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var  accountContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var  mobileMoneyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyUgandaContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyRWContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyFRContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyZMContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mpesaContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //    lazy var debitCardView: DebitCardView = {
    //        let view = DebitCardView()
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    lazy var debitCardView: DebitCardViewNew = {
        let view = DebitCardViewNew()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var ukViewContainer: UKAccountView = {
        let view = UKAccountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var ukDetailsViewContainer: UKAccountDetailsView = {
        let view = UKAccountDetailsView()
        view.isHidden = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ussdContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pinViewContainer: PinView = {
        let view = PinView()
        view.isHidden = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var otpContentContainer: OTPView = {
        let view = OTPView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var accountOtpContentContainer: OTPView = {
        let view = OTPView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mobileMoneyContentView: MobileMoneyGHView = {
        let view = MobileMoneyGHView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyPendingView: MobileMoneyGHPendingView = {
        let view = MobileMoneyGHPendingView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mobileMoneyUgandaContentContainer: MobileMoneyUganda = {
        let view = MobileMoneyUganda()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyRWContentContainer: MobileMoneyRW = {
        let view = MobileMoneyRW()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyFRContentContainer: MobileMoneyFR = {
        let view = MobileMoneyFR()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyZMContentContainer: MobileMoneyZM = {
        let view = MobileMoneyZM()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mpesaView: MpesaView = {
        let view = MpesaView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mpesaBusinessView: MPesaBusinessView = {
        let view = MPesaBusinessView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mpesaPendingView: MpesaPendingView = {
        let view = MpesaPendingView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var billingAddressContainer: BillingAddress = {
        let view = BillingAddress()
        view.isHidden = true
        view.goBackButton.rx.tap.subscribe(onNext: {
            self.goBackBillingButtonTapped()
        }).disposed(by: disposableBag)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    lazy var saveCardContainer: SavedCardsView = {
        let view = SavedCardsView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let selectBankAccountView:SelectBankAccountView = {
        let view = SelectBankAccountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let accountFormContainer:AccountForm = {
        let view = AccountForm()
        view.goBack.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var barterContentContainer: BarterView = {
        let view = BarterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    lazy var bankTransferContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bankTransferViewOne: BankTransferViewOne = {
        let view = BankTransferViewOne()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bankTransferViewTwo: BankTransferViewTwo = {
        let view = BankTransferViewTwo()
        view.isHidden = true
        //           view.goBackButton.rx.tap.subscribe(onNext: {
        //               self.goBackUssdButtonTapped()
        //           }).disposed(by: disposableBag)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var selectUssdBankView:USSDSelectBankView = {
        let view = USSDSelectBankView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var confirmUssdView: USSDConfirmView = {
        let view = USSDConfirmView()
        view.isHidden = true
        view.goBackButton.rx.tap.subscribe(onNext: {
            self.goBackUssdButtonTapped()
        }).disposed(by: disposableBag)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    
    let flutterwaveCardClient = FlutterwaveCardClient()
    let flutterwaveAccountClient = FlutterwaveAccountClient()
    let flutterwaveUKAccountClient = FlutterwaveAccountClient()
    let flutterwaveMpesaClient = FlutterwaveMpesaClient()
    let flutterwaveMobileMoney = FlutterwaveMobileMoneyClient()
    let flutterwaveMobileMoneyUganda = FlutterwaveMobileMoneyClient()
    let flutterMobileMoneyRW = FlutterwaveMobileMoneyClient()
    let flutterwaveMobileMoneyFR = FlutterwaveMobileMoneyClient()
    let flutterwaveMoneyZM = FlutterwaveMobileMoneyClient()
    public var amount:String?
    var saveCardTableController:SaveCardViewController!
    var savedCards:[SavedCard]?
    var bankPicker:UIPickerView!
    var ussdBankPicker:UIPickerView!
    var francoCountryPicker:UIPickerView!
    var ghsMobileMoneyPicker:UIPickerView!
    var zambiaMobileMoneyPicker:UIPickerView!
    var banks:[Bank]? = [] {
        didSet{
            bankPicker.reloadAllComponents()
        }
    }
    var selectedBankCode:String?
    var selectedNetwork:String?
    var selectedUSSDBank:USSDBanks?
    var selectedFrancophoneCountry:FrancophoneCountries?
    var selectedFrancophoneCountryCode:String?
    override public func loadView() {
        super.loadView()
        
       
        
        howCell.backgroundColor = .clear
        cardCell.backgroundColor = .clear
        mpesaCell.backgroundColor = .clear
        accountCell.backgroundColor = .clear
        ukAccountCell.backgroundColor = .clear
        mobileMoneyGH.backgroundColor = .clear
        mobileMoneyUG.backgroundColor = .clear
        mobileMoneyRW.backgroundColor = .clear
        mobileMoneyFR.backgroundColor = .clear
        mobileMoneyZM.backgroundColor = .clear
        // USSD CELL Background
        ussdCell.backgroundColor = .clear
        
        // BARTER CELL Background
        barterCell.backgroundColor = .clear
        
        ukAccountCell.contentView.addSubview(ukContentContainer)
        howCell.contentView.addSubview(howView)
        cardCell.contentView.addSubview(debitCardContentContainer)
        accountCell.contentView.addSubview(accountContentContainer)
        mpesaCell.contentView.addSubview(mpesaContentContainer)
        
        //Add USSD CONTENT CONTAINER TOO UDSD Cell
        ussdCell.contentView.addSubview(ussdContentContainer)
        
        //Add BARTER CONTENT CONTAINER TOO BARTER Cell
        barterCell.contentView.addSubview(barterContentContainer)
        
        //Add BANK TRANSFER CONTENT CONTAINER TO BANK TRANSFER CELL
        //        bankTransferCell
        bankTransferCell.contentView.addSubview(bankTransferContentContainer)
        
        bankTransferContentContainer.addSubview(bankTransferViewOne)
        bankTransferContentContainer.addSubview(bankTransferViewTwo)
        
        ukContentContainer.addSubview(ukViewContainer)
        ukContentContainer.addSubview(ukDetailsViewContainer)
        
        mobileMoneyRW.contentView.addSubview(mobileMoneyRWContainer)
        mobileMoneyFR.contentView.addSubview(mobileMoneyFRContainer)
        mobileMoneyRWContainer.addSubview(mobileMoneyRWContentContainer)
        mobileMoneyFRContainer.addSubview(mobileMoneyFRContentContainer)
        
        mobileMoneyZM.contentView.addSubview(mobileMoneyZMContainer)
        mobileMoneyZMContainer.addSubview(mobileMoneyZMContentContainer)
        
        debitCardContentContainer.addSubview(debitCardView)
        debitCardContentContainer.addSubview(pinViewContainer)
        debitCardContentContainer.addSubview(otpContentContainer)
        
        debitCardContentContainer.addSubview(billingAddressContainer)
        debitCardContentContainer.addSubview(saveCardContainer)
        
        accountContentContainer.addSubview(selectBankAccountView)
        accountContentContainer.addSubview(accountFormContainer)
        accountContentContainer.addSubview(accountOtpContentContainer)
        
        
        mpesaContentContainer.addSubview(mpesaView)
        mpesaContentContainer.addSubview(mpesaBusinessView)
        mpesaContentContainer.addSubview(mpesaPendingView)
        
        mobileMoneyGH.contentView.addSubview(mobileMoneyContainer)
        mobileMoneyContainer.addSubview(mobileMoneyContentView)
        mobileMoneyContainer.addSubview(mobileMoneyPendingView)
        
        mobileMoneyUG.contentView.addSubview(mobileMoneyUgandaContainer)
        mobileMoneyUgandaContainer.addSubview(mobileMoneyUgandaContentContainer)
        
        ussdContentContainer.addSubview(selectUssdBankView)
        ussdContentContainer.addSubview(confirmUssdView)
        
        
        
        
        NSLayoutConstraint.activate([
            howView.leadingAnchor.constraint(equalTo: howCell.leadingAnchor),
            howView.trailingAnchor.constraint(equalTo: howCell.trailingAnchor),
            howView.topAnchor.constraint(equalTo: howCell.topAnchor),
            howView.bottomAnchor.constraint(equalTo: howCell.bottomAnchor),
            
            ukContentContainer.leadingAnchor.constraint(equalTo: ukAccountCell.leadingAnchor),
            ukContentContainer.trailingAnchor.constraint(equalTo: ukAccountCell.trailingAnchor),
            ukContentContainer.topAnchor.constraint(equalTo: ukAccountCell.topAnchor),
            ukContentContainer.bottomAnchor.constraint(equalTo: ukAccountCell.bottomAnchor),
            
            ukViewContainer.leadingAnchor.constraint(equalTo: ukContentContainer.leadingAnchor),
            ukViewContainer.trailingAnchor.constraint(equalTo: ukContentContainer.trailingAnchor),
            ukViewContainer.topAnchor.constraint(equalTo: ukContentContainer.topAnchor),
            ukViewContainer.bottomAnchor.constraint(equalTo: ukContentContainer.bottomAnchor),
            
            ukDetailsViewContainer.leadingAnchor.constraint(equalTo: ukContentContainer.leadingAnchor),
            ukDetailsViewContainer.trailingAnchor.constraint(equalTo: ukContentContainer.trailingAnchor),
            ukDetailsViewContainer.topAnchor.constraint(equalTo: ukContentContainer.topAnchor),
            ukDetailsViewContainer.bottomAnchor.constraint(equalTo: ukContentContainer.bottomAnchor),
            
            mobileMoneyRWContainer.leadingAnchor.constraint(equalTo: mobileMoneyRW.leadingAnchor),
            mobileMoneyRWContainer.trailingAnchor.constraint(equalTo: mobileMoneyRW.trailingAnchor),
            mobileMoneyRWContainer.topAnchor.constraint(equalTo: mobileMoneyRW.topAnchor),
            mobileMoneyRWContainer.bottomAnchor.constraint(equalTo: mobileMoneyRW.bottomAnchor),
            
            mobileMoneyFRContainer.leadingAnchor.constraint(equalTo: mobileMoneyFR.leadingAnchor),
            mobileMoneyFRContainer.trailingAnchor.constraint(equalTo: mobileMoneyFR.trailingAnchor),
            mobileMoneyFRContainer.topAnchor.constraint(equalTo: mobileMoneyFR.topAnchor),
            mobileMoneyFRContainer.bottomAnchor.constraint(equalTo: mobileMoneyFR.bottomAnchor),
            
            mobileMoneyZMContainer.leadingAnchor.constraint(equalTo: mobileMoneyZM.leadingAnchor),
            mobileMoneyZMContainer.trailingAnchor.constraint(equalTo: mobileMoneyZM.trailingAnchor),
            mobileMoneyZMContainer.topAnchor.constraint(equalTo: mobileMoneyZM.topAnchor),
            mobileMoneyZMContainer.bottomAnchor.constraint(equalTo: mobileMoneyZM.bottomAnchor),
            
            mobileMoneyRWContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyRWContainer.leadingAnchor),
            mobileMoneyRWContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyRWContainer.trailingAnchor),
            mobileMoneyRWContentContainer.topAnchor.constraint(equalTo: mobileMoneyRWContainer.topAnchor),
            mobileMoneyRWContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyRWContainer.bottomAnchor),
            
            mobileMoneyFRContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyFRContainer.leadingAnchor),
            mobileMoneyFRContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyFRContainer.trailingAnchor),
            mobileMoneyFRContentContainer.topAnchor.constraint(equalTo: mobileMoneyFRContainer.topAnchor),
            mobileMoneyFRContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyFRContainer.bottomAnchor),
            
            mobileMoneyZMContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyZMContainer.leadingAnchor),
            mobileMoneyZMContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyZMContainer.trailingAnchor),
            mobileMoneyZMContentContainer.topAnchor.constraint(equalTo: mobileMoneyZMContainer.topAnchor),
            mobileMoneyZMContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyZMContainer.bottomAnchor),
            
            accountContentContainer.leadingAnchor.constraint(equalTo: accountCell.leadingAnchor),
            accountContentContainer.trailingAnchor.constraint(equalTo: accountCell.trailingAnchor),
            accountContentContainer.topAnchor.constraint(equalTo: accountCell.topAnchor),
            accountContentContainer.bottomAnchor.constraint(equalTo: accountCell.bottomAnchor),
            
            //SET CONSTRAINTS FOR USSD CONTAINER
            ussdContentContainer.leadingAnchor.constraint(equalTo: ussdCell.leadingAnchor),
            ussdContentContainer.trailingAnchor.constraint(equalTo: ussdCell.trailingAnchor),
            ussdContentContainer.topAnchor.constraint(equalTo: ussdCell.topAnchor),
            ussdContentContainer.bottomAnchor.constraint(equalTo: ussdCell.bottomAnchor),
            //
            selectBankAccountView.leadingAnchor.constraint(equalTo: accountContentContainer.leadingAnchor),
            selectBankAccountView.trailingAnchor.constraint(equalTo: accountContentContainer.trailingAnchor),
            selectBankAccountView.topAnchor.constraint(equalTo: accountContentContainer.topAnchor),
            selectBankAccountView.bottomAnchor.constraint(equalTo: accountContentContainer.bottomAnchor),
            
            accountFormContainer.leadingAnchor.constraint(equalTo: accountContentContainer.leadingAnchor),
            accountFormContainer.trailingAnchor.constraint(equalTo: accountContentContainer.trailingAnchor),
            accountFormContainer.topAnchor.constraint(equalTo: accountContentContainer.topAnchor),
            accountFormContainer.bottomAnchor.constraint(equalTo: accountContentContainer.bottomAnchor),
            
            selectUssdBankView.leadingAnchor.constraint(equalTo: ussdContentContainer.leadingAnchor),
            selectUssdBankView.trailingAnchor.constraint(equalTo: ussdContentContainer.trailingAnchor),
            selectUssdBankView.topAnchor.constraint(equalTo: ussdContentContainer.topAnchor),
            selectUssdBankView.bottomAnchor.constraint(equalTo: ussdContentContainer.bottomAnchor),
            
            confirmUssdView.leadingAnchor.constraint(equalTo: ussdContentContainer.leadingAnchor),
            confirmUssdView.trailingAnchor.constraint(equalTo: ussdContentContainer.trailingAnchor),
            confirmUssdView.topAnchor.constraint(equalTo: ussdContentContainer.topAnchor),
            confirmUssdView.bottomAnchor.constraint(equalTo: ussdContentContainer.bottomAnchor),
            
            
            mpesaContentContainer.leadingAnchor.constraint(equalTo: mpesaCell.leadingAnchor),
            mpesaContentContainer.trailingAnchor.constraint(equalTo: mpesaCell.trailingAnchor),
            mpesaContentContainer.topAnchor.constraint(equalTo: mpesaCell.topAnchor),
            mpesaContentContainer.bottomAnchor.constraint(equalTo: mpesaCell.bottomAnchor),
            
            mpesaView.leadingAnchor.constraint(equalTo: mpesaContentContainer.leadingAnchor),
            mpesaView.trailingAnchor.constraint(equalTo: mpesaContentContainer.trailingAnchor),
            mpesaView.topAnchor.constraint(equalTo: mpesaContentContainer.topAnchor),
            mpesaView.bottomAnchor.constraint(equalTo: mpesaContentContainer.bottomAnchor),
            
            mpesaBusinessView.leadingAnchor.constraint(equalTo: mpesaContentContainer.leadingAnchor),
            mpesaBusinessView.trailingAnchor.constraint(equalTo: mpesaContentContainer.trailingAnchor),
            mpesaBusinessView.topAnchor.constraint(equalTo: mpesaContentContainer.topAnchor),
            mpesaBusinessView.bottomAnchor.constraint(equalTo: mpesaContentContainer.bottomAnchor),
            
            mpesaPendingView.leadingAnchor.constraint(equalTo: mpesaContentContainer.leadingAnchor),
            mpesaPendingView.trailingAnchor.constraint(equalTo: mpesaContentContainer.trailingAnchor),
            mpesaPendingView.topAnchor.constraint(equalTo: mpesaContentContainer.topAnchor),
            mpesaPendingView.bottomAnchor.constraint(equalTo: mpesaContentContainer.bottomAnchor),
            
            debitCardContentContainer.leadingAnchor.constraint(equalTo: cardCell.leadingAnchor),
            debitCardContentContainer.trailingAnchor.constraint(equalTo: cardCell.trailingAnchor),
            debitCardContentContainer.topAnchor.constraint(equalTo: cardCell.topAnchor),
            debitCardContentContainer.bottomAnchor.constraint(equalTo: cardCell.bottomAnchor),
            
            debitCardView.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            debitCardView.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            debitCardView.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            debitCardView.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            saveCardContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            saveCardContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            saveCardContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            saveCardContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            billingAddressContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            billingAddressContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            billingAddressContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            billingAddressContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            pinViewContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            pinViewContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            pinViewContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            pinViewContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            otpContentContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            otpContentContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            otpContentContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            otpContentContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            accountOtpContentContainer.leadingAnchor.constraint(equalTo: accountContentContainer.leadingAnchor),
            accountOtpContentContainer.trailingAnchor.constraint(equalTo: accountContentContainer.trailingAnchor),
            accountOtpContentContainer.topAnchor.constraint(equalTo: accountContentContainer.topAnchor),
            accountOtpContentContainer.bottomAnchor.constraint(equalTo: accountContentContainer.bottomAnchor),
            
            mobileMoneyContainer.leadingAnchor.constraint(equalTo: mobileMoneyGH.leadingAnchor),
            mobileMoneyContainer.trailingAnchor.constraint(equalTo: mobileMoneyGH.trailingAnchor),
            mobileMoneyContainer.topAnchor.constraint(equalTo: mobileMoneyGH.topAnchor),
            mobileMoneyContainer.bottomAnchor.constraint(equalTo: mobileMoneyGH.bottomAnchor),
            
            mobileMoneyContentView.leadingAnchor.constraint(equalTo: mobileMoneyContainer.leadingAnchor),
            mobileMoneyContentView.trailingAnchor.constraint(equalTo: mobileMoneyContainer.trailingAnchor),
            mobileMoneyContentView.topAnchor.constraint(equalTo: mobileMoneyContainer.topAnchor),
            mobileMoneyContentView.bottomAnchor.constraint(equalTo: mobileMoneyContainer.bottomAnchor),
            
            mobileMoneyPendingView.leadingAnchor.constraint(equalTo: mobileMoneyContainer.leadingAnchor),
            mobileMoneyPendingView.trailingAnchor.constraint(equalTo: mobileMoneyContainer.trailingAnchor),
            mobileMoneyPendingView.topAnchor.constraint(equalTo: mobileMoneyContainer.topAnchor),
            mobileMoneyPendingView.bottomAnchor.constraint(equalTo: mobileMoneyContainer.bottomAnchor),
            
            mobileMoneyUgandaContainer.leadingAnchor.constraint(equalTo: mobileMoneyUG.leadingAnchor),
            mobileMoneyUgandaContainer.trailingAnchor.constraint(equalTo: mobileMoneyUG.trailingAnchor),
            mobileMoneyUgandaContainer.topAnchor.constraint(equalTo: mobileMoneyUG.topAnchor),
            mobileMoneyUgandaContainer.bottomAnchor.constraint(equalTo: mobileMoneyUG.bottomAnchor),
            
            mobileMoneyUgandaContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.leadingAnchor),
            mobileMoneyUgandaContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.trailingAnchor),
            mobileMoneyUgandaContentContainer.topAnchor.constraint(equalTo: mobileMoneyUgandaContainer.topAnchor),
            mobileMoneyUgandaContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyUgandaContainer.bottomAnchor),
            
            
            
            
            //SET CONSTRAINTS FOR BARTER CONTAINER
            barterContentContainer.leadingAnchor.constraint(equalTo: barterCell.leadingAnchor),
            barterContentContainer.trailingAnchor.constraint(equalTo: barterCell.trailingAnchor),
            barterContentContainer.topAnchor.constraint(equalTo: barterCell.topAnchor),
            barterContentContainer.bottomAnchor.constraint(equalTo: barterCell.bottomAnchor),
            
            //SET CONSTRAINTS FOR BANK TRANSFER CONTAINER
            bankTransferContentContainer.leadingAnchor.constraint(equalTo: bankTransferCell.leadingAnchor),  bankTransferContentContainer.trailingAnchor.constraint(equalTo: bankTransferCell.trailingAnchor),
            bankTransferContentContainer.topAnchor.constraint(equalTo: bankTransferCell.topAnchor),
            bankTransferContentContainer.bottomAnchor.constraint(equalTo: bankTransferCell.bottomAnchor),
            
            
            bankTransferViewOne.leadingAnchor.constraint(equalTo: bankTransferContentContainer.leadingAnchor),
            bankTransferViewOne.trailingAnchor.constraint(equalTo: bankTransferContentContainer.trailingAnchor),
            bankTransferViewOne.topAnchor.constraint(equalTo: bankTransferContentContainer.topAnchor),
            bankTransferViewOne.bottomAnchor.constraint(equalTo: bankTransferContentContainer.bottomAnchor),
            
            bankTransferViewTwo.leadingAnchor.constraint(equalTo: bankTransferContentContainer.leadingAnchor),
            bankTransferViewTwo.trailingAnchor.constraint(equalTo: bankTransferContentContainer.trailingAnchor),
            bankTransferViewTwo.topAnchor.constraint(equalTo: bankTransferContentContainer.topAnchor),
            bankTransferViewTwo.bottomAnchor.constraint(equalTo: bankTransferContentContainer.bottomAnchor),
        ])
    }
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        
        cardCallbacks()
        accountCallbacks()
        saveCardCallbacks()
        
        setUpObservers()
        
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let navTitle = FlutterwavePayNavTitle(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        navTitle.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navTitle)
        
        let closeButton = UIButton(type: .system)
        closeButton.tintColor = .darkGray
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.titleLabel?.font  = UIFont.systemFont(ofSize: 17, weight: .bold)
        closeButton.titleLabel?.textAlignment = .center
        closeButton.frame = CGRect(x: 0, y:0, width: 40, height: 40)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        self.tableView.backgroundColor = UIColor(hex: "#F2F2F2")
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedRowHeight = 0
        configureView()
        configureDebitCardView()
        configureGBPView()
        configureBankView()
        configureOTPView()
        configureMpesaView()
        configureMobileMoneyGhana()
        configureMobileMoneyUganda()
        configureMobileMoneyRwanda()
        configureMobileMoneyFranco()
        configureMobileMoneyZambia()
        configureUssdBankView()
        configureBarter()
        configureBankTransfer()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        debitCardView.frame = debitCardContentContainer.frame
    }
    
    
    func configureView(){
        
        let debitCardHeader = getHeader()
        let bankAccountHeader = getHeader()
        let mpesaHeader = getHeader()
        let ghanaMobileMoneyHeader = getHeader()
        let ugandaMobileMoneyHeader = getHeader()
        let rwandaMobileMoneyHeader = getHeader()
        let francoMobileMoneyHeader = getHeader()
        let zambiaMobileMoneyHeader = getHeader()
        let ukMobileMoneyHeader = getHeader()
        let ussdHeader = getHeader()
        let payWithBarterHeader = getHeader()
        let payWithNigerianAccountHeader = getHeader()
        let payWithBankTransferHeader = getHeader()
        headers = [nil,debitCardHeader,bankAccountHeader, mpesaHeader,ghanaMobileMoneyHeader,ugandaMobileMoneyHeader,rwandaMobileMoneyHeader,francoMobileMoneyHeader,zambiaMobileMoneyHeader,ukMobileMoneyHeader,ussdHeader,payWithBarterHeader,payWithNigerianAccountHeader, payWithBankTransferHeader]
    }
    
    
    func configureDebitCardView(){
        
        //Validate Expiry Date
        //Limit cvv texfield character
        debitCardView.cardCVV.rx.text.orEmpty
            .map { String($0.prefix(3)) }
            .bind(to: debitCardView.cardCVV.rx.text)
            .disposed(by: disposeBag)
        
        //Limit expiry texfield character
        debitCardView.cardExpiry.rx.text.orEmpty
            .map { String($0.prefix(5)) }
            .bind(to: debitCardView.cardExpiry.rx.text)
            .disposed(by: disposeBag)
        
        debitCardView.cardNumberTextField.rx.text.orEmpty
            .map { String($0.prefix(24)) }
            .bind(to: debitCardView.cardNumberTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        let cardValidator = ValidatorType.card
        self.debitCardView.cardNumberTextField.watchText2(validationType: cardValidator, disposeBag: disposeBag)
        
        self.debitCardView.cardCVV.watchText(validationType: ValidatorType.requiredField(field: "CVV"), disposeBag: disposeBag)
        
        let expiryValidator = ValidatorType.cardMonth
        self.debitCardView.cardExpiry.watchText(validationType: expiryValidator, disposeBag: disposeBag)
        
        //MARK Format expiry month-year texfield
        debitCardView.cardExpiry.rx.text.changed.subscribe(onNext: { input in
            self.debitCardView.cardExpiry.formatTextToSlash(textPattern:"##/##")
        }).disposed(by: disposeBag)
        
        debitCardView.cardNumberTextField.rx.text.changed.subscribe(onNext: { input in
            self.debitCardView.cardNumberTextField.formatTextToSpace(textPattern: "#### #### #### #### ###")
        }).disposed(by: disposeBag)
        
        //MARK CVV texfield button action
        self.debitCardView.questionButton.rx.tap.subscribe(onNext: {
            //                        self.showFWToast(message: "Your Toast Message")
        }).disposed(by: disposableBag)
        
        
        
        debitCardView.cardPayButton.addTarget(self, action: #selector(cardPayButtonTapped), for: .touchUpInside)
        debitCardView.cardPayButton.setTitle("PAY \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        
        saveCardContainer.useAnotherCardButton.addTarget(self, action: #selector(showDebitCardView), for: .touchUpInside)
        
        debitCardView.rememberCardView.rememberCardCheck.addTarget(self, action: #selector(toggleSaveCardCheck), for: .touchUpInside)
        debitCardView.rememberCardView.rememberCardText.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(toggleSaveCardCheck)))
        debitCardView.rememberCardView.rememberCardText.isUserInteractionEnabled = true
        debitCardView.rememberCardView.isHidden = !FlutterwaveConfig.sharedConfig().allowSaveCard
        
        saveCardTableController = SaveCardViewController()
        saveCardTableController.delegate = self
        self.addChild(saveCardTableController)
        self.saveCardContainer.savedCardTableContainer.addSubview(saveCardTableController.view)
        saveCardTableController.view.frame = self.saveCardContainer.savedCardTableContainer.frame
        saveCardTableController.view.clipsToBounds = true
        saveCardTableController.didMove(toParent: self)
        
        pinViewContainer.hiddenPinTextField.delegate = self
        pinViewContainer.hiddenPinTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        pinViewContainer.pinContinueButton.layer.cornerRadius = 5
        pinViewContainer.pinContinueButton.addTarget(self, action: #selector(pinContinueButtonTapped), for: .touchUpInside)
        for _view in pinViewContainer.pins{
            _view.layer.cornerRadius = 3
            _view.isUserInteractionEnabled = true
            _view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPinKeyboard)))
        }
        
        
        self.billingAddressContainer.zipCodeTextField.watchText(validationType: ValidatorType.requiredField(field: "zip"), disposeBag: disposeBag)
        self.billingAddressContainer.billingAddressTextField.watchText(validationType: ValidatorType.requiredField(field: "billing address"), disposeBag: disposeBag)
        self.billingAddressContainer.stateTextField.watchText(validationType: ValidatorType.requiredField(field: "state"), disposeBag: disposeBag)
        self.billingAddressContainer.cityTextField.watchText(validationType: ValidatorType.requiredField(field: "city"), disposeBag: disposeBag)
        self.billingAddressContainer.countryTextField.watchText(validationType: ValidatorType.requiredField(field: "country"), disposeBag: disposeBag)
        
        billingAddressContainer.billingAddressTextField.delegate = self
        
        billingAddressContainer.stateTextField.delegate = self
        
        billingAddressContainer.cityTextField.delegate = self
        billingAddressContainer.countryTextField.delegate = self
        
        billingAddressContainer.zipCodeTextField.delegate = self
        billingAddressContainer.billingContinueButton.addTarget(self, action: #selector(billAddressButtonTapped), for: .touchUpInside)
    }
    
    
    
    func  configureBankView(){
        bankPicker = UIPickerView()
        bankPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        bankPicker.delegate = self
        bankPicker.dataSource = self
        bankPicker.tag = 12
        
        self.selectBankAccountView.otherBanksTextField.delegate = self
        self.selectBankAccountView.otherBanksTextField.inputView = self.bankPicker
        
        
        
        accountFormContainer.accountPayButton.setTitle("PAY \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        
        
        accountFormContainer.accountPayButton.addTarget(self, action: #selector(accountPayButtonTapped), for: .touchUpInside)
        
        accountFormContainer.phoneNumberTextField.rx.text.orEmpty
            .map { String($0.prefix(11)) }
            .bind(to: accountFormContainer.phoneNumberTextField.rx.text)
            .disposed(by: disposeBag)
        
        accountFormContainer.dobTextField.rx.text.changed.subscribe(onNext: { input in
            self.accountFormContainer.dobTextField.formatDobText()
        }).disposed(by: disposeBag)
        
        
        // MARK Validate text fields
        self.accountFormContainer.phoneNumberTextField.watchText(validationType: ValidatorType.requiredField(field: "Phone number"), disposeBag: disposeBag)
        self.accountFormContainer.accountNumberTextField.watchText(validationType: ValidatorType.requiredField(field: "Account number"), disposeBag: disposeBag)
        
        let dobValidator = ValidatorType.dob
        self.accountFormContainer.dobTextField.watchText(validationType: dobValidator, disposeBag: disposeBag)
        
        self.accountFormContainer.accountBvn.watchText(validationType: ValidatorType.requiredField(field: "BVN"), disposeBag: disposeBag)
        
        accountFormContainer.accountNumberTextField.rx.text.orEmpty
            .map { String($0.prefix(10)) }
            .bind(to: accountFormContainer.accountNumberTextField.rx.text)
            .disposed(by: disposeBag)
        
        accountFormContainer.accountBvn.rx.text.orEmpty
            .map { String($0.prefix(11)) }
            .bind(to: accountFormContainer.accountBvn.rx.text)
            .disposed(by: disposeBag)
        
        flutterwaveAccountClient.amount = self.amount
        
        
    }
    func configureOTPView(){
        self.otpContentContainer.otpTextField.watchText(validationType: ValidatorType.requiredField(field: "OTP"), disposeBag: disposeBag)
        self.otpContentContainer.otpButton.addTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
    }
    func configureMpesaView(){
        flutterwaveMpesaClient.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        
        mpesaView.mpesaPayButton.layer.cornerRadius = 5
        mpesaView.mpesaPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mpesaView.mpesaPayButton.addTarget(self, action: #selector(mpesaPayButtonTapped), for: .touchUpInside)
        
        flutterwaveMpesaClient.amount = self.amount
        flutterwaveMpesaClient.email = FlutterwaveConfig.sharedConfig().email
        
        self.mpesaView.mpesaPhoneNumber.watchText(validationType: ValidatorType.requiredField(field: "phone number"), disposeBag: disposeBag)
    }
    
    //MARK: MPESA Payment
    @objc func mpesaPayButtonTapped(){
        self.mpesaPayAction()
    }
    
    func mpesaPayAction(){
        self.view.endEditing(true)
        flutterwaveMpesaClient.phoneNumber = mpesaView.mpesaPhoneNumber.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let phoneValid = self.mpesaView.mpesaPhoneNumber.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        
        
        if(phoneValid ){
            flutterwaveMpesaClient.chargeMpesa()
        }
        
        
    }
    func configureGBPView(){
        flutterwaveUKAccountClient.amount = amount
        ukViewContainer.accountPayButton.layer.cornerRadius = 5
        ukViewContainer.accountPayButton.setTitle("PAY \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        ukViewContainer.accountPayButton.addTarget(self, action: #selector(chargeGBPAccountFlow), for: .touchUpInside)
        ukDetailsViewContainer.accountContinueButton.layer.cornerRadius = 5
        
        self.ukDetailsViewContainer.accountContinueButton.rx.tap.subscribe(onNext: {
            PaymentServicesViewModel.sharedViewModel.mpesaVerify(flwRef: BankViewModel.sharedViewModel.flwRef)
        }).disposed(by: disposableBag)
    }
    
    func configureMobileMoneyGhana(){
        flutterwaveMobileMoney.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        
        ghsMobileMoneyPicker = UIPickerView()
        ghsMobileMoneyPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        ghsMobileMoneyPicker.delegate = self
        ghsMobileMoneyPicker.dataSource = self
        ghsMobileMoneyPicker.tag = 20
        self.mobileMoneyContentView.mobileMoneyChooseNetwork.delegate = self
        
        self.mobileMoneyContentView.mobileMoneyChooseNetwork.inputView = ghsMobileMoneyPicker
        mobileMoneyContentView.mobileMoneyChooseNetwork.layer.cornerRadius = 5
        
        mobileMoneyContentView.mobileMoneyPhoneNumber.layer.cornerRadius = 5
        
        mobileMoneyContentView.mobileMoneyVoucher.layer.cornerRadius = 5
        
        mobileMoneyContentView.mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyContentView.mobileMoneyPay.setTitle("Pay \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyContentView.mobileMoneyPay.addTarget(self, action: #selector(mobileMoneyPayAction), for: .touchUpInside)
        
        flutterwaveMobileMoney.amount = self.amount
        flutterwaveMobileMoney.email = FlutterwaveConfig.sharedConfig().email
        
        self.mobileMoneyContentView.mobileMoneyPhoneNumber.watchText(validationType: ValidatorType.requiredField(field: "phone number"), disposeBag: disposeBag)
        self.mobileMoneyContentView.mobileMoneyChooseNetwork.watchText(validationType: ValidatorType.requiredField(field: "choose network"), disposeBag: disposeBag)
        self.mobileMoneyContentView.mobileMoneyVoucher.watchText(validationType: ValidatorType.requiredField(field: "voucher"), disposeBag: disposeBag)
        
    }
    
    func configureMobileMoneyUganda(){
        flutterwaveMobileMoneyUganda.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPhone.layer.cornerRadius = 5
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPayButton.layer.cornerRadius = 5
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPayButton.addTarget(self, action: #selector(mobileMoneyUgandaPayAction), for: .touchUpInside)
        
        flutterwaveMobileMoneyUganda.amount = self.amount
        flutterwaveMobileMoneyUganda.email = FlutterwaveConfig.sharedConfig().email
        self.mobileMoneyUgandaContentContainer.mobileMoneyUgandaPhone.watchText(validationType: ValidatorType.requiredField(field: "phone number"), disposeBag: disposeBag)
    }
    
    
    func configureMobileMoneyZambia(){
        flutterwaveMoneyZM.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        mobileMoneyZMContentContainer.mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyZMContentContainer.mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyZMContentContainer.mobileMoneyPay.setTitle("Pay \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyZMContentContainer.mobileMoneyPay.addTarget(self, action: #selector(mobileMoneyZambiaPayAction), for: .touchUpInside)
        
        self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.watchText(validationType: ValidatorType.requiredField(field: "select network"), disposeBag: disposeBag)
        
        self.mobileMoneyZMContentContainer.mobileMoneyPhoneNumber.watchText(validationType: ValidatorType.requiredField(field: "phone number"), disposeBag: disposeBag)
        
        zambiaMobileMoneyPicker = UIPickerView()
        zambiaMobileMoneyPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        zambiaMobileMoneyPicker.delegate = self
        zambiaMobileMoneyPicker.dataSource = self
        zambiaMobileMoneyPicker.tag = 17
        self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.delegate = self
        
        self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.inputView = zambiaMobileMoneyPicker
        mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.layer.cornerRadius = 5
        
        flutterwaveMoneyZM.amount = self.amount
        flutterwaveMoneyZM.email = FlutterwaveConfig.sharedConfig().email
        
    }
    
    func configureMobileMoneyFranco(){
        flutterwaveMobileMoneyFR.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.layer.cornerRadius = 5
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.layer.cornerRadius = 5
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.addTarget(self, action: #selector(mobileMoneyFrancoPayAction), for: .touchUpInside)
        
        flutterwaveMobileMoneyFR.amount = self.amount
        flutterwaveMobileMoneyFR.email = FlutterwaveConfig.sharedConfig().email
        
        
        self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.rightViewMode = .always
        francoCountryPicker = UIPickerView()
        francoCountryPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        francoCountryPicker.delegate = self
        francoCountryPicker.dataSource = self
        francoCountryPicker.tag = 15
        
        self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.watchText(validationType: ValidatorType.requiredField(field: "country"), disposeBag: disposeBag)
        
        self.mobileMoneyFRContentContainer.mobileMoneyFRPhone.watchText(validationType: ValidatorType.requiredField(field: "phone"), disposeBag: disposeBag)
        
        self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.delegate = self
        
        self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.inputView = francoCountryPicker
    }
    
    func configureMobileMoneyRwanda(){
        flutterMobileMoneyRW.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.layer.cornerRadius = 5
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.layer.cornerRadius = 5
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.addTarget(self, action: #selector(mobileMoneyRwandaPayAction), for: .touchUpInside)
        flutterMobileMoneyRW.amount = self.amount
        flutterMobileMoneyRW.email = FlutterwaveConfig.sharedConfig().email
        
        self.mobileMoneyRWContentContainer.mobileMoneyRWPhone.watchText(validationType: ValidatorType.requiredField(field: "phone number"), disposeBag: disposeBag)
        //        raveMobileMoneyRW.getFee()
    }
    @objc func chargeGBPAccountFlow(){
        self.view.endEditing(true)
        if FlutterwaveConfig.sharedConfig().currencyCode == .some("GBP"){
            LoadingHUD.shared.show()
            flutterwaveUKAccountClient.amount = self.amount
            flutterwaveUKAccountClient.accountNumber = "00000"
            flutterwaveUKAccountClient.bankCode = "093"
            flutterwaveUKAccountClient.phoneNumber = FlutterwaveConfig.sharedConfig().phoneNumber
            //            raveUKAccountClient.chargeAccount()
            
            BankViewModel.sharedViewModel.ukAccountTransfer(amount: self.amount.orEmpty(), accountBank:  flutterwaveUKAccountClient.bankCode.orEmpty(), accountNumber: flutterwaveUKAccountClient.accountNumber.orEmpty())
            
        }
    }
    @objc func completeGBPAccountFlow(){
        self.view.endEditing(true)
        if FlutterwaveConfig.sharedConfig().currencyCode == .some("GBP"){
            LoadingHUD.shared.show()
            //            raveUKAccountClient.queryTransaction(txRef: raveUKAccountClient.txRef)
        }
    }
    
    @objc func mobileMoneyPayAction(){
        self.view.endEditing(true)
        flutterwaveMobileMoney.network = mobileMoneyContentView.mobileMoneyChooseNetwork.text
        flutterwaveMobileMoney.voucher = mobileMoneyContentView.mobileMoneyVoucher.text
        flutterwaveMobileMoney.phoneNumber = mobileMoneyContentView.mobileMoneyPhoneNumber.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        // raveMobileMoney.chargeMobileMoney()
        
        let phoneValid = self.mobileMoneyContentView.mobileMoneyPhoneNumber.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        let networkValid = self.mobileMoneyContentView.mobileMoneyChooseNetwork.validateAndShowError(validationType: ValidatorType.requiredField(field: "choose network"))
        
        let voucherValid = self.mobileMoneyContentView.mobileMoneyVoucher.validateAndShowError(validationType: ValidatorType.requiredField(field: "voucher"))
        
        let validateVoucher = voucherValid && phoneValid  && networkValid
        let phoneNetworkValid = phoneValid && networkValid
        
        
        switch selectedNetwork {
        case "VODAFONE":
            if(!validateVoucher){
                return
            }
        default:
            if(!phoneNetworkValid){
                return
            }
        }
        MobileMoneyViewModel.sharedViewModel.rwandaMoney(amount: self.amount ?? "", network: "", phoneNumber: flutterMobileMoneyRW.phoneNumber ?? "")
        
    }
    
    @objc func mobileMoneyUgandaPayAction(){
        self.view.endEditing(true)
        flutterwaveMobileMoneyUganda.mobileMoneyType = .uganda
        flutterwaveMobileMoneyUganda.phoneNumber = mobileMoneyUgandaContentContainer.mobileMoneyUgandaPhone.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let phoneValid = self.mobileMoneyUgandaContentContainer.mobileMoneyUgandaPhone.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        
        
        if (phoneValid){
            MobileMoneyViewModel.sharedViewModel.rwandaMoney(amount: self.amount ?? "", network: "", phoneNumber: flutterwaveMobileMoneyUganda.phoneNumber ?? "")
        }
    }
    
    @objc func mobileMoneyRwandaPayAction(){
        self.view.endEditing(true)
        
        flutterMobileMoneyRW.mobileMoneyType = .rwanda
        flutterMobileMoneyRW.phoneNumber = mobileMoneyRWContentContainer.mobileMoneyRWPhone.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let phoneValid = self.mobileMoneyRWContentContainer.mobileMoneyRWPhone.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        
        
        if(phoneValid ){
            MobileMoneyViewModel.sharedViewModel.rwandaMoney(amount: self.amount ?? "", network: "", phoneNumber: flutterMobileMoneyRW.phoneNumber ?? "")
        }
        
        
    }
    
    @objc func mobileMoneyFrancoPayAction(){
        
        self.view.endEditing(true)
        
        flutterwaveMobileMoneyFR.mobileMoneyType = .franco
        flutterwaveMobileMoneyFR.phoneNumber = mobileMoneyFRContentContainer.mobileMoneyFRPhone.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        
        let phoneValid = self.mobileMoneyFRContentContainer.mobileMoneyFRPhone.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        
        let countryValid = self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.validateAndShowError(validationType: ValidatorType.requiredField(field: "country"))
        
        
        if(phoneValid && countryValid ){
            MobileMoneyViewModel.sharedViewModel.francoPhoneMoney(amount: self.amount ?? "", phoneNumber: flutterwaveMobileMoneyFR.phoneNumber ?? "", country: selectedFrancophoneCountryCode.orEmpty())
        }
        
        
    }
    
    @objc func mobileMoneyZambiaPayAction(){
        
        self.view.endEditing(true)
        let phoneValid = self.mobileMoneyZMContentContainer.mobileMoneyPhoneNumber.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        let networkValid = self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.validateAndShowError(validationType: ValidatorType.requiredField(field: "network"))
        
        flutterwaveMoneyZM.network = mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.text
        flutterwaveMoneyZM.mobileMoneyType = .zambia
        flutterwaveMoneyZM.phoneNumber = mobileMoneyZMContentContainer.mobileMoneyPhoneNumber.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if phoneValid && networkValid {
            MobileMoneyViewModel.sharedViewModel.zambiaMoney(amount: self.amount ?? "", phoneNumber: flutterwaveMoneyZM.phoneNumber ?? "", network: flutterwaveMoneyZM.network ?? "")
        }
    }
    
    //    @objc func dobPickerValueChanged(_ sender: UIDatePicker){
    //        let dateFormatter: DateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "ddMMyyyy"
    //        let selectedDate: String = dateFormatter.string(from: sender.date)
    ////        self.accountFormContainer.dobTextField.text = selectedDate
    //    }
    
    @objc func accountPayButtonTapped(){
        
        let phoneValid = self.accountFormContainer.phoneNumberTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        let accountValid = self.accountFormContainer.accountNumberTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "expiry"))
        
        let dobbValidator = ValidatorType.dob
        let dobValid = self.accountFormContainer.dobTextField.validateAndShowError(validationType: dobbValidator)
        
        let bvnValid = self.accountFormContainer.accountBvn.validateAndShowError(validationType: ValidatorType.requiredField(field: "BVN"))
        
        let validateDOB = dobValid && phoneValid  && accountValid
        let validateBVN = bvnValid && phoneValid  && accountValid
        let validatePhoneAndAccount = phoneValid  && accountValid
        
        switch selectedBankCode {
        case "057":
            if(!validateDOB){
                return
            }
        case "033":
            if(!validateBVN){
                return
            }
        default:
            if(!validatePhoneAndAccount){
                return
            }
        }
        self.accountPayAction()
    }
    func accountPayAction(){
        self.view.endEditing(true)
        
        flutterwaveAccountClient.accountNumber = accountFormContainer.accountNumberTextField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        flutterwaveAccountClient.phoneNumber = accountFormContainer.phoneNumberTextField.text
        flutterwaveAccountClient.amount = self.amount
        flutterwaveAccountClient.bankCode = selectedBankCode
        
        if selectedBankCode == "057"{
            let seperateDobTextField = accountFormContainer.dobTextField.text?.split(separator: "-")
            let dobValid = self.accountFormContainer.dobTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "DOB"))
            
            let dob = String((seperateDobTextField?[0] ?? "")) + String((seperateDobTextField?[1] ?? "")) + String((seperateDobTextField?[2] ?? ""))
            
            if (dobValid){
                flutterwaveAccountClient.passcode = dob
            }
        }
        
        
        if selectedBankCode == "215"{
            let bvnValid = self.accountFormContainer.accountBvn.validateAndShowError(validationType: ValidatorType.requiredField(field: "BVN"))
            
            if (bvnValid){
                flutterwaveAccountClient.bvn = self.accountFormContainer.accountBvn.text
            }
        }
        
        
        
        flutterwaveAccountClient.chargeAccount()
    }
    func chargeUSAccountFlow(){
        self.view.endEditing(true)
        if FlutterwaveConfig.sharedConfig().country == .some("US"){
            LoadingHUD.shared.show()
            flutterwaveAccountClient.isUSBankAccount = true
            flutterwaveAccountClient.amount = self.amount
            flutterwaveAccountClient.phoneNumber = FlutterwaveConfig.sharedConfig().phoneNumber
            // raveAccountClient.chargeAccount()
            
        }
    }
    
    func chargeSAAccountFlow(){
        self.view.endEditing(true)
        if FlutterwaveConfig.sharedConfig().country == .some("ZA"){
            LoadingHUD.shared.show()
            flutterwaveAccountClient.amount = self.amount
            flutterwaveAccountClient.accountNumber = "00000"
            flutterwaveAccountClient.bankCode = "093"
            flutterwaveAccountClient.phoneNumber = FlutterwaveConfig.sharedConfig().phoneNumber
            // raveAccountClient.chargeAccount()
        }
    }
    @objc func selectBankArrowTapped(){
        self.selectBankAccountView.otherBanksTextField.becomeFirstResponder()
    }
    
    @objc func showPinKeyboard(){
        self.pinViewContainer.hiddenPinTextField.becomeFirstResponder()
    }
    
    @objc func toggleSaveCardCheck(){
        flutterwaveCardClient.saveCard =  !flutterwaveCardClient.saveCard
        let image =  flutterwaveCardClient.saveCard == true ? UIImage(named:"rave_check_box",in: Bundle.getResourcesBundle(), compatibleWith: nil) :  UIImage(named:"rave_unchecked_box",in: Bundle.getResourcesBundle(), compatibleWith: nil)
        debitCardView.rememberCardView.rememberCardCheck.setImage(image, for: .normal)
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return expandables.count
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expandables[section].isExpanded ? 1 : 0
    }
    
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            howCell.selectionStyle = .none
            return  howCell
        case 1:
            cardCell.selectionStyle = .none
            return cardCell
        case 2:
            accountCell.selectionStyle = .none
            return accountCell
        case 3:
            mpesaCell.selectionStyle = .none
            return mpesaCell
        case 4:
            mobileMoneyGH.selectionStyle = .none
            return mobileMoneyGH
        case 5:
            mobileMoneyUG.selectionStyle = .none
            return mobileMoneyUG
        case 6:
            mobileMoneyRW.selectionStyle = .none
            return mobileMoneyRW
        case 7:
            mobileMoneyFR.selectionStyle = .none
            return mobileMoneyFR
        case 8:
            mobileMoneyZM.selectionStyle = .none
            return mobileMoneyZM
        case 9:
            ukAccountCell.selectionStyle = .none
            return ukAccountCell
        case 10:
            ussdCell.selectionStyle = .none
            return ussdCell
        case 11:
            barterCell.selectionStyle = .none
            return barterCell
        case 12:
            accountCell.selectionStyle = .none
            return accountCell
        case 13:
            bankTransferCell.selectionStyle = .none
            return bankTransferCell
        default:
            fatalError("Unknown row in section 0")
        }
    }
    
    func checkIfPaymentOptionIsExcluded(paymentOption:PaymentOption) -> Bool{
        return FlutterwaveConfig.sharedConfig().paymentOptionsToExclude.filter{ currentPaymentOption in
            currentPaymentOption == paymentOption
        }.count > 0
    }
    
    
    override  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            //||  RaveConfig.sharedConfig().country == "UG"
            return FlutterwaveConfig.sharedConfig().currencyCode == "" || FlutterwaveConfig.sharedConfig().country == "GHS" || checkIfPaymentOptionIsExcluded(paymentOption: .debitCard)  ? 0 :  65
        case 2:
            return  (FlutterwaveConfig.sharedConfig().currencyCode == "USD" || FlutterwaveConfig.sharedConfig().currencyCode == "ZAR") && !checkIfPaymentOptionIsExcluded(paymentOption: .bankAccount)  ? 65 : 0
        case 3:
            return FlutterwaveConfig.sharedConfig().currencyCode == "KES" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 4:
            return FlutterwaveConfig.sharedConfig().currencyCode == "GHS" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 5:
            return FlutterwaveConfig.sharedConfig().currencyCode == "UGX" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 6:
            return FlutterwaveConfig.sharedConfig().currencyCode == "RWF"  && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 7:
            return (FlutterwaveConfig.sharedConfig().currencyCode == "XAF" || FlutterwaveConfig.sharedConfig().currencyCode == "XOF") && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 8:
            return FlutterwaveConfig.sharedConfig().currencyCode == "ZMW"  && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 9:
            return FlutterwaveConfig.sharedConfig().currencyCode == "GBP" && !checkIfPaymentOptionIsExcluded(paymentOption: .bankAccount)  ? 65 : 0
        case 10:
            return FlutterwaveConfig.sharedConfig().currencyCode == "NGN" && !checkIfPaymentOptionIsExcluded(paymentOption: .ussd)  ? 65 : 0
        case 11:
            return FlutterwaveConfig.sharedConfig().currencyCode == "NGN" && !checkIfPaymentOptionIsExcluded(paymentOption: .barter) ? 65 : 0
        //            return false
        case 12:
            return FlutterwaveConfig.sharedConfig().currencyCode == "NGN"  && !checkIfPaymentOptionIsExcluded(paymentOption: .bankAccount) ? 65  : 0
        case 13:
            return FlutterwaveConfig.sharedConfig().currencyCode == "NGN"  && !checkIfPaymentOptionIsExcluded(paymentOption: .bankTransfer) ? 65 : 0
        default:
            return 0
        }
    }
    override public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // If this section's header height is 0, return nil explicitly
        let headerHeight = self.tableView(tableView, heightForHeaderInSection: section)
        guard headerHeight > 0 else { return nil }
        
        switch section {
        case 0:
            return nil
            
        case 1:
            let headerTitle = "Pay with your Debit Card"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Debit Card")!, in: headerTitle))
            headers[1]?.titleLabel.attributedText = attributedString
            headers[1]?.arrowButton.tag = 1
            headers[1]?.button.tag = 1
            return headers[1]
        case 2:
            let headerTitle = "Pay with your Bank Account"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Bank Account")!, in: headerTitle))
            headers[2]?.titleLabel.attributedText = attributedString
            headers[2]?.arrowButton.tag = 2
            headers[2]?.button.tag = 2
            return headers[2]
        case 3:
            let headerTitle = "Pay with M-PESA"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "M-PESA")!, in: headerTitle))
            headers[3]?.titleLabel.attributedText = attributedString
            headers[3]?.arrowButton.tag = 3
            headers[3]?.button.tag = 3
            return headers[3]
        case 4:
            let headerTitle = "Pay with Mobile Money Ghana"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Ghana")!, in: headerTitle))
            headers[4]?.titleLabel.attributedText = attributedString
            headers[4]?.arrowButton.tag = 4
            headers[4]?.button.tag = 4
            return headers[4]
        case 5:
            let headerTitle = "Pay with Mobile Money Uganda"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Uganda")!, in: headerTitle))
            headers[5]?.titleLabel.attributedText = attributedString
            headers[5]?.arrowButton.tag = 5
            headers[5]?.button.tag = 5
            return headers[5]
        case 6:
            let headerTitle = "Pay with Mobile Money Rwanda"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Rwanda")!, in: headerTitle))
            headers[6]?.titleLabel.attributedText = attributedString
            headers[6]?.arrowButton.tag = 6
            headers[6]?.button.tag = 6
            return headers[6]
        case 7:
            let headerTitle = "Pay with Mobile Money Francophone"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Francophone")!, in: headerTitle))
            headers[7]?.titleLabel.attributedText = attributedString
            headers[7]?.arrowButton.tag = 7
            headers[7]?.button.tag = 7
            return headers[7]
        case 8:
            let headerTitle = "Pay with Mobile Money Zambia"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Zambia")!, in: headerTitle))
            headers[8]?.titleLabel.attributedText = attributedString
            headers[8]?.arrowButton.tag = 8
            headers[8]?.button.tag = 8
            return headers[8]
            
        case 9:
            let headerTitle = "Pay with your Bank Account"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: " Bank Account")!, in: headerTitle))
            headers[9]?.titleLabel.attributedText = attributedString
            headers[9]?.arrowButton.tag = 9
            headers[9]?.button.tag = 9
            return headers[9]
        case 10:
            let headerTitle = "Pay with USSD"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "USSD")!, in: headerTitle))
            headers[10]?.titleLabel.attributedText = attributedString
            headers[10]?.arrowButton.tag = 10
            headers[10]?.button.tag = 10
            return headers[10]
        case 11:
            let headerTitle = "Pay with Barter"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Barter")!, in: headerTitle))
            headers[11]?.titleLabel.attributedText = attributedString
            headers[11]?.arrowButton.tag = 11
            headers[11]?.button.tag = 11
            return headers[11]
        case 12:
            let headerTitle = "Pay with your Bank Account"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: " Bank Account")!, in: headerTitle))
            headers[12]?.titleLabel.attributedText = attributedString
            headers[12]?.arrowButton.tag = 12
            headers[12]?.button.tag = 12
            return headers[12]
        case 13:
            let headerTitle = "Pay with Bank Transfer"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: " Bank Transfer")!, in: headerTitle))
            headers[13]?.titleLabel.attributedText = attributedString
            headers[13]?.arrowButton.tag = 13
            headers[13]?.button.tag = 13
            return headers[13]
            
        default:
            return nil
            
        }
        
        
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //  return expandables[indexPath.section].isExpanded ? self.view.frame.height - (180) : 0
        
        switch indexPath.section {
        case 0:
            
            if ( expandables[indexPath.section].isExpanded && FlutterwaveConfig.sharedConfig().currencyCode == "NGN" ){
                return self.view.frame.height - (400 + navBarHeight)
                
            }
            
            return expandables[indexPath.section].isExpanded   ? self.view.frame.height - (200 + navBarHeight) : 0
        case 1:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 2:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 3:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 4:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 5:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 6:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 7:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 8:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 9:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 10:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 11:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 12:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        case 13:
            return expandables[indexPath.section].isExpanded ? 400 : 0
        default:
            return expandables[indexPath.section].isExpanded ? self.view.frame.height - (200 + navBarHeight) : 0
        }
        
    }
    
    override public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // 0 for hidden sections; use leastNormalMagnitude or a small value for visible ones if needed
        let headerHeight = self.tableView(tableView, heightForHeaderInSection: section)
        return headerHeight == 0 ? 0 : .leastNormalMagnitude
    }

    override public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Return nil for hidden sections
        let headerHeight = self.tableView(tableView, heightForHeaderInSection: section)
        return headerHeight == 0 ? nil : UIView(frame: .zero)
    }
    
    func getHeader()-> FlutterwaveHeaderView{
        let header = FlutterwaveHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        header.backgroundColor = UIColor(hex: "#FBEED8")
        header.button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        return header
    }
    @objc func handleButtonTap(_ sender:UIButton){
        self.handelCloseOrExpandSection(section: sender.tag)
    }
    func handelCloseOrExpandSection(section:Int){
        let expandedState = expandables[section].isExpanded
        if expandedState{
            //Collapse the expanded state and expaand the first section
            expandables[0].isExpanded = true
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            expandables[section].isExpanded = false
            self.tableView.deleteRows(at: [IndexPath(row: 0, section: section)], with: .fade)
            self.headers[section]?.arrowButton.setImage(UIImage(named: "rave_up_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        }else{
            //Expand current view and collapse the other sections
            var expandedIndexPath = [IndexPath]()
            var newExpandables = [Expandables]()
            for item in self.expandables{
                if item.isExpanded == true{
                    expandedIndexPath.append(IndexPath(row: 0, section: item.section))
                    self.headers[section]?.arrowButton.setImage(UIImage(named: "rave_up_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
                }
            }
            
            for item in self.expandables{
                newExpandables.append(Expandables(isExpanded: false, section: item.section))
                self.headers[item.section]?.arrowButton.setImage(UIImage(named: "rave_up_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
            }
            self.expandables = newExpandables
            
            
            self.tableView.deleteRows(at: expandedIndexPath, with: .fade)
            //expandables[0].isExpanded = false
            
            
            self.expandables[section].isExpanded = true
            self.headers[section]?.arrowButton.setImage(UIImage(named: "rave_down_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: section)], with: .fade)
            //Check if selected tab is Bank Account and Country is US
            if section == 2{
                self.chargeUSAccountFlow()
                self.chargeSAAccountFlow()
            }
        }
    }
    
    
    @objc func closeView(){
            self.view.endEditing(true)
            self.delegate?.onDismiss()
            self.dismiss(animated: true)
        }
    
    @objc func cardPayButtonTapped(){
        
        let expiryValidator = ValidatorType.cardMonth
        let carrdValidator = ValidatorType.card
        let cardValid = self.debitCardView.cardNumberTextField.validateAndShowError2(validationType: carrdValidator)
        let expiryValid = self.debitCardView.cardExpiry.validateAndShowError(validationType: expiryValidator)
        let cvvValid = self.debitCardView.cardCVV.validateAndShowError(validationType: ValidatorType.requiredField(field: "CVV"))
        
        if(cardValid && expiryValid && cvvValid ){
            self.cardPayAction()
        }
    }
    func saveCardCallbacks(){
        if let _ = FlutterwaveConfig.sharedConfig().publicKey{
            if let deviceNumber = FlutterwaveConfig.sharedConfig().phoneNumber, deviceNumber != ""{
              //  LoadingHUD.shared.show()
                CardViewModel.sharedViewModel.fetchCard()
            }
        }
        
        CardViewModel.sharedViewModel.sendCardOtpResponse.subscribe(onNext: { [weak self] response in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.showOTP(message: response.message ?? "Enter the OTP sent to your mobile phone and email address to continue", flwRef: "", otpType: .savedCard)
            }
        } ).disposed(by: disposeBag)
        
//        flutterwaveCardClient.sendOTPSuccess = { [weak self](message) in
//            guard let strongSelf = self else {
//                return
//            }
//            DispatchQueue.main.async {
//                LoadingHUD.shared.hide()
//                strongSelf.showOTP(message: message ?? "Enter the OTP sent to your mobile phone and email address to continue", flwRef: "", otpType: .savedCard)
//            }
//        }
//        flutterwaveCardClient.sendOTPError = {(message) in
//
//            DispatchQueue.main.async {
//                LoadingHUD.shared.hide()
//                showSnackBarWithMessage(msg: message ?? "An error occured while sending OTP")
//            }
//        }
        
        CardViewModel.sharedViewModel.fetchCardResponse.subscribe(onNext: { [weak self] response in
           let saveCards =   response.data
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                if let count = saveCards?.count, count > 0 {
                    strongSelf.saveCardContainer.isHidden = false
                    strongSelf.debitCardView.isHidden = true
                    strongSelf.savedCards = saveCards
                    strongSelf.saveCardTableController.savedCards = saveCards
                    strongSelf.saveCardTableController.saveCardTable.reloadData()
                }
            }
          
        } ).disposed(by: disposeBag)
        
        CardViewModel.sharedViewModel.fetchCardFailed.subscribe(onNext: { [weak self] error in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                LoadingHUD.shared.hide()
                strongSelf.debitCardView.isHidden = false
                strongSelf.saveCardContainer.isHidden  = true
            }
        }).disposed(by: disposeBag)
        
//        flutterwaveCardClient.saveCardSuccess = {[weak self](saveCards) in
//            guard let strongSelf = self else {
//                return
//            }
//            DispatchQueue.main.async {
//                LoadingHUD.shared.hide()
//                if let count = saveCards?.count, count > 0 {
//                    strongSelf.saveCardContainer.isHidden = false
//                    strongSelf.debitCardView.isHidden = true
//                    strongSelf.savedCards = saveCards
//                    strongSelf.saveCardTableController.savedCards = saveCards
//                    strongSelf.saveCardTableController.saveCardTable.reloadData()
//                }
//            }
//
//        }
//        flutterwaveCardClient.saveCardError = {[weak self](saveCards) in
//            guard let strongSelf = self else {
//                return
//            }
//            DispatchQueue.main.async {
//                LoadingHUD.shared.hide()
//                strongSelf.debitCardView.isHidden = false
//                strongSelf.saveCardContainer.isHidden  = true
//            }
//        }
    }
    
    func gbpAccountCallbacks(){
        flutterwaveUKAccountClient.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        flutterwaveUKAccountClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.ukViewContainer.accountPayButton.setTitle("PAY \(amount.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        flutterwaveUKAccountClient.chargeSuccess = {[weak self](flwRef,data) in
            LoadingHUD.shared.hide()
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        
        flutterwaveUKAccountClient.chargeGBPOTPAuth =  {[weak self](flwRef, reference,message) in
            LoadingHUD.shared.hide()
            self?.showGBPBankDetails(reference)
        }
        
        flutterwaveUKAccountClient.redoChargeOTPAuth =  {[weak self](flwRef, message) in
            LoadingHUD.shared.hide()
            self?.showOTP(message: message, flwRef: flwRef, otpType: .bank)
        }
        
        flutterwaveUKAccountClient.chargeWebAuth = {[weak self](flwRef, authURL) in
            LoadingHUD.shared.hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        flutterwaveUKAccountClient.validateError = {[weak self](message,data) in
            LoadingHUD.shared.hide()
            //Still show success
            if let _data  = data{
                let flwref = _data.flwRef
                self?.delegate?.tranasctionSuccessful(flwRef: flwref,responseData: data)
            }else{
                if (message?.containsIgnoringCase(find: "Timed Out"))!{
                    self?.delegate?.tranasctionSuccessful(flwRef: nil, responseData: data)
                }else{
                    self?.delegate?.tranasctionFailed(flwRef: nil, responseData:  data)
                }
            }
            self?.dismiss(animated: true)
        }
        flutterwaveUKAccountClient.error = {(message,data) in
            LoadingHUD.shared.hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "Timed Out"){
                        showSnackBarWithMessage(msg: message ?? "The request timed out")
                    }else{
                        showSnackBarWithMessage(msg: message ?? "An error occurred")
                    }
                }
            }
        }
        
    }
    
    func showGBPBankDetails(_ reference:String){
        ukDetailsViewContainer.isHidden = false
        ukDetailsViewContainer.alpha = 0
        
        ukDetailsViewContainer.amountValue.text = flutterwaveUKAccountClient.chargeAmount?.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode)
        ukDetailsViewContainer.accountNumberValue.text = "43271228"
        ukDetailsViewContainer.sortCodeValue.text = "04-00-53"
        ukDetailsViewContainer.referenceNumberValue.text = reference
        UIView.animate(withDuration: 0.6, animations: {
            self.ukDetailsViewContainer.alpha = 1
            self.ukViewContainer.alpha = 0
        }) { (completed) in
            self.ukViewContainer.isHidden = true
        }
    }
    func accountCallbacks(){
        flutterwaveAccountClient.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        flutterwaveAccountClient.banks = {[weak self](banks) in
            if let whitelistedBanks = FlutterwaveConfig.sharedConfig().whiteListedBanksOnly{
                var _banks:[Bank] =  []
                whitelistedBanks.forEach({ (code) in
                    let bank = banks?.filter({ (bank) -> Bool in
                        bank.bankCode == code
                    }).first!
                    _banks.append(bank!)
                })
                self?.banks = _banks
                self?.banks = self?.banks?.sorted(by: { (first, second) -> Bool in
                    return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
                })
            }else{
                self?.banks = banks
                self?.banks = self?.banks?.sorted(by: { (first, second) -> Bool in
                    return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
                })
            }
            DispatchQueue.main.async {
                self?.bankPicker.reloadAllComponents()
            }
        }
        flutterwaveAccountClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.accountFormContainer.accountPayButton.setTitle("PAY \(amount.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        flutterwaveAccountClient.chargeSuccess = {[weak self](flwRef,data) in
            LoadingHUD.shared.hide()
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        
        flutterwaveAccountClient.chargeOTPAuth =  {[weak self](flwRef, message) in
            LoadingHUD.shared.hide()
            self?.showOTP(message: message, flwRef: flwRef, otpType: .bank)
        }
        
        flutterwaveAccountClient.redoChargeOTPAuth =  {[weak self](flwRef, message) in
            LoadingHUD.shared.hide()
            self?.showOTP(message: message, flwRef: flwRef, otpType: .bank)
        }
        
        flutterwaveAccountClient.chargeWebAuth = {[weak self](flwRef, authURL) in
            LoadingHUD.shared.hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        flutterwaveAccountClient.validateError = {[weak self](message,data) in
            LoadingHUD.shared.hide()
            
            //Still show success
            if let _data  = data{
                let flwref = _data.flwRef.orEmpty()
                self?.delegate?.tranasctionSuccessful(flwRef: flwref,responseData: data)
            }else{
                if (message?.containsIgnoringCase(find: "Timed Out"))!{
                    self?.delegate?.tranasctionSuccessful(flwRef: nil,responseData: data)
                }else{
                    self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                }
            }
            self?.dismiss(animated: true)
        }
        flutterwaveAccountClient.error = {(message,data) in
            LoadingHUD.shared.hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "Timed Out"){
                        showSnackBarWithMessage(msg: message ?? "The request timed out")
                    }else{
                        showSnackBarWithMessage(msg: message ?? "An error occurred")
                    }
                }
            }
        }
        
    }
    
    func cardCallbacks(){
        flutterwaveCardClient.transactionReference = FlutterwaveConfig.sharedConfig().transcationRef
        
        flutterwaveCardClient.chargeSuccess = {[weak self](flwRef,data) in
            LoadingHUD.shared.hide()
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        flutterwaveCardClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.debitCardView.cardPayButton.setTitle("Pay \(amount.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        flutterwaveCardClient.chargeSuggestedAuth = {[weak self](authModel, data, authURL) in
            LoadingHUD.shared.hide()
            switch authModel {
            case .AVS_VBVSECURECODE:
                self?.showBillingAddress()
                break
            case .GTB_OTP:
                self?.showPin()
                break
            case .NOAUTH_INTERNATIONAL:
                self?.showBillingAddress()
            case .PIN:
                self?.showPin()
                break
            case .VBVSECURECODE:
                let ref = data?["flwRef"] as? String
                self?.showWebView(url: authURL,ref:ref)
                break
            default:
                break
            }
        }
        
        flutterwaveCardClient.error = {(message,data) in
            LoadingHUD.shared.hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg: message ?? "The request timed out", style: .error)
                    }else{
                        showSnackBarWithMessage(msg: message ?? "An error occurred", style: .error)
                    }
                }
            }
        }
        
        flutterwaveCardClient.chargeOTPAuth = {[weak self](flwRef, message) in
            LoadingHUD.shared.hide()
            self?.showOTP(message: message, flwRef: flwRef, otpType: .card)
        }
        
        flutterwaveCardClient.chargeWebAuth = {[weak self](flwRef, authURL) in
            LoadingHUD.shared.hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        flutterwaveCardClient.validateError = {[weak self](message,data) in
            LoadingHUD.shared.hide()
            if let _data  = data{
                let flwref = _data.flwRef.orEmpty()
                self?.delegate?.tranasctionSuccessful(flwRef: flwref,responseData: data)
            }else{
                if (message?.containsIgnoringCase(find: "Timed Out"))!{
                    self?.delegate?.tranasctionSuccessful(flwRef: nil,responseData: data)
                }else{
                    self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                }
            }
            self?.dismiss(animated: true)
        }
        
    }
    
    func mpesaCallbacks(){
        flutterwaveMpesaClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mpesaView.mpesaPayButton.setTitle("Pay \(amount.toCountryCurrency(code: FlutterwaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        
        flutterwaveMpesaClient.chargePending = {[weak self] (title,message) in
            LoadingHUD.shared.hide()
            DispatchQueue.main.async {
                guard let strongSelf = self else{ return}
                self?.showMpesaPending(mesage: message ?? "")
                Timer.scheduledTimer(timeInterval: 30, target: strongSelf, selector: #selector(strongSelf.showMpesaPendingNoNotificaction), userInfo: nil, repeats: false)
            }
            
        }
        flutterwaveMpesaClient.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        flutterwaveMpesaClient.error = {[weak self](message,data) in
            LoadingHUD.shared.hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
        
    }
    
    func showMpesaPending(mesage:String){
        mpesaPendingView.isHidden = false
        mpesaPendingView.alpha = 0
        mpesaPendingView.mpesaPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mpesaPendingView.alpha = 1
            self.mpesaView.alpha = 0
        }) { (completed) in
            self.mpesaView.isHidden = true
            
        }
    }
    @objc func showMpesaPendingNoNotificaction(){
        self.mpesaPendingView.mpesaPendingNoNotification.isHidden = false
        self.mpesaPendingView.mpesaPendingNoNotification.isUserInteractionEnabled = true
        self.mpesaPendingView.mpesaPendingNoNotification.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMpesaBusinessView)))
    }
    @objc func showMpesaBusinessView(){
        mpesaBusinessView.isHidden = false
        mpesaBusinessView.alpha = 0
        mpesaBusinessView.mpesaBusinessNumber.text = flutterwaveMpesaClient.businessNumber
        mpesaBusinessView.mpesaAccountNumber.text = flutterwaveMpesaClient.accountNumber
        UIView.animate(withDuration: 0.6, animations: {
            self.mpesaBusinessView.alpha = 1
            self.mpesaPendingView.alpha = 0
        }) { (completed) in
            self.mpesaPendingView.isHidden = true
            
        }
    }
    
    
    func showMobileMoneyPendingZM(mesage:String) {
        mobileMoneyZMContainer.addSubview(mobileMoneyPendingView)
        NSLayoutConstraint.activate([
            mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyZMContainer.leadingAnchor, constant:20),
            mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyZMContainer.topAnchor, constant:71),
            mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyZMContainer.trailingAnchor, constant:-20),
        ])
        mobileMoneyPendingView.frame = mobileMoneyZMContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyZMContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyZMContentContainer.isHidden = true
        }
    }
    func showMobileMoneyPendingFR(mesage:String){
        mobileMoneyFRContainer.addSubview(mobileMoneyPendingView)
        NSLayoutConstraint.activate([
            mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyFRContainer.leadingAnchor, constant:20),
            mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyFRContainer.topAnchor, constant:71),
            mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyFRContainer.trailingAnchor, constant:-20),
        ])
        mobileMoneyPendingView.frame = mobileMoneyFRContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyFRContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyFRContentContainer.isHidden = true
            
        }
    }
    func showMobileMoneyPendingRW(mesage:String){
        mobileMoneyRWContainer.addSubview(mobileMoneyPendingView)
        NSLayoutConstraint.activate([
            mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyRWContainer.leadingAnchor, constant:20),
            mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyRWContainer.topAnchor, constant:71),
            mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyRWContainer.trailingAnchor, constant:-20),
        ])
        mobileMoneyPendingView.frame = mobileMoneyRWContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyRWContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyRWContentContainer.isHidden = true
            
        }
    }
    
    func showMobileMoneyPendingUG(mesage:String){
        mobileMoneyUgandaContainer.addSubview(mobileMoneyPendingView)
        NSLayoutConstraint.activate([
            mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.leadingAnchor, constant:20),
            mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyUgandaContainer.topAnchor, constant:71),
            mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.trailingAnchor, constant:-20),
        ])
        mobileMoneyPendingView.frame = mobileMoneyUgandaContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyUgandaContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyUgandaContentContainer.isHidden = true
            
        }
    }
    func showMobileMoneyPending(mesage:String){
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyContentView.alpha = 0
        }) { (completed) in
            self.mobileMoneyContentView.isHidden = true
            
        }
    }
    
    func cardPayAction(){
        self.view.endEditing(true)
        flutterwaveCardClient.cardNumber = self.debitCardView.cardNumberTextField.text?.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
        
        //        print("SDK VALUE \(flutterwaveCardClient.cardNumber.orEmpty())")
        flutterwaveCardClient.cvv = self.debitCardView.cardCVV.text
        
        let seperateCardExpiry = debitCardView.cardExpiry.text?.split(separator: "/")
        
        flutterwaveCardClient.expMonth = String((seperateCardExpiry![0]))
        flutterwaveCardClient.expYear = String((seperateCardExpiry![1]))
        
        flutterwaveCardClient.amount = self.amount
        flutterwaveCardClient.chargeCard(replaceData: true)
        
    }
    
    
}

extension UIApplication {
    
    static var bottomSafeAreaHeight: CGFloat {
        var bottomSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
        }
        return bottomSafeAreaHeight
    }
    
    
    
}
