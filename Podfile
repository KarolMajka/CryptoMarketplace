platform :ios, '13.0'
inhibit_all_warnings!

def shared_pods

  # Tools
  pod 'SwiftLint'
  pod 'SwiftGen'

  # RX
  pod 'RxSwift'
  pod 'RxCocoa'

  # UI
  pod 'SnapKit'
  pod 'Kingfisher'
  pod 'Keyboard+LayoutGuide'

  # Networking
  pod 'Moya/RxSwift'

end

target 'crypto-marketplace' do
  use_frameworks!

  shared_pods

  target 'crypto-marketplaceTests' do
    inherit! :search_paths

    pod 'SwiftyMocky'
    pod 'RxTest'
    pod 'RxBlocking'
  end

end
