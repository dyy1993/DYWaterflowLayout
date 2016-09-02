

Pod::Spec.new do |s|
  s.name         = "DYWaterflowLayout"
  s.version      = "0.0.2"
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.summary      = "A WaterflowLayout"

  s.homepage     = "https://github.com/dyy1993/DYWaterflowLayout"

  s.license      = "MIT"


  s.author             = { "dyy" => "771750834@qq.com" }
  s.social_media_url   = "http://weibo.com/1800731733"

  s.source       = { :git => "http://EXAMPLE/DYWaterflowLayout.git", :tag => "0.0.1" }
  s.source_files  = "DYWaterflowLayout", "DYWaterflowLayout/**/*.{h,m}"

  s.requires_arc = true


end
