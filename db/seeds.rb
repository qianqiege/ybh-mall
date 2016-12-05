# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if AdminUser.first.blank?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

if HealthExamine.first.blank?
  HealthExamine.create!(name:'血压',url:'pressure')
  HealthExamine.create!(name:'血糖',url:'glucose')
  HealthExamine.create!(name:'体重',url:'weight')
  HealthExamine.create!(name:'心率',url:'heart')
  HealthExamine.create!(name:'体温',url:'temperature')
end

if Serve.first.blank?
  Serve.create!(serve_name:'龙氏脊筑',url: 'service_spinebuild')
  Serve.create!(serve_name:'慢病健康管理深度临床营养干预')
  Serve.create!(serve_name:'数字中医TDS')
  Serve.create!(serve_name:'教育培训')
  Serve.create!(serve_name:'居家养老')
  Serve.create!(serve_name:'综合服务')
end

if VipType.first.blank?
  VipType.create!(name:' 御邦医通奉亲俱乐部',remark: '御邦医通奉亲俱乐部')
  VipType.create!(name:' 御邦医通健康俱乐部',remark: '御邦医通健康俱乐部')
end

if MemberClub.first.blank?
  MemberClub.create!(name:'御邦医通奉亲俱乐部',vip_type_id:1)
  MemberClub.create!(name:'御邦医通黄卡俱乐部',vip_type_id:2)
  MemberClub.create!(name:'御邦医通绿卡俱乐部',vip_type_id:2)
  MemberClub.create!(name:'御邦医通红卡俱乐部',vip_type_id:2)
  MemberClub.create!(name:'御邦医通绿卡青少年专属',vip_type_id:2)
end

if MembershipCard.first.blank?
  MembershipCard.create!(name:'御邦医通-木聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-火聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-土聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-金聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-水聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-太聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-黄卡',member_club_id:2,discount:8)
  MembershipCard.create!(name:'御邦医通-绿卡A',member_club_id:3,discount:8)
  MembershipCard.create!(name:'御邦医通-绿卡B',member_club_id:3,discount:8)
  MembershipCard.create!(name:'御邦医通-绿卡(专卡)',member_club_id:3,discount:9)
  MembershipCard.create!(name:'御邦医通-红卡',member_club_id:4,discount:8)
end

if Setmeal.first.blank?
  Setmeal.create!(
    name:'A 套餐:25万',
    content:'
      <p>1、 享有“ 御邦医通” 慢病健康管理深度临床营养干预之功能康复调理方案（ 连续调理六个月） 2 人次、 5 万元/人次， 共计人民币 10 万元，超出部分按对应会员价费用自理。</p>
      <p>2、 享有“ 御邦医通” 慢病健康管理深度临床营养干预之单病种 （肿瘤、 冠心病、脑中风、糖尿病、 “ 五高” 症、 慢阻肺等） 强化干预方案（ 连续干预六个月） 1 人次、 6 万元/人次， 共计人民币 6  万 元，超出部分按对应会员价费用自理</p>
      <p>3、 享有“ 御邦医通龙氏脊筑” 尊享级筑脊师全脊柱慢病干预及养护疗程服务， 2 疗程/1 人次或 1 疗程/2 人次， 28000 元/疗程， 共计人民币 56000 元。</p>
      <p>4、 享有“ 御邦医通” 之数字中医 TDS 评价、 诊断、 检测设备一套，共计人民币 19800 元（含 200 人次免费检测） 。</p>
      <p>5、 有“ 御邦医通” 之“惠健康” 可穿戴动态监测设备一套， 共计人民币 6900 元。</p>
      <p>6、 享有“ 御邦医通” 之“油此开始” 茶尔康养生茶油 10 份， 每份市场价 298 元，共计人民币 2980 元</p>
      <p>7、 享有“ 御邦医通” 之美容护眼保健眼贴膜 50 盒， 98 元/盒，共计人民币 4900 元</p>'
  )

  Setmeal.create!(
    name:'B 套餐:53万',
    content:'
      <p>1、 享有“ 御邦医通” 慢病健康管理深度临床营养干预之功能康复调理方案（ 连续调理六个月） 4 人次、 5 万元/人次， 共计人民币 20 万元，超出部分费用自理。</p>
      <p>2、 享有“ 御邦医通” 慢病健康管理深度临床营养干预之单病种 （肿瘤、 冠心病、脑中风、糖尿病、 “ 五高” 症、 慢阻肺等） 强化干预方案（ 连续干预九个月） 2 人次、 9 万元/人次， 共计人民币 18 万元，超出部分费用自理。</p>
      <p>3、 享有“ 御邦医通龙氏脊筑” 尊享级筑脊师全脊柱治疗及养护疗程服务 2 疗程/2 人次或 1 疗程/4 人次， 28000 元/疗程， 共计人民币 11.2万元。</p>
      <p>4、 享有“ 御邦医通” 数字中医 TDS 评价、 诊断、 检测设备一套，共计人民币 19800 元（含 200 人次免费检测） 。</p>
      <p>5、 享有“ 御邦医通” 之“惠健康” 可穿戴动态监测设备一套， 共计人民币 6900 元。</p>
      <p>6、 享有“ 御邦医通” 之“油此开始” 茶尔康养生茶油 20 份， 每份市场价 298 元，共计人民币 5960 元</p>
      <p>7、 享有“ 御邦医通” 之美容护眼保健眼贴膜 100 盒， 98 元/盒，共计人民币 9800 元。</p>'
  )

  Setmeal.create!(
    name:'C 套餐:105万',
    content:'
      <p>1、 享有“ 御邦医通” 慢病健康管理深度临床营养干预之功能康复调理方案（ 连续调理六个月） 4 人次、 5 万元/人次， 共计人民币 20 万元，超出部分按尊享会员价费用自理。</p>
      <p>2、 享有“ 御邦医通” 慢病健康管理深度临床营养干预之单病种 （肿瘤、 冠心病、脑中风、糖尿病、 “ 五高” 症、 慢阻肺等） 强化干预方案（ 连续干预九个月） 2 人次、 9 万元/人次， 共计人民币 18 万元，超出部分按尊享会员价费用自理。</p>
      <p>3、 享有“ 御邦医通龙氏脊筑” 尊享级筑脊师全脊柱慢病干预及养护疗程服务， 2 疗程/3 人次或 1 疗程/6 人次， 28000 元/疗程， 共计人民币 16.8 万元。</p>
      <p>4、 享有“御邦医通奇医堂”中医针灸痛风治疗中重度痛风精准治疗 1 人次，价值人民币 42.8 万元。</p>
      <p>5、 享有“ 御邦医通” 数字中医 TDS 评价、 诊断、 检测设备 2 套，共计人民币 39600 元（ 每套含 200 人次免费检测） 。</p>
      <p>6、 享有“ 御邦医通” 之“惠健康” 可穿戴动态监测设备 2 套， 共计人民币 13800 元。</p>
      <p>7、 享有“ 御邦医通” 之“油此开始” 茶尔康养生茶油 20 份， 每份市场价 298 元，共计人民币 5960 元。</p>
      <p>8、 享有“ 御邦医通” 之美容护眼保健眼贴膜 200 盒， 每盒 98 元/7贴，共计人民币 19600 元。</p>'
  )
end
