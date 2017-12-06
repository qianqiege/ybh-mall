// JavaScript Document



	function txtfocus(){
	
		var mytxt=document.getElementById("txt");
		
		if(mytxt.value=="SEARACH"){
		
			mytxt.value="";
			
			mytxt.style.color="#121212";
		
		}
	
	}
	
	function txtonblur(){
	
		var mytxt=document.getElementById("txt");
		
			if(mytxt.value==""){
			
				mytxt.value=mytxt.defaultValue;
				
				mytxt.style.color="#c7d1cc";
		
		}
	
	}
	
	$(function(){
		$('.main-dh ul li').hover(function(){
			$(this).children('div').stop().slideToggle(200);
		})
		
		$('.main-dh ul li:first-child a').css('background','#fff');
		$('.main-dh ul li:gt(4) a').css('background','#fff')
		
		$('.main-dh li:eq(1) div').css('width','445px');
		$('.main-dh li:eq(2) div').css('width','284px');
		$('.main-dh li:eq(3) div').css('width','454px');
		$('.main-dh li:eq(4) div').css('width','258px');
		
		//手机导航
		
		$('.menu').click(function(){
			$('.mobile-wrap').show();
			$('.mobile-nav').animate({'right':'0'},200);
			$('html,body').css({'overflow':'hidden'});
		})
		$('.mobile-wrap').click(function(){
			$(this).hide();
			$('.mobile-nav').animate({'right':'-230px'},200);
			$('html,body').css({'overflow':'auto'});
		})
		
		$('.mobile-nav li').click(function(){
			$(this).find('div').slideToggle();
			$(this).siblings().find('div').slideUp();
		})
		//手机导航 end
		
		
		$('.index-btn').click(function(){
			$('body,html').animate({'scrollTop':'0'},200);
		})
		$(window).scroll(function(){
			var sT = $(window).scrollTop();
			if( sT > 300 ){
				$('.index-btn').animate({'right':'15px'},50);
			}else{
				$('.index-btn').animate({'right':'-40px'},50);
			}
		})
		
		//首页
		$('.index li:eq(1)').addClass('index_li02');
		
		var webWidth = $(window).width();
		if( webWidth > 1100 ){
			$('.index li').hover(function(){
		        $(this).find('.list_text02').stop().animate({'left':'50%'},300);
		        $(this).find('a').addClass('aClass').find('a').children('span').addClass('spanClass');
		    },function(){
		        $(this).find('.list_text02').stop().animate({'left':'101%'},300);
		        $(this).find('a').removeClass('aClass').find('a').children('span').removeClass('spanClass');
		    })
		}
		
		$('.con-cont3 li:eq(1)').addClass('cont3_li02');
		
		
		$('.con-cont4 li img').load(function(){
			function change(){
				var imgHeight = $('.con-cont4 li img').height();
				$('.text01_wrap').css('height',imgHeight+'px');
			}
			change();
		})
		function change(){
			var imgHeight = $('.con-cont4 li img').height();
			$('.text01_wrap').css('height',imgHeight+'px');
		}
		change();
		$(window).resize(function(){
			change();
		})
		
		
		//新闻
		$('.main-hynew li img').load(function(){
			function newsChange(){
				var imgHeight = $('.main-hynew li img').height();
				$('.hynew_textwrap').css('height',imgHeight+'px');
			}
			newsChange();
		})
		function newsChange(){
			var imgHeight = $('.main-hynew li img').height();
			$('.hynew_textwrap').css('height',imgHeight+'px');
		}
		newsChange();
		$(window).resize(function(){
			newsChange();
		})
		// 新闻end
		
	
	})
	
	$(function(){
		var liElement01 =  $('.main-min-twjh li:eq(1)').html();
		var liElement05 =  $('.main-min-twjh li:eq(5)').html();
		var liElement09 =  $('.main-min-twjh li:eq(9)').html();
		var webWidth = $(window).width();
		if( webWidth < 1100 ){
			$('.main-min-twjh li:eq(0)').before('<li>' + liElement01 + '</li>');
			$('.main-min-twjh li:eq(2)').remove();
			$('.main-min-twjh li:eq(4)').before('<li>' + liElement05 + '</li>');
			$('.main-min-twjh li:eq(6)').remove();
			$('.main-min-twjh li:eq(8)').before('<li>' + liElement09 + '</li>');
			$('.main-min-twjh li:eq(10)').remove();
		}
		
		//发展历程
		if( webWidth < 1100 ){
			var rightLi01 = $('.develop-right li:eq(0)').html();
			var rightLi02 = $('.develop-right li:eq(1)').html();
			$('.develop-left02 li:eq(0)').after('<li>' + rightLi01 +'</li>');
			$('.develop-left02 li:eq(2)').after('<li>' + rightLi02 +'</li>');
			$('.develop-right').remove();
			
		}
		
		//发展历程
		
		
		
	})
	
	
	$(function(){
	var aDiv=document.getElementById("box");
	var aUl=aDiv.getElementsByTagName('ul');
	var aLi=aUl[0].getElementsByTagName('li');
	var bLi=aUl[1].getElementsByTagName('li');
	var timer=play=null;
	var index=0;
	for(var i=0;i<bLi.length;i++)
	{
		bLi[i].index=i
		bLi[i].onmouseover=function()
		{
		  qh(this.index);
	    }
		//图片的变换alpha变换
		function qh(a)
		{
			var alpha=0;
		  for(var i=0;i<aLi.length;i++)
		  {
		    bLi[i].className=''
			aLi[i].style.display='none'
		  }
		  bLi[a].className='active'
		  aLi[a].style.display='block'
		  clearInterval(timer)
		  for(var i=0;i<aLi.length;i++)
		  {
			aLi[i].style.opacity=0;
			aLi[i].style.filter="alpha(opacity:0)";
		  }
		  index=a
		  timer=setInterval(function()
		  {
			alpha+=2;
			aLi[index].style.opacity=alpha/100 
			aLi[index].style.filter='alpha(opacity:'+alpha+')';
			if(alpha>=100)
		    {
				alpha=100;
				clearInterval(timer)
			}
		  },35)
		}		
	 }
	//图片的自动播放
	function autoPlay()
		{
		  play=setInterval(function()
		  {
			index++
			index%=bLi.length
			qh(index)	
		  },5000)	
		}
		autoPlay();
		aDiv.onmouseover=function()
		{
		   clearInterval(play)
		}
		aDiv.onmouseout=function()
		{
		   autoPlay();
		}
})
	
		
	



