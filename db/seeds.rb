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

if Serve.first.blank?
  Serve.create!(serve_name:'龙氏脊筑',url: 'service_spinebuild')
  Serve.create!(serve_name:'慢病健康管理深度临床营养干预')
  Serve.create!(serve_name:'数字中医TDS')
  Serve.create!(serve_name:'惠健康可穿戴动态监测设备一套')
end

if VipType.first.blank?
  VipType.create!(name:'御邦会员',remark: '御邦会 会员')
  VipType.create!(name:'医通会员',remark: '医通会 会员')
end

if MemberClub.first.blank?
  MemberClub.create!(name:'御邦会奉亲俱乐部',vip_type_id:1)
  MemberClub.create!(name:'医通會黄卡俱乐部',vip_type_id:2)
  MemberClub.create!(name:'医通會绿卡俱乐部',vip_type_id:2)
  MemberClub.create!(name:'医通會红卡俱乐部',vip_type_id:2)
  MemberClub.create!(name:'医通會绿卡青少年专属',vip_type_id:2)
end

if MembershipCard.first.blank?
  MembershipCard.create!(name:'御邦医通-火聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-土聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-水聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-木聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-金聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-金聖卡',member_club_id:1,discount:6.8)
  MembershipCard.create!(name:'御邦医通-黄卡',member_club_id:2,discount:8)
  MembershipCard.create!(name:'御邦医通-绿卡',member_club_id:3,discount:9)
  MembershipCard.create!(name:'御邦医通-红卡',member_club_id:4,discount:8)
end

if Setmeal.first.blank?
  Setmeal.create!(name:'A类套餐',
  content:'<p>一、御邦医通深度临床营养干预： 1、功能调理方 案，6个月，2人次（5万元/次），10万元。2、单病种 （肿瘤、冠心病、脑中风、糖尿病、五高症状、慢阻 肺）强化干预，6个月，1人次（6万元/次），12万。</p> <p>二、龙氏脊筑服务： 全脊柱治疗及养护疗程服务，2 疗程/1人次或1疗程2人次，28000元/次（5.6万元）</p> <p>三、数字中医TDS经络健康监测： 数字中医TDS智能 化评估、诊断、检测设备一套（1.98万元,含200人次免 费检测）</p> <p>四、可穿戴设备： &ldquo;御邦医通&rdquo;智慧可穿戴设备一套 （约0.69万元）</p> <p>五、茶油： &ldquo;御邦医通&rdquo;之茶尔康养生茶油10份，298 元/份（0.298万元）</p> <p>六、眼贴膜： &ldquo;御邦医通&rdquo;之护眼眼贴膜50盒，98元/ 盒（0.49万元）</p>')

  Setmeal.create!(name:'B类套餐',
  content:'<p>1、功能调理方案，6个月，4人次（5万元/次）， 20万元。</p> <p>2、单病种（肿瘤、冠心病、脑中风、糖尿病、五高症状、慢阻肺）强化干预，9个月，2人次（ 18万元/次），超出部分自理。</p> <p>3、 全脊柱治疗及养护疗程服务，2疗程/2人次或1疗程4人次，28000元/次（ 11.2万元）；</p> <p>4、数字中医TDS智能化评估、诊断、检测设备一套（ 1.98万元,含200次免费检测）；</p> <p>5、&ldquo;御邦医通&rdquo;智慧可穿戴设备一套（ 0.69万元）；</p> <p>6、&ldquo;御邦医通&rdquo;之茶尔康养生茶油20份（ 0.596万元）；</p> <p>7、&ldquo;御邦医通&rdquo;之护眼眼贴膜100盒，98元/盒（ 0.98万元）<br /> &nbsp;</p>')

  Setmeal.create!(name:'C类套餐',
  content:'<p>1、功能调理方案，6个月，4人次（5万元/次）， 20万元。</p> <p>2、单病种（肿瘤、冠心病、脑中风、糖尿病、五高症状、慢阻肺）强化干预，9个月，2人次（ 18万元/次），超出部分自理。</p> <p>3、 全脊柱治疗及养护疗程服务，2疗程/3人次或1疗程6人次，28000元/次（ 16.8万元）；</p> <p>4、&ldquo;御邦医通奇医堂&rdquo;中医针灸痛风治疗中重度痛风精准治疗1人次（ 42.8万元）</p> <p>5、数字中医TDS智能化评估、诊断、检测设备两套（1.98万元,含200次免费检测） 3.96万；</p> <p>6、&ldquo;御邦医通&rdquo;智慧可穿戴设备两套（0.69万元/套1.38万）；</p> <p>7、&ldquo;御邦医通&rdquo;之茶尔康养生茶油20份（ 0.596万元）；</p> <p>8、&ldquo;御邦医通&rdquo;之护眼眼贴膜200盒，98元/盒7贴。（ 1.96万元）<br /> &nbsp;</p>')
end
