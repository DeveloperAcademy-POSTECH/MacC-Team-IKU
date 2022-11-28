//
//  ProfileViewController.swift
//  IKU
//
//  Created by kwon ji won on 2022/11/19.
//
import SwiftUI
import UIKit
final class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    let mainLabel = UILabel()
    let profileImage = UIImageView()
    let photoSelect = UIButton()
    let nickNameTitle = UILabel()
    let nickName = UITextField()
    let ageNameTitle = UILabel()
    let hospitalTitle = UILabel()
    let hospital = UITextField()
    private var age: UITextField = {
        var tf = UITextField()
        tf.keyboardType = .numberPad
        return tf
    }()
    let limitLength = 10

    
    private lazy var nickNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nickNameTitle,nickName])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var ageNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ageNameTitle,age])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        return stackView

    }()
    
    private lazy var hospitalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hospitalTitle,hospital])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        return stackView
    }()

    
    lazy private var button: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .ikuBlue
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .nexonGothicFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(Button(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        makeAutoLayout()
        self.nickName.delegate = self
    }
    
    //화면 터치시 키보드가 내려간다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
        
    }
    
    //글자수 제한 받기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = nickName.text else { return true }
            let newLength = text.count - range.length 
            return newLength <= limitLength
        }
    
    func setup() {
        mainLabel.text = "Please fill out baby profile"
        mainLabel.font = .nexonGothicFont(ofSize: 17)
        view.addSubview(mainLabel)
        view.backgroundColor = .ikuBackgroundBlue
        let image = UIImage(named: "coverEye")
        self.profileImage.image = image
        self.profileImage.contentMode = .scaleAspectFill
        self.profileImage.frame.size = CGSize(width: 120, height: 120)
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2.0
        self.profileImage.layer.masksToBounds = true
        self.view.addSubview(profileImage)
        
        view.addSubview(nickNameStackView)
        nickNameStackView.backgroundColor = .white
        //색상 바뀔예정
        nickNameTitle.textColor = .gray
        nickNameTitle.text = "Nickname"
        nickNameTitle.font = .nexonGothicFont(ofSize: 13)
        nickName.text = ""
        nickName.font = .nexonGothicFont(ofSize: 17)
        
        view.addSubview(ageNameStackView)
        ageNameStackView.backgroundColor = .white
        ageNameTitle.text = "Age"
        ageNameTitle.textColor = .gray
        ageNameTitle.font = .nexonGothicFont(ofSize: 13)
        
        view.addSubview(hospitalStackView)
        hospitalStackView.backgroundColor = .white
        hospitalTitle.text = "Bookmark Hospital"
        hospitalTitle.textColor = .gray
        hospitalTitle.font = .nexonGothicFont(ofSize: 13)
        hospital.text = ""
        hospital.font = .nexonGothicFont(ofSize: 17)
        
        view.addSubview(button)
    
    }
    
    @objc private func Button(_ sender: UIButton) {
        navigationController?.pushViewController(DictionaryViewController(), animated: true)
    }
    
    
    func makeAutoLayout() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 135).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: nickNameStackView.topAnchor, constant: -32).isActive = true
        
        nickNameStackView.translatesAutoresizingMaskIntoConstraints = false
        nickNameStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 328).isActive = true
        nickNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nickNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
        nickNameStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nickNameTitle.topAnchor.constraint(equalTo: nickNameStackView.topAnchor,constant: 12).isActive = true
        nickName.topAnchor.constraint(equalTo: nickNameTitle.bottomAnchor,constant: 5).isActive = true
        nickName.leadingAnchor.constraint(equalTo: nickNameStackView.leadingAnchor,constant: 16).isActive = true
        nickName.bottomAnchor.constraint(equalTo: nickNameStackView.bottomAnchor,constant: -10).isActive = true
        
        ageNameStackView.translatesAutoresizingMaskIntoConstraints = false
        ageNameStackView.topAnchor.constraint(equalTo: nickNameStackView.bottomAnchor, constant: 16).isActive = true
        ageNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        ageNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
        ageNameStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ageNameTitle.topAnchor.constraint(equalTo: ageNameStackView.topAnchor,constant: 12).isActive = true
        age.topAnchor.constraint(equalTo: ageNameTitle.bottomAnchor,constant: 5).isActive = true
        age.leadingAnchor.constraint(equalTo: ageNameStackView.leadingAnchor,constant: 16).isActive = true
        age.bottomAnchor.constraint(equalTo: ageNameStackView.bottomAnchor,constant: -10).isActive = true
        
        hospitalStackView.translatesAutoresizingMaskIntoConstraints = false
        hospitalStackView.topAnchor.constraint(equalTo: ageNameStackView.bottomAnchor, constant: 16).isActive = true
        hospitalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        hospitalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
        hospitalStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        hospitalTitle.topAnchor.constraint(equalTo: hospitalStackView.topAnchor,constant: 12).isActive = true
        hospital.topAnchor.constraint(equalTo: hospitalTitle.bottomAnchor,constant: 5).isActive = true
        hospital.leadingAnchor.constraint(equalTo: hospitalStackView.leadingAnchor,constant: 16).isActive = true
        hospital.bottomAnchor.constraint(equalTo: hospitalStackView.bottomAnchor,constant: -10).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -32).isActive = true
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
    }
}


//struct ProfileView: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> ProfileViewController {
//        ProfileViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {}
//}

struct ProfileView: View {
    @State private var nickName: String = "Lisa"
    @State private var age: Int?
    @State private var hospital: String = ""
    var imageURL: URL? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please fill out baby profile")
                .foregroundColor(.black)
                .font(Font(UIFont.nexonGothicFont(ofSize: 17)))
                .padding(.vertical, 32)
            Button {
                Void()
            } label: {
                if let imageURL {
                    Text(imageURL.path())
                } else {
                    Image("DefaultProfileImage")
                        .resizable()
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                        .overlay {
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.gray)
                                        .overlay {
                                            Image(systemName: "camera")
                                                .frame(width: 32, height: 32)
                                                .foregroundColor(.white)
                                        }
                                }
                            }
                        }
                }
            }

            VStack {
                HStack {
                    Text("Nickname")
                        .foregroundColor(.ikuDarkGray)
                        .font(Font(UIFont.nexonGothicFont(ofSize: 13)))
                    Spacer()
                }
                TextField("please type nickname", text: $nickName)
                    .font(Font(UIFont.nexonGothicFont(ofSize: 17)))
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
            )
            
            VStack {
                HStack {
                    Text("Age")
                        .foregroundColor(.ikuDarkGray)
                        .font(Font(UIFont.nexonGothicFont(ofSize: 13)))
                    Spacer()
                }
                TextField(value: $age, format: .number) {
                    Text("please type age")
                        .font(Font(UIFont.nexonGothicFont(ofSize: 17)))
                }
                .keyboardType(.decimalPad)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
            )
            
            VStack {
                HStack {
                    Text("Hospital you go to")
                        .foregroundColor(.ikuDarkGray)
                        .font(Font(UIFont.nexonGothicFont(ofSize: 13)))
                    Spacer()
                }
                TextField("please type hospital you go to", text: $hospital)
                    .font(Font(UIFont.nexonGothicFont(ofSize: 17)))
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
            )
            
            Spacer()
            
            Button {
                Void()
            } label: {
                HStack {
                    Spacer()
                    Text("Save")
                        .font(Font(UIFont.nexonGothicFont(ofSize: 20, weight: .bold)))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.ikuBlue)
                )
            }

        }
        .padding()
        .background(Color.init(uiColor: .ikuBackgroundBlue))
        .onTapGesture {
            endEditing()
        }
    }
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
