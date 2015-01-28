Pod::Spec.new do |s|

  s.name          = 'AlipaySDK-2.0'
  s.version       = '2.1.2'
  s.summary       = 'Alipay SDK 2.0 for iOS.'
  s.description   = '支付宝移动支付 SDK 标准版 for iOS'
  s.homepage      = 'https://b.alipay.com/newIndex.htm'
  s.license       = { 'type' => 'Copyright', 'text' => '支付宝(中国)网络技术有限公司 ^? 版权所有.'}
  s.author        = { 'AliPay' => 'https://www.alipay.com/' }
  s.platform      = :ios, '5.0'
  s.source        = {
      :git => 'https://github.com/candyan/AlipaySDK.git',
      :tag => s.version.to_s
  }

  s.subspec 'Core' do |core|
    core.resources           = 'AlipaySDK.bundle',
    core.vendored_frameworks = 'AlipaySDK.framework'
    core.public_header_files = 'AlipaySDK.framework/Headers/**/*.h'
    core.frameworks          = 'SystemConfiguration', 'CoreTelephony'
    core.requires_arc        = true
  end

  s.default_subspec = 'Core'

end
