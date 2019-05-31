Pod::Spec.new do |s|
  s.name         = "ZhengHeFramework" # 项目名称
  s.version      = "0.0.1"        # 版本号 与 你仓库的 标签号 对应
  s.license      = "MIT"          # 开源证书
  s.summary      = "ZhengHeFramework" # 项目简介

  s.homepage     = "https://github.com/kongzichixiangjiao" # 你的主页
  s.source       = { :git => "https://github.com/kongzichixiangjiao/ZhengHeFramework.git", :tag => "#{s.version}" } #你的仓库地址，不能用SSH地址

  s.source_files = "ZhengHeFramework/**/*.{swift}" #路径与.podspec文件名一致
  s.resource_bundles = {
    'ZHFramework' => ['ZhengHeFramework/**/*.{xib}']
  }
  s.requires_arc = true # 是否启用ARCS
  s.platform     = :ios, "9.0" #平台及支持的最低版本
  s.frameworks   = "UIKit", "Foundation" #支持的框架

  # s.swift_versions = '4.2'
  # User
  s.author             = { "GA" => "houjianan_110@163.com" } # 作者信息
  s.social_media_url   = "https://github.com/kongzichixiangjiao" # 个人主页

end