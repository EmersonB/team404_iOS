//import UIKit
//import FirebaseAuth
//import Firebase
//
//
//class LoginViewController: UIViewController, UITextFieldDelegate {
//    
//    
//    @IBOutlet var userNameField: UITextField!
//    @IBOutlet var passwordField: UITextField!
//    @IBOutlet var nicknameField: UITextField!
//    
//    var ref: FIRDatabaseReference!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        userNameField.delegate = self
//        passwordField.delegate = self
//        
//        
//        
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    
//    @IBAction func didTapLogin(_ sender: Any) {
//        if let email = userNameField.text {
//            if let password = passwordField.text {
//                if email != "" && password != "" {
//                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
//                        if error != nil {
//                            if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
//                                switch errCode {
//                                case .errorCodeUserDisabled:
//                                    print("user disabled")
//                                case .errorCodeWrongPassword:
//                                    print("incorrect password")
//                                case .errorCodeInvalidEmail:
//                                    print("invalid email")
//                                default:
//                                    print("login error: \(error)")
//                                }
//                            }
//                        } else {
//                            print('success');
//                        }
//                    })
//                }
//            }
//        }
//    }
//    @IBAction func didTapRegister(_ sender: Any) {
//        if let email = userNameField.text {
//            if let password = passwordField.text {
//                if email != "" && password != "" {
//                    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
//                        if error != nil {
//                            if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
//                                switch errCode {
//                                case .errorCodeInvalidEmail:
//                                    print("invalid email")
//                                case .errorCodeEmailAlreadyInUse:
//                                    print("email in use")
//                                case .errorCodeWeakPassword:
//                                    print("weak password")
//                                default:
//                                    print("login error: \(error)")
//                                }
//                            }
//                        }
//                        else if self.bankField.text?.characters.count != 16{
//                            print("bank account not long enough")
//                        }
//                        else {
//                            print("success")
//
//                                
//                                //self.performSegue(withIdentifier: "returnSegue", sender: self)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        
//    }
//}
//
