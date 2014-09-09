<style>
<!--
	.container-tips {
		text-align: left;
		background-color: #ECEFF5;
		border: 1px solid #ccc;
		border-radius: 5px;
		margin-top: 1px;
		padding-top: 10px;
		padding-bottom: 10px;
		padding-left: 15px;
		padding-right: 15px;
		display: none;
		
		-webkit-transition: all 1s ease-in;
		transition: all 1s ease-in;
	}
	
	.subtitle {
		font-weight: 700;
		font-size: 1.2em !important;
	}
	
	.text-body {
		font-size:0.9em;
	}
	
	.tip-title {
		font-weight: 700;
		font-size: 1.2em;
	}
	
	.editing-tips-switch {
		text-align: left;
		margin-top: 15px;
		cursor: pointer;
	}
-->
</style>
<script type="text/javascript">
	var onoff = false;
	
	$(function() {
		$('.editing-tips-switch').click(function(e) {
			if (onoff) {
				onoff = false;
				$('.container-tips').css('display', 'none');
			} else {
				onoff = true;
				$('.container-tips').css('display', 'block');
			}
		});
	});
</script>
<div class="editing-tips-switch">
	<p><i class="fa fa-pencil"></i> 編輯小技巧</p>
</div>

<div class="container-tips">

	<p class="tip-title">
		請善加利用隱藏式的小技巧，讓您的文章更美觀。
	</p>

	<div class="row">
	
	<div class="col-xs-12 col-sm-6 col-md-4">
		<p class="text-body">
			<span class="subtitle">強調(斜體)：</span>
			<br/>
			請輸入米字鍵 ＊ 在需要斜體的文字前後
			<br/>
			EX : 
			<br/>
			*文字*
		</p>
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4">
		<p class="text-body">
			<span class="subtitle">粗體：</span>
			<br/>
			請輸入兩個米字鍵 ＊ 在需要粗體的文字前後
			<br/>
			EX : 
			<br/>
			**文字**
		</p>
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4">
		<p class="text-body">
			<span class="subtitle">項目符號：</span>
			<br/>
			請輸入 - 鍵在需要顯示項目符號的文字前
			<br/>
			EX : 
			<br/>
			- 項目一
			<br/>
			- 項目二
		</p>
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4">
		<p class="text-body">
			<span class="subtitle">清單：</span>
			<br/>
			請輸入數字在需要顯示順序號碼的文字前
			<br/>
			EX : 
			<br/>
			1. 項目一
			<br/>
			2. 項目二
		</p>
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4">
		<p class="text-body">
			<span class="subtitle">標題字：</span>
			<br/>
			請輸入井字鍵 ＃ 在需要顯示標體字的文字前
			<br/>
			EX : 
			<br/>
			# 標題h1
			<br/>
			## 標題h2
			<br/>
			### 標題h3
			<br/>
			#### 標題h4
			<br/>
			##### 標題h5
			<br/>
			###### 標題h6
		</p>
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4">
		<p class="text-body">
			<span class="subtitle">文章分段：</span>
			<br/>
			輸入兩次Enter即可分段
		</p>
	</div>
	
	</div>
</div>