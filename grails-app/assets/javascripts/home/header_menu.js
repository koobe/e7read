$(function() {
	console.log('Register menu button hover event');
	
	var categoryName = getQueryVariable("c");
	
	var tip = $.spinner({
		bgColor: 'rgba(148, 230, 218, 0.7)',
		showIcon: false,
		defaultMsg: ' ',
		isTimeout: false,
		msgLeftPadding: '20px'
	});
	
	registerHoverEvent('header-menu-channel', '頻道');
	registerHoverEvent('header-menu-personal', '個人文章');
	registerHoverEvent('header-menu-create', '撰寫');
	registerHoverEvent('header-menu-profile', '個人檔案');
	registerHoverEvent('header-menu-message', '訊息');
	registerHoverEvent('header-menu-map', '地圖');
	registerHoverEvent('header-menu-logout', '登出');
	registerHoverEvent('header-menu-login', '登入');
	registerHoverEvent('header-menu-category', '類別');
	registerHoverEvent('header-menu-return', '回首頁');
	registerHoverEvent('gototop-button', '回到頂端');
	
	if (categoryName) {
		var target = $("a[data-category-name='" + categoryName + "']");
		console.log(target.html());
		registerHoverEvent('search-form', '在' + target.html() + '類別中搜尋');
	} else {
		registerHoverEvent('search-form', '搜尋');
	}
	
	function registerHoverEvent(className, message) {
		$('.' + className).hover(function() {
			tip.show(message);
		}, function() {
			tip.hide();
		});
	}
});