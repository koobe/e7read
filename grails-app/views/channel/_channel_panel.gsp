<asset:javascript src="channel/channel_panel.js"/>
<div class="channel-menu-float" style="display:none;">
	<div class="side-menu-header">
		<div class="side-menu-title">
			<span>
				頻道
			</span>
		</div>
		<div class="back-button">
			<g:link class="koobe-btn koobe-btn-normal" uri="javascript: hideChannelPanel();" 
					style="background-color: #8ACCC3; border: 1px solid #8ACCC3;">
		        <i class="fa fa-times-circle-o"></i>
		    </g:link>
		</div>
	</div>
	<div class="side-menu">
		<g:render template="/channel/channel_panel_item" model="[channels: channels]" />
	</div>
</div>