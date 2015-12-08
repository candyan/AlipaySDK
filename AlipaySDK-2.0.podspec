Pod::Spec.new do |s|
  s.name              = "AlipaySDK-2.0"
  s.version           = "3.0.1-bitcode"
  s.summary           = "Alipay SDK for iOS. You can create alipay order or sign orders with `Order` subspec."
  s.homepage          = "https://b.alipay.com/newIndex.htm"
  s.license           = {
    :type => 'Copyright',
    :text => <<-LINCENSE
      支付宝(中国)网络技术有限公司 ^? 版权所有.
      LINCENSE
  }
  s.author            = { "AliPay" => "http://www.alipay.com/" }
  s.platform          = :ios, '7.0'
  s.requires_arc      = true

  s.source            = { :git => "https://github.com/candyan/AlipaySDK.git", :tag => "#{s.version}" }
  s.frameworks        = 'CoreTelephony', 'SystemConfiguration', 'CoreMotion'
  s.libraries         = 'z', 'c++'

  s.default_subspec   = 'Core'

  s.subspec "Core" do |core|
    core.source_files = 'sources/extensions/ANAlipayResultCode.h'
    core.resources    = 'AlipaySDK.bundle'
    core.vendored_frameworks = 'AlipaySDK.framework'
    core.public_header_files = 'AlipaySDK.framework/Headers/**/*.h', 'sources/extensions/ANAlipayResultCode.h'
  end

  s.subspec "Order" do |order|
    order.source_files = 'sources/order/**/*.{h,m}'
    order.dependency 'AlipaySDK-2.0/Core'
    order.dependency 'OpenSSL'
    order.dependency 'PupaFoundation'
  end

end
