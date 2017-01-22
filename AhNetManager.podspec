

Pod::Spec.new do |s|
  s.name         = 'AhNetManager'
  s.version      = '0.2.1'
  s.ios.deployment_target = '8.0'
  s.summary      = 'NetManager base on AFN  by 阿浩'
  s.homepage     = 'https://github.com/ahao1011/AhManager'
  s.license      = 'MIT'
  s.author       = { 'ah'=> 'zth1011@126.com'}
  s.source       = { :git => 'https://github.com/ahao1011/AhManager.git', :tag => s.version.to_s }
  #s.source_files = 'AhManager'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'MJExtension', '~> 3.0.13'
  s.dependency 'MBProgressHUD', '~> 1.0.0'
   `echo "2.3" > .swift-version`

end
