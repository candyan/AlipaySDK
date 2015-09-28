Pod::Spec.new do |s|
  s.name              = "AlipaySDK-2.0"
  s.version           = "3.0.1"
  s.summary           = "Alipay SDK 2.0 for iOS"
  s.homepage          = "https://b.alipay.com/newIndex.htm"
  s.license           = {
    :type => 'Copyright'
    :text => <<-LINCENSE
      支付宝(中国)网络技术有限公司 ^? 版权所有.
      LINCENSE
  }
  s.author            = { "AliPay" => "http://www.alipay.com/" }
  s.platform          = :ios
  s.requires_arc      = true

  s.source            = { :git => "http://github.com/candyan/AlipaySDK.git", :tag => "#{s.version}" }
  s.frameworks        = 'CoreTelephony', 'SystemConfiguration'

  s.default_subspec   = 'Core'

  s.subspec "Core" do |core|
    core.resources    = 'AlipaySDK.bundle'
    core.vendored_frameworks = 'AlipaySDK.framework'
    core.public_header_files = 'AlipaySDK.framework/Headers/**/*.h'
  end

  s.subspec "SSL" do |ssl|
    ssl.dependency 'AlipaySDK-2.0/Core'
    ssl.dependency 'OpenSSL'
  end

end

